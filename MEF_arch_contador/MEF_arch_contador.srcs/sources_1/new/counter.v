`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 02:27:19 PM
// Design Name: 
// Module Name: counter
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


module counter (
    input wire clk,          // Sinal de clock
    input wire rst,          // Sinal de reset síncrono
    input wire LD,           // Sinal de LOAD
    input wire [3:0] P,      // Entrada paralela (valor a ser carregado)
    output reg [3:0] Q       // Saída do contador
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset síncrono: zera o contador
            Q <= 4'b0000;
        end else if (LD) begin
            // Se LOAD (LD) = 1, carrega o valor da entrada P
            Q <= P;
        end else begin
            // Caso contrário, incrementa o contador
            Q <= Q + 1;
        end
    end

endmodule
