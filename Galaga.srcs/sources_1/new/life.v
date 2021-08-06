`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 19:03:34
// Design Name: 
// Module Name: life
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


module life
(
input [24:0] VGA_Ctrl,
input [1:0] lifeship,
output reg [3:0] RGB
);
   
    wire position = VGA_Ctrl[20:17]<lifeship && VGA_Ctrl[10:7]==11;  

    reg [3:0] life [255:0];
    
    initial $readmemh("LifeShipSprite.txt", life);
 
    always@(posedge VGA_Ctrl[0])
        RGB <= position ? life[VGA_Ctrl[16:13]+ VGA_Ctrl[6:3]*9'd16]: 4'd0;

endmodule
