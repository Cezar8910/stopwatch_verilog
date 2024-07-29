module cronometro (
    input clock, resetI, contarI, pausarI, pararI,
    output reg[6:0] display_mss, display_uss, display_dss, display_css
);
    wire resetC, contarC, pausarC, pararC;
    wire [3:0] num_saida_ms_display, num_saida_us_display, num_saida_ds_display, num_saida_cs_display;
    wire [3:0] num_saida_ms_contador, num_saida_us_contador, num_saida_ds_contador, num_saida_cs_contador;
    wire [6:0] display_ms, display_us, display_ds, display_cs;
    
    receber_input entradas(
        .clock(clock),
        .resetI(resetI),
        .contarI(contarI),
        .pausarI(pausarI),
        .pararI(pararI),

        .resetC(resetC),
        .contarC(contarC),
        .pausarC(pausarC),
        .pararC(pararC)
    );
    
    contador_inicial contador_ms(
        .clock(clock),
        .reset(resetC),
        .contar(contarC),
        .pausar(pausarC),
        .parar(pararC),

        .num_saida_display(num_saida_ms_display),
        .num_saida_contador(num_saida_ms_contador)
    );
    contador_segundos contador_us(
        .clock(clock),
        .reset(resetC),
        .contar(contarC),
        .pausar(pausarC),
        .parar(pararC),

        .num_contador_anterior (num_saida_ms_contador),
        .num_saida_display(num_saida_us_display),
        .num_saida_contador(num_saida_us_contador)
    );
    contador_segundos contador_ds(
        .clock(clock),
        .reset(resetC),
        .contar(contarC),
        .pausar(pausarC),
        .parar(pararC),

        .num_contador_anterior (num_saida_us_contador),
        .num_saida_display(num_saida_ds_display),
        .num_saida_contador(num_saida_ds_contador)
    );
    contador_segundos contador_cs(
        .clock(clock),
        .reset(resetC),
        .contar(contarC),
        .pausar(pausarC),
        .parar(pararC),

        .num_contador_anterior (num_saida_ds_contador),
        .num_saida_display(num_saida_cs_display),
        .num_saida_contador(num_saida_cs_contador)
    );

    display display0(
        .digito (num_saida_ms_display),
        .segmentos (display_ms)
    );
    display display1(
        .digito (num_saida_us_display),
        .segmentos (display_us)
    );
    display display2(
        .digito (num_saida_ds_display),
        .segmentos (display_ds)
    );
    display display3(
        .digito (num_saida_cs_display),
        .segmentos (display_cs)
    );

    always @(posedge clock) begin
        display_mss <= display_ms;
        display_uss <= display_us;
        display_dss <= display_ds;
        display_css <= display_cs;
    end
endmodule