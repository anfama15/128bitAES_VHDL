
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ShiftRows is
Port (
        --clk                 :   IN  STD_LOGIC;
        inverse             :   IN  STD_LOGIC;
        State_array_In      :   IN  STD_LOGIC_VECTOR (127 DOWNTO 0);
        new_state_array     :   OUT STD_LOGIC_VECTOR (127 downto 0)
        );
end ShiftRows;

architecture Behavioral of ShiftRows is
        type row_arr is array(7 downto 0) of std_logic_vector(31 downto 0);
        signal row: row_arr;
        signal w0, w1, w2, w3 : STD_LOGIC_VECTOR (7 DOWNTO 0);
        signal w4, w5, w6, w7 : STD_LOGIC_VECTOR (7 DOWNTO 0);
        signal w8, w9, w10, w11 : STD_LOGIC_VECTOR (7 DOWNTO 0);
        signal w12, w13, w14, w15 : STD_LOGIC_VECTOR (7 DOWNTO 0);
begin
 

        -- Extract column 0 bytes
        w0 <= State_array_In(127 DOWNTO 120); --w0
        w1 <= State_array_In(119 DOWNTO 112); --w1
        w2 <= State_array_In(111 DOWNTO 104); --w2
        w3 <= State_array_In(103 DOWNTO 96);  --w3

        -- Extract column 1 bytes
        w4 <= State_array_In(95 DOWNTO 88);  --w4
        w5 <= State_array_In(87 DOWNTO 80);  --w5
        w6 <= State_array_In(79 DOWNTO 72);  --w6
        w7 <= State_array_In(71 DOWNTO 64);  --w7

        -- Extract column 2 bytes
        w8 <= State_array_In(63 DOWNTO 56); --w8
        w9 <= State_array_In(55 DOWNTO 48); --w9 
        w10 <= State_array_In(47 DOWNTO 40); --w10 
        w11 <= State_array_In(39 DOWNTO 32); --w11 

        -- Extract column 3 bytes
        w12 <= State_array_In(31 DOWNTO 24); --w12
        w13 <= State_array_In(23 DOWNTO 16); --w13
        w14 <= State_array_In(15 DOWNTO 8);  --w14
        w15 <= State_array_In(7 DOWNTO 0);  --w15

  --normal operation (Encryption    )
        row(0) <= w0 & w5 & w10 & w15;  -- w0  w4  w8  w12 --> w0  w4  w8  w12
        row(1) <= w4 & w9 & w14 & w3 ; -- w1  w5  w9  w13 --> w5  w9  w13 w1
        row(2) <= w8 & w13 & w2 & w7 ; -- w2  w6  w10 w14 --> w10 w14 w2  w6
        row(3) <= w12 & w1 & w6 & w11 ; -- w3  w7  w11 w15 --> w15 w3  w7  w11

        
        row(4) <= w0 & w13 & w10 & w7 ; -- w0  w4  w8  w12 --> w0   w4   w8  w12
        row(5)<= w4 & w1 & w14 & w11 ; -- w1  w5  w9  w13 --> w13  w1  w5   w9
        row(6)<= w8 & w5 & w2 & w15 ; -- w2  w6  w10 w14 --> w10  w14   w2  w6
        row(7)<= w12 & w9 & w6 & w3 ; -- w3  w7  w11 w15 --> w7   w11  w15  w3
        
        new_state_array<=row(0) & row(1) & row(2) & row(3) when (inverse='0') else
                        row(4) & row(5) & row(6) & row(7);



    
    end Behavioral;


