module note(clk, rst, frequency, amplitude);

input clk, rst;
input [100:0] frequency;
output signed [31:0] amplitude;

reg signed [31:0] signed_amplitude, true_signed_amplitude;

reg[5:0] state, n_state;
reg [100:0] amp_counter;
reg invert_wave;

//Amplitude is the actual output
assign amplitude = true_signed_amplitude;

always @(posedge clk or negedge rst)
begin
	if(rst == 1'b0)
	begin
		amp_counter <= 11'd0;
		state <= 6'd0;
	end
	else
	begin
		amp_counter <= amp_counter + 1'b1;
		if(amp_counter >= frequency)
		begin
			state <= n_state;
			amp_counter <= 11'd0;
		end
	end
end

always @(*)
begin
	case(state)
	6'd0: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd0;
	end
	6'd1: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd654031;
	end
	6'd2: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd1305262;
	end
	6'd3: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd1950903;
	end
	6'd4: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd2588190;
	end
	6'd5: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd3214395;
	end
	6'd6: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd3826834;
	end
	6'd7: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd4422887;
	end
	6'd8: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd5000000;
	end
	6'd9: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd5555702;
	end
	6'd10: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd6087614;
	end
	6'd11: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd6593458;
	end
	6'd12: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7071068;
	end
	6'd13: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7518398;
	end
	6'd14: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7933533;
	end
	6'd15: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8314696;
	end
	6'd16: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8660254;
	end
	6'd17: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8968727;
	end
	6'd18: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9238795;
	end
	6'd19: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9469301;
	end
	6'd20: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9659258;
	end
	6'd21: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9807853;
	end
	6'd22: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9914449;
	end
	6'd23: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9978589;
	end
	6'd24: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd10000000;
	end
	6'd25: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9978589;
	end
	6'd26: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9914449;
	end
	6'd27: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9807853;
	end
	6'd28: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9659258;
	end
	6'd29: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9469301;
	end
	6'd30: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd9238795;
	end
	6'd31: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8968727;
	end
	6'd32: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8660254;
	end
	6'd33: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd8314696;
	end
	6'd34: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7933533;
	end
	6'd35: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7518398;
	end
	6'd36: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd7071068;
	end
	6'd37: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd6593458;
	end
	6'd38: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd6087614;
	end
	6'd39: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd5555702;
	end
	6'd40: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd5000000;
	end
	6'd41: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd4422887;
	end
	6'd42: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd3826834;
	end
	6'd43: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd3214395;
	end
	6'd44: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd2588190;
	end
	6'd45: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd1950903;
	end
	6'd46: 
	begin
		n_state <= state + 1'b1;
		signed_amplitude <= 32'd1305262;
	end
	6'd47: 
	begin
		n_state <= 6'b0;
		signed_amplitude <= 32'd654031;
		invert_wave <= invert_wave + 1'b1;
	end
	endcase
	if(invert_wave == 1'b1)
		true_signed_amplitude <= -signed_amplitude;
	else
		true_signed_amplitude <= signed_amplitude;
end

endmodule

