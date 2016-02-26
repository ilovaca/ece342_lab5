module LDA_peripheral (
	csi_clockreset_clk, 
	csi_clockreset_reset, 
	avs_s1_chipselect,
	avs_s1_address,
	avs_s1_read,
	avs_s1_write,
	avs_s1_writedata,
	avs_s1_readdata
	avs_s1_waitrequest,
	coe_vga_LEDG,
	coe_vga_VGA_R,
	coe_vga_VGA_G,
	coe_vga_VGA_B,
	coe_vga_VGA_HS,
	coe_vga_VGA_VS,
	coe_vga_VGA_BLANK,
	coe_vga_VGA_SYNC,
	coe_vga_VGA_CLK );
	/* System clock and reset */
	input csi_clockreset_reset, csi_clockreset_clk;
	/* Avalon slave signals */
	input avs_s1_chipselect, avs_s1_read, avs_s1_write;
	input [2 : 0] avs_s1_address;
	input [31 : 0] avs_s1_writedata;
	output [31 : 0] avs_s1_readdata;
	output avs_s1_waitrequest;
	/* Outputs to VGA controller */
	output [8 : 0] coe_vga_LEDG;
	output [9 : 0] coe_vga_VGA_R, coe_vga_VGA_G, coe_vga_VGA_B;
	output coe_vga_VGA_HS, coe_vga_VGA_VS, coe_vga_VGA_BLANK, coe_vga_VGA_SYNC, coe_vga_VGA_CLK;

	

endmodule
