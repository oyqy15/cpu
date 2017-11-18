----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:00:00 11/18/2017 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port ( 
		rst : in  STD_LOGIC;
		clk50 : in  STD_LOGIC;
		ram1addr : out  STD_LOGIC_VECTOR (17 downto 0);
      ram1data : inout  STD_LOGIC_VECTOR (15 downto 0);
      ram1oe : out  STD_LOGIC;
      ram1we : out  STD_LOGIC;
      ram1en : out  STD_LOGIC;
      ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
      ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
      ram2oe : out  STD_LOGIC;
      ram2we : out  STD_LOGIC;
      ram2en : out  STD_LOGIC;
		data_ready : in  STD_LOGIC;
		rdn : out  STD_LOGIC;
		tbre : in  STD_LOGIC;
		tsre : in  STD_LOGIC;
		wrn : out  STD_LOGIC
	 );
end main;

architecture Behavioral of main is
component maketime
		  Port (
					clk1 : in STD_LOGIC;
					clk2 : out STD_LOGIC
			  );
end component;

component pc
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					stall : in STD_LOGIC_VECTOR(4 downto 0);
					pre_pc: in STD_LOGIC_VECTOR(15 downto 0);
					pc : out STD_LOGIC_VECTOR(15 downto 0);
					pause : out STD_LOGIC 
			  );
end component;


component ifram
			Port (
					rst : in STD_LOGIC;
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
end component;


component iftoid
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					stall : in STD_LOGIC_VECTOR(4 downto 0);
					
					nextpc_if: in STD_LOGIC_VECTOR(15 downto 0);
					nextpc_id: out STD_LOGIC_VECTOR(15 downto 0);
					
					inst_if: in STD_LOGIC_VECTOR(15 downto 0);
					inst_id: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end component;


component id
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					
					inst: in STD_LOGIC_VECTOR(15 downto 0);
					nextpc: in STD_LOGIC_VECTOR(15 downto 0);
					
					correctpc: out STD_LOGIC_VECTOR(15 downto 0);
					predict: in STD_LOGIC;
					b_need : out STD_LOGIC;
					b_pc: out STD_LOGIC_VECTOR(15 downto 0);
					need_predict: out std_logic_vector(1 downto 0);
					
					a: out STD_LOGIC_VECTOR(15 downto 0);
					a_addr: out STD_LOGIC_VECTOR(15 downto 0);
					b: out STD_LOGIC_VECTOR(15 downto 0);
					b_addr: out STD_LOGIC_VECTOR(15 downto 0);
					imm: out STD_LOGIC_VECTOR(15 downto 0);
					a_imm: out STD_LOGIC;
					b_imm: out STD_LOGIC;
					
					op_alu: out std_logic_vector(2 downto 0); 
					op_mem: out std_logic_vector(1 downto 0);
					need_wb: out STD_LOGIC;
					wb_addr: out STD_LOGIC;
					
					wb_addr_ex: in STD_LOGIC_VECTOR(15 downto 0);
					op_mem_ex: in std_logic_vector(1 downto 0);
					
					r1_addr: out STD_LOGIC_VECTOR(15 downto 0);
					r2_addr: out STD_LOGIC_VECTOR(15 downto 0);
					r1_data: in STD_LOGIC_VECTOR(15 downto 0);
					r2_data: in STD_LOGIC_VECTOR(15 downto 0);
					r1_need: out STD_LOGIC;
					r2_need: out STD_LOGIC;
					
					stallreq: out STD_LOGIC
			  );
end component;


component idtoex
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					stall : in STD_LOGIC_VECTOR(4 downto 0);
					
					op_alu_id: in std_logic_vector(2 downto 0);
					op_alu_ex: out std_logic_vector(2 downto 0);
					a_id: in STD_LOGIC_VECTOR(15 downto 0);
					a_ex: out STD_LOGIC_VECTOR(15 downto 0);
					a_addr_id: in STD_LOGIC_VECTOR(15 downto 0);
					a_addr_ex: out STD_LOGIC_VECTOR(15 downto 0);
					b_id: in STD_LOGIC_VECTOR(15 downto 0);
					b_ex: out STD_LOGIC_VECTOR(15 downto 0);
					b_addr_id: in STD_LOGIC_VECTOR(15 downto 0);
					b_addr_ex: out STD_LOGIC_VECTOR(15 downto 0);
					imm_id: in STD_LOGIC_VECTOR(15 downto 0);
					imm_ex: out STD_LOGIC_VECTOR(15 downto 0);
					a_imm_id: in STD_LOGIC;
					a_imm_ex: out STD_LOGIC;
					b_imm_id: in STD_LOGIC;
					b_imm_ex: out STD_LOGIC;
					
					op_mem_id: in std_logic_vector(1 downto 0);
					op_mem_ex: out std_logic_vector(1 downto 0);
					need_wb_id: in STD_LOGIC;
					need_wb_ex: out STD_LOGIC;
					wb_addr_id: in STD_LOGIC;
					wb_addr_ex: out STD_LOGIC;
					
					correctpc_id: in STD_LOGIC_VECTOR(15 downto 0);
					correctpc_ex: out STD_LOGIC_VECTOR(15 downto 0);
					need_predict_id: in std_logic_vector(1 downto 0);
					need_predict_ex: out STD_LOGIC;
					
					nop_last_ex: in STD_LOGIC
			  );
