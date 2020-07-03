library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

package testbench_utils_pkg is

    type OPCODE_t is (ADD_OP,SUB_OP,AND_OP,OR_OP,NOT_OP,XOR_OP,CMP_OP,SL_OP,SR_OP,LOAD_OP,STORE_OP,JUMP_OP,NOP_OP,JZ_OP,JNZ_OP,LI_OP);
    type GPR_t is (R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15);

    function encode(opcode: OPCODE_t; par1,par2,par3: std_logic_vector := "0000") return std_logic_vector;
    function AD(reg_name: GPR_t) return std_logic_vector;
    function vec2str(vec: std_logic_vector) return string;
    
end package testbench_utils_pkg ;

package body testbench_utils_pkg is

    function vec2str(vec: std_logic_vector) return string is 
        variable result_b: string(1 to (vec'high+1) ); 
        variable result_l: string((vec'high+1) downto 1 ); 
    begin 
        if (vec'left > vec'right) then
            for i in 1 to vec'high+1 loop 
                case to_x01(vec(i-1)) is 
                    when '1' =>  
                        result_l(i) := '1'; 
                    when '0' =>  
                        result_l(i) := '0'; 
                    when others =>       
                        result_l(i) := 'X'; 
                end case; 
            end loop; 
            return result_l; 
        else
            for i in 1 to vec'high+1 loop 
                case to_x01(vec(i-1)) is 
                    when '1' =>  
                        result_b(i) := '1'; 
                    when '0' =>  
                        result_b(i) := '0'; 
                    when others =>       
                        result_b(i) := 'X'; 
                end case; 
            end loop; 
            return result_b; 
        end if;
    end; 

    function AD(reg_name: GPR_t) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(GPR_t'Pos(reg_name),4));
    end;

    function encode(opcode: OPCODE_t; par1,par2,par3: std_logic_vector := "0000") return std_logic_vector is 
        variable opcode_temp: std_logic_vector(3 downto 0); 
        variable temp: std_logic_vector(15 downto 0); 
    begin 
        opcode_temp := std_logic_vector(to_unsigned(OPCODE_t'Pos(opcode),4));
        if(OPCODE_t'Pos(opcode) < 9) then -- arithmetic, logical or compare operation
            temp := opcode_temp & par1 & par2 & par3;
        elsif(opcode = LOAD_OP) then           -- load
            temp := opcode_temp & par1 & par2 & "0000";
        elsif(opcode = STORE_OP) then           -- store
            temp := opcode_temp & "0000" & par1 & par2;
        elsif(opcode = JUMP_OP) then           -- jump
            temp := opcode_temp & "0000" & par1;
        elsif((opcode = JZ_OP) OR (opcode = JNZ_OP)) then
            temp := opcode_temp & par1 & par2;
        elsif(opcode = LI_OP) then           
            temp := opcode_temp & par1 & par2;
        elsif(opcode = NOP_OP) then          
            temp := opcode_temp & par1 & par2 & par3;
        else
            report "Wrong use of function" severity warning;
        end if;

    return temp;
    end; 
    
end package body testbench_utils_pkg;
