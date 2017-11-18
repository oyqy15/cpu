--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
package cpu_constant is

constant ALU_ADD : std_logic_vector(2 downto 0):= "000";
constant ALU_AND : std_logic_vector(2 downto 0):= "001";
constant ALU_SUB : std_logic_vector(2 downto 0):= "010";
constant ALU_SLL : std_logic_vector(2 downto 0):= "011";
constant ALU_SRA : std_logic_vector(2 downto 0):= "100";
constant ALU_SRL : std_logic_vector(2 downto 0):= "101";
constant ALU_OR : std_logic_vector(2 downto 0):= "110";
constant ALU_NOP : std_logic_vector(2 downto 0):= "111";

constant MEM_NOP: std_logic_vector(1 downto 0):= "00";
constant MEM_READ: std_logic_vector(1 downto 0):= "01";
constant MEM_WRITE: std_logic_vector(1 downto 0):= "10";


constant PREDICT_NOP: std_logic_vector(1 downto 0):= "00";
constant PREDICT_EZ: std_logic_vector(1 downto 0):= "01";
constant PREDICT_NZ: std_logic_vector(1 downto 0):= "10";


-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end cpu_constant;

package body cpu_constant is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end cpu_constant;
