module top 
(
    input clk,           // 100 MHz
    input btnC,          // reset
    input [15:0] sw,     // switches
    output [15:0] led,    //LEDs
    output [3:0] an,     //Outputs for 7-segment display
    output [6:0] seg     //Outputs for 7-segment display
);

/******** DO NOT MODIFY ********/
wire clk_1Hz;       //Generate Internal 1Hz Clock
wire btnC_1Hz;     //Stretch load signal

//If running simulation, output clock frequency is 100MHz, else 1Hz
`ifndef SYNTHESIS
    assign clk_1Hz = clk;
`else
    clk_div #(.INPUT_FREQ(100_000_000), .OUTPUT_FREQ(1)) clk_div_1Hz 
    (.iclk(clk) , .rst(btnC) , .oclk(clk_1Hz));
`endif

// Check stopwatch/timer frequency
initial begin
`ifndef SYNTHESIS
    $display("Stopwatch/Timer Frequency set to 100MHz");
`else
    $display("Stopwatch/Timer Frequency set to 1Hz");
`endif
end

//Seven Segment Display Interface
seven_segment_inf seven_segment_inf_inst (.clk(clk), .rst(btnC), .count(count) , .anode(an), .segs(seg));

// Control signals
wire mode   = sw[0];        // 0 = stopwatch, 1= timer
wire run    = sw[1];        // 0 = pause (circuit holds it state), 1 = run (counter increments/decrements)
wire load   = sw[2];        // 1 = load value from load_value into timer counter, 0 = do nothing
wire [5:0] load_value = sw[15:10];      //Set Timer Value (Value to load in timer)

//Stop watch output value
wire [5:0] sw_count;
//Timer output value
wire [5:0]  tm_count;
//Determines which mode to use for the timer
wire [5:0] count = (mode == 0) ? sw_count : tm_count;

stopwatch instance_SW (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(run & ~mode),
    .state(sw_count)
);

timer instance_timer (
    .clk(clk_1Hz),
    .rst(btnC),
    .en(run & mode),
    .load(load & mode),
    .load_value(load_value),
    .state(tm_count)
);

//Displays the stopwatch value on LEDs
assign led[8:3] = sw_count;
//Displays the timer value on LEDs
assign led[15:10] = tm_count;

endmodule