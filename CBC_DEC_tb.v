module tb_aes_128_cbc_decrypt;

    reg clk;
    reg rst_n;
    reg [127:0] ciphertext;
    reg [127:0] key;
    reg [127:0] iv;
    wire [127:0] plaintext;

    // Instantiate the AES CBC decryption module
    aes_128_cbc_decrypt uut (
        .clk(clk),
        .rst_n(rst_n),
        .ciphertext(ciphertext),
        .key(key),
        .iv(iv),
        .plaintext(plaintext)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize the clock and reset
        clk = 0;
        rst_n = 0;
        ciphertext = 128'h69c4e0d86a7b0430d8cdb78070b4c55a; // Example ciphertext (replace with actual ciphertext)
        key = 128'h000102030405060708090a0b0c0d0e0f;       // Example AES key
        iv = 128'h1234567890abcdef1234567890abcdef;        // Example IV

        // Apply reset
        #10 rst_n = 1;

        // Monitor the outputs
        $monitor("Time=%0t | Ciphertext=%h | Plaintext=%h", $time, ciphertext, plaintext);

        // Wait for 100 ns and stop
        #100 $stop;
    end

endmodule

