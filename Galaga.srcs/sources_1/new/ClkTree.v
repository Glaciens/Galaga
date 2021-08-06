`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: ClkTree
// Project Name: Galaga
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


module ClkTree
(
input clk,
output Clk75MHz
);

wire feedback,Clk75MHz_unbuff;

 MMCME2_BASE #(
     .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
     .CLKFBOUT_MULT_F(30.0),     // Multiply value for all CLKOUT (2.000-64.000).
     .CLKIN1_PERIOD(8.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
     .CLKOUT0_DIVIDE_F(10.0),    // Divide amount for CLKOUT0 (1.000-128.000).
     .DIVCLK_DIVIDE(5)         // Master division value (1-106)
 )
  MMCME2_BASE_inst (
     // Clock Outputs: 1-bit (each) output: User configurable clock outputs
     .CLKOUT0(Clk75MHz_unbuff),     // 1-bit output: CLKOUT0
     // Feedback Clocks: 1-bit (each) output: Clock feedback ports
     .CLKFBOUT(feedback),   // 1-bit output: Feedback clock
     // Status Ports: 1-bit (each) output: MMCM status ports
     // Clock Inputs: 1-bit (each) input: Clock input
     .CLKIN1(clk),       // 1-bit input: Clock
     // Control Ports: 1-bit (each) input: MMCM control ports
     .PWRDWN(1'b0),       // 1-bit input: Power-down
     .RST(1'b0),             // 1-bit input: Reset
     // Feedback Clocks: 1-bit (each) input: Clock feedback ports
     .CLKFBIN(feedback)      // 1-bit input: Feedback clock
  );
  
    BUFG BUFG_inst (.O(Clk75MHz),.I(Clk75MHz_unbuff));
    
endmodule

