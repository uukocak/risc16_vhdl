library ieee;
use ieee.std_logic_1164.all;

entity LSU is
	port
	(
		clk		   : in std_logic;
        cmd_in     : in std_logic_vector(1 downto 0);   -- 00 idle, 01 load, 10 store , 11 load_im
		mdr_in     : in std_logic_vector(15 downto 0);
        data_a_in  : in std_logic_vector(15 downto 0);
        data_b_in  : in std_logic_vector(15 downto 0);
        imm_in     : in std_logic_vector(7 downto 0);
		mdr_out    : out std_logic_vector(15 downto 0);
        mem_data_w : out std_logic_vector(15 downto 0);
        addr_out   : out std_logic_vector(15 downto 0);
        memR       : out std_logic;
        memW       : out std_logic;
        regfileWR  : out std_logic;
        IorD       : out std_logic
	);
end entity;

architecture rtl of LSU is

    signal MDR : std_logic_vector(15 downto 0); -- mdr_out

    type state_t is (IDLE, LOAD, STORE, LOAD_IM);
    signal state_c,state_next : state_t;

begin
    FSM : process (state_c,cmd_in)
        variable clk_count : integer range 0 to 3:= 0;
    begin
            memR      <= '0';
            memW      <= '0';
            IorD      <= '0';
            regfileWR <= '0';
            case(state_c) is
                when IDLE =>
                    if(cmd_in = "00") then
                        state_next <= IDLE;
                    elsif(cmd_in = "01") then
                        memR      <= '1';
                        IorD      <= '1';
                        state_next <= LOAD;
                    elsif(cmd_in = "10") then
                        memW      <= '1';
                        IorD      <= '1';
                        state_next <= STORE;
                    else
                        state_next <= LOAD_IM;
                    end if;
                when LOAD =>
                    if clk_count = 0 then
                        clk_count := clk_count + 1;
                        state_next <= LOAD;
                    else
                        regfileWR <= '1';
                        clk_count := 0;
                        state_next <= IDLE;
                    end if;
                when STORE =>
                    if clk_count = 0 then
                        clk_count := clk_count + 1;
                        state_next <= STORE;
                    else
                        clk_count := 0;
                        state_next <= IDLE;
                    end if;
                when LOAD_IM =>
                    if clk_count = 0 then
                        clk_count := clk_count + 1;
                        state_next <= LOAD_IM;
                    else
                        regfileWR <= '1';
                        clk_count := 0;
                        state_next <= IDLE;
                    end if;
            end case;
    end process;

    STATE_TRANS : process(clk)
    begin
        if rising_edge(clk) then
            state_c <= state_next;
        end if;
    end process;

    REG_TRANSFER : process(clk)
    begin
        if rising_edge(clk) then
            MDR <= mdr_in;
        end if;
    end process;

    mdr_out <=  (x"00" & imm_in) when state_c = LOAD_IM else MDR;
    mem_data_w <= data_b_in;
	addr_out <= data_a_in;

end rtl;
