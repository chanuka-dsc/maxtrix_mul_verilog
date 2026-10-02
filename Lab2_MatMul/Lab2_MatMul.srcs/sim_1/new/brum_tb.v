`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2026 18:26:55
// Design Name: 
// Module Name: brum_tb
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

module bram_tb;
    reg clk;
    reg resetn;
    reg en;
    reg rw;
    reg [1 : 0] addr;
    reg [31 : 0] data_in;
    wire [31 : 0] data_out;
     
    bram dut (.s00_axi_aclk(clk), .s00_axi_aresetn(resetn), .en(en), .addr(addr), .data_in(data_in), .data_out(data_out), .rw(rw));
    
    initial clk = 1; 
    always #5 clk = ~clk;
    integer i;
    integer j;
    integer errors = 0;
    initial begin
        en = 1; rw = 1; resetn = 1;
        #1; // 1ns to avoind race conditions 
        resetn = 0;
        
        // write phase
        for(i = 0; i < 4; i = i + 1) begin
            addr = i;
            data_in = (i+1)*10;
            #10; // one cycle 
        end
        
        // read phase
        rw = 0;
        for( j = 0; j < 4 ; j = j + 1) begin
            addr = j;
            #10; // one cycle
            if(data_out !== (j+1)*10) begin
                  $display("FAIL: addr=%d got %d, expected %d", addr, data_out, (j+1)*10);
                  errors = errors + 1;
            end
        end
        
        
        if(errors === 0)
          $display("All tests passed");
        else
          $display("Test failed %d errors found", errors);

        $finish;
    end
     
endmodule