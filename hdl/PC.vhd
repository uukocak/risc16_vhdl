library ieee;
use ieee.std_logic_1164.all;

entity PC is
  port( clk  : in  std_logic;
        rst  : in  std_logic;
        inp  : in  std_logic_vector(15 downto 0);
        en   : in  std_logic;
        outp : out std_logic_vector(15 downto 0));
end PC;

architecture Behavioral of PC is

signal pc_in : std_logic_vector(15 downto 0);

begin
    process (clk,rst)
      begin
        if rst ='1' then
          pc_in <= (others => '0');
        elsif rising_edge(clk) and en = '1' then
          pc_in <= inp;
        end if;
    end process;

outp <= pc_in;
  
end Behavioral;
