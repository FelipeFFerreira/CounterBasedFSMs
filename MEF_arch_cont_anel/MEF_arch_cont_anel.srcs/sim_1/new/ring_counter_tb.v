`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 07:03:53 PM
// Design Name: 
// Module Name: ring_counter_tb
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


module ring_counter_tb();
    // Entradas
    reg clk;
    reg clear;

    // Saída
    wire [6:0] Q;

    // Instanciar o contador em anel
    ring_counter uut (
        .clk(clk),
        .clear(clear),
        .Q(Q)
    );

    // Gerador de clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        clear = 1; // CLEAR desativado para contagem normal

        // Teste inicial: Contagem em anel
        #50 clear = 0; // Ativar CLEAR: Deve permanecer em Q1
        #20 clear = 1; // Desativar CLEAR: Deve continuar contagem

        // Teste contínuo
        #100 clear = 0; // Manter em Q1 novamente
        #30 clear = 1; // Liberar para contagem

        // Finalizar simulação
        #50;
        $finish;
    end
endmodule
