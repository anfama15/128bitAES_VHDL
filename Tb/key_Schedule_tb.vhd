library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity key_schedule_tb is
end key_schedule_tb;

architecture Behavioral of key_Schedule_tb is
 

    -- Signals to connect to the UUT
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';

    signal key_in : STD_LOGIC_VECTOR (127 downto 0):= (others => '0');
    signal key_s1 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s2 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s3 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s4 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s5 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s6 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s7 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s8 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s9 : STD_LOGIC_VECTOR (127 downto 0);
    signal key_s10 : STD_LOGIC_VECTOR (127 downto 0);
       -- signal key_s11 : STD_LOGIC_VECTOR (127 downto 0);




    



begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.keySchedule(Behavioral) Port map (
                clk => clk,
                rst =>rst,
                key_in => key_in,
                key_s1 => key_s1,
                key_s2 => key_s2,
                key_s3 => key_s3,
                key_s4 => key_s4,
                key_s5 => key_s5,
                key_s6 => key_s6,
                key_s7 => key_s7,
                key_s8 => key_s8,
                key_s9 => key_s9,
                key_s10 => key_s10
                               -- key_s11 => key_s11

        
      
    );

  -- Clock generation
    clk_process: process
    begin
        clk<=not clk;
        wait for 10 ns;
    end process;


    -- Stimulus process
    stim_proc: process
    begin		
        -- Test vector: Applying a known key
        key_in <= x"2b7e151628aed2a6abf7158809cf4f3c";
        rst <='0';
      
        
        

        -- Stop simulation
        wait;
    end process;

end Behavioral;
