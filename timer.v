//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //6-bits to represent the highest number 59
);

//Holds the values of the next state
wire [5:0] next;

//If reset == 1 then we reset the counter
//If reset == 0 then we check if load == 1
//If load == 1 we set the clock to that value
//If load == 0 then we check if en == 1
//If en == 1 then we count down by 1 and stop at 0
//If en == 0 then we hold the current state 
assign next = (rst == 1) ? 0 : (load == 1) ? load_value : (en == 1) ? ((state == 0) ? 0 : state - 1) : state;


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