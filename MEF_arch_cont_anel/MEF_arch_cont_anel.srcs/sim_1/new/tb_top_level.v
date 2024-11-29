`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 07:55:44 PM
// Design Name: 
// Module Name: tb_top_level
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


module tb_top_level;

    // Declaração dos sinais
    reg clk, reset, REQ, RW;
    wire DOUT, DA, WE, WC, C0, C1; // Saídas do top-level

    // Instanciar o módulo top-level
    top_level uut_top_level (
        .clk(clk),
        .reset(reset),
        .REQ(REQ),
        .RW(RW),
        .DOUT(DOUT),
        .DA(DA),
        .WE(WE),
        .WC(WC),
        .C0(C0),
        .C1(C1)
    );

    // Gera o clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock com período de 10 ns
    end

    // Estímulos para os testes
    initial begin
        // Inicialização
        reset = 1; REQ = 0; RW = 0;
        #20 reset = 0;  // Sai do reset
        #20;

        // Aplicação dos estímulos fornecidos

        // Q = 1; REQ = 0; RW = 0;
        REQ = 0; RW = 0;
        #40;

        // Q = 1; REQ = 0; RW = 1;
        REQ = 0; RW = 1;
        #40;

        // Q = 1; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 2; REQ = 0; RW = 1;
        REQ = 0; RW = 1;
        #40;

        // Q = 2; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 3; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 4; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 5; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 5; REQ = 1; RW = 1 (repetido);
        REQ = 1; RW = 1;
        #40;

        // Q = 6; REQ = 0; RW = 1;
        REQ = 0; RW = 1;
        #40;

        // Q = 1; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 2; REQ = 1; RW = 1;
        REQ = 1; RW = 1;
        #40;

        // Q = 3; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 4; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 5; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 6; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 7; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 8; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 9; REQ = 1; RW = 0;
        REQ = 1; RW = 0;
        #40;

        // Q = 1; REQ = 0; RW = 0;
        REQ = 0; RW = 0;
        #40;

        // Finaliza a simulação
        $stop;
    end

    // Monitoramento
    initial begin
        $monitor("Time: %0t | Reset=%b | REQ=%b | RW=%b | DOUT=%b | DA=%b | WE=%b | WC=%b | C0=%b | C1=%b",
                 $time, reset, REQ, RW, DOUT, DA, WE, WC, C0, C1);
    end
endmodule
