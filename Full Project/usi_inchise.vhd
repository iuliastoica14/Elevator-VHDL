library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counter_usi is
	port(
		clk:in std_logic;
		q_counter_usi:out std_logic_vector(3 downto 0);
		en: in std_logic;
		rst: in std_logic);
end counter_usi;

architecture c_usi of counter_usi is  
signal c: std_logic_vector(3 downto 0):=(others=>'0');
begin 
	process (clk)
	begin
		if en='1' and clk'event and clk='1' and c<5 then
			c<=c+1;
		end if;
		if rst='1' then
			c<=(others => '0');
			
		end if;
	end process; 
	q_counter_usi<=c;
end c_usi;