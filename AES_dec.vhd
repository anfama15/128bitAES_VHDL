

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES_dec is
 Port ( 
        clk                    : IN  STD_LOGIC;
        rst                    : IN  STD_LOGIC;             
        key_in                 : IN  STD_LOGIC_VECTOR(127 downto 0);
        plain_text             : IN  STD_LOGIC_VECTOR(127 downto 0);
        ciphertext             : OUT STD_LOGIC_VECTOR(127 downto 0);
        decrypted_text             : OUT STD_LOGIC_VECTOR(127 downto 0) 
 
 
 );
end AES_dec;

architecture Behavioral of AES_dec is
component AES_enc is
    Port (  
       clk                    : IN  STD_LOGIC;
        rst                    : IN  STD_LOGIC;   
        inverse                : IN  STD_LOGIC;
     
        key_in                 : IN  STD_LOGIC_VECTOR(127 downto 0);
        plain_text             : IN  STD_LOGIC_VECTOR(127 downto 0);
        ciphertext             : OUT STD_LOGIC_VECTOR(127 downto 0)
          );
end component;
signal inverse_0                :   STD_LOGIC;
signal inverse_1                :   STD_LOGIC;
signal cipher                :   STD_LOGIC_vector (127 downto 0);
signal dec                :   STD_LOGIC_vector (127 downto 0);




begin
inverse_0<='0';
inverse_1<='1';


AES_ENC_1 : AES_enc port map (clk=>clk,rst=>rst,inverse=>inverse_0,key_in=>key_in,plain_text=>plain_text,ciphertext =>cipher);
AES_DEC_1 : AES_enc port map (clk=>clk,rst=>rst,inverse=>inverse_1,key_in=>key_in,plain_text=>cipher,ciphertext =>dec);


process (clk)
begin 
ciphertext<=cipher;
decrypted_text<=dec;
end process;

end Behavioral;
