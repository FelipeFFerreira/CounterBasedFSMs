`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 06:40:58 PM
// Design Name: 
// Module Name: MEF_input
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

module fsm (
    input wire clk,               // Clock
    input wire reset,             // Sinal de reset
    input wire [4:1] Q,           // Entradas do decodificador
    input wire REQ,               // Requisição
    input wire RW,                // Leitura/Escrita
    output reg [1:0] E            // Saída como vetor (E[1] = E1, E[0] = E0)
);

    wire S1, S0;

    // Lógica combinacional para S1
    assign S1 = (E[1] & E[0] & REQ & RW) |
                (~Q[4] & Q[1] & ~E[1] & ~E[0] & REQ & ~RW) |
                (Q[1] & E[1] & REQ & RW) |
                (Q[1] & E[1] & E[0]) |
                (Q[2] & E[1]) |
                (Q[2] & Q[1] & ~E[0]) |
                (Q[3] & ~Q[2] & ~E[0]) |
                (Q[3] & E[1]) |
                (Q[3] & Q[2] & Q[1]) |
                (Q[4] & ~Q[1] & ~E[1]) |
                (Q[4] & ~Q[1] & REQ & ~RW) |
                (Q[4] & E[0]) |
                (Q[4] & Q[1] & E[1]);

    // Lógica combinacional para S0
    assign S0 = (E[1] & E[0] & REQ & RW) |
                (~Q[4] & ~Q[3] & ~Q[2] & Q[1] & ~E[0] & REQ & RW) |
                (Q[1] & E[1] & E[0]) |
                (Q[2] & E[0]) |
                (Q[2] & Q[1] & ~E[1]) |
                (Q[3] & ~Q[2] & ~Q[1] & ~E[1]) |
                (Q[3] & ~Q[2] & ~E[1] & ~E[0]) |
                (Q[3] & ~Q[1] & E[0]) |
                (Q[3] & E[0] & REQ & RW) |
                (Q[4] & ~Q[1] & ~E[1]) |
                (Q[4] & E[0]) |
                (Q[4] & Q[2]) |
                (Q[4] & Q[3]);

    // Flip-flops com reset para E[1:0]
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            E <= 2'b00;  // Reset de E[1:0]
        end else begin
            E[1] <= S1;  // Armazena o valor de S1
            E[0] <= S0;  // Armazena o valor de S0
        end
    end

endmodule
