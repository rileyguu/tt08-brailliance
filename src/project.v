/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal reset signal (active high, inverted from rst_n)
    wire reset = ~rst_n;

    // Internal wire for reader1_out from braille_converter_top
    wire [7:0] reader1_out;

    // Instantiate the braille_converter_top module
    braille_converter_top braille_top_inst (
        .clk(clk),               // Clock comes from the template's clock input
        .reset(reset),           // Reset (active-high) from inverted rst_n
        .next(ui_in[0]),         // 'next' signal is now mapped to ui_in[0]
        .reader1_out(reader1_out) // Internal wire reader1_out connected to the output of the braille converter
    );

    // Assign the output reader1_out from braille_converter_top to uo_out
    assign uo_out = reader1_out;

    // Assign unused IO pins to 0
    assign uio_out = 8'b0;        // All unused IOs set to 0
    assign uio_oe  = 8'b0;        // Set IOs in input mode (0=input)

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in, ui_in[7:1], 1'b0};  // Updated to account for ui_in[0] being used

endmodule
