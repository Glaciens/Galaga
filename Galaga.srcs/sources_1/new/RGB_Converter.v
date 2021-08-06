`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 23:11:07
// Design Name: 
// Module Name: RGB_Converter
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


module RGB_Converter(
    input clk,
    input  [3:0] RGB4bit,
    output reg [15:0] RGB16bit
    );

always@(clk)
    case(RGB4bit)
        4'h1 : RGB16bit = 16'hda00;
        4'h2 : RGB16bit = 16'h0492;
        4'h3 : RGB16bit = 16'h035b;
        4'h4 : RGB16bit = 16'hffc0;
        4'h5 : RGB16bit = 16'hf800;
        4'h6 : RGB16bit = 16'hdedb;
        4'h7 : RGB16bit = 16'h001b;
        4'h8 : RGB16bit = 16'hb81b;
        4'h9 : RGB16bit = 16'h07db;
        4'ha : RGB16bit = 16'h7651;
        4'hb : RGB16bit = 16'h7e2f;
        4'hc : RGB16bit = 16'hc525;
        4'hd : RGB16bit = 16'he982;
        4'he : RGB16bit = 16'h41e8;
      default : RGB16bit = 16'h0;
    endcase
    
endmodule
