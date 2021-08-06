`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2018 18:52:52
// Design Name: 
// Module Name: ebene
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


module ebene(
input [24:0] VGA_Ctrl,
input [5:0]ebene,
output [3:0] ebeneRGB
);
   
    wire [10:0] PixX=VGA_Ctrl[21:11];
    wire [9:0] PixY=VGA_Ctrl[10:1]; 
    wire position1 = PixX[9:5]>31-(ebene%5) && PixY[9:6]==11;
    wire position2 = PixX[9:5]==27 && PixY[9:6]==11;
    wire position3 = PixX[9:6]==12 && PixY[9:6]==11;
    wire position4 = PixX[9:6]==11 && PixY[9:6]==11;
    wire position5 = PixX[9:6]==10 && PixY[9:6]==11;
    wire position6 = PixX[9:6]==9  && PixY[9:6]==11;
        
    (*ram_style="Block"*)reg [3:0] level1 [127:0];
    (*ram_style="Block"*)reg [3:0] level5 [127:0];
    (*ram_style="Block"*)reg [3:0] level10 [255:0];
    (*ram_style="Block"*)reg [3:0] level20 [255:0];
    (*ram_style="Block"*)reg [3:0] level30 [255:0];
    (*ram_style="Block"*)reg [3:0] level50 [255:0];
     
    reg [3:0] stage1RGB;
    reg [3:0] stage2RGB;
    reg [3:0] stage3RGB;
    reg [3:0] stage4RGB;
    reg [3:0] stage5RGB;
    reg [3:0] stage6RGB;
   
    initial $readmemh("lvl1.txt", level1);
    initial $readmemh("lvl5.txt", level5);
    initial $readmemh("lvl10.txt", level10);
    initial $readmemh("lvl20.txt", level20);
    initial $readmemh("lvl30.txt", level30);
    initial $readmemh("lvl50.txt", level50);
    
    always@(posedge VGA_Ctrl[0])
    begin
        stage1RGB<= position1 ? level1[PixX[4:2]+8*PixY[5:2]]: 4'd0;
        stage2RGB<= position2 ? level5[PixX[4:2]+8*PixY[5:2]]: 4'd0;
        stage3RGB<= position3 ? level10[PixX[5:2]+16*PixY[5:2]]: 4'd0;
        stage4RGB<= position4 ? level20[PixX[5:2]+16*PixY[5:2]]: 4'd0;
        stage5RGB<= position5 ? level30[PixX[5:2]+16*PixY[5:2]]: 4'd0;
        stage6RGB<= position6 ? level50[PixX[5:2]+16*PixY[5:2]]: 4'd0;
    end
        
    assign ebeneRGB =   stage1RGB>0 ? stage1RGB : 
                        stage2RGB>0 && ((ebene%10)>=5) ? stage2RGB :
                        stage3RGB>0 && ((ebene>=10 && ebene<=19)||(ebene>=40 && ebene<=49)) ? stage3RGB :
                        stage4RGB>0 && ebene>=20 && ebene<=29 ? stage4RGB :
                        stage5RGB>0 && ebene>=30 && ebene<=49 ? stage5RGB :
                        stage6RGB>0 && ebene>=50 ? stage6RGB :
                        4'd0 ;
                         
endmodule