module contador_segundos (
    input clock, reset, contar, pausar, parar,
    input wire[3:0] num_contador_anterior,
    output reg[3:0] num_saida_display, num_saida_contador
);

    reg[3:0] num_contador_anterior_aux;

    reg[2:0] estado_atual;
    reg[3:0] num_conta;

    parameter RESET = 3'd0, CONTAR = 3'd1, PAUSAR = 3'd2, PARAR = 3'd3;
    
    initial begin
        estado_atual <= RESET;
    end

    always@(posedge clock or posedge reset) begin
        if(reset)begin
            estado_atual <= RESET;
        end
        else begin
            case (estado_atual)
                RESET: begin
                    if(pausar) estado_atual <= PAUSAR;
                    else if(contar) estado_atual <= CONTAR;
                end
                PARAR: begin
                    if(reset) estado_atual <= RESET;
                    else if(contar) estado_atual <= CONTAR;
                end
                PAUSAR: begin
                    if(reset) estado_atual <= RESET;
                    else if(contar) estado_atual <= CONTAR;
                    else if(parar) estado_atual <= PARAR;
                end
                CONTAR: begin
                    if(reset) estado_atual <= RESET;
                    else if(contar) estado_atual <= CONTAR;
                    else if(parar) estado_atual <= PARAR;
                    else if(pausar) estado_atual <= PAUSAR;
                end
            endcase
        end
	end

    always @(posedge clock) begin
        case (estado_atual)
            RESET: begin
                num_conta = 4'd0;
                num_saida_display<= 4'd0;
                num_saida_contador <= 4'd0;
            end
            PARAR: begin
                num_saida_display <= num_conta;
                num_saida_contador <= num_conta;
            end
            PAUSAR: begin
                if ((num_contador_anterior == 4'd0) && (num_contador_anterior_aux == 4'd9)) begin
                    num_conta = num_conta + 1;
                end

                if (num_conta == 4'd10) begin
                    num_conta = 4'd0;
                end
                num_saida_contador <= num_conta;
            end
            CONTAR: begin
                if ((num_contador_anterior == 4'd0) && (num_contador_anterior_aux == 4'd9)) begin
                    num_conta = num_conta + 1;
                end

                if (num_conta == 4'd10) begin
                    num_conta = 4'd0;
                end

                num_saida_display = num_conta;
                num_saida_contador <= num_conta;
            end
        endcase
        num_contador_anterior_aux = num_contador_anterior;
    end
endmodule
