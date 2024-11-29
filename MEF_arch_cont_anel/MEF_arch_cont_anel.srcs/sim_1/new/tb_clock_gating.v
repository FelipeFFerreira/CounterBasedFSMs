`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 05:26:46 PM
// Design Name: 
// Module Name: tb_clock_gating
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_clock_gating_control;

    // Declarações de sinais
    reg clk;                // Clock de entrada
    reg [3:0] Q;            // Entrada Q (4 bits)
    reg [1:0] S;            // Entrada S (2 bits)
    wire clk_out;           // Clock de saída condicionado

    // Instancia o módulo a ser testado
    clock_gating_control uut (
        .clk(clk),
        .Q(Q),
        .S(S),
        .clk_out(clk_out)
    );

    // Gera o sinal de clock (50% duty cycle)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock com período de 10 ns
    end

    // Gera os estímulos
    initial begin
        // Inicializa sinais
        Q = 4'b0000;
        S = 2'b00;

        // Caso 1: Enable = 1 (condição fora das restrições)
        #10 Q = 4'b0001; S = 2'b11;  // clk_out deve seguir clk

        // Caso 2: Enable = 0 (Q = 0101 e S = 01)
        #20 Q = 4'b0101; S = 2'b01;  // clk_out deve ser 0

        // Caso 3: Enable = 0 (Q = 1000 e S = 10)
        #20 Q = 4'b1000; S = 2'b10;  // clk_out deve ser 0

        // Caso 4: Enable = 1 (condição fora das restrições)
        #20 Q = 4'b0011; S = 2'b00;  // clk_out deve seguir clk

        // Finaliza a simulação
        #40 $stop;
    end

    // Monitoramento dos sinais
    initial begin
        $monitor("Time: %0t | CLK: %b | Q: %b | S: %b | CLK_OUT: %b", $time, clk, Q, S, clk_out);
    end

endmodule

