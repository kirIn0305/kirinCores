/*================================================================================
  | Projectname
  |---------------------------------------------------------------------------------
  | Block name  : lbuPtrUpdater
  | Version     : 0.1
  | Description :
  |     - 
  |
  |---------------------------------------------------------------------------------
  | Created by  : 
  \===============================================================================*/

module lbuPtrUpdater #(
    parameter p_mode = 3,
    parameter p_stride = 8,
    parameter p_START = 24,
    parameter p_END = 24,
    parameter p_ptr= 24,
    parameter p_PtrOpNone = 3'd0,
    parameter p_PtrOpRst = 3'd1,
    parameter p_PtrOpIncr = 3'd2,
    parameter p_PtrOpDecr = 3'd3,
)
(
    input wire [p_mode-1:0] mode,    
    input wire waEn, // Wrap Around valid Enable    
    input wire lbsetEn, // lbset instruction valid signal
    input wire signed [p_stride-1:0] stride,
    input wire signed [p_START-1:0] ptr_start,
    input wire signed [p_END-1:0] ptr_end,
    input wire signed [p_ptr-1:0] r_ptr,
    output wire signed [p_ptr-1:0] lbuIDPtrUpd
);

    //================================================================================
    // wire and regs 
    //================================================================================
    wire decrementEn;
    wire signed [p_stride-1:0] stride_mux0; //decide add stride using for incr or decr
    wire signed [p_ptr-1:0] ptr_update;
    wire flagWrapStartOver;
    wire flagWrapEndOver;
    wire [p_ptr-1:0] ptr_afterWAEnd; // multiplex, calcptr or ptr_end
    wire selPtrFinal; // final ptr output multiplex selector
    wire [p_ptr-1:0] ptr_out; // multiplex, calcptr or ptr_end
    
    //================================================================================
    // main
    //================================================================================
    //----------------- incr or decr -----------------
    assign decrementEn = (mode == p_PtrOpDecr);
    assign stride_mux0 = (decrementEn)? -stride : stride;
    assign ptr_update = r_ptr + stride_mux0;

    //----------------- Wrap Around Range Detect -----------------
    // wrap around end point check
    assign flagWrapEndOver = (ptr_end < r_ptr) && waEn;
    assign ptr_afterWAEnd = (flagWrapEndOver)? ptr_end : ptr_update;
    // wrap around start point check
    assign flagWrapStartOver = (r_ptr < ptr_start) && waEn;
    // concat wrap around start, lbsetEn and rst, because ptr store value is same
    assign selPtrFinal = flagWrapStartOver | lbsetEn | (mode == p_PtrOpRst);

    assign lbuIDPtrUpd = (selPtrFinal)? ptr_start : ptr_update;
    
endmodule
