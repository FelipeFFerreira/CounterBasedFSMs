module top_level (
    input wire clk,           // Clock principal
    input wire reset,         // Sinal de reset
    input wire REQ,           // Sinal de requisição
    input wire RW,            // Sinal de leitura/escrita
    output wire DOUT,         // Saída DOUT
    output wire DA,           // Saída DA
    output wire WE,           // Saída WE
    output wire WC,           // Saída WC
    output wire C0,           // Saída C0
    output wire C1            // Saída C1
);

    // Declaração dos sinais internos
    wire [9:1] Q_ring;        // Saída do contador em anel
    wire [4:1] C_decoder;     // Saída do decodificador
    wire [1:0] E;             // Saída da FSM
    wire clear;               // Controle do clear
    wire clk_out;             // Clock condicionado para o contador

    // Instanciar o contador em anel
    ring_counter uut_ring_counter (
        .clk(clk_out),        // Clock condicionado
        .clear(clear),
        .Q(Q_ring)
    );

    // Instanciar o decodificador
    decoder_one_hot uut_decoder (
        .Q(Q_ring),
        .C(C_decoder)
    );

    // Instanciar a máquina de estados
    fsm uut_fsm (
        .clk(clk),
        .reset(reset),
        .Q(C_decoder),
        .REQ(REQ),
        .RW(RW),
        .E(E)
    );

    // Instanciar o módulo de controle do clear
    clear_control uut_clear_control (
        .Q(C_decoder),
        .E(E),
        .REQ(REQ),
        .RW(RW),
        .clear(clear)
    );

    // Instanciar o módulo de controle de clock
    clock_gating_control uut_clock_control (
        .clk(clk),
        .Q(C_decoder),
        .E(E),
        .clk_out(clk_out)
    );

    // Instanciar o módulo de saída
    output_decoder uut_output_decoder (
        .Q(C_decoder),
        .E(E),
        .DOUT(DOUT),
        .DA(DA),
        .WE(WE),
        .WC(WC),
        .C0(C0),
        .C1(C1)
    );

endmodule
