module upsampling_controller(clk, rst, start, end_of_pixel, cnt_col, clear, start, 
	SmuxFinal, SmuxFirst1, SmuxFirst2, SmuxEnd1, SmuxEnd2, Wrenb, en_cnt, shiften, SmuxFirst1, SmuxEnd1, done);

	parameter [2:0] IDLE = 4'd0, READY = 4'd1; WAIT = 4'd2, READ0 = 4'd3, READ1 = 4'd4, READ2 = 4'd5, 
					READ3 = 4'd6, READ4 = 4'd7, READ5 = 4'd8;

	input clk, rst, start, end_of_pixel;
	input[9:0] cnt_col;

	output reg clear, SmuxFinal, SmuxFirst2, SmuxEnd2, Wrenb, en_cnt, shiften;
	output reg [1:0]  SmuxFirst1, SmuxEnd1;
	output done;


	always @(ps) begin
		{clear, SmuxFinal, SmuxFirst2, SmuxEnd2, Wrenb, en_cnt
				, shiften, done} = 11'b0;
		SmuxFirst1, SmuxEnd1 = 2'b0;

		case(ps)
			IDLE:
				begin		clear = 1'b1; rst_cnt = 1'b1;
				end
			READY:begin 
							en_cnt = 1'b1;
							SmuxFinal = 1'b0;
				end
			WAIT:
				begin    	// do nothing //

				end	
			READ0:begin		shiften = 1'b1;

				end
			READ1:
				begin 		shiften = 1'b1;

				end
			READ2:
				begin		shiften = 1'b1; Wrenb = 1'b1;
							SmuxFirst1 = 2'd2; SmuxFirst2 = 1'b1; 
							SmuxEnd1 = 1'b0; SmuxEnd2 = 1'b0;
				end
			READ3:
				begin		Wrenb = 1'b1; 
							SmuxFirst1 = 1'b1; SmuxFirst2 = 1'b0; 
							SmuxEnd1 = 1'b0; SmuxEnd2 = 1'b0;
				end
			READ4:
				begin		SmuxFirst1 = 1'b0; SmuxFirst2 = 1'b0; 
							if(cnt_col == 10'd 319 || 10'd 318)
								SmuxEnd1 = 1'b1; SmuxEnd2 = 1'b1;	
							else 
								SmuxEnd1 = 1'b0; SmuxEnd2 = 1'b0;
							Wrenb = 1'b1; shiften = 1'b1;
				end
			READ5:
				begin		Wrenb = 1'b1; shiften = 1'b1;
							// if(cnt_col == 10'd320)
							// 	{
							// 		en_cnt_row = 1'b1;
							// 		en_rst_col = 1'b1;
							// 	}
			// default:	
		endcase
	end

	always @(ps) begin
		case(ps)
			IDLE:	ns = (start == 1'b1) ? READY : IDLE;
			READY:  ns = WAIT;
			WAIT: 	ns = READ0;
			READ0:	ns = READ1;
			READ1:	ns = READ2;
			READ2:	ns = READ3;
			READ3:  ns = READ4;
			READ4:  ns = READ5;
			READ5:	ns = (cnt_col == 10'd 320) ? WAIT : READ4;

			default: ps = ps;
		endcase
	end

	assign done = end_of_pixel == 1'b1 ? 1 : 0;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ps <= IDLE;
		end
		else ps <= ns;
	end
endmodule
