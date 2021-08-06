`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 21.05.2018 02:47:55
// Design Name: 
// Module Name: background
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


module background(
input [24:0] VGA_Ctrl,
input [3:0] btn,
input [1:0] state,
output [3:0] starRGB
);

    reg [6:0] Xmove;
    reg [6:0] Ymove;
    reg ostar;
    reg ystar;
    reg bstar;
    
    wire [6:0] BluePixX=VGA_Ctrl[19:13]-Ymove+4'd11;
    wire [6:0] OrangePixX=VGA_Ctrl[18:12]-Ymove+7'd55;
    wire [6:0] YellowPixX=VGA_Ctrl[17:11]-Ymove+7'd33;
    wire [6:0] BluePixY=VGA_Ctrl[9:3]-Xmove; 
    wire [6:0] OrangePixY=VGA_Ctrl[8:2]-Xmove; 
    wire [6:0] YellowPixY=VGA_Ctrl[7:1]-Xmove;  

    always@(posedge VGA_Ctrl[0])
    begin
        if((VGA_Ctrl[21:11]==8'd130) && (VGA_Ctrl[10:1]==10'd770))
        begin
            Xmove<=Xmove+1;
            if(btn[0] && state==1)Ymove<=Ymove-1'd1;
            if(btn[1] && state==1)Ymove<=Ymove+1'd1;
        end
        bstar<=(!BluePixX && BluePixY== 6'd32 )     || (BluePixX== 7'd64 && !BluePixY )     || (BluePixX== 8'd96 && BluePixY== 7'd64 )       || (BluePixX== 6'd32 && BluePixY== 8'd96 )     || (BluePixX== 7'd48 && BluePixY== 7'd48 );
        ostar<=(!OrangePixX && OrangePixY== 6'd32 ) || (OrangePixX== 7'd64 && !OrangePixY ) || (OrangePixX== 8'd96 && OrangePixY== 7'd64 )   || (OrangePixX== 6'd32 && OrangePixY== 8'd96 ) || (OrangePixX== 7'd48 && OrangePixY== 7'd48 );
        ystar<=(!YellowPixX && YellowPixY== 6'd32 ) || (YellowPixX== 7'd64 && !YellowPixY ) || (YellowPixX== 8'd96 && YellowPixY== 7'd64 )   || (YellowPixX== 6'd32 && YellowPixY== 8'd96 ) || (YellowPixX== 7'd48 && YellowPixY== 7'd48 );
    end

    assign starRGB= bstar || ostar || ystar ? 4'h6:4'h0;
    
endmodule
