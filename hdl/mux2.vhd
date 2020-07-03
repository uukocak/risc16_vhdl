library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
generic (
    data_width : integer := 16 );
port (
  in1  : in  std_logic_vector(data_width-1 downto 0);
  in2  : in  std_logic_vector(data_width-1 downto 0);
  sel  : in  std_logic;
  outp : out std_logic_vector(data_width-1 downto 0));

end mux2;

architecture Behavioral of mux2 is
begin
  outp <= in1 when (sel = '0') else
          in2;
end Behavioral;
