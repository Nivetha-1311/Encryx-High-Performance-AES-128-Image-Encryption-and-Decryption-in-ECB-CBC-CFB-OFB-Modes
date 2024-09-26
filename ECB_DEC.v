module ECB_DEC(
    input wire clk,
    input wire rst,
    input wire [127:0] cipher_text,
    input wire [127:0] key,
    output reg [127:0] plain_text,
    output reg done
);

// Internal variables and states
reg [3:0] round;
reg [127:0] state;
reg [127:0] round_keys [0:10];  // Declare round keys globally

// Round key generation and decryption rounds logic
task generate_round_keys(input [127:0] key_in);
begin
    // Add round key generation logic here (can be the inverse of encryption round keys)
    // Modify the global round_keys array directly
end
endtask

task add_round_key(input [127:0] in_state, input [127:0] round_key, output [127:0] out_state);
begin
    out_state = in_state ^ round_key;
end
endtask

task inv_shift_rows(input [127:0] in_state, output [127:0] out_state);
begin
    // Implement inverse shift rows
end
endtask

task inv_sub_bytes(input [127:0] in_state, output [127:0] out_state);
begin
    // Implement inverse sub bytes
end
endtask

task inv_mix_columns(input [127:0] in_state, output [127:0] out_state);
begin
    // Implement inverse mix columns
end
endtask

always @(posedge clk or posedge rst) begin
    if (rst) begin
        done <= 0;
        round <= 0;
        state <= 128'h0;
    end else begin
        if (round == 0) begin
            state <= cipher_text;  // Initialize the state with cipher text
            generate_round_keys(key);  // Call key generation task
            add_round_key(state, round_keys[10], state);  // Initial AddRoundKey
            round <= round + 1;
        end else if (round < 10) begin
            inv_shift_rows(state, state);
            inv_sub_bytes(state, state);
            add_round_key(state, round_keys[10 - round], state);
            if (round != 9) inv_mix_columns(state, state);
            round <= round + 1;
        end else begin
            plain_text <= state;
            done <= 1;  // Signal that decryption is complete
        end
    end
end

endmodule

