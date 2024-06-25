module ROM2_Z0(clk, rst_n, cs, addr, data);

input [3:0] addr; // address
input cs; // chip select
input rst_n; 
input clk; 
output reg [16:0] data;

reg [16:0] rom_data;
reg rst_n_sync;

always@(*) begin

if(cs)
begin
//   c1= 0.9807852804 , c2= 0.92387953251 , c3= 0.8314696123 , c4= 0.70710678118 , c5= 0.55557023302 , c6= 0.38268343236 , c7= 0.19509032201 
//   It is in Fixed Point representation!
case(addr) 
4'b0000: rom_data = 17'b000_00000000000000; // 0 
4'b0001: rom_data = 17'b000_10110101000001; // c4 
4'b0010: rom_data = 17'b000_10110101000001; // c4
4'b0011: rom_data = 17'b001_01101010000010; // 2 c4
4'b0100: rom_data = 17'b000_10110101000001; // c4
4'b0101: rom_data = 17'b001_01101010000010; // 2 c4
4'b0110: rom_data = 17'b001_01101010000010; // 2 c4
4'b0111: rom_data = 17'b010_00011111000011; // 3 c4

4'b1000: rom_data = 17'b000_10110101000001; // c4 
4'b1001: rom_data = 17'b001_01101010000010; // 2 c4 
4'b1010: rom_data = 17'b001_01101010000010; // 2 c4 
4'b1011: rom_data = 17'b010_00011111000011; // 3 c4
4'b1100: rom_data = 17'b001_01101010000010; // 2 c4 
4'b1101: rom_data = 17'b010_00011111000011; // 3 c4 
4'b1110: rom_data = 17'b010_00011111000011; // 3 c4 
4'b1111: rom_data = 17'b010_11010100000100; // 4 c4 

default: rom_data = 0;
endcase 
end 
else rom_data = 0; 
end 

// Asynchronous reset assertion, synchronous reset deassertion
always @(negedge rst_n or posedge clk) begin
    if (!rst_n)
        rst_n_sync <= 1'b0;  // Asynchronous reset assertion
    else
        rst_n_sync <= 1'b1;  // Synchronous reset deassertion
end

// Data output logic
always @(*) begin
    if (!rst_n_sync)
        data = 17'b0;  // Clear data on reset
    else
        data = rom_data;  // Update data immediately from combinational logic
end

endmodule
