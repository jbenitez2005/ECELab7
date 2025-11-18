module seg_detector(
input clk, rst, P1,
output Y;
);
parameter  s0=0, s1=2'b01, s2=2, s3=3;

reg [1:0] PS, NS;

//state initialization
always @(posedge clk or rst)
begin
    if (reset)
        PS <= S0;
    else
        PS <= NS;
    
end

//state transition
always @(posedge PS or P1)
begin

    case(PS)
    begin
    S0:
    begin
    if(P1)
    NS <= S1;
    else
    NS<=S0;
    end
    NS<=
    S1:
    S2:
    S3:

    endcase
    
end

//output
always @(posedge PS or P1) //MEALY
//always @(PS) //MOORE


case(PS)
    begin
    S0:
    begin
    if(P1)
    NS <= S1;
    else
    NS<=S0;
    end
    S1: Y=0;
    S2:
    S3:

    endcase
begin
//---------------
    S0: Y=0;
    S1: Y=0;
    S2: Y=0;
    S3: Y=1;
    

endmodule