library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port( rst  : in  std_logic;
          inp1 : in  std_logic_vector(15 downto 0);
          inp2 : in  std_logic_vector(15 downto 0);
          ALU_op : in  std_logic_vector(3 downto 0);
          cmp_S1_S2 : out std_logic;
          outp   : out std_logic_vector(15 downto 0);
          flags : out std_logic_vector(4 downto 0)
         );
end ALU;

architecture rtl of ALU is

signal flags_in : std_logic_vector(4 downto 0);

begin

flags_in(0) <= '1' when inp1 = inp2 else '0';
flags_in(1) <= '1' when inp1 = x"0000" else '0';
flags_in(2) <= '1' when inp2 = x"0000" else '0';
flags_in(3) <= '1' when inp1 > inp2 else '0';
flags_in(4) <= '1' when inp1 < inp2 else '0';

flags <= flags_in;

process(ALU_op,inp1,inp2,rst)
begin
    if rst = '1' then
        outp <= (others => '0');
    else
            cmp_S1_S2 <= '0';
            if ALU_op = "0000"  then
                outp <= std_logic_vector(unsigned(inp1) + unsigned(inp2));
            elsif ALU_op = "0001" then
                if unsigned(inp1) > unsigned(inp2) then
                    outp <= std_logic_vector(unsigned(inp1) - unsigned(inp2));
                else
                    outp <= std_logic_vector(unsigned(inp2) - unsigned(inp1));
                end if;
            elsif ALU_op = "0010" then
                outp <= inp1 AND inp2;
            elsif ALU_op = "0011" then
                outp <= inp1 OR inp2;
            elsif ALU_op = "0100" then
                outp <= NOT inp2;
            elsif ALU_op = "0101" then
                outp <= inp1 XOR inp2;
            elsif ALU_op = "0110" then
                outp <= "00000000000" & flags_in;
            elsif ALU_op = "0111" then
                outp <= inp1(14 downto 0) & '0';
            elsif ALU_op = "1000" then
                outp <= '0' & inp1(15 downto 1);
            elsif ALU_op = "1011" then
                outp <= std_logic_vector(unsigned(inp1) + unsigned(inp2) - 1);
            elsif ALU_op = "1101" then
                if(inp2 = x"0000") then
                    cmp_S1_S2 <= '1';
                else
                    cmp_S1_S2 <= '0';
                end if;
            elsif ALU_op = "1110" then
                if(inp2 = x"0000") then
                    cmp_S1_S2 <= '0';
                else
                    cmp_S1_S2 <= '1';
                end if;
            else
                outp <= (others => '0');
            end if;
    end if;
end process;


end architecture;
