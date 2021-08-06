`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Wolfgang Koppe
// 
// Create Date: 25.05.2018 00:19:52
// Design Name: 
// Module Name: level
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


module level(
input [24:0] VGA_Ctrl,
input [3:0] playerRGB,
input [1:0] state,
input playerdead,
output [20:0] point,
output reg collision,
output [3:0] enemyRGB,
output reg [5:0] ebene
    );
    
    wire [3:0] bee1RGB;
    wire [3:0] bee2RGB;
    wire [3:0] bee3RGB;
    wire [3:0] bee4RGB;
    wire [3:0] bee5RGB;
    wire [3:0] bee6RGB;
    wire [3:0] bee7RGB;
    wire [3:0] bee8RGB;
    wire [3:0] bee9RGB;
    wire [3:0] bee10RGB;
    wire [3:0] bee11RGB;
    wire [3:0] bee12RGB;
    wire [3:0] bee13RGB;
    wire [3:0] bee14RGB;
    wire [3:0] bee15RGB;
    wire [3:0] bee16RGB;
    wire [3:0] bee17RGB;
    wire [3:0] bee18RGB;
    wire [3:0] bee19RGB;
    wire [3:0] bee20RGB;
    wire [3:0] boss1RGB;
    wire [3:0] boss2RGB;
    wire [3:0] boss3RGB;
    wire [3:0] boss4RGB;
    wire [3:0] butterfly1RGB;
    wire [3:0] butterfly2RGB;
    wire [3:0] butterfly3RGB;
    wire [3:0] butterfly4RGB;
    wire [3:0] butterfly5RGB;
    wire [3:0] butterfly6RGB;
    wire [3:0] butterfly7RGB;
    wire [3:0] butterfly8RGB;
    wire [3:0] butterfly9RGB;
    wire [3:0] butterfly10RGB;
    wire [3:0] butterfly11RGB;
    wire [3:0] butterfly12RGB;
    wire [3:0] butterfly13RGB;
    wire [3:0] butterfly14RGB;
    wire [3:0] butterfly15RGB;
    wire [3:0] butterfly16RGB;
    wire [3:0] shootRGB1;
    wire [3:0] shootRGB2;
    wire [3:0] shootRGB3;
    wire [3:0] shootRGB4;
    wire [3:0] shootRGB5;
    wire [3:0] shootRGB6;
    wire [3:0] shootRGB7;
    wire [3:0] shootRGB8;
    wire [3:0] shootRGB9;
    wire [3:0] shootRGB10;
    wire [3:0] shootRGB11;
    wire [3:0] shootRGB12;
    wire [3:0] shootRGB13;
    wire [3:0] shootRGB14;
    wire [3:0] shootRGB15;
    wire [3:0] shootRGB16;
    wire [3:0] shootRGB17;
    wire [3:0] shootRGB18;
    wire [3:0] shootRGB19;
    wire [3:0] shootRGB20;
    wire [3:0] shootRGB21;
    wire [3:0] shootRGB22;
    wire [3:0] shootRGB23;
    wire [3:0] shootRGB24;
    wire [3:0] shootRGB25;
    wire [3:0] shootRGB26;
    wire [3:0] shootRGB27;
    wire [3:0] shootRGB28;
    wire [3:0] shootRGB29;
    wire [3:0] shootRGB30;
    wire [3:0] shootRGB31;
    wire [3:0] shootRGB32;
    wire [3:0] shootRGB33;
    wire [3:0] shootRGB34;
    wire [3:0] shootRGB35;
    wire [3:0] shootRGB36;
    wire [3:0] shootRGB37;
    wire [3:0] shootRGB38;
    wire [3:0] shootRGB39;
    wire [3:0] shootRGB40;
    wire [9:0] PixX = VGA_Ctrl [20:11];
    wire [9:0] PixY = VGA_Ctrl [10:1];
    wire [5:0] shoot;
    wire [5:0] attack;
    wire [10:0] movementX;
    wire [10:0] movementY;
    wire [1:0] phase;
    
    reg [39:0] dead = 0 ;
    reg [39:0] olddead = 0 ;
    reg [20:0] oldpoint;
    reg [6:0] randomshoot= 7'd42;
    reg [6:0] randomattack= 7'd69;
    reg [4:0] timer;
    reg [8:0] timer2;
    
    enemy_movement(VGA_Ctrl, state, dead, playerdead, phase, movementX, movementY);
    
    boss boss1(VGA_Ctrl,phase==2? -movementX*2+192+192 :phase==1 ? movementX+192 : 192,(attack==0 && phase==2) || phase==1 ? movementY+64 : 64,dead[0],shoot==0 && !dead[0] && !playerdead,state==1,shootRGB1, boss1RGB);
    boss boss2(VGA_Ctrl,phase==2? -movementX+256+192 :phase==1 ? movementX+256 : 256,(attack==1 && phase==2) || phase==1 ? movementY+64 : 64,dead[1],shoot==1 && !dead[1] && !playerdead,state==1,shootRGB2, boss2RGB);
    boss boss3(VGA_Ctrl,phase==2? movementX+320+192 :phase==1 ? movementX+320 : 320,(attack==2 && phase==2) || phase==1 ? movementY+64 : 64,dead[2],shoot==2 && !dead[2] && !playerdead,state==1,shootRGB3, boss3RGB);
    boss boss4(VGA_Ctrl,phase==2? movementX*2+384+192 :phase==1 ? movementX+384 : 384,(attack==3 && phase==2) || phase==1 ? movementY+64 : 64,dead[3],shoot==3 && !dead[3] && !playerdead,state==1,shootRGB4, boss4RGB);
    
    butterfly butterfly1(VGA_Ctrl, phase==2? -movementX*4+64+192 :phase==1 ? movementX+64 : 64, (attack==4 && phase==2) || phase==1 ? movementY+128 : 128 ,dead[4],shoot==4 && !dead[4] && !playerdead,state==1,shootRGB5, butterfly1RGB);
    butterfly butterfly2(VGA_Ctrl, phase==2? -movementX*3+128+192 :phase==1 ? movementX+128 :128,(attack==5 && phase==2) || phase==1 ? movementY+128 : 128,dead[5],shoot==5 && !dead[5] && !playerdead,state==1,shootRGB6, butterfly2RGB);
    butterfly butterfly3(VGA_Ctrl, phase==2? -movementX*2+192+192 :phase==1 ? movementX+192 :192,(attack==6 && phase==2) || phase==1 ? movementY+128 : 128,dead[6],shoot==6 && !dead[6] && !playerdead,state==1,shootRGB7, butterfly3RGB);
    butterfly butterfly4(VGA_Ctrl, phase==2? -movementX+256+192 :phase==1 ? movementX+256 :256,(attack==7 && phase==2) || phase==1 ? movementY+128 : 128,dead[7],shoot==7 && !dead[7] && !playerdead,state==1,shootRGB8, butterfly4RGB);
    butterfly butterfly5(VGA_Ctrl, phase==2? movementX+320+192 :phase==1 ? movementX+320 :320,(attack==8 && phase==2) || phase==1 ? movementY+128 : 128,dead[8],shoot==8 && !dead[8] && !playerdead,state==1,shootRGB9, butterfly5RGB);
    butterfly butterfly6(VGA_Ctrl, phase==2? movementX*2+384+192 :phase==1 ? movementX+384 :384,(attack==9 && phase==2) || phase==1 ? movementY+128 : 128,dead[9],shoot==9 && !dead[9] && !playerdead,state==1,shootRGB10, butterfly6RGB);
    butterfly butterfly7(VGA_Ctrl, phase==2? movementX*3+448+192 :phase==1 ? movementX+448 :448,(attack==10 && phase==2) || phase==1 ? movementY+128 : 128,dead[10],shoot==10 && !dead[10] && !playerdead,state==1,shootRGB11, butterfly7RGB);
    butterfly butterfly8(VGA_Ctrl, phase==2? movementX*4+512+192 :phase==1 ? movementX+512 :512,(attack==11 && phase==2) || phase==1 ? movementY+128 : 128,dead[11],shoot==11 && !dead[11] && !playerdead,state==1,shootRGB12, butterfly8RGB);
    butterfly butterfly9(VGA_Ctrl, phase==2? -movementX*4+64+192 :phase==1 ? movementX+64 :64, (attack==12 && phase==2) || phase==1 ? movementY+192 : 192,dead[12],shoot==12 && !dead[12] && !playerdead,state==1,shootRGB13, butterfly9RGB);
    butterfly butterfly10(VGA_Ctrl,phase==2? -movementX*3+128+192 :phase==1 ? movementX+128 :128,(attack==13 && phase==2) || phase==1 ? movementY+192 : 192,dead[13],shoot==13 && !dead[13] && !playerdead,state==1,shootRGB14, butterfly10RGB);
    butterfly butterfly11(VGA_Ctrl,phase==2? -movementX*2+192+192 :phase==1 ? movementX+192 :192,(attack==14 && phase==2) || phase==1 ? movementY+192 : 192,dead[14],shoot==14 && !dead[14] && !playerdead,state==1,shootRGB15, butterfly11RGB);
    butterfly butterfly12(VGA_Ctrl,phase==2? -movementX+256+192 :phase==1 ? movementX+256 :256,(attack==15 && phase==2) || phase==1 ? movementY+192 : 192,dead[15],shoot==15 && !dead[15] && !playerdead,state==1,shootRGB16, butterfly12RGB);
    butterfly butterfly13(VGA_Ctrl,phase==2? movementX+320+192 :phase==1 ? movementX+320 :320,(attack==16 && phase==2) || phase==1 ? movementY+192 : 192,dead[16],shoot==16 && !dead[16] && !playerdead,state==1,shootRGB17, butterfly13RGB);
    butterfly butterfly14(VGA_Ctrl,phase==2? movementX*2+384+192 :phase==1 ? movementX+384 :384,(attack==17 && phase==2) || phase==1 ? movementY+192 : 192,dead[17],shoot==17 && !dead[17] && !playerdead,state==1,shootRGB18, butterfly14RGB);
    butterfly butterfly15(VGA_Ctrl,phase==2? movementX*3+448+192 :phase==1 ? movementX+448 :448,(attack==18 && phase==2) || phase==1 ? movementY+192 : 192,dead[18],shoot==18 && !dead[18] && !playerdead,state==1,shootRGB19, butterfly15RGB);
    butterfly butterfly16(VGA_Ctrl,phase==2? movementX*4+512+192 :phase==1 ? movementX+512 :512,(attack==19 && phase==2) || phase==1 ? movementY+192 : 192,dead[19],shoot==19 && !dead[19] && !playerdead,state==1,shootRGB20, butterfly16RGB);
    
    bee bee1(VGA_Ctrl,  phase==2? -movementX*5+192 :phase==1 ? movementX :0,     phase==2 && attack==20? movementY+256 :  phase==1 ? movementY+256 : 256, dead[20],shoot==20 && !dead[20] && !playerdead,state==1,shootRGB21, bee1RGB);
    bee bee2(VGA_Ctrl,  phase==2? -movementX*4+64+192 :phase==1 ? movementX+64 :64,  phase==2 && attack==21? movementY+256 :  phase==1 ? movementY+256 : 256, dead[21],shoot==21 && !dead[21] && !playerdead,state==1,shootRGB22, bee2RGB);
    bee bee3(VGA_Ctrl,  phase==2? -movementX*3+128+192 :phase==1 ? movementX+128 :128, phase==2 && attack==22? movementY+256 :  phase==1 ? movementY+256 : 256, dead[22],shoot==22 && !dead[22] && !playerdead,state==1,shootRGB23, bee3RGB);
    bee bee4(VGA_Ctrl,  phase==2? -movementX*2+192+192 :phase==1 ? movementX+192 :192, phase==2 && attack==23? movementY+256 :  phase==1 ? movementY+256 : 256, dead[23],shoot==23 && !dead[23] && !playerdead,state==1,shootRGB24, bee4RGB);
    bee bee5(VGA_Ctrl,  phase==2? -movementX+256+192 :phase==1 ? movementX+256 :256, phase==2 && attack==24? movementY+256 :  phase==1 ? movementY+256 : 256, dead[24],shoot==24 && !dead[24] && !playerdead,state==1,shootRGB25, bee5RGB);
    bee bee6(VGA_Ctrl,  phase==2? movementX+320+192 :phase==1 ? movementX+320 :320, phase==2 && attack==25? movementY+256 :  phase==1 ? movementY+256 : 256, dead[25],shoot==25 && !dead[25] && !playerdead,state==1,shootRGB26, bee6RGB);
    bee bee7(VGA_Ctrl,  phase==2? movementX*2+384+192 :phase==1 ? movementX+384 :384, phase==2 && attack==26? movementY+256 :  phase==1 ? movementY+256 : 256, dead[26],shoot==26 && !dead[26] && !playerdead,state==1,shootRGB27, bee7RGB);
    bee bee8(VGA_Ctrl,  phase==2? movementX*3+448+192 :phase==1 ? movementX+448 :448, phase==2 && attack==27? movementY+256 :  phase==1 ? movementY+256 : 256, dead[27],shoot==27 && !dead[27] && !playerdead,state==1,shootRGB28, bee8RGB);
    bee bee9(VGA_Ctrl,  phase==2? movementX*4+512+192 :phase==1 ? movementX+512 :512, phase==2 && attack==28? movementY+256 :  phase==1 ? movementY+256 : 256, dead[28],shoot==28 && !dead[28] && !playerdead,state==1,shootRGB29, bee9RGB);
    bee bee10(VGA_Ctrl, phase==2? movementX*5+576+192 :phase==1 ? movementX+576 :576, phase==2 && attack==29? movementY+256 :  phase==1 ? movementY+256 : 256, dead[29],shoot==29 && !dead[29] && !playerdead,state==1,shootRGB30, bee10RGB);
    bee bee11(VGA_Ctrl, phase==2? -movementX*5+192     :phase==1 ? movementX     : 0   , phase==2 && attack==30? movementY+320 :  phase==1 ? movementY+320 : 320, dead[30],shoot==30 && !dead[30] && !playerdead,state==1,shootRGB31, bee11RGB);
    bee bee12(VGA_Ctrl, phase==2? -movementX*4+64+192 :phase==1 ? movementX+64 :64 , phase==2 && attack==31? movementY+320 :  phase==1 ? movementY+320 : 320, dead[31],shoot==31 && !dead[31] && !playerdead,state==1,shootRGB32, bee12RGB);
    bee bee13(VGA_Ctrl, phase==2? -movementX*3+128+192 :phase==1 ? movementX+128 :128, phase==2 && attack==32? movementY+320 :  phase==1 ? movementY+320 : 320, dead[32],shoot==32 && !dead[32] && !playerdead,state==1,shootRGB33, bee13RGB);
    bee bee14(VGA_Ctrl, phase==2? -movementX*2+192+192 :phase==1 ? movementX+192 :192, phase==2 && attack==33? movementY+320 :  phase==1 ? movementY+320 : 320, dead[33],shoot==33 && !dead[33] && !playerdead,state==1,shootRGB34, bee14RGB);
    bee bee15(VGA_Ctrl, phase==2? -movementX+256+192 :phase==1 ? movementX+256 :256, phase==2 && attack==34? movementY+320 :  phase==1 ? movementY+320 : 320, dead[34],shoot==34 && !dead[34] && !playerdead,state==1,shootRGB35, bee15RGB);
    bee bee16(VGA_Ctrl, phase==2? movementX+320+192 :phase==1 ? movementX+320 :320, phase==2 && attack==35? movementY+320 :  phase==1 ? movementY+320 : 320, dead[35],shoot==35 && !dead[35] && !playerdead,state==1,shootRGB36, bee16RGB);
    bee bee17(VGA_Ctrl, phase==2? movementX*2+384+192 :phase==1 ? movementX+384 :384, phase==2 && attack==36? movementY+320 :  phase==1 ? movementY+320 : 320, dead[36],shoot==36 && !dead[36] && !playerdead,state==1,shootRGB37, bee17RGB);
    bee bee18(VGA_Ctrl, phase==2? movementX*3+448+192 :phase==1 ? movementX+448 :448, phase==2 && attack==37? movementY+320 :  phase==1 ? movementY+320 : 320, dead[37],shoot==37 && !dead[37] && !playerdead,state==1,shootRGB38, bee18RGB);
    bee bee19(VGA_Ctrl, phase==2? movementX*4+512+192 :phase==1 ? movementX+512 :512, phase==2 && attack==38? movementY+320 :  phase==1 ? movementY+320 : 320, dead[38],shoot==38 && !dead[38] && !playerdead,state==1,shootRGB39, bee19RGB);
    bee bee20(VGA_Ctrl, phase==2? movementX*5+578+192 :phase==1 ? movementX+578 :578, phase==2 && attack==39? movementY+320 :  phase==1 ? movementY+320 : 320, dead[39],shoot==39 && !dead[39] && !playerdead,state==1,shootRGB40, bee20RGB);
   
    always@(posedge VGA_Ctrl[0])
    begin
        if (VGA_Ctrl [21:11] == 1030 && VGA_Ctrl [10:1] == 770 && state==1 && !playerdead)
        begin
            timer<=timer+1;
            if(dead==40'hFFFFFFFFFF)
                    begin 
                        timer2<=timer2+1;
                        if(timer2[8])
                        begin
                            dead <= 40'd0;
                            ebene<=ebene+1;
                            oldpoint<=point;
                            timer2<=0;
                        end
                    end
            end
        if(olddead!=dead)
        begin
            collision<=1;
            olddead[39:0]<=dead[39:0];
        end
        else
        collision <=0;
        if(playerRGB && boss1RGB)  dead[0]<=1;
        if(playerRGB && boss2RGB)  dead[1]<=1;
        if(playerRGB && boss3RGB)  dead[2]<=1;
        if(playerRGB && boss4RGB)  dead[3]<=1;
        if(playerRGB && butterfly1RGB)  dead[4]<=1;
        if(playerRGB && butterfly2RGB)  dead[5]<=1;
        if(playerRGB && butterfly3RGB)  dead[6]<=1;
        if(playerRGB && butterfly4RGB)  dead[7]<=1;
        if(playerRGB && butterfly5RGB)  dead[8]<=1;
        if(playerRGB && butterfly6RGB)  dead[9]<=1;
        if(playerRGB && butterfly7RGB)  dead[10]<=1;
        if(playerRGB && butterfly8RGB)  dead[11]<=1;
        if(playerRGB && butterfly9RGB)  dead[12]<=1;
        if(playerRGB && butterfly10RGB)  dead[13]<=1;
        if(playerRGB && butterfly11RGB)  dead[14]<=1;
        if(playerRGB && butterfly12RGB)  dead[15]<=1;
        if(playerRGB && butterfly13RGB)  dead[16]<=1;
        if(playerRGB && butterfly14RGB)  dead[17]<=1;
        if(playerRGB && butterfly15RGB)  dead[18]<=1;
        if(playerRGB && butterfly16RGB)  dead[19]<=1;
        if(playerRGB && bee1RGB)  dead[20]<=1;
        if(playerRGB && bee2RGB)  dead[21]<=1;
        if(playerRGB && bee3RGB)  dead[22]<=1;
        if(playerRGB && bee4RGB)  dead[23]<=1;
        if(playerRGB && bee5RGB)  dead[24]<=1;
        if(playerRGB && bee6RGB)  dead[25]<=1;
        if(playerRGB && bee7RGB)  dead[26]<=1;
        if(playerRGB && bee8RGB)  dead[27]<=1;
        if(playerRGB && bee9RGB)  dead[28]<=1;
        if(playerRGB && bee10RGB)  dead[29]<=1;
        if(playerRGB && bee11RGB)  dead[30]<=1;
        if(playerRGB && bee12RGB)  dead[31]<=1;
        if(playerRGB && bee13RGB)  dead[32]<=1;
        if(playerRGB && bee14RGB)  dead[33]<=1;
        if(playerRGB && bee15RGB)  dead[34]<=1;
        if(playerRGB && bee16RGB)  dead[35]<=1;
        if(playerRGB && bee17RGB)  dead[36]<=1;
        if(playerRGB && bee18RGB)  dead[37]<=1;
        if(playerRGB && bee19RGB)  dead[38]<=1;
        if(playerRGB && bee20RGB)  dead[39]<=1;
        if(state==0) 
        begin
            oldpoint<=0;
            ebene<=0;
            dead<=40'd0;
        end
        if (phase==2 && !movementY)randomattack<={(randomattack[1]^randomattack[0])| (randomattack[5:0]==0), randomattack[6:1]};
    end
    
    always@(posedge timer[4])
        if (state==1 && !playerdead)randomshoot<={(randomshoot[1]^randomshoot[0])| (randomshoot[5:0]==0), randomshoot[6:1]};
        
    assign point = state>0 ? (dead[0]+dead[1]+dead[2]+dead[3])*15+(dead[4]+dead[5]+dead[6]+dead[7]+dead[8]+dead[9]+dead[10]+dead[11]+dead[12]+dead[13]+dead[14]+dead[15]+dead[16]+dead[17]+dead[18]+dead[19])*8+
                    (dead[20]+dead[21]+dead[22]+dead[23]+dead[24]+dead[25]+dead[26]+dead[27]+dead[28]+dead[29]+dead[30]+dead[31]+dead[32]+dead[33]+dead[34]+dead[35]+dead[36]+dead[37]+dead[38]+dead[39])*5+oldpoint:
                    20'd0;
    assign shoot=randomshoot%40;
    assign attack=randomattack%40;
    assign enemyRGB =   !state[0] ? 4'd0:
                        boss1RGB ? boss1RGB :
                        boss2RGB ? boss2RGB :
                        boss3RGB ? boss3RGB :
                        boss4RGB ? boss4RGB :
                        butterfly1RGB ? butterfly1RGB :
                        butterfly2RGB ? butterfly2RGB :
                        butterfly3RGB ? butterfly3RGB :
                        butterfly4RGB ? butterfly4RGB :
                        butterfly5RGB ? butterfly5RGB :
                        butterfly6RGB ? butterfly6RGB :
                        butterfly7RGB ? butterfly7RGB :
                        butterfly8RGB ? butterfly8RGB :
                        butterfly9RGB ? butterfly9RGB :
                        butterfly10RGB ? butterfly10RGB :
                        butterfly11RGB ? butterfly11RGB :
                        butterfly12RGB ? butterfly12RGB :
                        butterfly13RGB ? butterfly13RGB :
                        butterfly14RGB ? butterfly14RGB :
                        butterfly15RGB ? butterfly15RGB :
                        butterfly16RGB ? butterfly16RGB :
                        bee1RGB ? bee1RGB :
                        bee2RGB ? bee2RGB :
                        bee3RGB ? bee3RGB :
                        bee4RGB ? bee4RGB :
                        bee5RGB ? bee5RGB :
                        bee6RGB ? bee6RGB :
                        bee7RGB ? bee7RGB :
                        bee8RGB ? bee8RGB :
                        bee9RGB ? bee9RGB :
                        bee10RGB ? bee10RGB :
                        bee11RGB ? bee11RGB :
                        bee12RGB ? bee12RGB :
                        bee13RGB ? bee13RGB :
                        bee14RGB ? bee14RGB :
                        bee15RGB ? bee15RGB :
                        bee16RGB ? bee16RGB :
                        bee17RGB ? bee17RGB :
                        bee18RGB ? bee18RGB :
                        bee19RGB ? bee19RGB :
                        bee20RGB ? bee20RGB :
                        state==3  ? 4'd0:
                        shootRGB1 ? shootRGB1 :
                        shootRGB2 ? shootRGB2 :
                        shootRGB3 ? shootRGB3 :
                        shootRGB4 ? shootRGB4 :
                        shootRGB5 ? shootRGB5 :
                        shootRGB6 ? shootRGB6 :
                        shootRGB7 ? shootRGB7 :
                        shootRGB8 ? shootRGB8 :
                        shootRGB9 ? shootRGB9 :                        
                        shootRGB10 ? shootRGB10 :
                        shootRGB11 ? shootRGB11 :
                        shootRGB12 ? shootRGB12 :
                        shootRGB13 ? shootRGB13 :
                        shootRGB14 ? shootRGB14 :
                        shootRGB15 ? shootRGB15 :
                        shootRGB16 ? shootRGB16 :
                        shootRGB17 ? shootRGB17 :
                        shootRGB18 ? shootRGB18 :
                        shootRGB19 ? shootRGB19 :
                        shootRGB20 ? shootRGB20 :
                        shootRGB21 ? shootRGB21 :
                        shootRGB22 ? shootRGB22 :
                        shootRGB23 ? shootRGB23 :
                        shootRGB24 ? shootRGB24 :
                        shootRGB25 ? shootRGB25 :
                        shootRGB26 ? shootRGB26 :
                        shootRGB27 ? shootRGB27 :
                        shootRGB28 ? shootRGB28 :
                        shootRGB29 ? shootRGB29 :
                        shootRGB30 ? shootRGB30 :
                        shootRGB31 ? shootRGB31 :
                        shootRGB32 ? shootRGB32 :
                        shootRGB33 ? shootRGB33 :
                        shootRGB34 ? shootRGB34 :
                        shootRGB35 ? shootRGB35 :
                        shootRGB36 ? shootRGB36 :
                        shootRGB37 ? shootRGB37 :
                        shootRGB38 ? shootRGB38 :
                        shootRGB39 ? shootRGB39 :
                        shootRGB40 ? shootRGB40 :
                        4'd0;

endmodule