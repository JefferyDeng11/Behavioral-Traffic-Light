`timescale 1ns / 1ps

module tb();

    reg     quartzClock,  carDetected;
    wire    green, yellow, red;
    wire    [3:0] timerDisp;
    
    main    dummy(quartzClock, carDetected, green, yellow, red, timerDisp);
    
    initial begin
    
            quartzClock = 0;  carDetected = 0;
        #10 quartzClock = 1;
        #10 carDetected = 1;
        end
    
    always begin
        #10 quartzClock = !quartzClock;
        end

endmodule
