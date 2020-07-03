library ieee;
use ieee.std_logic_1164.all;

entity CU is
port(
  clk : in std_logic;
  rst : in std_logic;
  opcodes : in std_logic_vector(3 downto 0);
  GPRF_wr : out std_logic;
  IR_wr_en : out std_logic;
  S2_select : out std_logic;
  ALU_op : out std_logic_vector(3 downto 0);
  ALU_src_1 : out std_logic;
  ALU_src_2 : out std_logic_vector(1 downto 0);
  PC_WCond : out std_logic;
  PC_Write  : out std_logic;
  PC_Source  : out std_logic;
  mem_read : out std_logic;
  MemtoReg : out std_logic;
  cmd_in : out std_logic_vector(1 downto 0)
  );
end CU;

architecture Behavioral of CU is

type state_cu is (idle, fetch, decode, execute, arithmetic, write_back, compare);
signal state, next_state : state_cu;

begin

process(clk, rst)
begin
    if (rst = '1') then
        state <= idle;
    elsif rising_edge(clk) then
        state <= next_state;
    end if;
end process;

process(state, opcodes)
begin
   IR_wr_en <= '0';
   ALU_op <= "1100";
   ALU_src_1 <= '0';
   ALU_src_2 <= "00";
   PC_source <= '0';
   PC_Write <= '0';
   mem_read <= '0';
   GPRF_wr <= '0';
   MemtoReg <= '0';
   S2_select <= '0';
   PC_WCond <= '0';
   cmd_in <= "00";
   mem_read <= '0';
   MemtoReg <= '1';

  case state is
    when idle =>
        next_state <= fetch;
    when fetch =>
        next_state <= decode;
        mem_read <= '1';
        ALU_op <= "0000";
        ALU_src_1 <= '1';
        ALU_src_2 <= "01";
        PC_Write <= '1';
        next_state <= decode;
        IR_wr_en <= '1';
    when decode =>
        next_state <= execute;
    when execute =>
       ALU_op <= opcodes;
        if opcodes(3)='0' OR opcodes = "1000" then
           next_state <= arithmetic;
        elsif opcodes = "1001" OR opcodes = "1010" OR opcodes = "1111" then
           cmd_in <= opcodes(1 downto 0);
           next_state <= fetch;
        elsif opcodes = "1011" then
           ALU_src_1 <= '1';
           ALU_src_2 <= "10";
           PC_Write <= '1';
           next_state <= fetch;
        elsif opcodes = "1101" or opcodes = "1110" then
           ALU_op <= "1011";
           PC_source <= '1';
           ALU_src_1 <= '1';
           ALU_src_2 <= "10";
           S2_select <= '1';
           next_state <= compare;
        else
           next_state <= fetch;
        end if;
    when arithmetic =>
        GPRF_wr <= '1';
        MemtoReg <= '0';
       ALU_op <= opcodes;
        next_state <= write_back;
    when write_back =>
       ALU_op <= opcodes;
        next_state <= fetch;
    when compare =>
       PC_WCond <= '1';
        ALU_op <= opcodes;
        next_state <= fetch;
    when others =>
       null;
  end case;
end process;

end Behavioral;
