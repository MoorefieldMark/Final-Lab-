//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);

//Holds the values of the next state
wire [5:0] next;

//If en == 1 then increment the counter, if state is == 59 then reset the counter.
//If en == 0 then we just keep the current state
assign next = (en == 1) ? ((state == 59) ? 0 : state + 1) : state;

//Each bit of state is connected to one of these D Flip Flops
dff instance_dffOne(
    .d(next[0]),
    .clk(clk),
    .rst(rst),
    .q(state[0])
);

dff instance_dffTwo(
    .d(next[1]),
    .clk(clk),
    .rst(rst),
    .q(state[1])
);

dff instance_dffThree(
    .d(next[2]),
    .clk(clk),
    .rst(rst),
    .q(state[2])
);

dff instance_dffFour(
    .d(next[3]),
    .clk(clk),
    .rst(rst),
    .q(state[3])
);

dff instance_dffFive(
    .d(next[4]),
    .clk(clk),
    .rst(rst),
    .q(state[4])
);

dff instance_dffSix(
    .d(next[5]),
    .clk(clk),
    .rst(rst),
    .q(state[5])
);
   
endmodule




