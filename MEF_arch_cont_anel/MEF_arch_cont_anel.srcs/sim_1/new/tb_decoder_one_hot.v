`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 02:12:11 AM
// Design Name: 
// Module Name: tb_decoder_one_hot
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


module tb_decoder_with_ring_counter;

    // Sinais do contador
    reg clk, clear;
    wire [9:1] Q;

    // Saídas do decodificador
    wire [4:1] C;

    // Instanciar o contador em anel
    ring_counter uut_counter (
        .clk(clk),
        .clear(clear),
        .Q(Q)
    );

    // Instanciar o decodificador
    decoder_one_hot uut_decoder (
        .Q(Q),
        .C(C)
    );

    // Gerador de clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock com período de 10 ns
    end

    // Estímulos para o teste
    initial begin
        // Inicialização
        clear = 1; // CLEAR desativado para contagem normal
        #20 clear = 0; // Ativar CLEAR: Reinicia em Q1
        #20 clear = 1; // Desativar CLEAR: Contagem normal

        // Teste contínuo
        #100;

        // Finalizar simulação
        $stop;
    end

    // Monitoramento
    initial begin
        $monitor("Time: %0t | Q=%b | C=%b | Clear=%b", 
                 $time, Q, C, clear);
    end
endmodule


