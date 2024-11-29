`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 08:19:57 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register (
    input wire clk,          // Sinal de clock
    input wire rst,          // Sinal de reset síncrono
    input wire LD,           // Sinal de LOAD
    input wire [3:0] P,// Entrada paralela para LOAD
    input wire ES,           // Entrada do bit MSB
    output reg [3:0] Q       // Saída do registrador
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset síncrono: zera o registrador
            Q <= 4'b0000;
        end else if (LD) begin
            // LOAD: Carrega a entrada deslocada e insere LS no MSB
            Q <= {ES, P[3:1]};
        end else begin
            // Deslocamento à direita: Insere LS no MSB
            Q <= {ES, Q[3:1]};
        end
    end

endmodule
