module DataPath(clk, rst, end_of_pixel, mux_first1_sel, mux_first2_sel, mux_end1_sel, mux_end2_sel, r_addr, w_addr, shift_enb
					, r_data);
	
	input reg [15:0] r_data;
	input reg [17:0] r_addr, w_addr;
	input reg clk, rst, shift_enb;
	input reg end_of_pixel;
	input reg [1:0] mux_first1_sel,  mux_end1_sel;
	input reg mux_first2_sel, mux_end2_sel;

	wire [7:0] mux_first1_out, mux_first2_out, mux_end1_out, mux_end2_out;
	
	reg row_cnt = 0;
	reg [47:0]shiftReg;

	always @(posedge clk) begin
		if (shift_enb) shiftReg = {shiftReg[31:0], r_data};
	end
	

endmodule