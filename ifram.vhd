----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:06:20 11/18/2017 
-- Design Name: 
-- Module Name:    ifram - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ifram is
	Port ( rst : in STD_LOGIC;
			 clk : in STD_LOGIC;
			 pause : in STD_LOGIC;
			 pc_pc: in STD_LOGIC_VECTOR(15 downto 0);
			 b_need_id: in STD_LOGIC;
		 	 b_pc_id: in STD_LOGIC_VECTOR(15 downto 0);
		    b_need_ex: in STD_LOGIC;
			 b_pc_ex: in STD_LOGIC_VECTOR(15 downto 0);
					
			 nextpc: out STD_LOGIC_VECTOR(15 downto 0);
			 inst: out STD_LOGIC_VECTOR(15 downto 0);
					
			 ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
			 ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
			 ram2oe : out  STD_LOGIC;
			 ram2we : out  STD_LOGIC;
			 ram2en : out  STD_LOGIC
		   );
end ifram;

architecture Behavioral of ifram is

begin

process(rst,clk)
begin
	
end process;

end Behavioral;

