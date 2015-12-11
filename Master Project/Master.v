/**
TO DO: Make note modules, make keyboard enable/disable notes, try live-play, finish display
if liveplay fails, make switch-based enables to store notes
**/

//Master control module, instantiates all other modules
module Master(
	//Misc Inputs
	CLK_50MHz, resetn, KEY,
	
	//Digital Display
	LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA, 
	//Keyboard
	PS2_DAT, PS2_CLK,
	//Sound
	AUD_XCK, AUD_DACDAT, AUD_ADCDAT, I2C_SCLK, TD_CLK27,
	AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, I2C_SDAT);
	

  //Push Buttons
  input  [2:0]  KEY;
  //  DPDT Switches 
 // input  [17:0]  SW;
  //  7-SEG Displays
//  output  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
  //  LEDs
  //output  [7:0]  LEDG;  //  LED Green[8:0]
  //output  [17:0]  LEDR;  //  LED Red[17:0]
  //  PS2 data and clock lines
  input    PS2_DAT;
  input    PS2_CLK;
  
  input CLK_50MHz, resetn;
 
  output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
  output [7:0] LCD_DATA;
  
  input	TD_CLK27;
  input	AUD_ADCDAT;
  // Bidirectionals
  inout				AUD_BCLK;
  inout				AUD_ADCLRCK;
  inout				AUD_DACLRCK;
  inout				I2C_SDAT;
  // Outputs
  output				AUD_XCK;
  output				AUD_DACDAT;
  output				I2C_SCLK;

	reg en_C, en_Cs,en_D,en_Ds,en_E,en_F,en_Fs,en_G,
	en_Gs,en_A,en_As,en_B,en_C5;
	
	wire [7:0] history1, history2;
	
always@(posedge CLK_50MHz)
begin
	if (history2 != 8'hf0)
	begin
		case(history1)
			8'h1c: en_C <= 1'b1;
			8'h1d: en_Cs <= 1'b1;
			8'h1b: en_D <= 1'b1;
			8'h24: en_Ds <= 1'b1;
			8'h23: en_E <= 1'b1;
			8'h2b: en_F <= 1'b1;
			8'h2c: en_Fs <= 1'b1;
			8'h34: en_G <= 1'b1;
			8'h35: en_Gs <= 1'b1;
			8'h33: en_A <= 1'b1;
			8'h3c: en_As <= 1'b1;
			8'h3b: en_B <= 1'b1;
			8'h42: en_C5 <= 1'b1;
		endcase
	end
	else
	begin
		case(history1)
			8'h1c: en_C <= 1'b0;
			8'h1d: en_Cs <= 1'b0;
			8'h1b: en_D <= 1'b0;
			8'h24: en_Ds <= 1'b0;
			8'h23: en_E <= 1'b0;
			8'h2b: en_F <= 1'b0;
			8'h2c: en_Fs <= 1'b0;
			8'h34: en_G <= 1'b0;
			8'h35: en_Gs <= 1'b0;
			8'h33: en_A <= 1'b0;
			8'h3c: en_As <= 1'b0;
			8'h3b: en_B <= 1'b0;
			8'h42: en_C5 <= 1'b0;
		endcase
	end
end

PS2 keyboard(.CLOCK_50(CLK_50MHz), .history_output1(history1), .history_output2(history2),.PS2_DAT(PS2_DAT), .PS2_CLK(PS2_CLK));

fsm_lcd display(.CLK_50MHz(CLK_50MHz), .resetn(resetn), .LCD_ON(LCD_ON),
 .LCD_RS(LCD_RS), .LCD_EN(LCD_EN), .LCD_RW(LCD_RW), .LCD_DATA(LCD_DATA),
 .en_C(en_C), .en_Cs(en_Cs),.en_D(en_D),
 .en_Ds(en_Ds),.en_E(en_E),.en_F(en_F),.en_Fs(en_Fs),.en_G(en_G),
 .en_Gs(en_Gs),.en_A(en_A),.en_As(en_As),.en_B(en_B),.en_C5(en_C5));
 
SoundOut sound(.resetn(resetn), .CLOCK_50(CLK_50MHz), .TD_CLK27(TD_CLK27), .KEY(KEY[0]), .AUD_BCLK(AUD_BCLK),
 .AUD_ADCLRCK(AUD_ADCLRCK), .AUD_DACLRCK(AUD_DACLRCK), .I2C_SDAT(I2C_SDAT), .AUD_XCK(AUD_XCK),
 .AUD_DACDAT(AUD_DACDAT), .I2C_SCLK(I2C_SCLK),.en_C(en_C), .en_Cs(en_Cs),.en_D(en_D),
	.en_Ds(en_Ds),.en_E(en_E),.en_F(en_F),.en_Fs(en_Fs),.en_G(en_G),
	.en_Gs(en_Gs),.en_A(en_A),.en_As(en_As),.en_B(en_B));
endmodule
