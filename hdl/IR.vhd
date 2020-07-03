library ieee;
use ieee.std_logic_1164.all;

entity IR is
port (
  clk : in std_logic;
  rst : in std_logic;
  instruction  : in  std_logic_vector(15 downto 0);
  IR_wr_en : in std_logic;
  sel_S1 : out std_logic_vector(3 downto 0);
  sel_S2 : out std_logic_vector(3 downto 0);
  sel_D  : out std_logic_vector(3 downto 0);
  opcodes : out std_logic_vector(3 downto 0);
  immediate : out std_logic_vector(7 downto 0)
  );
end IR;

architecture Behavioral of IR is

signal instruction_in :std_logic_vector(15 downto 0);

begin

process(clk,rst)
begin
    if rst = '1' then
      instruction_in <= (others => '0');
    elsif rising_edge(clk) and IR_wr_en = '1' then
      instruction_in <= instruction;
    end if;
end process;

sel_S1 <= instruction_in(7 downto 4);
sel_S2 <= instruction_in(3 downto 0);
sel_D <= instruction_in(11 downto 8);
opcodes <= instruction_in(15 downto 12);
immediate <= instruction_in(7 downto 0);

end Behavioral;
