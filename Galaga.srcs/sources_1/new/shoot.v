`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: shoot
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


module shoot
(
input [24:0] VGA_Ctrl,
input [10:0] Xmove,
input [9:0] Ymove,
input btn,
input collision,
input [1:0] state,
output reg [3:0] RGB,
output reg action
);

    reg [3:0] bullet [255:0];
    reg [9:0] Y;
    reg [10:0] X;
    
    wire [10:0] PixX=VGA_Ctrl[21:11]-X;
    wire [9:0] PixY=VGA_Ctrl[10:1]-Ymove+Y-6'd32; 
    wire position = PixX[9:6]==0 && PixY[9:6]==0;     
    
    initial $readmemh("ShootSprite.txt", bullet);
    always@(posedge VGA_Ctrl[0])
    begin
        RGB<= position && action ? bullet[PixX[5:2]+16*PixY[5:2]]: 16'd0;
        if((VGA_Ctrl[21:11]==1130) && (VGA_Ctrl[10:1]==770) && state==1)
        begin   
                if (Y<11'd701 && action)Y<=Y+4'd10;
                if (Y==11'd700) action<=0;
                if (btn && action==0) 
                begin
                   X<=Xmove;
                   Y<=0;
                   action<=1;
                end
        end
        if(collision) action<=0;
    end

endmodule

