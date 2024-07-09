library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftColumns_tb is
end ShiftColumns_tb;

architecture Behavioral of ShiftColumns_tb is
    -- Component Declaration for the Unit Under Test (UUT)
--    component ShiftColumns
--        Port (
--       clk                 :   IN  std_logic;
--        State_array_in      :   IN  std_logic_vector(127 downto 0); -- Corrected range
--        output              :   OUT std_logic_vector(127 downto 0)    -- Corrected range
--        );
--    end component;

    -- Signals to connect to the UUT
   -- signal clk       : std_logic := '0';
    signal inverse       : std_logic ;

    signal state_array_in  : std_logic_vector(127 downto 0);
    signal output : std_logic_vector(127 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.ShiftColumns(structural)
        port map (
          inverse       => inverse,
          state_array_in  => state_array_in,
            output => output
        );

    -- Clock generation
--    clk_process: process
--    begin
--        clk <= '0';
--        wait for 10 ns;
--        clk <= '1';
--        wait for 10 ns;
--    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1
        state_array_in <= x"d4bf5d30e0b452aeb84111f11e2798e5";
        inverse <= '0';
        wait for 20 ns;
     end process;
     
     end Behavioral;
