`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 05:35:03 PM
// Design Name: 
// Module Name: controller_mem registrador
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


module top_level (
    input wire clk,          // Clock
    input wire rst,          // Reset síncrono
    input wire rw,           // Entrada RW
    input wire req,          // Entrada REQ
    output wire dout,        // Saída DOUT
    output wire da,          // Saída DA
    output wire we,          // Saída WE
    output wire wc,          // Saída WC
    output wire c0,          // Saída C0
    output wire c1           // Saída C1
);

    // Declaração de sinais internos
    wire ld;                 // Controle de LOAD para o registrador
    wire es;                 // bit MSB para o registrador
    wire [3:0] P;            // Entradas de LOAD para o registrador
    wire [3:0] Q;            // Saídas do contador (Q1-Q4)
    
    // Instanciação do contador com as saídas renomeadas
    shift_register U1 (
        .clk(clk),
        .rst(rst),
        .LD(ld),
        .ES(es),
        .P(P),
        .Q(Q)
    );

    // Renomeando os bits do contador para maior clareza
    wire Q1 = Q[3];          // Bit mais significativo
    wire Q2 = Q[2];
    wire Q3 = Q[1];
    wire Q4 = Q[0];          // Bit menos significativo

    // Bloco Lógico 1: Controle do LD
    assign ld = (~Q1 & ~Q2 & Q4) |
                (~Q1 & ~Q3 & Q4 & req & ~rw) |
                (~Q1 & Q3 & Q4 & req & rw) |
                (Q1 & ~Q2 & ~Q3 & ~rw) |
                (Q1 & ~Q2 & Q3 & ~Q4) |
                (Q1 & Q2 & Q3 & Q4);

  
  assign es =  (~Q1 & ~Q2 & ~Q3 & ~Q4 & req) |
                (Q2 & ~Q3 & Q4) |
                (Q2 & Q3 & ~Q4) |
                (Q1 & ~Q2 & ~Q3 & ~rw) |
                (Q1 & ~Q2 & Q4);

                

    // Bloco Lógico 2: Entradas de LOAD (P1-P4)
    assign P[3] = ~Q3 | (Q1 & Q2); // P1
    assign P[2] =  ~Q1 & ~Q3; // P2
    assign P[1] =  (~Q1 & ~Q3) | Q2; // P3
    assign P[0] =  (~Q1 & ~Q3) | (~Q1 & Q2);  // P4

    // Bloco Lógico 3: Saídas do Top-Level
    assign dout = (~Q2 & ~Q3) | Q4 | (Q2 & Q3) | Q1;
    assign da = ~Q3 | Q4 | Q2 | Q1;
    assign we = (~Q1 & ~Q2) | (~Q1 & ~Q3) | (~Q2 & ~Q4) | (Q2 & Q3 & Q4);
    assign wc = (~Q1 & ~Q4) | (~Q2 & Q4) | (~Q1 & Q3) | (Q1 & ~Q3);
    assign c0 = (~Q1 & Q2 & Q3 & ~Q4) | (Q1 & ~Q3 & Q4);
    assign c1 = (Q1 & ~Q2 & Q4) | (Q1 & ~Q3 & Q4);

endmodule
