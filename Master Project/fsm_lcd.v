//Module to display notes on the LCD that are currently playing
module fsm_lcd(CLK_50MHz, resetn,
LCD_ON, LCD_RS, LCD_EN, LCD_RW, LCD_DATA,en_C, en_Cs,en_D,en_Ds,en_E,en_F,
en_Fs,en_G,en_Gs,en_A,en_As,en_B,en_C5);

input CLK_50MHz, resetn, en_C, en_Cs,en_D,en_Ds,en_E,en_F,
en_Fs,en_G,en_Gs,en_A,en_As,en_B,en_C5;

output LCD_ON, LCD_RS, LCD_EN, LCD_RW;
output [7:0] LCD_DATA;

reg [5:0] p_state, n_state;
reg LCD_EN, LCD_RS;
reg [7:0] LCD_DATA_VALUE;

reg [15:0] clk_counter;
reg CLK_400Hz;

parameter [5:0] reset1=1, reset2=2, reset3=3, FUNC_SET=4,
display_off=5, display_clear=6,
display_on=7, mode_set=8, write_char1=9,
write_char2=10, write_char3=11, write_char4=12,
write_char5=13, write_char6=14, write_char7=15,
write_char8=16, write_char9=17, write_char10=18,
return_home=19,write_char11=50,write_char12=51,write_char13=52,write_char14=53,
write_char15=54,write_char16=55,write_char17=56,write_char18=57,write_char19=58,
write_char20=59,write_char21=60,write_char22=61,write_char23=62,write_char24=63,
toggle_e1=20,toggle_e2=21, toggle_e3=22, toggle_e4=23,
toggle_e5=24,toggle_e6=25, toggle_e7=26, toggle_e8=27,
toggle_e9=28,toggle_e10=29, toggle_e11=30, toggle_e12=31,
toggle_e13=32,toggle_e14=33, toggle_e15=34, toggle_e16=35,
toggle_e17=36,toggle_e18=37, toggle_e19=38, sharp_address=39,toggle_e22=45,
toggle_e23=46,toggle_e24=47,toggle_e25=48, toggle_e26=49,toggle_e27=64,
toggle_e28=65,toggle_e29=66,toggle_e30=67,toggle_e31=68,toggle_e32=69,toggle_e33=70,
toggle_e34=71,toggle_e35=72;

parameter [5:0] toggle_e20=41, toggle_e21=42, char1_address=43;

assign LCD_ON=1;
assign LCD_RW=0;
assign LCD_DATA = LCD_RW? 8'bzzzzzzzz: LCD_DATA_VALUE;

