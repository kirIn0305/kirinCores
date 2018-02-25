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

module lbuCtrlPtrRegs #(
    parameter p_mode = 3,
    parameter p_stride = 3,
    parameter p_PtrOpNone = 3'd0,
    parameter p_PtrOpRst = 3'd1,
    parameter p_PtrOpIncr = 3'd2,
    parameter p_PtrOpDecr = 3'd3,
)
(
    input wire [p_mode-1:0] mode,    
    input wire [p_stride-1:0] stride,
        );

    //================================================================================
    // wire and regs 
    //================================================================================

    //================================================================================
    // Function
    //================================================================================
    function f_PtrUpdate;
        input [p_mode-1:0] opcode;
        input signed [p_stride-1:0] stride;
        begin
            if(opcode == p_PtrOpDecr)
                opcode = - opcode;
        end
    endfunction

    //function f_wrapAroundDetect;
    //    input;
    //begin
    //end
    //endfunction
    //================================================================================
    // main
    //================================================================================


    

endmodule
