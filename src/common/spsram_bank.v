/*================================================================================
| Single Port SRAM with Bank switch
|---------------------------------------------------------------------------------
| Block name  : spram_bank
| Version     : 1.0
| Description :
|     - 
|
|---------------------------------------------------------------------------------
| Created by kirin : 
\===============================================================================*/

module spsram_bank #(
    parameter DW = 8,
    parameter DEPTH = 1024, //SRAM DEPTH of 1 bank
    parameter AW = $clog2(DEPTH)
    parameter NB = 4 // Number of Bank
    )
    (
    input clk,
    input [AW-1:0] Addr,
    input [DW-1:0] Din,
    input [NB-1:0] BS, // Bank Select
    input WE,
    output [DW-1:0] Dout
);

    //====================== Reg and Wires ======================
    wire [NB-1:0] en_we;
    wire [DW*NB-1:0] dout_sram;
    genvar i;

    //====================== main ======================
    assign en_we = BS && WE;

    generate
        for(i=0; i < NB; i = i + 1) begin: bank
            spsram spsram(.clk(clk),
                          .Addr(Addr),
                          .Din(Din),
                          .WE(en_we[i]),
                          .Dout(dout_sram[DW * (i+1) - 1: DW * i]));
    endgenerate

endmodule

module spsram #(
    parameter DW = 8,
    parameter DEPTH = 1024, //SRAM DEPTH of 1 bank
    parameter AW = $clog2(DEPTH)
    )
    (
    input clk,
    input [AW-1:0] Addr,
    input [DW-1:0] Din,
    input WE,
    output [DW-1:0] Dout
);

    //====================== Reg and Wire ======================
    reg [DW-1:0] mem[0:DEPTH-1];

    always @(posedge clk) begin
        if(WE)
            mem[Addr] <= Din;
        Dout <= mem[Addr]; 
    end
endmodule
