`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 07:26:18 PM
// Design Name: 
// Module Name: output_decoder
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


module output_decoder (
    input wire [4:1] Q,    // Entradas do decodificador (Q4..Q1)
    input wire [1:0] E,    // Entradas da máquina de estados (E[1] = E1, E[0] = E0)
    output wire DOUT,      // Saída DOUT
    output wire DA,        // Saída DA
    output wire WE,        // Saída WE
    output wire WC,        // Saída WC
    output wire C0,        // Saída C0
    output wire C1         // Saída C1
);

    // Implementação das expressões lógicas para as saídas

    assign DOUT = ~Q[2] | ~E[0] | E[1] | Q[3] | Q[4];
    assign DA = ~Q[2] | ~Q[1] | ~E[0] | E[1] | Q[3] | Q[4];
    assign WE = (~Q[3] & ~Q[2]) | ~E[1] | E[0] | (Q[3] & Q[2] & Q[1]) | Q[4];
    assign WC = (~Q[4] & ~Q[2]) | ~E[1] | E[0] | (~Q[3] & Q[2]) | (Q[4] & Q[3]);
    assign C0 = (~Q[4] & ~Q[3] & Q[2] & Q[1] & E[1] & ~E[0]) | 
                (~Q[4] & Q[3] & ~Q[2] & Q[1] & E[1] & ~E[0]);
    assign C1 = (~Q[4] & Q[3] & ~Q[2] & E[1] & ~E[0]);

endmodule

