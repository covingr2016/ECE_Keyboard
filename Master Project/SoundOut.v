
module SoundOut (
	// Inputs
	CLOCK_50, resetn,
	TD_CLK27,
	KEY,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	I2C_SCLK,
	en_C, en_Cs,en_D,
	en_Ds,en_E,en_F,en_Fs,en_G,
	en_Gs,en_A,en_As,en_B
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
input				TD_CLK27;
input				KEY;
input resetn;

input				AUD_ADCDAT;

input en_C, en_Cs,en_D,en_Ds,en_E,en_F,en_Fs,en_G,
	en_Gs,en_A,en_As,en_B;
	
// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;

output				I2C_SCLK;
/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;
wire				read_audio_in;

wire				audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire				write_audio_out;

// Internal Registers
reg [17:0] counter, count_value, half_count_value; 
reg [31:0] amplitude;
reg [4:0] S, NS;
reg en_C5;
/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/
always @(posedge CLOCK_50 or negedge resetn)
begin
	if(resetn == 1'b0)
	begin
		counter <= 18'd1;
		S <= 5'd0;
		amplitude <= 32'd100000000;
	end
	else
	begin
		counter <= counter - 1'b1;
		if(counter == 18'd0)
		begin
			S <= NS;
			counter <= count_value;
			amplitude <= 32'd100000000;
		end
		else if(counter <= half_count_value)
			amplitude <= -32'd100000000;
	end
end

always@(*)
begin
	case (S)
		5'd0:
		begin
			NS <= 5'd1;
			if(en_C == 1'b1)
			begin
				count_value <= 18'd95557;
				half_count_value <= 18'd47779;
				
			end
			else
				count_value <= 18'd1;
		end
		5'd1:
		begin
			NS <= 5'd2;
			if(en_Cs == 1'b1)
			begin
				count_value <= 18'd90194;
				half_count_value <= 18'd45097;
			end
			else
				count_value <= 18'd1;
		end
		5'd2:
		begin
			NS <= 5'd3;
			if(en_D == 1'b1)
			begin
				count_value <= 18'd85133;
				half_count_value <= 18'd42566;
			end
			else
				count_value <= 18'd1;
		end
		5'd3:
		begin
			NS<= 5'd4;
			if(en_Ds == 1'b1)
			begin
				count_value <= 18'd80352;
				half_count_value <= 18'd40176;
			end
			else
				count_value <= 18'd1;
		end
		5'd4:
		begin
			NS<= 5'd5;
			if(en_E == 1'b1)
			begin
				count_value <= 18'd75843;
				half_count_value <= 18'd37921;
			end
			else
				count_value <= 18'd1;
		end
		5'd5:
		begin
			NS<= 5'd6;
			if(en_F == 1'b1)
			begin
				count_value <= 18'd71586;
				half_count_value <= 18'd35793;
			end
			else
				count_value <= 18'd1;
		end
		5'd6:
		begin
			NS<= 5'd7;
			if(en_Fs == 1'b1)
			begin
				count_value <= 18'd67560;//70
				half_count_value <= 18'd33780;//5
			end
			else
				count_value <= 18'd1;
		end
		5'd7:
		begin
			NS<= 5'd8;
			if(en_G == 1'b1)
			begin
				count_value <= 18'd63778;
				half_count_value <= 18'd31888;
			end
			else
				count_value <= 18'd1;
		end
		5'd8:
		begin
			NS<= 5'd9;
			if(en_Gs == 1'b1)
			begin
				count_value <= 18'd60198;
				half_count_value <= 18'd30099;
			end
			else
				count_value <= 18'd1;
		end
		5'd9:
		begin
			NS<= 5'd10;
			if(en_A == 1'b1)
			begin
				count_value <= 18'd56808;//18
				half_count_value <= 18'd28400;//409
			end
			else
				count_value <= 18'd1;
		end
		5'd10:
		begin
			NS<= 5'd11;
			if(en_As == 1'b1)
			begin
				count_value <= 18'd53630;
				half_count_value <= 18'd26815;
			end
			else
				count_value <= 18'd1;
		end
		5'd11:
		begin
			NS<= 5'd12;
			if(en_B == 1'b1)
			begin
				count_value <= 18'd50619;
				half_count_value <= 18'd25310;
			end
			else
				count_value <= 18'd1;
		end
	5'd12:
		begin
			NS<= 5'd0;
			if(en_C5 == 1'b1)
			begin
				count_value <= 18'd47779;
				half_count_value <= 18'd23889;
			end
			else
				count_value <= 18'd1;
		end
		/*5'd13:
		begin
			NS<= 5'd0;
		end*/
	endcase
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

wire [31:0] sound = amplitude;

assign read_audio_in			= audio_in_available & audio_out_allowed;

assign left_channel_audio_out	= left_channel_audio_in+sound;
assign right_channel_audio_out	= right_channel_audio_in+sound;
assign write_audio_out			= audio_in_available & audio_out_allowed;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset						(~KEY),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),
	
	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);

avconf #(.USE_MIC_INPUT(1)) avc (
	.I2C_SCLK					(I2C_SCLK),
	.I2C_SDAT					(I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~KEY)
);

endmodule

