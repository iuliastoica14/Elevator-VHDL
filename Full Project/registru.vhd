library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg is 
	port(	etaj_cerut: in std_logic_vector(3 downto 0);
	   		GS: in std_logic;  	-- memorare/load
		  	clk: in std_logic;
			q_reg:out std_logic_vector(3 downto 0);
			reset:in std_logic
			);
end reg;

architecture reg_arch  of reg is
begin
	process(clk,GS)
	begin
		if clk'event and clk='1' then
			if GS='1' then
				q_reg <= etaj_cerut	;
			end if;	
		end if;	
		if reset='1' then
			q_reg<="XXXX";	
		end if;
	end process;
end reg_arch;