`default_nettype none
module upsampling_top#(
	parameter WRITE_ADDR_BASE = 115200,
	parameter READ_ADDR_BASE = 0,
	parameter W = 320,
	parameter H = 240,
	parameter DW = 16,
	parameter AW = 18)
(
	input wire clk,
	input wire reset,
	input wire start, // 
	output wire done,
	// *********** SRAM Interface Signals ****************************
	// Read-only port
	output wire [AW-1:0]	raddr,
	input wire	[DW-1:0]	rdata,
	// Write-only port
	output wire [AW-1:0]	waddr,
	output wire [DW-1:0]	wdata,
	output wire 			wr_enable
);
	

endmodule

