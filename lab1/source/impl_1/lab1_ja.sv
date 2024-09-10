// Joseph Abdelmalek
// Email: jabdelmalek@hmc.edu
// Top level that houses the modules led_control and seven_seg. The clock is initiated here using the on-board high speed oscillator.

module lab1_ja(
	input	logic	reset,
	input 	logic	[3:0] s,
	output 	logic 	[2:0] led,
	output	logic	[6:0] seg
);

	logic int_osc;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Call the modules
	led_control led_controlxx(.clk(int_osc), .reset(reset), .s(s), .led(led));
	seven_seg    segxx(.s(s), .seg(seg));
	
endmodule
