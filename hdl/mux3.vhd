library ieee;
use ieee.std_logic_1164.all;

entity mux3 is
port(
  in1  : in  std_logic_vector(15 downto 0);
  in2  : in  std_logic_vector(15 downto 0);
  in3  : in  std_logic_vector(7 downto 0);
  sel  : in  std_logic_vector(1 downto 0);
  outp : out std_logic_vector(15 downto 0));
end mux3;

architecture Behavioral of mux3 is
begin
  outp <= in1 when (sel = "00") else
          in2 when (sel = "01") else
          x"00" & in3 when (sel = "10") else
          x"0000";
end Behavioral;
