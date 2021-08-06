`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 19:03:34
// Design Name: 
// Module Name: menu
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


module menu
(
input [24:0] VGA_Ctrl,
input btn,
input GameOver,
output reg [1:0] state,
output [3:0] menuRGB
);
   
    wire [10:0] PixX=VGA_Ctrl[21:11];
    wire [9:0] PixY=VGA_Ctrl[10:1];
    wire letS;
    wire letT;
    wire letA;
    wire letR;
    wire letT2;
    wire letG;
    wire letA2;
    wire letM;
    wire letE;
    wire letO;
    wire letV;
    wire letE2;
    wire letR2;
    
    reg [3:0] logoRGB;
    reg buffer;
    
    (*ram_style="Block"*)reg [3:0] logo [37119:0];
    (*ram_style="Block"*)initial $readmemh("LogoSprite.txt", logo);
 
    always@(posedge VGA_Ctrl[0])
    begin
        logoRGB <= logo[PixX[9:2]+256*PixY[9:2]];
        buffer<=btn | GameOver; 
    end      
      
    always@(posedge buffer)
        case (state)
            2'd0:   if (btn) state<=2'd1; //menu
            2'd1:   begin               // play
                    if(GameOver) state<=2'd3;
                    if(btn)state<=2'd2;
                    end
            2'd2:   if (btn) state<=2'd1;  //pause       
            2'd3:   if (btn) state<=2'd0;  //GameOver
         endcase
      
    letter letterS(VGA_Ctrl,13,16,state==2?15:18,letS);
    letter letterT(VGA_Ctrl,14,16,state==2?0:19,letT);
    letter letterA(VGA_Ctrl,15,16,state==2?20:0,letA);
    letter letterR(VGA_Ctrl,16,16,state==2?18:17,letR);
    letter letterT2(VGA_Ctrl,17,16,state==2?4:19,letT2);
    
    letter letterG(VGA_Ctrl,11,16,6,letG);
    letter letterA2(VGA_Ctrl,12,16,0,letA2);
    letter letterM(VGA_Ctrl,13,16,12,letM);
    letter letterE(VGA_Ctrl,14,16,4,letE);
    letter letterO(VGA_Ctrl,16,16,14,letO);
    letter letterV(VGA_Ctrl,17,16,21,letV);
    letter letterE2(VGA_Ctrl,18,16,4,letE2);
    letter letterR2(VGA_Ctrl,19,16,17,letR2);

    
    assign menuRGB =    state==3 && (letG || letA2 || letM || letE || letO || letV || letE2 || letR2)? 4'h5:
                        !state[0] && (letS || letT || letA || letR || letT2) ? 4'h5:
                        !state[0]&& logoRGB>0 ? logoRGB :
                        4'h0;

endmodule
