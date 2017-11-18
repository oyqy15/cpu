----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:22 11/09/2017 
-- Design Name: 
-- Module Name:    pc - Behavioral 
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

entity pc is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  stall : in STD_LOGIC_VECTOR(4 downto 0);
			  pre_pc : in STD_LOGIC_VECTOR(15 downto 0);
			  pc : out STD_LOGIC_VECTOR(15 downto 0);
			  pause : out STD_LOGIC
		   );
end pc;

architecture Behavioral of pc is

signal state:integer :=0;


begin
	process(rst,clk)
	begin
		if (rst='0') then
			pc<="0000000000000000";
			pause<='0';
			state<=1;
		elsif (clk'event and clk = '1') then
			case state is 
				when 1=>
					state<=2;
				when 2=>
					state<=3;
				when 3=>
					state<=0;
				when 0=>
					if (stall(0)='1') then
						pause<='1';
					else
						pc<=pre_pc;
						pause<='0';
					end if;
					state<=1;
				when others=>
					state<=1;
			end case;
		end if;
		
	end process;

end Behavioral;

