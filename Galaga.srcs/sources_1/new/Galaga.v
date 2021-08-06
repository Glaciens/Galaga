`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2018 18:48:48
// Design Name: 
// Module Name: Galaga
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


module Galaga
(
input clk,
input [3:0] btn,   
output vga_hs,vga_vs,
output [4:0]vga_r,vga_b, 
output [5:0] vga_g
);

    wire Clk75MHz;
    wire [24:0] VGA_Ctrl;
    wire [3:0] playerRGB;
    wire [3:0] lifeRGB;
    wire [3:0] enemyRGB;
    wire [3:0] backRGB;
    wire letterRGB;
    wire digitRGB;
    wire [20:0] point;
    wire collision;
    wire [3:0] RGB4Bit;
    wire [15:0] RGB16Bit;
    wire [5:0] ebene;
    wire [3:0] ebeneRGB;
    wire [3:0] logoRGB;
    wire [1:0] lifeship;
    wire GameOver;
    wire [1:0] state;
    wire playerdead;
    
    ClkTree CLKTree_inst(clk, Clk75MHz);
    VGA1024 VGA1024_inst(Clk75MHz, VGA_Ctrl);
    player player_inst(VGA_Ctrl, btn [3:0], state,collision, enemyRGB,GameOver,playerdead,lifeship ,playerRGB);
    score score_inst(VGA_Ctrl, point, state, digitRGB, letterRGB);
    life life_inst(VGA_Ctrl,lifeship, lifeRGB);
    background background_inst(VGA_Ctrl,btn,state,backRGB);
    level level_inst(VGA_Ctrl, playerRGB,state,playerdead, point, collision, enemyRGB, ebene);
    RGB_Converter converter_inst(VGA_Ctrl[0],RGB4Bit,RGB16Bit);
    ebene ebene_inst(VGA_Ctrl,ebene,ebeneRGB);
    menu menu_inst(VGA_Ctrl,btn[2],GameOver,state,logoRGB);
    
    assign RGB4Bit =  playerRGB>0 ? playerRGB:
                      logoRGB>0 ? logoRGB:
                      digitRGB>0 && state? 4'h6:
                      letterRGB>0 && state? 4'h5:
                      ebeneRGB>0 && state? ebeneRGB:
                      lifeRGB>0 && state? lifeRGB:
                      enemyRGB>0 ? enemyRGB:
                      backRGB>0 ? backRGB:
                      4'd0;
    
    assign vga_hs=VGA_Ctrl[23];
    assign vga_vs=VGA_Ctrl[22]; 
    assign {vga_r,vga_g,vga_b} = ~VGA_Ctrl[24] ? 16'd0: RGB16Bit;
   
endmodule

