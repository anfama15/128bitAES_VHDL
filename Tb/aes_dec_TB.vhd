----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2024 06:23:06 PM
-- Design Name: 
-- Module Name: aes_dec_TB - Behavioral
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

entity aes_dec_TB is
--  Port ( );
end aes_dec_TB;

architecture Behavioral of aes_dec_TB is
signal        clk                     :   STD_LOGIC := '0';
signal        rst                     :   STD_LOGIC;
signal        inverse                     :   STD_LOGIC;

        
signal        key_in                  :   std_logic_vector(127 downto 0);
signal        plain_text              :   std_logic_vector(127 downto 0);
signal        enc_output      :   std_logic_vector(127 downto 0);
signal        dec_output      :   std_logic_vector(127 downto 0);
    constant clk_period : time := 10 ns;-- Clock period definition


begin
uut : entity work.AES_dec(Behavioral)

port map(
            clk => clk,rst => rst, key_in=>key_in,
            plain_text =>plain_text, ciphertext => enc_output,
decrypted_text=>   dec_output        
          );

 -- Clock process definitions
   clk_process: process
    begin
        clk<=not clk;
        wait for 5 ns;
    end process clk_process;


stimulus    : process
begin
key_in<=x"2b7e151628aed2a6abf7158809cf4f3c";
plain_text<=x"a0fafe1788542cb123a339392a6c7605";
inverse<='1';
rst<='0';

  wait for 10ns;

end process;

end Behavioral;
