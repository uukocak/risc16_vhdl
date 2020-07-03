library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.testbench_utils_pkg.all;

entity RISC16_bit_tb is
end RISC16_bit_tb;

architecture rtl of RISC16_bit_tb is

	component memory16_bit
		generic 
		(
			DATA_WIDTH : natural := 16;
			ADDR_WIDTH : natural := 16
		);
		port 
		(
            clk		: in std_logic;
            we		: in std_logic;
            re		: in std_logic;
            addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
            w_data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
            r_data	: out std_logic_vector((DATA_WIDTH-1) downto 0)
		);
	end component;

    component CPU 
        port (
        instruction : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        address : out std_logic_vector(15 downto 0);
        mem_read : out std_logic;
        mem_write : out std_logic;
        data : out std_logic_vector(15 downto 0));
    end component;
	
	signal clk : std_logic;
    signal rst : std_logic;

    signal mem_we : std_logic;
    signal mem_re : std_logic;
    signal mem_addr : std_logic_vector(15 downto 0);
    signal mem_w_data : std_logic_vector(15 downto 0);
    signal mem_r_data : std_logic_vector(15 downto 0);

    signal ACC_ADDR : std_logic_vector(15 downto 0);

    signal CLK_PERIOD : time    := 10 ns;
    signal CLK_ON     : boolean := true;
 
begin

    ACC_ADDR <= mem_addr when mem_re = '1' else (others => '0');

	mem1: memory16_bit
	port map(clk    => clk,
             we     => mem_we,
             re     => mem_re,
             addr   => mem_addr,
             w_data => mem_w_data,
             r_data => mem_r_data
            );

    cpu1 : CPU
    port map( instruction => mem_r_data,
            clk => clk,
            rst => rst,
            address => mem_addr,
            mem_read => mem_re,
            mem_write => mem_we,
            data => mem_w_data
        );

    clock_gen : process
    begin
        if CLK_ON then
            clk <= '1';
            wait for CLK_PERIOD/2;
            clk <= '0';
            wait for CLK_PERIOD/2;
        else
            wait;
        end if;
    end process;

    stimulus: process
        variable error_count : integer range 0 to 64 := 0;
    begin
        --Control Signals operation
        rst <= '1';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        -----------------------------
        rst <= '0';
 
        wait for 140*CLK_PERIOD;

        report "Test finished with " & integer'Image(0) & " error"  severity error;

        CLK_ON <= false;
        wait;
    end process;

end rtl;
