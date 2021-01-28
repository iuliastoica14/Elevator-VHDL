library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity dmux8 is
	port(
	en: in std_logic;
	input: in std_logic; 
	sel: in std_logic_vector (3 downto 0);
	output: out std_logic_vector(12 downto 0)
	);
end dmux8;	 

architecture dmux8_arch of dmux8 is
begin
	process(sel,en)
	begin
	if en='1' then
		case sel is
			when "0000" => output(0) <= '1';	 
			when "0001" => output(1) <= '1';
			when "0010" => output(2) <= '1';	 
			when "0011" => output(3) <= '1';
			when "0100" => output(4) <= '1';	 
			when "0101" => output(5) <= '1';
			when "0110" => output(6) <= '1';	 
			when "0111" => output(7) <= '1';
			when "1000" => output(8) <= '1';
			when "1001" => output(9) <= '1';
			when "1010" => output(10) <= '1';
			when "1011" => output(11) <= '1';
			when "1100" => output(12) <= '1';
			when others => output <= (others => '0');	
		end case;
	else
		output<=(others => '0');
	end if;
	end process;
end dmux8_arch;