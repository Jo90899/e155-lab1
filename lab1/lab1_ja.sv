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

module led_control(
	input	logic	clk,
	input 	logic	reset,
	input 	logic	[3:0] s,
	output 	logic 	[2:0] led
);

	logic [23:0] counter;
	
	
	// Simple clock counter
	always_ff @(posedge int_osc) begin
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

module seven_seg(
	input	logic	[3:0] s,
	output	logic	[6:0] seg
);

	always_comb begin
        case (s)
            4'h0: seg = 7'b1000000; // 0
            4'h1: seg = 7'b1111001; // 1
            4'h2: seg = 7'b0100100; // 2
            4'h3: seg = 7'b0110000; // 3
            4'h4: seg = 7'b0011001; // 4
            4'h5: seg = 7'b0010010; // 5
            4'h6: seg = 7'b0000010; // 6
            4'h7: seg = 7'b1111000; // 7
            4'h8: seg = 7'b0000000; // 8
            4'h9: seg = 7'b0010000; // 9
            4'hA: seg = 7'b0001000; // A
            4'hB: seg = 7'b0000011; // B
            4'hC: seg = 7'b1000110; // C
            4'hD: seg = 7'b0100001; // D
            4'hE: seg = 7'b0000110; // E
            4'hF: seg = 7'b0001110; // F
            default: seg = 7'b1111111; // All off
        endcase
    end

endmodule