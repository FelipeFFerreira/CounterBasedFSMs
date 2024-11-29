`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2024 07:00:26 PM
// Design Name: 
// Module Name: ring_counter
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


module ring_counter (
    input clk,           // Clock para transição do contador
    input clear,         // Entrada CLEAR (se 0, mantém em Q1)
    output reg [9:1] Q   // Saída one-hot (Q1 a Q9)
);
    always @(posedge clk) begin
        if (!clear) begin
            // CLEAR ativo: Mantém em Q1 (000000001)
            Q <= 9'b000000001;
        end else begin
            // Contagem em anel
            Q <= {Q[8:1], Q[9]}; // Rotação da saída one-hot
        end
    end

    initial begin
        // Inicializa no estado Q1
        Q = 9'b000000001;
    end
endmodule


