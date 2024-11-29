`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 04:34:43 PM
// Design Name: 
// Module Name: testbench
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


module testbench;

    // Declaração dos sinais para o testbench
    reg clk;                  // Sinal de clock
    reg rst;                  // Sinal de reset
    reg LD;                   // Sinal de LOAD
    reg [3:0] P;              // Entrada paralela (valor de carga)
    wire [3:0] Q;             // Saída do contador

    // Instanciação do módulo contador_4bits
    parallel_counter uut (
        .clk(clk),
        .rst(rst),
        .LD(LD),
        .P(P),
        .Q(Q)
    );

    // Geração do clock (período de 10 unidades de tempo)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Alterna o clock a cada 5 unidades de tempo
    end

    // Teste funcional
    initial begin
        // Início da simulação
        $display("Início da simulação");
        $monitor("Tempo = %0t | LD = %b | P = %b | Q = %b | rst = %b", 
                 $time, LD, P, Q, rst);

        // Inicialização
        rst = 1; LD = 0; P = 4'b0000;  // Reset ativado, LD = 0
        #10 rst = 0;  // Libera o reset após 10 unidades de tempo

        // Teste 1: Incremento normal (LD = 0)
        #20 LD = 0;   // Contador deve incrementar normalmente
        #40;          // Espera 40 unidades de tempo

        // Teste 2: LOAD com LD = 1
        #10 LD = 1; P = 4'b1010;  // Define P = 1010 (10 em decimal)
        #20;                      // Permanece em LD = 1 por 20 unidades de tempo

        // Teste 3: Retorna para incremento normal
        #10 LD = 0;               // LD = 0, contador deve continuar incrementando
        #40;                      // Espera 40 unidades de tempo

        // Teste 4: Reinicia com reset
        #10 rst = 1;              // Ativa o reset
        #10 rst = 0;              // Libera o reset após 10 unidades de tempo

        // Teste 5: LOAD com outro valor
        #10 LD = 1; P = 4'b0111;  // Define P = 0111 (7 em decimal)
        #20;                      // Permanece em LD = 1 por 20 unidades de tempo

        // Teste 6: Incremento normal novamente
        #10 LD = 0;               // LD = 0, volta ao incremento normal
        #30;                      // Espera 30 unidades de tempo

        // Finaliza a simulação
        #10 $stop;                // Finaliza a simulação após 10 unidades de tempo
    end

endmodule

