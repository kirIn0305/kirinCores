/*================================================================================
| regfile
|---------------------------------------------------------------------------------
| Block name  : regfile
| Version     : 1.0
| Description :
|     - Reg File
|     - Read Latency : 0cycle
|     - Write Latency : 1cycle
|
|---------------------------------------------------------------------------------
| Created by kirin : 
\===============================================================================*/

module regfile #(
    parameter DW = 8,
    parameter DEPTH = 256,
    parameter AW = $clog2(DEPTH)
    )
    (
    input clk,
    input rst,
    input we,
    input [AW-1:0] Addr,
    input [DW-1:0] Din,
    output [DW-1:0] Dout
);

    //====================== Reg and Wire ======================
    reg [DW-1:0] rf[0:DEPTH-1];
    integer i

    //====================== main  ======================
    always @(posedge clk) begin
        if(rst)
            for (i = 0; i < DEPTH-1; i = i+1)
                rf[i] <= 0;
        else
            if(we)
                rf[Addr] <= Din;
    end

    assign Dout = rf[Addr];

endmodule
