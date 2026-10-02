`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2026 15:32:20
// Design Name: 
// Module Name: MAC_tb
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



module MAC_tb;

     reg s00_axi_aclk;
     reg s00_axi_aresetn;
     reg clear;
     reg [31 : 0] data_A;
     reg [31 : 0] data_B;
     wire [31 : 0] data_R;
         
     MAC dut (
         .s00_axi_aclk(s00_axi_aclk),
         .s00_axi_aresetn(s00_axi_aresetn),
         .clear(clear),
         .data_A(data_A),
         .data_B(data_B),
         .data_R(data_R)
     );

  initial s00_axi_aclk = 0;
  always #5 s00_axi_aclk =~s00_axi_aclk;
  integer errors = 0;
  
  initial begin 
        clear = 0;
        s00_axi_aresetn = 0;
        #6; 
        
        if (data_R !== 0) begin
            $display("FAIL: for output got %d, expected %d", data_R, 0);
            errors = errors + 1;
        end
        
        s00_axi_aresetn = 1;
        data_A = 2;
        data_B = 3;
        #10;
        
        if (data_R !== 6) begin
            $display("FAIL: for output got %d, expected %d", data_R, 6);
            errors = errors + 1;
        end
        
        data_A = 4;
        data_B = 5;
        #10;
        
        if (data_R !== 26) begin
            $display("FAIL: for output got %d, expected %d", data_R, 26);
            errors = errors + 1;
        end       
        
        clear = 1;
        data_A = 1;
        data_B = 1;
        #10;
        
        if (data_R !== 1) begin
            $display("FAIL: for output got %d, expected %d", data_R, 1);
            errors = errors + 1;
        end  
        
        clear = 0;
        data_A = 2;
        data_B = 1;
        #10;

        if (data_R !== 3) begin
            $display("FAIL: for output got %d, expected %d", data_R, 3);
            errors = errors + 1;
        end  
            
        data_A = 0;
        data_B = 0;
        
        
        if (errors !== 0) 
            $display("FAIL: %d errors found", errors);
        else
            $display("All tests passed!");
        
        
       
        $finish;
  end   
endmodule

