----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2024 03:39:20 AM
-- Design Name: 
-- Module Name: ShiftRows_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ShiftRows_tb is
--  Port ( );
end ShiftRows_tb;

architecture Behavioral of ShiftRows_tb is
signal         State_array_In      :    STD_LOGIC_VECTOR (127 DOWNTO 0);
signal         new_state_array     :    STD_LOGIC_VECTOR (127 downto 0);
--signal         clk                 :    STD_LOGIC;
signal         inverse             :    STD_LOGIC;
    constant clk_period : time := 10 ns;

begin
uut : entity work.ShiftRows(Behavioral)
port map (
            --clk           => clk,
            inverse       => inverse,
            State_array_in => state_array_in,
            new_state_array => new_state_array
        
);

-- clk_process : process
--    begin
--        while true loop
--            clk <= '1';
--            wait for clk_period / 2;
--            clk <= '0';
--            wait for clk_period / 2;
--        end loop;
--    end process;
    
stim_proc   : process 
begin 
State_array_In<=x"1b20296384296e2f6e84b720d684b7b7";
inverse<='1';
        wait for 20 ns;

end process ;

end Behavioral;
