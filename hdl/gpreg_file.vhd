-- Quartus Prime VHDL Template
-- True Dual-Port RAM with single clock
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gpreg_file is

	generic
	(
		DATA_WIDTH : natural := 16;
		ADDR_WIDTH : natural := 4
	);

	port
	( rst : in std_logic;
		clk		: in std_logic;
        we  	: in std_logic;
		addr_a	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		addr_b	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		addr_in	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
        data_in	: in std_logic_vector((DATA_WIDTH-1) downto 0);
        data_a	: out std_logic_vector((DATA_WIDTH-1) downto 0);
        data_b	: out std_logic_vector((DATA_WIDTH-1) downto 0)
	);

end gpreg_file;

architecture rtl of gpreg_file is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	-- Declare the RAM
	signal ram : memory_t;

begin

	process(clk,rst)
	begin
	if rst = '1' then
	    ram := (others => (others => '0'));
        null;
	elsif(rising_edge(clk)) then
		if(we = '1') then
			ram(to_integer(unsigned(addr_in))) <= data_in;
		end if;
		data_a <= ram(to_integer(unsigned(addr_a)));
		data_b <= ram(to_integer(unsigned(addr_b)));
	end if;
	end process;

end rtl;
