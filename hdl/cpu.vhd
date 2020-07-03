library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPU is port (
    instruction : in std_logic_vector(15 downto 0);
    clk : in std_logic;
    rst : in std_logic;
    address : out std_logic_vector(15 downto 0);
    mem_read : out std_logic;
    mem_write : out std_logic;
    data : out std_logic_vector(15 downto 0));
end CPU;

architecture Behavioral of CPU is

component gpreg_file
	generic (
      DATA_WIDTH : natural := 16;
	    ADDR_WIDTH : natural := 4	);
	port (
      rst		  : in  std_logic;
	  	clk		  : in  std_logic;
      we    	: in  std_logic;
	  	addr_a	: in  std_logic_vector((ADDR_WIDTH-1) downto 0);
	  	addr_b	: in  std_logic_vector((ADDR_WIDTH-1) downto 0);
	  	addr_in	: in  std_logic_vector((ADDR_WIDTH-1) downto 0);
      data_in	: in  std_logic_vector((DATA_WIDTH-1) downto 0);
	    data_a	: out std_logic_vector((DATA_WIDTH-1) downto 0);
      data_b	: out std_logic_vector((DATA_WIDTH-1) downto 0)	);
end component;

component mux2
generic (
    data_width : integer := 16 );
port(
  in1  : in  std_logic_vector(data_width-1 downto 0);
  in2  : in  std_logic_vector(data_width-1 downto 0);
  sel  : in  std_logic;
  outp : out std_logic_vector(data_width-1 downto 0));
end component;

component mux3
port(
  in1  : in  std_logic_vector(15 downto 0);
  in2  : in  std_logic_vector(15 downto 0);
  in3  : in  std_logic_vector(7 downto 0);
  sel  : in  std_logic_vector(1 downto 0);
  outp : out std_logic_vector(15 downto 0));
end component;

component ALU
    port( rst  : in  std_logic;
          inp1 : in  std_logic_vector(15 downto 0);
          inp2 : in  std_logic_vector(15 downto 0);
          ALU_op : in  std_logic_vector(3 downto 0);
          cmp_S1_S2 : out std_logic;
          outp   : out std_logic_vector(15 downto 0);
          flags : out std_logic_vector(4 downto 0)
         );
end component;

component IR
port (
  clk : in std_logic;
  rst : in std_logic;
  instruction  : in  std_logic_vector(15 downto 0);
  IR_wr_en : in std_logic;
  sel_S1 : out std_logic_vector(3 downto 0);
  sel_S2 : out std_logic_vector(3 downto 0);
  sel_D  : out std_logic_vector(3 downto 0);
  opcodes : out std_logic_vector(3 downto 0);
  immediate : out std_logic_vector(7 downto 0)
  );
end component;

component PC
  port( clk  : in  std_logic;
        rst  : in  std_logic;
        inp  : in  std_logic_vector(15 downto 0);
        en   : in  std_logic;
        outp : out std_logic_vector(15 downto 0));
end component;

component alu_out
  port( clk  : in  std_logic;
        rst  : in  std_logic;
        inp  : in  std_logic_vector(15 downto 0);
        outp : out std_logic_vector(15 downto 0));
end component;

component CU
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
  mem_read  : out std_logic;
  MemtoReg : out std_logic;
  cmd_in : out std_logic_vector(1 downto 0)
  );
end component;

component LSU
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
end component;


signal GPRF_wr : std_logic;
signal sel_S1 : std_logic_vector(3 downto 0);
signal sel_S2 : std_logic_vector(3 downto 0);
signal sel_D : std_logic_vector(3 downto 0);
signal data_S1 : std_logic_vector(15 downto 0);
signal data_S2 : std_logic_vector(15 downto 0);
signal IR_wr_en : std_logic;
signal S2_select : std_logic;
signal opcodes : std_logic_vector(3 downto 0);
signal immediate : std_logic_vector(7 downto 0);
signal mux1_out : std_logic_vector(3 downto 0);
signal flags : std_logic_vector(4 downto 0);
signal alu_outp : std_logic_vector(15 downto 0);
signal cmp_S1_S2 : std_logic;
signal ALU_op : std_logic_vector(3 downto 0);
signal mux2_out : std_logic_vector(15 downto 0);
signal mux3_out : std_logic_vector(15 downto 0);
signal ALU_src_1 : std_logic;
signal ALU_src_2 : std_logic_vector(1 downto 0);
signal PC_out : std_logic_vector(15 downto 0);
signal PC_WCond : std_logic;
signal PC_Write  : std_logic;
signal PC_Source : std_logic;
signal mux4_out : std_logic_vector(15 downto 0);
signal alu_out_out : std_logic_vector(15 downto 0);
signal pc_en : std_logic;
signal MemtoReg : std_logic;
signal mux5_out : std_logic_vector(15 downto 0);
signal lsu_out : std_logic_vector(15 downto 0);
signal GPRF_wr_mem : std_logic;
signal GPRF_wr_main : std_logic;
signal IorD : std_logic;
signal address_out : std_logic_vector(15 downto 0);
signal cmd_in : std_logic_vector(1 downto 0);
signal mem_read_LSU : std_logic;
signal mem_read_CU : std_logic;

