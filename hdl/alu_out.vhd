library ieee;
use ieee.std_logic_1164.all;

entity alu_out is
  port( clk  : in  std_logic;
        rst  : in  std_logic;
        inp  : in  std_logic_vector(15 downto 0);
        outp : out std_logic_vector(15 downto 0));
end alu_out;

architecture Behavioral of alu_out is

signal alu_in : std_logic_vector(15 downto 0);

begin
    process (clk,rst)
      begin
        if rst ='1' then
          alu_in <= (others => '0');
        elsif rising_edge(clk) then
          alu_in <= inp;
        end if;
    end process;

outp <= alu_in;

end Behavioral;
