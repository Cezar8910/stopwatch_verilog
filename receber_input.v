module receber_input(
    input clock, resetI, contarI, pausarI, pararI,
	 input wire[3:0] num_ms, num_us, num_ds, num_cs,
    output reg resetC, contarC, pausarC, pararC
);
    reg resetA, contarA, pausarA, pararA;
    reg apertou;

    initial begin
        apertou <= 1;
        resetA <= 0;
        contarA <= 0;
        pausarA <= 0;
        pararA <= 0;
    end

    always @(posedge clock) begin
        if (~resetI && contarI && pausarI && pararI && apertou) begin
            resetA <= 1;
            apertou <= 0;
        end else if (~contarI && resetI && pausarI && pararI && apertou) begin
            contarA <= 1;
            apertou <= 0;
        end else if (~pausarI && resetI && contarI && pararI && apertou) begin
            pausarA <= 1;
            apertou <= 0;
        end else if (~pararI && resetI && contarI && pausarI && apertou) begin
            pararA <= 1;
            apertou <= 0;
        end else if(num_ms == 4'd9 && num_us == 4'd9 && num_ds == 4'd9 && num_cs == 4'd9) begin
				resetC <= 1;
            contarC <= 0;
            pausarC <= 0;
            pararC <= 0;
		  end else apertou <= 1;

        if (resetI && resetA) begin
            resetC <= 1;
            contarC <= 0;
            pausarC <= 0;
            pararC <= 0;

            resetA <= 0;
        end else if (contarI && contarA) begin
            resetC <= 0;
            contarC <= 1;
            pausarC <= 0;
            pararC <= 0;

            contarA <= 0;
        end else if (pausarI && pausarA) begin
            resetC <= 0;
            contarC <= 0;
            pausarC <= 1;
            pararC <= 0;

            pausarA <= 0;
        end else if (pararI && pararA) begin
            resetC <= 0;
            contarC <= 0;
            pausarC <= 0;
            pararC <= 1;

            pararA <= 0;
        end
        end
endmodule

