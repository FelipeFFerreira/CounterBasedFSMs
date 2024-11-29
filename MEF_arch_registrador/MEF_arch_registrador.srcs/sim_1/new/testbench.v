`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 02:30:20 PM
// Design Name: 
// Module Name: testbench controlador de memoria baseado em registrador
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

module tb_top_level;

    // Declaração de sinais
    reg clk;       // Clock
    reg rst;       // Reset síncrono
    reg rw;        // Entrada RW
    reg req;       // Entrada REQ
    wire dout;     // Saída DOUT
    wire da;       // Saída DA
    wire we;       // Saída WE
    wire wc;       // Saída WC
    wire c0;       // Saída C0
    wire c1;       // Saída C1

    // Instanciação do módulo top-level
    top_level uut (
        .clk(clk),
        .rst(rst),
        .rw(rw),
        .req(req),
        .dout(dout),
        .da(da),
        .we(we),
        .wc(wc),
        .c0(c0),
        .c1(c1)
    );

    // Geração do clock (período de 10 unidades de tempo)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock alternando a cada 5 unidades de tempo
    end

    // Teste funcional
    initial begin
        // Monitoramento das saídas
        $monitor("Tempo = %0t | REQ = %b | RW = %b | DOUT = %b | DA = %b | WE = %b | WC = %b | C0 = %b | C1 = %b",
                 $time, req, rw, dout, da, we, wc, c0, c1);

        // Fluxo de teste
        // 1. Realizar o reset do circuito
        rst = 1; req = 0; rw = 0;  // Inicialização com reset ativado
        #20 rst = 0;               // Libera o reset após 20 unidades de tempo

        // 2. Manter REQ = 0 por 6 ciclos
        #60 req = 0; rw = 0;

        // 3. Fazer REQ = 1 e RW = 1 por 1 ciclo, manter por 6 ciclos
        #10 req = 1; rw = 1;       // Ativa REQ = 1 e RW = 1
        #60;                       // Mantém por 6 ciclos de clock

        // 4. Fazer REQ = 0 e manter por 6 ciclos
        #10 req = 0; rw = 0;       // REQ volta a 0
        #60;                       // Mantém por 6 ciclos de clock

        // 5. Fazer REQ = 1 e RW = 0 por 1 ciclo, manter por 9 ciclos
        #10 req = 1; rw = 0;       // Ativa REQ = 1 e RW = 0
        #90;                       // Mantém por 9 ciclos de clock

        // 6. Fazer REQ = 0 e manter por 6 ciclos
        #10 req = 0; rw = 0;       // REQ volta a 0
        #60;                       // Mantém por 6 ciclos de clock

        // Finaliza a simulação
        #10 $stop;
    end

endmodule
