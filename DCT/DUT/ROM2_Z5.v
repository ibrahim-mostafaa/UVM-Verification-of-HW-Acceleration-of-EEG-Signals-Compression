module ROM2_Z5(clk, rst_n, cs, addr, data);

input [2:0] addr; // address
input cs; // chip select
input rst_n; 
input clk; 
output reg [15:0] data;

reg [15:0] rom_data;
reg rst_n_sync;

always@(*) begin

if(cs)
begin
//   c1= 0.9807852804 , c2= 0.92387953251 , c3= 0.8314696123 , c4= 0.70710678118 , c5= 0.55557023302 , c6= 0.38268343236 , c7= 0.19509032201 
case(addr) 
3'b000: rom_data = 16'b0001001100111110;
3'b001: rom_data = 16'b1110111110101111;
3'b010: rom_data = 16'b0101001000000011;
3'b011: rom_data = 16'b0010111001110100;

3'b100: rom_data = 16'b0000011011000001;
3'b101: rom_data = 16'b1110001100110011;
3'b110: rom_data = 16'b0100010110000111;
3'b111: rom_data = 16'b0010000111111000;
default: rom_data = 16'b0;
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
 

// // c1= 0.9807852804 , c2= 0.92387953251 , c3= 0.8314696123 , c4= 0.70710678118 , c5= 0.55557023302 , c6= 0.38268343236 , c7= 0.19509032201 
// // make sure that c4 is equal 32'b01011010100000100111100110011001
// // This is for the first row to get z1 only 	*this is the first rom*
//     			                           // It must be in Fixed Point representation! 
// // first bit is for +/- , then the 2nd bit either 0 for 0 or 1 for 1, negatives is the 2's compliment for the whole number
 
//      if (addr == 3'b000) begin data <= 16'b0001001100111110; end // 0.3006724435 = -0.5(-0.8314696123 - 0.19509032201 + 0.9807852804 - 0.55557023302 )
// // (x0j==0 && x1j==0 && x2j==0 && x3j==0 )  0 = -0.5[-c3-c7+c1-c5] negative 1111  

// else if (addr == 3'b001) begin data <= 16'b1110111110101111; end // -0.2548977896 = -0.5(-0.8314696123 - 0.19509032201 + 0.9807852804 + 0.55557023302 )
// // (x0j==0 && x1j==0 && x2j==0 && x3j==1 ) -c2 = -0.5[-c3-c7+c1+c5] = negative 1110    

// else if (addr == 3'b010) begin data <= 16'b0101001000000011; end // 1.281457724 = -0.5(-0.8314696123 - 0.19509032201 - 0.9807852804 - 0.55557023302 )
// // (x0j==0 && x1j==0 && x2j==1 && x3j==0 ) -c6 = -0.5[-c3-c7-c1-c5] = negative 1101  
 
// else if (addr == 3'b011) begin data <= 16'b0010111001110100; end // 0.7258874908 = -0.5(-0.8314696123 - 0.19509032201 - 0.9807852804 + 0.55557023302 )
// // (x0j==0 && x1j==0 && x2j==1 && x3j==1 ) -c2-c6 = -0.5[-c3-c7-c1+c5] = negative 1100 
  

// else if (addr == 3'b100) begin data <= 16'b0000011011000001; end // 0.1055821215 = -0.5(-0.8314696123 + 0.19509032201 + 0.9807852804 - 0.55557023302 )
// // (x0j==0 && x1j==1 && x2j==0 && x3j==0 ) c6 = -0.5[-c3+c7+c1-c5] = negative 1011  

// else if (addr == 3'b101) begin data <= 16'b1110001100110011; end // -0.4499881116 = -0.5(-0.8314696123 + 0.19509032201 + 0.9807852804 + 0.55557023302 )
// // (x0j==0 && x1j==1 && x2j==0 && x3j==1 ) c6-c2 = -0.5[-c3+c7+c1+c5] = negative 1010  
  
// else if (addr == 3'b110) begin data <= 16'b0100010110000111; end // 1.086367402 = -0.5(-0.8314696123 + 0.19509032201 - 0.9807852804 - 0.55557023302 )
// // (x0j==0 && x1j==1 && x2j==1 && x3j==0 ) 0 = -0.5[-c3+c7-c1-c5] = negative 1001  
 
// else if (addr == 3'b111) begin data <= 16'b0010000111111000; end // 0.5307971688 = -0.5(-0.8314696123 + 0.19509032201 - 0.9807852804 + 0.55557023302 )
// // (x0j==0 && x1j==1 && x2j==1 && x3j==1 ) -c2 = -0.5[-c3+c7-c1+c5] = negative 1000   


