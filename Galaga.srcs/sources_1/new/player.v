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


module player
(
input [24:0] VGA_Ctrl,
input [3:0] btn,
input [1:0]state,
input collision,
input [3:0] enemyRGB,
output reg GameOver,
output reg dead=0,
output reg [1:0] lifeship = 3,
output [3:0] RGB
);    

    reg [10:0] Xmove=11'd450;
    reg [9:0] Ymove=10'd639;
    
    wire [3:0] shipRGB;
    wire [3:0] shoot1RGB;
    wire [3:0] shoot2RGB;
    wire [10:0] Xshoot1;
    wire [10:0] Xshoot2;
    wire [9:0] Yshoot1;
    wire [9:0] Yshoot2;
    wire action1;
    wire action2;     
    wire shootenable1;
    wire shootenable2;
    
    reg [4:0] shoottime;
    reg shootready;
    reg [2:0] shootcoll=0;
    reg [8:0] timer;
     
    ship ship1(VGA_Ctrl,Xmove,Ymove,dead,state,shipRGB);
    shoot shoot1(VGA_Ctrl,Xmove,Ymove,shootenable1,shootcoll[0],state,shoot1RGB,action1);
    shoot shoot2(VGA_Ctrl,Xmove,Ymove,shootenable2,shootcoll[1],state,shoot2RGB,action2);
 
    always@(posedge VGA_Ctrl[0])
    begin
        if((VGA_Ctrl[21:11]==1030) && (VGA_Ctrl[10:1]==770) && state==1)
        begin
            if(btn[0] && !dead && Xmove !=960 && state<3)Xmove<=Xmove+5;
            if(btn[1] && !dead && Xmove!=0 && state<3)Xmove<=Xmove-5;
            shoottime <= action1 ? shoottime+1 : 0;
            if(shoottime>20 && !action2) shootready<=1;
            if(action2) shootready<=0;
            shootcoll[1:0]<=0;
            if(dead && state<3) timer<=timer+1;
        end        
        if (timer[8] && dead && state<3) 
                    begin
                        dead<=0;
                        timer<=0;
                        if(lifeship)lifeship<=lifeship-1;
                        Xmove<=450;
                    end
        if (collision && shoot1RGB) shootcoll[0] <=1;
        if (collision && shoot2RGB) shootcoll[1] <=1;
        if (enemyRGB && shipRGB && !dead) dead<=1;     
        if(state==0) 
        begin
            lifeship<=3;
            dead<=0;
            Xmove<=450;
        end
        GameOver<=(!lifeship && dead && state==1);
    end
    
    assign shootenable1 = btn[3] && !action1 && !dead && state==1;
    assign shootenable2 = btn[3] && !action2 && shootready && !dead && state==1;
    assign RGB =!state[0] ? 4'h0:
                shipRGB>0 ? shipRGB :
                state==3  ? 4'd0: 
                shoot1RGB ? shoot1RGB : 
                shoot2RGB ? shoot2RGB : 
                4'h0 ;
   
endmodule

