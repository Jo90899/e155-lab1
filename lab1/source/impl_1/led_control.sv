// Joseph Abdelmalek
// Email: jabdelmalek@hmc.edu
// Code for a counter that blinks led[2] at 2.5 Hz and uses XOR and AND logic to turn on led[0] and led[1]. 

module led_control(
	input	logic	clk,
	input 	logic	reset,
	input 	logic	[3:0] s,
	output 	logic 	[2:0] led
);

	logic [23:0] counter;
	
	
	// Simple clock counter
	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 24'd0;
			led[2] <= 1'd0;
		end else if (counter >= 10000000) begin
			counter <= 24'd0;
			led[2] <= ~led[2];
		end else begin
			counter <= counter + 1;
		end
	end

	assign led[0] = s[0] ^ s[1];
	assign led[1] = s[2] & s[3];
	

endmodule