----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2024 02:37:53 AM
-- Design Name: 
-- Module Name: SubBytes_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SubBytes_TB is
--  Port ( );
end SubBytes_TB;

architecture Behavioral of SubBytes_TB is
    signal i_state: std_logic_vector(127 downto 0);
    signal o_state: std_logic_vector(127 downto 0);
    signal inverse: std_logic;

begin
    uut: entity work.SubBytes(Behavioral)
        port map (
            i_state => i_state,
            o_state => o_state,
            inverse => inverse
        );
-- Stimulus process
    stimulus: process
    begin
        -- Test case 1
        i_state <= x"444f204e4f542054454c4c204a4f4500";
        inverse <= '0';
        wait for 20 ns;

end process;
end Behavioral;
