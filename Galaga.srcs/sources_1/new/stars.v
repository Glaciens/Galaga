`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 21.05.2018 03:01:26
// Design Name: 
// Module Name: stars
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


module stars(
    input [24:0] VGA_Ctrl,
    output RGB
    );
    
//       wire [2:0] X = VGA_Ctrl[15:13];
//       wire [2:0] Y;
//       wire position = {VGA_Ctrl[10:6]==5}&&{VGA_Ctrl[20:16]==5};
       
//       reg [15:0] star [15:0];
//       reg [15:0] row;
//       reg [22:0] timer;
           
//       initial $readmemh("StarSprite.txt", star);
       
//       always@(posedge VGA_Ctrl[0])
//       begin
//          row<= star[Y];
//          timer<=timer+1;
//       end
        
//       assign RGB=row[X] && position;
//       assign Y= VGA_Ctrl[5:3]-timer;
      
endmodule