begin

mem_read <= mem_read_LSU OR mem_read_CU;

pc_en <= (PC_WCond AND cmp_S1_S2 ) OR PC_Write;
GPRF_wr_main <= GPRF_wr_mem OR GPRF_wr;

u_gpreg_file : gpreg_file
    generic map (
        DATA_WIDTH => 16,
        ADDR_WIDTH => 4 )
    port map (
        rst     => rst,
        clk		  => clk,
        we    	=> GPRF_wr_main,
        addr_a	=> sel_S1,
        addr_b	=> mux1_out,
        addr_in	=> sel_D,
        data_in	=> mux5_out,
        data_a	=> data_S1,
        data_b	=> data_S2 );


u_mux2_1 : mux2
generic map(
    data_width => 4 )
port map (
  in1  => sel_S2,
  in2  => sel_D,
  sel  => S2_select,
  outp => mux1_out);


u_IR : IR
port map (
  clk => clk,
  rst => rst,
  instruction => instruction,
  IR_wr_en => IR_wr_en,
  sel_S1 => sel_S1,
  sel_S2 => sel_S2,
  sel_D  => sel_D,
  opcodes => opcodes,
  immediate => immediate );


U_ALU : ALU
port map ( rst  => rst,
           inp1 => mux2_out,
           inp2 => mux3_out,
           ALU_op => ALU_op,
           cmp_S1_S2 => cmp_S1_S2,
           outp => alu_outp,
           flags => flags );

u_mux2_2 : mux2
generic map(
    data_width => 16 )
port map (
  in1  => data_S1,
  in2  => PC_out,
  sel  => ALU_src_1,
  outp => mux2_out);

u_mux3_3 :  mux3
port map(
  in1  => data_S2,
  in2  => x"0001",
  in3  => immediate,
  sel  => ALU_src_2,
  outp => mux3_out );

u_PC :  PC
port map ( clk  => clk,
           rst  => rst,
           inp  => mux4_out,
           en   => pc_en,
           outp => pc_out );

u_alu_out : alu_out
port map ( clk  => clk,
           rst  => rst,
           inp  => alu_outp,
           outp => alu_out_out);

 u_mux2_4 : mux2
 generic map(
     data_width => 16 )
 port map (
   in1  => alu_outp,
   in2  => alu_out_out,
   sel  => PC_source,
   outp => mux4_out );

 u_CU : CU
port map (
     clk => clk,
     rst => rst,
     opcodes => opcodes,
     GPRF_wr => GPRF_wr,
     IR_wr_en  => IR_wr_en,
     S2_select  => S2_select,
     ALU_op  => ALU_op,
     ALU_src_1  => ALU_src_1,
     ALU_src_2  => ALU_src_2,
     PC_WCond  => PC_WCond,
     PC_Write   => PC_Write,
     PC_Source  => PC_Source,
     mem_read => mem_read_CU,
     MemtoReg => MemtoReg,
     cmd_in => cmd_in
 );

 u_mux2_5 : mux2
 generic map(
     data_width => 16 )
 port map (
   in1  => alu_out_out,
   in2  => lsu_out,
   sel  => MemtoReg,
   outp => mux5_out);

 u_LSU : LSU
 	port map (
    clk		     => clk,
    cmd_in     => cmd_in,
    mdr_in     => instruction,
    data_a_in  => data_S1,
    data_b_in  => data_S2,
    imm_in     => immediate,
    mdr_out    => lsu_out,
    mem_data_w => data,
    addr_out   => address_out,
    memR       => mem_read_LSU,
    memW       => mem_write,
    regfileWR  => GPRF_wr_mem,
    IorD       => IorD );

u_mux2_6 : mux2
generic map(
    data_width => 16 )
port map (
  in1  => pc_out,
  in2  => address_out,
  sel  => IorD,
  outp => address);


end Behavioral;
