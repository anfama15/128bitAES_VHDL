
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES_enc is
    Port (  
        clk                    : IN  STD_LOGIC;
        rst                    : IN  STD_LOGIC;   
        inverse                : IN  STD_LOGIC;
        key_in                 : IN  STD_LOGIC_VECTOR(127 downto 0);
        plain_text             : IN  STD_LOGIC_VECTOR(127 downto 0);
        ciphertext             : OUT STD_LOGIC_VECTOR(127 downto 0)
    );
end AES_enc;

architecture Behavioral of AES_enc is
    -- component declaration keyschedule
    component keyschedule is
        Port (
            clk     : IN  STD_LOGIC;
            rst     : IN  STD_LOGIC;
            key_in  : IN  STD_LOGIC_VECTOR (127 downto 0);
            key_s0  : OUT  STD_LOGIC_VECTOR (127 downto 0);
            key_s1  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s2  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s3  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s4  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s5  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s6  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s7  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s8  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s9  : OUT STD_LOGIC_VECTOR (127 downto 0);
            key_s10 : OUT STD_LOGIC_VECTOR (127 downto 0)
        );
    end component;
    
    
   -- component declaration for sub_bytes
   component SubBytes is
 Port (
        inverse : in std_logic;
        i_state : in  std_logic_vector(127 downto 0);
        o_state : out std_logic_vector(127 downto 0)
    );
end component;


--component declaration for ShiftRows

        component ShiftRows is
Port (
       
         -- clk                 :   IN  STD_LOGIC;
        inverse             :   IN  STD_LOGIC;
        State_array_In      :   IN  STD_LOGIC_VECTOR (127 DOWNTO 0);
        new_state_array     :   OUT STD_LOGIC_VECTOR (127 downto 0)
        );
end component;

-- component declaration for ShiftColumns

            component ShiftColumns is
    port (  state_array_in   : in std_logic_vector(127 downto 0);
            inverse          : in std_logic;
            output           : out std_logic_vector(127 downto 0));
            end component;
            
-- component declaration for AddRoundKeys

             component AddRoundKeys is
port(
        input_key   : IN    std_logic_vector(127 downto 0);
        state_array : IN    std_logic_vector(127 downto 0);
        output      : out   std_logic_vector(127 downto 0)

);
end component;      
---temp signals for debugging
    signal Intial_Rnd    : std_logic_vector(127 downto 0);
    signal Intial_Rnd_inv    : std_logic_vector(127 downto 0);
    signal temp3    : std_logic_vector(127 downto 0);
    
--signals for inverse condition for aes_dec
   -- signal inverse : std_logic;

--signals for keyschedule instantiation 
    type key_array is array (0 to 10) of STD_LOGIC_VECTOR(127 downto 0);
    signal keys : key_array;
     --signals for subbytes instantiation 
    type sub_bytes_array_in is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal sub_bytes_in : sub_bytes_array_in;
    
    type sub_bytes_array_out is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal sub_bytes_out : sub_bytes_array_out;
    
    --signals for shiftrows instantiation 
    type shiftrows_array_in is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal shiftrows_in : shiftrows_array_in;
    
    type shiftrows_array_out is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal shiftrows_out : shiftrows_array_out;
    
      --signals for ShiftColumn instantiation 
    type ShiftColumn_array_in is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal ShiftColumn_in : ShiftColumn_array_in;
    
    type ShiftColumn_array_out is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal ShiftColumn_out : ShiftColumn_array_out;
    
      --signals for AddRoundkey instantiation 
    type AddRoundkey_array_in is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal Round_inv : AddRoundkey_array_in;
    
    type AddRoundkey_array_out is array (0 to 20) of STD_LOGIC_VECTOR(127 downto 0);
    signal Round_out : AddRoundkey_array_out;
begin
    --instance of keyschedule
    keys_inst : keyschedule
        port map (
            clk => clk, 
            rst => rst, 
            key_in => key_in,
            key_s0 => keys(0),
            key_s1 => keys(1),
            key_s2 => keys(2),
            key_s3 => keys(3),
            key_s4 => keys(4),
            key_s5 => keys(5),
            key_s6 => keys(6),
            key_s7 => keys(7),
            key_s8 => keys(8),
            key_s9 => keys(9),
            key_s10 => keys(10)
        );
        

   ---Intial round
      Intial_Rnd<=plain_text xor keys(0);
      Intial_Rnd_inv<=plain_text xor keys(10);

