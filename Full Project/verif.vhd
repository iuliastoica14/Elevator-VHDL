library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity t10 is
	port(t: in std_logic_vector(3 downto 0);
	ok: out std_logic);
end t10;

architecture t10_arch of t10 is
begin 
	process(t)
	begin
	if t="0101" then
		ok<='1';
	elsif t="0000" then
		ok<='0';
	end if;

	end process;
end t10_arch;