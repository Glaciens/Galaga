`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 19:03:20
// Design Name: 
// Module Name: VGA1024
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


module VGA1024(
input Clk75MHz, 
output [24:0] VGA_Ctrl
);

    reg [10:0] PixX=11'd0;
    reg [9:0] PixY=10'd0;
    reg vga_hs, vga_vs, visible;
   
    always@(posedge Clk75MHz) begin

       if(PixX == 1327)
       begin
            PixX <= 0;
            PixY<=(PixY==805)?0:PixY+1;
       end
       else
            PixX<=PixX+1;
        
        vga_hs<=(PixX<1047)||(PixX>1183);
        vga_vs<=(PixY<770)||(PixY>776);

        if(PixX > 1024 || PixY > 768)
        visible=1'd0;
        else
        visible=1'd1;
    end
 
    assign VGA_Ctrl={visible, vga_hs, vga_vs, PixX, PixY, Clk75MHz};
    
endmodule
