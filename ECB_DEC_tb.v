module AES_128_decryption_tb;

// Testbench signals
reg clk;
reg rst;
reg [127:0] cipher_text;
reg [127:0] key;
wire [127:0] plain_text;
wire done;

// Instantiate the AES Decryption module (Corrected instantiation)
ECB_DEC uut (
    .clk(clk),
    .rst(rst),
    .cipher_text(cipher_text),
    .key(key),
    .plain_text(plain_text),
    .done(done)
);

// Clock generation
always #5 clk = ~clk;

// Initial setup for the testbench
initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    cipher_text = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;  // Cipher text to decrypt
    key = 128'h000102030405060708090a0b0c0d0e0f;         // Example AES key
    
    // Reset the system
    #10 rst = 0;
    
    // Wait for decryption to finish
    wait (done == 1);
    
    // Check results
    if (plain_text == 128'h00112233445566778899aabbccddeeff) begin
        $display("Decryption Successful");
    end else begin
        $display("Decryption Failed");
    end
    
    // Finish simulation
    #10 $stop;
end

endmodule

