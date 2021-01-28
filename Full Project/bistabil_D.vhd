library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity bist_D is
	port(		 
	D: in std_logic;
	reset: in std_logic;
	clk: in std_logic;
	Q: out std_logic
	);	
end bist_D;

architecture bist_D_arch of bist_D is
begin
	process(clk,reset)
	begin
		if reset='1' then
			Q <= '0';
		elsif clk'event and clk='1' then 
			if D='1' then
				Q <= D;
			end if;
		end if;	
	end process;
end bist_D_arch;