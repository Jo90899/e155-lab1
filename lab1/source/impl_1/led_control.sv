// Joseph Abdelmalek
// Email: jabdelmalek@hmc.edu
// Code for a counter that blinks led[2] at 2.5 Hz and uses XOR and AND logic to turn on led[0] and led[1]. 

module led_control(
	input	logic	clk,
	input 	logic	reset,
	input 	logic	[3:0] s,
	output 	logic 	[2:0] led
);

	// Initialize the clock
	logic [23:0] counter;
	
	
	// Simple clock counter
	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 24'd0; // Reset counter
			led[2] <= 1'd0; // Reset LED
		end else if (counter >= 10000000) begin
			counter <= 24'd0; // Reset counter
			led[2] <= ~led[2]; // Invert the value of the LED
		end else begin
			counter <= counter + 1; // Increment by 1
		end
	end

	assign led[0] = s[0] ^ s[1]; // S0 XOR S1
	assign led[1] = s[2] & s[3]; // S2 AND S3

endmodule