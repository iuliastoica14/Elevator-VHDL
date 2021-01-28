library IEEE;
use ieee.std_logic_1164.all;

entity mux4 is
	port(
			a: out std_logic;
			b: out std_logic;
			c: out std_logic;
			d: out std_logic;
			sel: in std_logic_vector (1 downto 0);
			y: in std_logic:='1'
	); 
end mux4;

architecture mux_arch of mux4 is
begin
	process(sel)	
	begin
	b<='0';
	c<='0';
		case sel is
			when "01" => b<=y;
			when "10" => c<=y;
			when "00" => a<=y;
			when others => d<=y;	  
		end case;
	end process;
end mux_arch;