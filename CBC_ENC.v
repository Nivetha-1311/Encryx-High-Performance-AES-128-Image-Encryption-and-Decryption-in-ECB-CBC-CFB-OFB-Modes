module aes_128_cbc(
    input wire clk,
    input wire rst_n,
    input wire [127:0] plaintext,
    input wire [127:0] key,
    input wire [127:0] iv,
    output reg [127:0] ciphertext
);

    wire [127:0] aes_output;
    reg [127:0] prev_cipher_block;
    reg [127:0] xor_input;

    // AES encryption core instance (simplified version)
    aes_128_core aes_core(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(xor_input),
        .key(key),
        .data_out(aes_output)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            prev_cipher_block <= iv;  // Initialize with IV
            ciphertext <= 0;
        end else begin
            xor_input <= plaintext ^ prev_cipher_block;  // XOR with previous ciphertext (or IV initially)
            ciphertext <= aes_output;                    // Get AES encrypted output
            prev_cipher_block <= aes_output;             // Update previous cipher block
        end
    end

endmodule

// Simplified AES core (dummy example, replace with full AES core)
module aes_128_core(
    input wire clk,
    input wire rst_n,
    input wire [127:0] data_in,
    input wire [127:0] key,
    output reg [127:0] data_out
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out <= 128'h0;
        end else begin
            // Here we should have AES encryption logic
            // For now, we'll just pass the input through for testing
            data_out <= data_in ^ key; // Dummy encryption for testing
        end
    end

endmodule

