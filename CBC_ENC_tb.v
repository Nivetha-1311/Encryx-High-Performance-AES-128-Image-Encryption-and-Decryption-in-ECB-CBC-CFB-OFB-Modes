module tb_aes_128_cbc;

    reg clk;
    reg rst_n;
    reg [127:0] plaintext;
    reg [127:0] key;
    reg [127:0] iv;
    wire [127:0] ciphertext;

    // Instantiate the AES CBC encryption module
    aes_128_cbc uut (
        .clk(clk),
        .rst_n(rst_n),
        .plaintext(plaintext),
        .key(key),
        .iv(iv),
        .ciphertext(ciphertext)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize the clock and reset
        clk = 0;
        rst_n = 0;
        plaintext = 128'h00112233445566778899aabbccddeeff;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        iv = 128'h1234567890abcdef1234567890abcdef;

        // Apply reset
        #10 rst_n = 1;

        // Monitor the outputs
        $monitor("Time=%0t | Plaintext=%h | Ciphertext=%h", $time, plaintext, ciphertext);

        // Change plaintext after some time
        #20 plaintext = 128'hffeeddccbbaa99887766554433221100;

        // Wait and stop
        #100 $stop;
    end

endmodule

