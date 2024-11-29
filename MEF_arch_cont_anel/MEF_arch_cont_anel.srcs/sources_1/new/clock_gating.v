`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITA
// Engineer: Felipe Ferreira Nascimento
// 
// Create Date: 11/28/2024 05:26:14 PM
// Design Name: 
// Module Name: clock_gating
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


module clock_gating_control (
    input wire clk,            // Clock de entrada
    input wire [4:1] Q,        // Entrada Q (4 bits) do decodificador
    input wire [1:0] E,        // Entrada E (2 bits) da máquina de estados
    input wire CL,             // Entrada feedback clear do contador em anel
    output wire clk_out        // Clock de saída condicionado
);

    reg enable;                // Controle de enable
    reg enable_sync;           // Sinal sincronizado

    // Lógica combinacional para determinar o estado do enable
    always @(*) begin
        if ((Q == 4'b0110 && E == 2'b01 && CL == 1) || (Q == 4'b0101 && E == 2'b01 && CL == 1) || (Q == 4'b1000 && E == 2'b10 && CL == 1))  begin
               // if ((Q == 4'b0101 && E == 2'b01) || (Q == 4'b1000 && E == 2'b10) || (Q == 4'b0110 && E == 2'b01) || (Q == 4'b1110 && E == 2'b01)) begin

            enable = 0; // Desativa o clock
        end else begin
            enable = 1; // Ativa o clock
        end
    end

    // Sincroniza o enable com o clock
    always @(posedge clk) begin
        enable_sync <= enable;
    end

    // Porta AND para condicionar o clock
    assign clk_out = clk & enable_sync;

endmodule