end component;


component ex
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					
					a: in STD_LOGIC_VECTOR(15 downto 0);
					a_addr: in STD_LOGIC_VECTOR(15 downto 0);
					b: in STD_LOGIC_VECTOR(15 downto 0);
					b_addr: in STD_LOGIC_VECTOR(15 downto 0);
					imm: in STD_LOGIC_VECTOR(15 downto 0);
					a_imm: in STD_LOGIC;
					b_imm: in STD_LOGIC;
					
					op_alu: in  std_logic_vector(2 downto 0);
					op_mem: in std_logic_vector(1 downto 0);
					
					need_wb: in STD_LOGIC;
					wb_addr: in STD_LOGIC;
					
					answer: out STD_LOGIC_VECTOR(15 downto 0);
					addr: out  STD_LOGIC_VECTOR(15 downto 0);
					
					r_data_mem: in STD_LOGIC_VECTOR(15 downto 0);
					r_addr_mem: in STD_LOGIC_VECTOR(15 downto 0);
					r_need_mem: in STD_LOGIC;
					
					r_data_wb: in STD_LOGIC_VECTOR(15 downto 0);
					r_addr_wb: in STD_LOGIC_VECTOR(15 downto 0);
					r_need_wb: in STD_LOGIC;
					
					need_predict:  in std_logic_vector(1 downto 0);
					b_need: out STD_LOGIC;
					b_pc: out STD_LOGIC_VECTOR(15 downto 0);
					
					stallreq: out STD_LOGIC
			  );
end component;


component extomem
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					stall : in STD_LOGIC_VECTOR(4 downto 0);
					
					answer_ex: in STD_LOGIC_VECTOR(15 downto 0);
					answer_mem: out STD_LOGIC_VECTOR(15 downto 0);
					addr_ex: in STD_LOGIC_VECTOR(15 downto 0);
					addr_mem: out STD_LOGIC_VECTOR(15 downto 0);
					
					op_mem_ex: in std_logic_vector(1 downto 0);
					op_mem_mem: out std_logic_vector(1 downto 0);
					
					need_wb_ex: in STD_LOGIC; 
					need_wb_mem:  out STD_LOGIC;
					wb_addr_ex: in STD_LOGIC_VECTOR(15 downto 0);
					wb_addr_mem: out STD_LOGIC_VECTOR(15 downto 0);
					
					r_data_mem: out STD_LOGIC_VECTOR(15 downto 0);
					r_addr_mem: out STD_LOGIC_VECTOR(15 downto 0);
					r_need_mem: out STD_LOGIC
			  );
end component;


component mem
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					
					answer: in STD_LOGIC_VECTOR(15 downto 0);
					addr: in STD_LOGIC_VECTOR(15 downto 0);
					op_mem: in std_logic_vector(1 downto 0):= "00";
					
					ram1addr : out  STD_LOGIC_VECTOR (17 downto 0);
					ram1data : inout  STD_LOGIC_VECTOR (15 downto 0);
					ram1oe : out  STD_LOGIC;
					ram1we : out  STD_LOGIC;
					ram1en : out  STD_LOGIC;
					ram2addr : out  STD_LOGIC_VECTOR (17 downto 0);
					ram2data : inout  STD_LOGIC_VECTOR (15 downto 0);
					ram2oe : out  STD_LOGIC;
					ram2we : out  STD_LOGIC;
					ram2en : out  STD_LOGIC;
					data_ready : in  STD_LOGIC;
					rdn : out  STD_LOGIC;
					tbre : in  STD_LOGIC;
					tsre : in  STD_LOGIC;
					wrn : out  STD_LOGIC;
					
					wb_data: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end component;


component memtowb
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					stall : in STD_LOGIC_VECTOR(4 downto 0);
					
					wb_data_mem: in STD_LOGIC_VECTOR(15 downto 0);
					wb_data_wb: out STD_LOGIC_VECTOR(15 downto 0);
					wb_addr_mem: in STD_LOGIC_VECTOR(15 downto 0);
					wb_addr_wb: out STD_LOGIC_VECTOR(15 downto 0);
					need_wb_mem: in STD_LOGIC;
					need_wb_wb: out STD_LOGIC;
					
					r_data_wb: out STD_LOGIC_VECTOR(15 downto 0);
					r_addr_wb: out STD_LOGIC_VECTOR(15 downto 0);
					r_need_wb: out STD_LOGIC
			  );
end component;


component reg
			Port (
					rst : in STD_LOGIC;
					clk : in STD_LOGIC;
					
					need_wb: in STD_LOGIC;
					wb_addr: in STD_LOGIC_VECTOR(15 downto 0);
					wb_data: in STD_LOGIC_VECTOR(15 downto 0);
					
					r1_need: in STD_LOGIC;
					r2_need: in STD_LOGIC;
					r1_addr: in STD_LOGIC_VECTOR(15 downto 0);
					r2_addr: in STD_LOGIC_VECTOR(15 downto 0);
					r1_data: out STD_LOGIC_VECTOR(15 downto 0);
					r2_data: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end component;

component ctrl
			Port (
					rst : in STD_LOGIC;
					stallreq_id: in STD_LOGIC;
					stallreq_ex: in STD_LOGIC;
					stall : out STD_LOGIC_VECTOR(4 downto 0)
			);
end component;


begin


end Behavioral;

