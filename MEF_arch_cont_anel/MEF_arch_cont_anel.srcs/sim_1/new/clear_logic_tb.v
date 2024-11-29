`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 07:27:39 PM
// Design Name: 
// Module Name: clear_logic_tb
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


`timescale 1ns / 1ps

module clear_logic_tb();
    // Entradas do bloco combinacional
    reg REQ;
    reg RW;

    // Conexão com o contador
    wire [6:0] Q;
    wire CL; // Saída do bloco lógico (conecta ao clear do contador)

    // Instanciar o contador em anel
    ring_counter ring_counter_inst (
        .clk(clk),
        .clear(CL),  // Controlado pela saída do bloco lógico
        .Q(Q)
    );

    // Instanciar o bloco lógico
    clear_logic cl_logic_inst (
        .Q7(Q[6]),
        .Q6(Q[5]),
        .Q5(Q[4]),
        .Q4(Q[3]),
        .Q3(Q[2]),
        .Q2(Q[1]),
        .Q1(Q[0]),
        .REQ(REQ),
        .RW(RW),
        .CL(CL)
    );

    // Sinais de controle
    reg clk;

    // Gerador de clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        REQ = 0;
        RW = 0;

        // Teste inicial: Deixar o contador rodar normalmente
        #50 REQ = 1; RW = 1; // Alterar entradas para ver impacto no clear
        #50 REQ = 0; RW = 0; // Alterar novamente as entradas

        // Continuar teste com diferentes combinações
        #50 REQ = 1; RW = 0;
        #50 REQ = 0; RW = 1;

        // Finalizar simulação
        #100;
        $finish;
    end
endmodule

