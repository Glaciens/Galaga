`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 20.05.2018 18:51:00
// Design Name: 
// Module Name: score
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


module score(
input [24:0] VGA_Ctrl,
input [20:0] point,
input [1:0] state,
output digitRGB,
output letterRGB
    );
    
    wire let0;
    wire let1;
    wire let2;
    wire let3;
    wire let4;
    
    reg [20:0] newpoint;
    reg [3:0] ten;
    reg [3:0] hundret;
    reg [3:0] thousand;
    reg [3:0] tenT;
    reg [3:0] hundretT;
    reg [3:0] mio;
          
    always@(posedge VGA_Ctrl[0])
        if (VGA_Ctrl [21:11] == 1030 && VGA_Ctrl [10:1] == 770)
        begin
            if(!state) 
            begin
                newpoint<=0;
                ten<=0;
                hundret<=0;
                thousand<=0;
                tenT<=0;
                hundretT<=0;
                mio<=0;
            end   
            if(point!=newpoint && state[0])
            begin 
                newpoint<=newpoint+1;    
                if(ten!=9) 
                    ten<=ten+1;
                else
                begin
                    ten<=0;
                    hundret<=hundret+1;
                end
                
                if(hundret==10) 
                begin
                    hundret<=0;
                    thousand<=thousand+1;
                end
                
                if(thousand==10) 
                begin
                    thousand<=0;
                    tenT<=tenT+1;
                end
                
                if(tenT==10) 
                begin
                    tenT<=0;
                    hundretT<=hundretT+1;
                end
                
                if(hundretT==10)
                begin
                    hundretT<=0;
                    mio<=mio+1;
                end                
             
                if(mio==10)
                begin
                    mio<=0;
                end  
              end  
            end
            
    letter letterS(VGA_Ctrl,16,0,18,let0);
    letter letterC(VGA_Ctrl,17,0,2,let1);
    letter letterO(VGA_Ctrl,18,0,14,let2);
    letter letterR(VGA_Ctrl,19,0,17,let3);
    letter letterE(VGA_Ctrl,20,0,4,let4);
    
    wire dig0;
    wire dig1;
    wire dig2;
    wire dig3;
    wire dig4;
    wire dig5;
    wire dig6;
    
    digit digit0(VGA_Ctrl,31,0,0,dig0);
    digit digit1(VGA_Ctrl,30,0,ten,dig1);
    digit digit2(VGA_Ctrl,29,0,hundret,dig2);
    digit digit3(VGA_Ctrl,28,0,thousand,dig3);
    digit digit4(VGA_Ctrl,27,0,tenT,dig4);
    digit digit5(VGA_Ctrl,26,0,hundretT,dig5);
    digit digit6(VGA_Ctrl,25,0,mio,dig6);
    
    assign digitRGB=dig0||(dig1 && point >= 1)||(dig2 && point >= 10)||(dig3 && point >= 100)||(dig4 && point >= 1000)||(dig5 && point > 10000)||(dig6 && point > 100000);
    assign letterRGB=let0||let1||let2||let3||let4;
   
endmodule

