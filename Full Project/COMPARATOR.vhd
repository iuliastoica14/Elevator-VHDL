library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparator is
	port(  
			x: in std_logic_vector(3 downto 0);
			y: in std_logic_vector(3 downto 0);
			gt: out std_logic;
			eq: out std_logic;
			lt: out std_logic
	);
end comparator;

architecture comp_arch of comparator is
begin
	process(x,y)
	begin
		gt <= '0';
		eq <= '0';
		lt <= '0'; 
		
		if x > y then
			gt <= '1';
		end if;	
		
		if x = y then
			eq <= '1';
		end if;		
		
		if x < y then
			lt <= '1';
		end if;
	end process;
end comp_arch;
		
