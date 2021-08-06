`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2018 19:07:54
// Design Name: 
// Module Name: letter
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


module letter(
input [24:0] VGA_Ctrl,
input [5:0]Xpos,
input [5:0]Ypos,
input [5:0]i,
output let
    );
    
     wire [2:0] X = VGA_Ctrl[15:13];
     wire [2:0] Y = VGA_Ctrl[5:3];
     wire istPos = VGA_Ctrl[10:6]==Ypos && VGA_Ctrl[20:16]==Xpos;
    
     reg [7:0] dec [207:0];
     reg [7:0] row;
        
     initial $readmemh("LetterSprite.txt", dec);
    
     always@(posedge VGA_Ctrl[0])
        row<= dec[Y+(i*8)];
     
     assign let=row[~X]&&istPos;
endmodule

