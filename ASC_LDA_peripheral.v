module ASC_LDA_peripheral (
	Done, Go, X_0, Y_0, X_1, Y_1,
	clk, reset, chipselect, address, read, write, 
	writedata, readdata, waitrequest);
	/* The only input from the LDA FSM is the Done signal */
	input Done;
	/* Outputs to the LDA_Controller */
	output Go, 
	output [8 : 0] X_0, X_1;
	output [9 : 0] Y_0, Y_1;
	/* Inputs from the Avalon interconnect */
	input clk, reset, chipselect, read, write;
	input [31 : 0]  writedata;
	/* Output to the Avalon interconnect */
	output reg [31 : 0] readdata;
	output waitrequest;
	/* registers */
	reg [31 : 0] Mode_reg, Status_reg, Go_reg, Line_start_reg, Line_end_reg;
	parameter STALL_MODE = 0, POLL_MODE = 1;

	/* writing to registers */
	always @(posedge clk) begin
		if (reset) begin
			// reset
			Mode_reg <= 32'd0;
			Status_reg <= 32'd0;
			Go_reg <= 32'd0;
			Line_start_reg <= 32'd0;
			Line_end_reg <= 32'd0;
		end
		else if (!chipselect) begin
			case (address)
			3'd0: /* mode register */
				begin
					if (write) Mode_reg <= writedata; 	
				end
			3'd2: /* Go register */
				begin
					if (write) Go_reg <= writedata;
				end
			3'd3: /* Line start register */
				begin
					if (write) Line_start_reg <= writedata;
				end
			3'd4: /*Line end register */
				begin
					if (write) Line_end_reg <= writedata;
				end
			default: begin
				Mode_reg <= Mode_reg;
				Go_reg <= Go_reg;
				Line_start_reg <= Line_start_reg;
				Line_end_reg <= Line_end_reg; 
				end
			endcase
		end
	end

	/* reading registers */
	always @ (*) begin
		if (!chipselect && read && address == 3'd1 && Mode_reg[0] == POLL_MODE) begin
				readdata = Status_reg;
		end
		else readdata = 32'bx;
	end

	/* waitrequest signal should only be asserted when... writing to Go register and its in stall mode */
	assign waitrequest = (!chipselect && write && address == 3'd1 && Mode_reg[0] == STALL_MODE && !Done)? 1: 0;
	
endmodule