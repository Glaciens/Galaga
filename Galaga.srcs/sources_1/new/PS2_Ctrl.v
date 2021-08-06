`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2018 15:43:32
// Design Name: 
// Module Name: PS2_Ctrl
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


module PS2_Ctrl(
input Clk75MHz,
output ps2clk
    );
    
    reg [10:0] timer;
    
    always@(posedge Clk75MHz)
        timer<=timer+1;
        
    assign ps2 = timer[10];
endmodule
