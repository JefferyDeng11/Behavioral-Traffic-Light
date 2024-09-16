`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Jeffery Deng
// 
// Create Date: 05/12/2024 01:24:10 PM
// Module Name: main 
// Project Name: Traffic Light
// 
//////////////////////////////////////////////////////////////////////////////////


module main(quartzClock, carDetected, green, yellow, red, timerDisp);

    input    quartzClock, carDetected;
    output   green, yellow, red;
    output  [3:0] timerDisp;
    
    //Green: 15s, Yellow: 3s, Red: 12s
    //Green = 11, yellow = 01, red = 00
    reg     [1:0] state = 2'b00;
    reg     [1:0] nextState = 2'b11;
    reg     [3:0] timer = 4'b1111; //starts at 15s
    reg     [7:0] clock = 8'b00000000;
    
    always @ (posedge quartzClock) begin
        //In presence of a car
        if(carDetected) begin
            clock = clock + 8'b00000001;
            //decrement timer
            if(clock == 0) begin
                timer = timer - 4'b0001;
            end
            //Green light 
            if(nextState == 3) begin
                state = nextState;
                if(timer == 0) begin
                    nextState = 2'b01;
                    timer = 4'b0011;
                end
            end
            //Yellow light
            else if(nextState == 1) begin
                state = nextState;
                if(timer == 0) begin
                    nextState = 2'b00;
                    timer = 4'b1111;
                end
            end
            //Red light
            else if(nextState == 0) begin
                state = nextState;
                if(timer == 0) begin
                    nextState = 2'b11;
                    timer = 4'b1111;
                end
            end
           
        end
        
        else begin
        //reset states
            state = 2'b00;
            timer = 4'b1111; //starts at 15s
            clock = 8'b00000000;
        end
    //end of always
    end
    
    assign timerDisp = timer;
    assign green    =   state[1]    &   state[0];
    assign yellow   =   !state[1]   &   state[0];
    assign red      =   !state[1]   &   !state[0];
    
endmodule
