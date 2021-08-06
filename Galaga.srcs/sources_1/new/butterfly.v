`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: butterfly
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


module butterfly
(
input [24:0] VGA_Ctrl,
input [10:0] Xmove,
input [9:0] Ymove,
input dead,
input shoot,
input start,
output [3:0] bulletRGB,
output [3:0] RGB
);
   
    wire [10:0] PixX=VGA_Ctrl[21:11]-Xmove+dead*32;
    wire [9:0] PixY=VGA_Ctrl[10:1]-Ymove+(dead*32); 
    wire position = PixX[9:6]==0 && PixY[9:6]==0;
    wire deadposition = PixX[9:7]==0 && PixY[9:7]==0;
    wire [3:0] shootRGB;
        
    (*ram_style="Block"*)reg [3:0] butterfly [511:0];
    (*ram_style="Block"*)reg [3:0] deadbutterfly [5119:0];
    
    reg [24:0] timer;
    reg animation;
    reg [2:0] deadanimation;
    reg[3:0]butterflyRGB;
    reg[3:0]deadRGB;
    
    initial $readmemh("EnemyButterflySprite.txt", butterfly);
    initial $readmemh("EnemyDeadSprite.txt", deadbutterfly);
    
    enemyshoot enemyshoot_inst(VGA_Ctrl,Xmove,Ymove,shoot,start,shootRGB);
    
    always@(posedge VGA_Ctrl[0])
    begin
        butterflyRGB <= position ? butterfly[(animation*9'd256+PixX[5:2])+5'd16*PixY[5:2]]: 4'd0;
        deadRGB <= deadposition ? deadbutterfly[(deadanimation*1024+PixX[6:2])+6'd32*PixY[6:2]]: 4'd0;
        timer<=timer+1'd1;
    end
    
   always@(posedge timer[23])
        begin
            if (dead && deadanimation < 5) deadanimation <= deadanimation+1'd1;
            if (!dead)deadanimation<=0;
        end
     
     always@(posedge timer[24])
         animation <= animation+1'd1;
         
      assign RGB= dead && deadanimation!=5 ? deadRGB:  
                        butterflyRGB && !dead ? butterflyRGB :
                        4'd0;
      assign bulletRGB = shootRGB ? shootRGB: 4'd0;

endmodule