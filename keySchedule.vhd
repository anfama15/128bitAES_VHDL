library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity keySchedule is
  Port (
    clk     : in  STD_LOGIC;
    rst     : in  STD_LOGIC;
    key_in  : in  STD_LOGIC_VECTOR (127 downto 0);
    key_s0  : OUT  STD_LOGIC_VECTOR (127 downto 0);
    key_s1  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s2  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s3  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s4  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s5  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s6  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s7  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s8  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s9  : out STD_LOGIC_VECTOR (127 downto 0);
    key_s10 : out STD_LOGIC_VECTOR (127 downto 0)
  );
end keySchedule;

architecture Behavioral of keySchedule is

  type key_array is array (1 to 10) of std_logic_vector(127 downto 0);
  signal keys : key_array;

  component AddRCon is
    Port (
      i_state  : in  std_logic_vector(31 downto 0);
      i_state0 : in  std_logic_vector(31 downto 0);
      round    : in  INTEGER range 1 to 10;
      rcon     : out STD_LOGIC_VECTOR (31 downto 0)
    );
  end component;

  type word_array is array (0 to 43) of STD_LOGIC_VECTOR(31 downto 0);
  signal w : word_array;

  type temp1 is array (1 to 10) of STD_LOGIC_VECTOR(31 downto 0);
  signal R_out : temp1;
begin

  -- Instances of AddRCon
  r1  : AddRCon Port map (i_state0 => w(0),      i_state => w(3),  round => 1,  rcon => R_out(1));
  r2  : AddRCon Port map (i_state0 => R_out(1),  i_state => w(7),  round => 2,  rcon => R_out(2));
  r3  : AddRCon Port map (i_state0 => R_out(2),  i_state => w(11), round => 3,  rcon => R_out(3));
  r4  : AddRCon Port map (i_state0 => R_out(3), i_state => w(15), round => 4,  rcon => R_out(4));
  r5  : AddRCon Port map (i_state0 => R_out(4), i_state => w(19), round => 5,  rcon => R_out(5));
  r6  : AddRCon Port map (i_state0 => R_out(5), i_state => w(23), round => 6,  rcon => R_out(6));
  r7  : AddRCon Port map (i_state0 => R_out(6), i_state => w(27), round => 7,  rcon => R_out(7));
  r8  : AddRCon Port map (i_state0 => R_out(7), i_state => w(31), round => 8,  rcon => R_out(8));
  r9  : AddRCon Port map (i_state0 => R_out(8), i_state => w(35), round => 9,  rcon => R_out(9));
  r10 : AddRCon Port map (i_state0 => R_out(9), i_state => w(39), round => 10, rcon => R_out(10));

  -- Key expansion logic
  w(0) <= key_in(127 downto 96);
  w(1) <= key_in(95 downto 64);
  w(2) <= key_in(63 downto 32);
  w(3) <= key_in(31 downto 0);

  w(4)  <= R_out(1);
  process (clk)
  begin
--    if rising_edge(clk) then
--      if rst = '1' then
--        -- Reset keys to default value
--        for i in 1 to 10 loop
--          keys(i) <= (others => '0');
--        end loop;
--      else
      
 
  w(5)  <= w(1) xor w(4);
  w(6)  <= w(2) xor w(1) xor w(4);
  w(7)  <= w(3) xor w(2) xor w(1) xor w(4);

  w(8)  <= R_out(2);  w(9)  <= w(5) xor R_out(2);
  w(10) <= w(6) xor w(5) xor R_out(2);
  w(11) <= w(7) xor w(6) xor w(5) xor R_out(2);

  w(12) <= R_out(3);
  w(13) <= w(9) xor R_out(3);
  w(14) <= w(10) xor w(9) xor R_out(3);
  w(15) <= w(11) xor w(10) xor w(9) xor R_out(3);

  w(16) <= R_out(4);
  w(17) <= w(13) xor R_out(4);
  w(18) <= w(14) xor w(13) xor R_out(4);
  w(19) <= w(15) xor w(14) xor w(13) xor R_out(4);

  w(20) <= R_out(5);
  w(21) <= w(17) xor R_out(5);
  w(22) <= w(18) xor w(17) xor R_out(5);
  w(23) <= w(19) xor w(18) xor w(17) xor R_out(5);

  w(24) <= R_out(6);
  w(25) <= w(21) xor R_out(6);
  w(26) <= w(22) xor w(21) xor R_out(6);
  w(27) <= w(23) xor w(22) xor w(21) xor R_out(6);

  w(28) <= R_out(7);
  w(29) <= w(25) xor R_out(7);
  w(30) <= w(26) xor w(25) xor R_out(7);
  w(31) <= w(27) xor w(26) xor w(25) xor R_out(7);

  w(32) <= R_out(8);
  w(33) <= w(29) xor R_out(8);
  w(34) <= w(30) xor w(29) xor R_out(8);
  w(35) <= w(31) xor w(30) xor w(29) xor R_out(8);

  w(36) <= R_out(9);
  w(37) <= w(33) xor R_out(9);
  w(38) <= w(34) xor w(33) xor R_out(9);
  w(39) <= w(35) xor w(34) xor w(33) xor R_out(9);

  w(40) <= R_out(10);
  w(41) <= w(37) xor R_out(10);
  w(42) <= w(38) xor w(37) xor R_out(10);
  w(43) <= w(39) xor w(38) xor w(37) xor R_out(10);

       
--      end if;
--    end if;
  end process;

  -- Assign keys to outputs
    key_s0 <= w(0) & w(1) & w(2) & w(3);
    key_s1 <= w(4) & w(5) & w(6) & w(7);
    key_s2 <= w(8) & w(9) & w(10) & w(11);
    key_s3 <= w(12) & w(13) & w(14) & w(15);
    key_s4 <= w(16) & w(17) & w(18) & w(19);
    key_s5 <= w(20) & w(21) & w(22) & w(23);
    key_s6 <= w(24) & w(25) & w(26) & w(27);
    key_s7 <= w(28) & w(29) & w(30) & w(31);
    key_s8 <= w(32) & w(33) & w(34) & w(35);
    key_s9 <= w(36) & w(37) & w(38) & w(39);
    key_s10 <= w(40) & w(41) & w(42) & w(43);

end Behavioral;
