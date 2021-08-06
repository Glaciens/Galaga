`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: player
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


module ship
(
input [24:0] VGA_Ctrl,
input [10:0] Xmove,
input [9:0] Ymove,
input dead,
input [1:0] state,
output [3:0] RGB
);
   
    wire [10:0] PixX=VGA_Ctrl[21:11]-Xmove+(dead*32);
    wire [9:0] PixY=VGA_Ctrl[10:1]-Ymove+(dead*32);
    wire position = PixX[9:6]==0 && PixY[9:6]==0; 
    wire deadposition = PixX[9:7]==0 && PixY[9:7]==0; 
    
    reg [3:0]playerRGB;    
    reg [3:0]deadRGB;    
    reg [2:0]deadanimation=0;
    reg [23:0] timer; 

    (*ram_style="Block"*)reg [3:0] playership [255:0];
    (*ram_style="Block"*)reg [3:0] deadship [4095:0];
    
    initial $readmemh("PlayerShipSprite.txt", playership);
    initial $readmemh("PlayerDeadSprite.txt", deadship);
    
    always@(posedge VGA_Ctrl[0])
    begin
       playerRGB<= position ? playership[PixX[5:2]+PixY[5:2]*9'd16]: 4'd0;
       deadRGB<= deadposition ? deadship[(deadanimation*13'd1024)+PixX[6:2]+PixY[6:2]*10'd32]: 4'd0; 
       timer<=timer+1;
    end
    
    always@(posedge timer[23])
    begin
        if (dead && deadanimation < 4 && state[0]) deadanimation <= deadanimation+1'd1;
        if (!dead)deadanimation<=0;
    end
    
    assign RGB= !dead ? playerRGB :
                deadanimation != 4 ? deadRGB:
                4'd0;
 
endmodule
