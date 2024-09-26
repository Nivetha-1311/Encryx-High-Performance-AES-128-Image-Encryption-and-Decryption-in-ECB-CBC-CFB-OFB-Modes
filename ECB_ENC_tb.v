module ECB_ENC_tb;

    reg clk;
    reg rst;
    reg start;
    reg [127:0] plaintext;
    reg [127:0] key;
    wire [127:0] ciphertext;
    wire done;

    ECB_ENC aes (
        .clk(clk),
        .rst(rst),
        .start(start),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        start = 0;
        plaintext = 128'h00112233445566778899aabbccddeeff;
        key = 128'h000102030405060708090a0b0c0d0e0f;

        // Release reset and start encryption
        #10 rst = 0;
        #10 start = 1;

        // Wait for encryption to complete
        wait(done);
        $display("Ciphertext: %h", ciphertext);

        // End simulation
        #10 $finish;
    end
endmodule

