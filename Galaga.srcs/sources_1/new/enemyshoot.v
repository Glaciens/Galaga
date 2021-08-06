`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: enemyshoot
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


module enemyshoot
(
input [24:0] VGA_Ctrl,
input [10:0] X,
input [9:0] Y,
input shoot,
input start,
output reg [3:0] RGB
);
 
    reg [3:0] bullet [255:0];    
    reg action=0;
    reg [9:0] Ymove;
    reg [9:0] Xmove;
    reg stop;
    
    wire [10:0] PixX=VGA_Ctrl[21:11]-Xmove;
    wire [9:0] PixY=VGA_Ctrl[10:1]-Ymove+32-Y; 
    wire position = {PixX[9:6]==0}&&{PixY[9:6]==0};     
    
    initial $readmemh("EnemyShootSprite.txt", bullet);
    
    always@(posedge VGA_Ctrl[0])
    begin
        RGB<= position && action ? bullet[PixX[5:2]+16*PixY[5:2]]: 4'd0;
        if(shoot && !action) 
        begin
            action<=1;
            Xmove<=X;
        end
        if((VGA_Ctrl[21:11]==1030) && (VGA_Ctrl[10:1]==770) && action && start)
            Ymove<=Ymove+10;
        if((VGA_Ctrl[10:1]==768 && RGB))
        begin 
            Ymove<=0;
            action<=0;
        end
    end

endmodule
