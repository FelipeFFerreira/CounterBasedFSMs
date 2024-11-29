`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2024 02:09:57 AM
// Design Name: 
// Module Name: decoder_one_hot
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

module decoder_one_hot (
    input wire [9:1] Q,       // Entradas do contador (de Q9 a Q1)
    output wire [4:1] C       // Saídas combinadas em um vetor de 4 bits
);

    // Implementação das expressões lógicas
    assign C[4] = ~Q[7] & ~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1];
    assign C[3] = ~Q[9] & ~Q[8] & ~Q[3] & ~Q[2] & ~Q[1];
    assign C[2] = ~Q[9] & ~Q[8] & ~Q[5] & ~Q[4] & ~Q[1];
    assign C[1] = ~Q[8] & ~Q[6] & ~Q[4] & ~Q[2];

endmodule

