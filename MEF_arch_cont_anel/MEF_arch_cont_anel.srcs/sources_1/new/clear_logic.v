`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITA
// Engineer: Felipe Ferreira Nascimento
// 
// Create Date: 11/27/2024 07:23:12 PM
// Design Name: 
// Module Name: clear_logic
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


module clear_control (
    input wire [4:1] Q,    // Entradas do decodificador (Q4..Q1)
    input wire [1:0] E,    // Saídas da máquina de estados (E[1] = E1, E[0] = E0)
    input wire REQ,        // Sinal de requisição
    input wire RW,         // Sinal de leitura/escrita
    output wire clear      // Sinal de controle do contador em anel
);

    // Implementação da lógica combinacional para o clear do contador em anel
    assign clear = (~Q[2] & ~Q[1]) |
                   (~Q[4] & ~Q[2] & REQ) |
                   (~Q[3] & ~Q[1] & E[0]) |
                   (E[0] & REQ & RW) |
                   (~Q[1] & E[1]) |
                   (E[1] & REQ & ~RW) |
                   (E[1] & E[0]) |
                   (Q[2] & Q[1]) |
                   (Q[3] & ~Q[2]) |
                   (Q[4] & ~Q[1]) |
                   (Q[4] & E[0]);

endmodule