--Round 1
      SB1  :   subbytes        port map (inverse => inverse,i_state =>Intial_Rnd, o_state =>sub_bytes_out(1) );
      SR1  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(1),new_state_array=> shiftrows_out(1) );
      SC1  :   shiftcolumns    port map (state_array_in =>shiftrows_out(1), inverse => inverse, output=>ShiftColumn_out(1) );
      ARK1 :   AddRoundKeys    port map (input_key =>  keys(1),state_array =>ShiftColumn_out(1),output =>Round_out(1)   );
 --Round 2
      SB2  :   subbytes        port map (inverse => inverse,i_state =>Round_out(1), o_state =>sub_bytes_out(2) );
      SR2  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(2),new_state_array=> shiftrows_out(2) );
      SC2  :   shiftcolumns    port map (state_array_in =>shiftrows_out(2), inverse => inverse, output=>ShiftColumn_out(2) );
      ARK2 :   AddRoundKeys    port map (input_key =>  keys(2),state_array =>ShiftColumn_out(2),output =>Round_out(2)   );
 --Round 3
      SB3  :   subbytes        port map (inverse => inverse,i_state =>Round_out(2), o_state =>sub_bytes_out(3) );
      SR3  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(3),new_state_array=> shiftrows_out(3) );
      SC3  :   shiftcolumns    port map (state_array_in =>shiftrows_out(3), inverse => inverse, output=>ShiftColumn_out(3) );
      ARK3 :   AddRoundKeys    port map (input_key =>  keys(3),state_array =>ShiftColumn_out(3),output =>Round_out(3)   );
 --Round 4
      SB4  :   subbytes        port map (inverse => inverse,i_state =>Round_out(3), o_state =>sub_bytes_out(4) );
      SR4  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(4),new_state_array=> shiftrows_out(4) );
      SC4  :   shiftcolumns    port map (state_array_in =>shiftrows_out(4), inverse => inverse, output=>ShiftColumn_out(4) );
      ARK4 :   AddRoundKeys    port map (input_key =>  keys(4),state_array =>ShiftColumn_out(4),output =>Round_out(4)   );
  --Round 5
      SB5  :   subbytes        port map (inverse => inverse,i_state =>Round_out(4), o_state =>sub_bytes_out(5) );
      SR5  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(5),new_state_array=> shiftrows_out(5) );
      SC5  :   shiftcolumns    port map (state_array_in =>shiftrows_out(5), inverse => inverse, output=>ShiftColumn_out(5) );
      ARK5 :   AddRoundKeys    port map (input_key =>  keys(5),state_array =>ShiftColumn_out(5),output =>Round_out(5)   );
   --Round 6
      SB6  :   subbytes        port map (inverse => inverse,i_state =>Round_out(5), o_state =>sub_bytes_out(6) );
      SR6  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(6),new_state_array=> shiftrows_out(6) );
      SC6  :   shiftcolumns    port map (state_array_in =>shiftrows_out(6), inverse => inverse, output=>ShiftColumn_out(6) );
      ARK6 :   AddRoundKeys    port map (input_key =>  keys(6),state_array =>ShiftColumn_out(6),output =>Round_out(6)   );
      --Round 7
      SB7  :   subbytes        port map (inverse => inverse,i_state =>Round_out(6), o_state =>sub_bytes_out(7) );
      SR7  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(7),new_state_array=> shiftrows_out(7) );
      SC7  :   shiftcolumns    port map (state_array_in =>shiftrows_out(7), inverse => inverse, output=>ShiftColumn_out(7) );
      ARK7 :   AddRoundKeys    port map (input_key =>  keys(7),state_array =>ShiftColumn_out(7),output =>Round_out(7)   );
      --Round 8
      SB8  :   subbytes        port map (inverse => inverse,i_state =>Round_out(7), o_state =>sub_bytes_out(8) );
      SR8  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(8),new_state_array=> shiftrows_out(8) );
      SC8  :   shiftcolumns    port map (state_array_in =>shiftrows_out(8), inverse => inverse, output=>ShiftColumn_out(8) );
      ARK8 :   AddRoundKeys    port map (input_key =>  keys(8),state_array =>ShiftColumn_out(8),output =>Round_out(8)   );  
       --Round 9
      SB9  :   subbytes        port map (inverse => inverse,i_state =>Round_out(8), o_state =>sub_bytes_out(9) );
      SR9  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(9),new_state_array=> shiftrows_out(9) );
      SC9  :   shiftcolumns    port map (state_array_in =>shiftrows_out(9), inverse => inverse, output=>ShiftColumn_out(9) );
      ARK9 :   AddRoundKeys    port map (input_key =>  keys(9),state_array =>ShiftColumn_out(9),output =>Round_out(9)   );  
      --Round 10
      SB10  :   subbytes        port map (inverse => inverse,i_state =>Round_out(9), o_state =>sub_bytes_out(10) );
      SR10  :   shiftrows       port map (inverse => inverse,State_array_In => sub_bytes_out(10),new_state_array=> shiftrows_out(10) );
     -- SC9  :   shiftcolumns    port map (state_array_in =>shiftrows_out(9), inverse => inverse, output=>ShiftColumn_out(9) );
      ARK10 :   AddRoundKeys    port map (input_key =>  keys(10),state_array =>shiftrows_out(10),output =>Round_out(10)   );