//Clock block to translate system clock to the 400Hz clock used in original design
always@(posedge CLK_50MHz)
begin
	clk_counter <= clk_counter + 1'b1;
	if(clk_counter == 16'd62500)
	begin
		CLK_400Hz <= !CLK_400Hz;
		clk_counter <= 16'd0;
	end
end

always @ (posedge CLK_400Hz, negedge resetn)
begin
	if (resetn == 1'b0)
	begin
		p_state <= reset1;
	end
	else
		p_state <= n_state;
end

always @ (p_state)
begin
	case (p_state)
	reset1:
	begin
		n_state = toggle_e1;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h38;
	end
	toggle_e1:
	begin
		n_state = reset2;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h38;
	end
	reset2:
	begin
		n_state = toggle_e2;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h38;
	end
	toggle_e2:
	begin
		n_state = reset3;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h38;
	end
	reset3:
	begin
		n_state = toggle_e3;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h38;
	end
	toggle_e3:
	begin
		n_state = FUNC_SET;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h38;
	end
	FUNC_SET:
	begin
		n_state = toggle_e4;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h38;
	end
	toggle_e4:
	begin
		n_state = display_off;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h38;
	end
		display_off:
	begin
		n_state = toggle_e5;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h08;
	end
		toggle_e5:
	begin
		n_state = display_clear;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h08;
	end
	display_clear:
	begin
		n_state = toggle_e6;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h01;
	end
		toggle_e6:
	begin
		n_state = display_on;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h01;
	end
	display_on:
	begin
		n_state = toggle_e7;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h0c;
	end
	toggle_e7:
	begin
		n_state = mode_set;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h0c;
	end	
	mode_set:
	begin
		n_state = toggle_e8;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE = 8'h06;
	end
	toggle_e8:
	begin
		n_state = write_char1;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE = 8'h06;
	end
	
	//Write 'C'
	write_char1:
	begin
		n_state = toggle_e9;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_C==1'b1 || en_Cs==1'b1)
			LCD_DATA_VALUE = 8'h43;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e9:
	begin
		n_state = write_char2;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h43;
	end
	//Write '#'
	write_char2:
	begin
		n_state = toggle_e10;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_Cs == 1'b1)
			LCD_DATA_VALUE = 8'h23;
		else
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e10:
	begin
		n_state = write_char3;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h23;
	end
	//Write 'D'
	write_char3:
	begin
		n_state = toggle_e11;	
		{LCD_EN, LCD_RS}=2'b11;
		if(en_D==1'b1 || en_Ds==1'b1)
			LCD_DATA_VALUE = 8'h44;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e11:
	begin
		n_state = write_char4;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h44;
	end
	//Write '#'
	write_char4:
	begin
		n_state = toggle_e12;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_Ds == 1'b1)
			LCD_DATA_VALUE = 8'h23;
		else
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e12:
	begin
		n_state = write_char5;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h23;
	end
	//Write 'E'
	write_char5:
	begin
		n_state = toggle_e13;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_E==1'b1)
			LCD_DATA_VALUE = 8'h45;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e13:
	begin
		n_state = write_char6;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h45;
	end
	//Write 'F'
	write_char6:
	begin
		n_state = toggle_e14;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_F==1'b1 || en_Fs==1'b1)
			LCD_DATA_VALUE = 8'h46;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e14:
	begin
		n_state = write_char7;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h46;
	end
	//Write '#'
	write_char7:
	begin
		n_state = toggle_e15;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_Fs == 1'b1)
			LCD_DATA_VALUE = 8'h23;
		else
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e15:
	begin
		n_state = write_char8;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE =8'h23;
	end
	//Write 'G'
	write_char8:
	begin
		n_state = toggle_e16;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_G==1'b1 || en_Gs==1'b1)
			LCD_DATA_VALUE = 8'h47;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e16:
	begin
		n_state = write_char9;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h47;
	end
	//Write '#'
	write_char9:
	begin
		n_state = toggle_e22;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_Gs == 1'b1)
			LCD_DATA_VALUE = 8'h23;
		else
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e22:
	begin
		n_state = write_char10;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h23;
	end
	//Write 'A'
	write_char10:
	begin
		n_state = toggle_e23;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_A==1'b1 || en_As==1'b1)
			LCD_DATA_VALUE = 8'h41;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e23:
	begin
		n_state = write_char11;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h41;
	end
	//Write '#'
	write_char11:
	begin
		n_state = toggle_e24;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_As == 1'b1)
			LCD_DATA_VALUE = 8'h23;
		else
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e24:
	begin
		n_state = write_char12;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h23;
	end
	//Write 'B'
	write_char12:
	begin
		n_state = toggle_e25;
		{LCD_EN, LCD_RS}=2'b11;
		if(en_B==1'b1)
			LCD_DATA_VALUE = 8'h42;
		else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e25:
	begin
		n_state = write_char13;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h42;
	end
	//Write 'C'
	write_char13:
	begin
		n_state = toggle_e26;
		{LCD_EN, LCD_RS}=2'b11;
		//if(en_C5==1'b1)
		//	LCD_DATA_VALUE = 8'h43;
		//else  
			LCD_DATA_VALUE = 8'h20;
	end
	toggle_e26:
	begin
		n_state = return_home;
		{LCD_EN, LCD_RS}=2'b01;
		LCD_DATA_VALUE = 8'h43;
	end

	//Return Home
	return_home:
	begin
		n_state = toggle_e21;
		{LCD_EN, LCD_RS}=2'b10;
		LCD_DATA_VALUE =8'h80;
	end
	toggle_e21:
	begin
		n_state = write_char1;
		{LCD_EN, LCD_RS}=2'b00;
		LCD_DATA_VALUE =8'h80;
	end
	endcase
	end
endmodule
