`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2018 00:46:45
// Design Name: 
// Module Name: enemy_movement
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


module enemy_movement(
input [24:0] VGA_Ctrl,
input [1:0] state,
input [39:0] dead,
input playerdead,
output reg [1:0] phase=1,
output reg [10:0] movementX,
output reg [10:0] movementY
    );
    
    reg Xway;
    reg Yway;
    reg [3:0] round;
    
    always@(posedge VGA_Ctrl[0])
           begin
                if (!state || dead==40'hFFFFFFFFFF)
                begin
                    phase<=1;
                    movementX<=194;
                    movementY<=1;
                    round<=0;
                    Xway=0;
                    Yway=0;
                end 
                if (VGA_Ctrl [21:11] == 11'd1030 && VGA_Ctrl [10:1] == 10'd770 && state==1 && !playerdead)
                case(phase)
                    2'd0:   begin
                            movementX<=movementX+1;
                            movementY<=movementY+1;
                            end
                    2'd1:   begin
                            if (!Xway) movementX<=movementX+2;
                            else movementX<=movementX-2;
                            if(!Yway)movementY<=movementY+1;
                            else movementY<=movementY-1;
                            if (movementX == 11'd384 && !Xway) Xway<=1;                           
                            if (!movementX) Xway<=0;                           
                            if (movementX == 11'd192) 
                            begin
                                Yway<=~Yway;
                                round<=round+1;
                            end
                            if (round==4'd6) 
                            begin
                            phase<=2;
                            round<=0;
                            movementY<=0;
                            movementX<=0;
//                            movementX<=10'd192;
                            end
                            end
                    2'd2:   begin
                            movementY<=movementY+4;
                            if(movementX<38 && round<14)movementX<=movementX+1;                           
                            if (round==4'd14 && movementX!=0)movementX<=movementX-1;
                            if (movementY>=11'd1024)
                            begin
                                round<=round+1;
                                movementY<=0;
                            end
                            if (round==4'd15) 
                            begin
                            phase<=1;
                            round<=0;
                            Yway<=0;
                            Xway<=0;
                            movementY<=11'd1;
                            movementX<=11'd194;
                            end                            
                            end
                endcase                    
            end    
    
endmodule