--Inverse Round 1
      SR11  :   shiftrows       port map (inverse => inverse,State_array_In =>Intial_Rnd_inv ,new_state_array=> shiftrows_out(11) );
      SB11  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(11), o_state =>sub_bytes_out(11) );
      ARK11 :   AddRoundKeys    port map (input_key =>  keys(9),state_array =>sub_bytes_out(11),output =>Round_out(11)   );
      SC11  :   shiftcolumns    port map (state_array_in =>Round_out(11), inverse => inverse, output=>ShiftColumn_out(11) );
      
 --Inverse Round 2
      SR12  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(11) ,new_state_array=> shiftrows_out(12) );
      SB12  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(12), o_state =>sub_bytes_out(12) );
      ARK12 :   AddRoundKeys    port map (input_key =>  keys(8),state_array =>sub_bytes_out(12),output =>Round_out(12)   );
      SC12  :   shiftcolumns    port map (state_array_in =>Round_out(12), inverse => inverse, output=>ShiftColumn_out(12) );
 --Inverse Round 3
      SR13  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(12) ,new_state_array=> shiftrows_out(13) );
      SB13  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(13), o_state =>sub_bytes_out(13) );
      ARK13 :   AddRoundKeys    port map (input_key =>  keys(7),state_array =>sub_bytes_out(13),output =>Round_out(13)   );
      SC13  :   shiftcolumns    port map (state_array_in =>Round_out(13), inverse => inverse, output=>ShiftColumn_out(13) );
 --Inverse Round 4
      SR14  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(13) ,new_state_array=> shiftrows_out(14) );
      SB14  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(14), o_state =>sub_bytes_out(14) );
      ARK14 :   AddRoundKeys    port map (input_key =>  keys(6),state_array =>sub_bytes_out(14),output =>Round_out(14)   );
      SC14  :   shiftcolumns    port map (state_array_in =>Round_out(14), inverse => inverse, output=>ShiftColumn_out(14) );
  --Inverse Round 5
      SR15  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(14) ,new_state_array=> shiftrows_out(15) );
      SB15  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(15), o_state =>sub_bytes_out(15) );
      ARK15 :   AddRoundKeys    port map (input_key =>  keys(5),state_array =>sub_bytes_out(15),output =>Round_out(15)   );
      SC15  :   shiftcolumns    port map (state_array_in =>Round_out(15), inverse => inverse, output=>ShiftColumn_out(15) );
   --Inverse Round 6
      SR16  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(15) ,new_state_array=> shiftrows_out(16) );
      SB16  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(16), o_state =>sub_bytes_out(16) );
      ARK16 :   AddRoundKeys    port map (input_key =>  keys(4),state_array =>sub_bytes_out(16),output =>Round_out(16)   );
      SC16  :   shiftcolumns    port map (state_array_in =>Round_out(16), inverse => inverse, output=>ShiftColumn_out(16) );
    --Inverse Round 7
      SR17  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(16) ,new_state_array=> shiftrows_out(17) );
      SB17  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(17), o_state =>sub_bytes_out(17) );
      ARK17 :   AddRoundKeys    port map (input_key =>  keys(3),state_array =>sub_bytes_out(17),output =>Round_out(17)   );
      SC17  :   shiftcolumns    port map (state_array_in =>Round_out(17), inverse => inverse, output=>ShiftColumn_out(17) );
      --Inverse Round 8
       SR18  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(17) ,new_state_array=> shiftrows_out(18) );
      SB18  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(18), o_state =>sub_bytes_out(18) );
      ARK18 :   AddRoundKeys    port map (input_key =>  keys(2),state_array =>sub_bytes_out(18),output =>Round_out(18)   );
      SC18  :   shiftcolumns    port map (state_array_in =>Round_out(18), inverse => inverse, output=>ShiftColumn_out(18) );
       --Inverse Round 9
      SR19  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(18) ,new_state_array=> shiftrows_out(19) );
      SB19  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(19), o_state =>sub_bytes_out(19) );
      ARK19 :   AddRoundKeys    port map (input_key =>  keys(1),state_array =>sub_bytes_out(19),output =>Round_out(19)   );
      SC19  :   shiftcolumns    port map (state_array_in =>Round_out(19), inverse => inverse, output=>ShiftColumn_out(19) );
      --Inverse Round 10
     SR20  :   shiftrows       port map (inverse => inverse,State_array_In =>ShiftColumn_out(19) ,new_state_array=> shiftrows_out(20) );
      SB20  :   subbytes        port map (inverse => inverse,i_state => shiftrows_out(20), o_state =>sub_bytes_out(20) );
      ARK20 :   AddRoundKeys    port map (input_key =>  key_in,state_array =>sub_bytes_out(20),output =>Round_out(20)  );
     

 
   process (clk)
   begin
if inverse='0' then
    ciphertext <= Round_out(10);
elsif inverse='1' then
        ciphertext <= Round_out(20)  ;
        
        end if;



--     

   ---Round 1   
   end process;

end Behavioral;
