-- Quartus Prime VHDL Template
-- Single-port RAM with single read/write address and initial contents

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.testbench_utils_pkg.all;

entity memory16_bit is

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

end memory16_bit;

architecture rtl of memory16_bit is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

    --TODO: rebuild initialization
	function init_ram
		return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
	begin
		for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
		end loop;
        -- CODE_SEGMENT
        tmp(0) := encode(LI_OP,AD(R0),x"01");
        tmp(1) := encode(LI_OP,AD(R1),x"02");
        tmp(2) := encode(LI_OP,AD(R2),x"0A");
        tmp(3) := encode(ADD_OP,AD(R3),AD(R0),AD(R1));
        tmp(4) := encode(LI_OP,AD(R5),x"0D");
        tmp(5) := encode(JZ_OP,AD(R4),x"03");
        tmp(6) := (others => '0');
        tmp(7) := (others => '0');
        tmp(8) := encode(ADD_OP,AD(R4),AD(R0),AD(R2));
        tmp(9) := encode(STORE_OP,AD(R5),AD(R4));
        tmp(10) := encode(JUMP_OP,x"05");
        tmp(11) := (others => '0');
        tmp(12) := (others => '0');
        tmp(13) := (others => '0');
        tmp(14) := (others => '0');
        tmp(15) := encode(LOAD_OP,AD(R8),AD(R2));

        --tmp(0) := encode(LOAD_OP,AD(R3),AD(R9));        -- LOAD MEM(*(R9)) => R3
        --tmp(1) := encode(NOP_OP);                       -- NOP
        --tmp(2) := encode(STORE_OP,AD(R5),AD(R4));       -- STORE R4 => MEM(*(R5))
        --tmp(3) := encode(ADD_OP,AD(R3),AD(R0),AD(R1));  -- ADD R3 = R1 + R0
        --tmp(4) := encode(LI_OP,AD(R5),"11101101");      -- Load immidiate R5 = "11101101"
        --tmp(5) := encode(NOP_OP);
        --tmp(6) := encode(JUMP_OP,x"04");                -- JUMP x03 (PC = PC + 3)
        --tmp(7) := encode(JZ_OP,AD(R4),x"04");           -- JZ R4, x04, (PC = PC + 4) if R4 = 0
        --tmp(8) := encode(NOP_OP);
        --
        --tmp(0) := encode(ADD_OP,AD(R0),AD(R3),AD(R9));
        --tmp(1) := encode(SUB_OP,AD(R0),AD(R3),AD(R9));
        --tmp(2) := encode(AND_OP,AD(R0),AD(R3),AD(R9));
        --tmp(3) := encode(OR_OP,AD(R0),AD(R3),AD(R9));
        --tmp(4) := encode(NOT_OP,AD(R0),AD(R3));
        --tmp(5) := encode(XOR_OP,AD(R0),AD(R3),AD(R9));
        --tmp(6) := encode(CMP_OP,AD(R0),AD(R3),AD(R9));
        --tmp(7) := encode(SL_OP,AD(R0),AD(R3));
        --tmp(8) := encode(SR_OP,AD(R0),AD(R3));
        --tmp(9) := encode(LOAD_OP,AD(R3),AD(R9));
        --tmp(10) := encode(STORE_OP,AD(R9),AD(R0));
        --tmp(11) := encode(LI_OP,AD(R0),x"ED");

        ---- DATA_SEGMENT
        --tmp(9) := B"0000_0000_1000_0000"; -- Source address pointer
        --tmp(10) := encode(AND_OP,AD(R0),AD(R9),AD(R6));
        --tmp(11) := encode(JZ_OP,AD(R0),x"30");
        --tmp(12) := encode(NOP_OP);
        --tmp(13) := encode(JNZ_OP,AD(R5),x"03");
        --tmp(14) := encode(NOP_OP);
        --tmp(15) := encode(NOP_OP);
        --tmp(16) := encode(CMP_OP,AD(R1),AD(R9),AD(R3));
        --tmp(17) := encode(NOP_OP);
        ---- STR_SEGMENT
        tmp(43981) := B"1111_0101_0000_1010"; -- Data in *(ABCD) = F50A
		return tmp;
	end init_ram;

	-- Declare the RAM signal and specify a default value.	Quartus Prime
	-- will create a memory initialization file (.mif) based on the
	-- default value.
	signal ram : memory_t := init_ram;

	-- Register to hold the address
	signal addr_reg : natural range 0 to 2**ADDR_WIDTH-1;

begin

    addr_reg <= to_integer(unsigned(addr));

	process(clk)
	begin
	if(falling_edge(clk)) then

        r_data <= (others => 'Z'); --Default case

		if(we = '1') then
			ram(addr_reg) <= w_data;
		end if;
		-- Register the address for reading
        if(re = '1') then
            r_data <= ram(addr_reg);
        end if;
	end if;
	end process;


end rtl;
