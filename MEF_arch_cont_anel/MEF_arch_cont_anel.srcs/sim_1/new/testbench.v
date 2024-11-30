`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 06:45:32 PM
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



module tb_fsm_with_clock_control;

    // Declaração dos sinais
    reg clk, reset, REQ, RW;
    wire [9:1] Q_ring;       // Saída do contador em anel
    wire [4:1] C_decoder;    // Saída do decodificador
    wire [1:0] E;            // Saída da FSM
    wire clear;              // Controle do clear
    wire clk_out;            // Clock condicionado para o contador
    wire DOUT, DA, WE, WC, C0, C1; // Saídas do decodificador de saída


    // Instanciar o contador em anel
    ring_counter uut_ring_counter (
        .clk(clk_out),       // Clock condicionado
        .clear(clear),
        .Q(Q_ring)
    );

    // Instanciar o decodificador
    decoder_one_hot uut_decoder (
        .Q(Q_ring),
        .C(C_decoder)
    );

    // Instanciar a máquina de estados
    fsm uut_fsm (
        .clk(clk),
        .reset(reset),
        .Q(C_decoder),
        .REQ(REQ),
        .RW(RW),
        .E(E)
    );

    // Instanciar o módulo de controle do clear
    clear_control uut_clear_control (
        .Q(C_decoder),
        .E(E),
        .REQ(REQ),
        .RW(RW),
        .clear(clear)
    );

    // Instanciar o módulo de controle de clock
    clock_gating_control uut_clock_control (
        .clk(clk),
        .Q(C_decoder),
        .E(E),
        .CL(clear),
        .clk_out(clk_out)
    );
    
    // Instanciar o módulo de saída
    output_decoder uut_output_decoder (
        .Q(C_decoder),
        .E(E),
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
        $monitor("Time: %0t | Reset=%b | Q_ring=%b | C_decoder=%b | REQ=%b | RW=%b | E=%b | Clear=%b | Clk_out=%b",
                 $time, reset, Q_ring, C_decoder, REQ, RW, E, clear, clk_out);
    end
endmodule


