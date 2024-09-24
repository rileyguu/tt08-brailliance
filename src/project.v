`default_nettype none

module braille_converter_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path (unused)
    output wire [7:0] uio_out,  // IOs: Output path (unused)
    output wire [7:0] uio_oe,   // IOs: Enable path (unused, set to input mode)
    input  wire       ena,      // always 1 when the design is powered, ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - active low reset
);

  // Internal signals
  wire reset = ~rst_n;  // Active low reset, so invert rst_n
  wire [7:0] reader1_out;  // Output from internal logic (to be defined)

  // Assign input pins
  assign clk   = ui_in[0];  // Clock input
  assign reset = ui_in[1];  // Reset input (active low)
  assign next  = ui_in[2];  // 'next' signal input
  
  // Map reader1_out to the dedicated outputs
  assign uo_out = reader1_out;

  // Assign unused IO pins to zero
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;  // Set bidirectional pins to input mode (0= input)

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, ui_in[7:3], 1'b0};

endmodule
