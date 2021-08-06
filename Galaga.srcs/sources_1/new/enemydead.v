`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name:  enemydead
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


module enemydead
(
input [24:0]    VGA_Ctrl,
input [10:0]    Xpos,
input [9:0]     Ypos,
output reg [15:0] RGB
);
   
    wire [10:0] PixX=VGA_Ctrl[21:11]+Xpos;// movement
    wire [9:0]  PixY=VGA_Ctrl[10:1]+Ypos; 
    wire position = {PixX[9:6]>=6}&&{PixX[9:6]<=9}&&{PixY[9:6]==1};
        
    reg [15:0]  dead [511:0];
    reg [22:0]  timer;
    reg [2:0]   animation;
    
    initial $readmemh("EnemyDeadSprite.txt", dead);
    always@(posedge VGA_Ctrl[0])
    begin
        RGB <= position ? dead[(animation*9'd256+PixX[6:2])+5'd16*PixY[6:2]]: 16'd0;
        timer <= timer + 1'd1;
    end
    
    always@(posedge timer[22])
        animation <= animation < 4 ? animation + 1'd1 : 0;

endmodule
