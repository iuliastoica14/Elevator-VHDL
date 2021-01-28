 library IEEE;
 use IEEE.STD_LOGIC_1164.all;
 use IEEE.STD_LOGIC_unsigned.all;
 
 entity counter_rev is
	 port(
			 clr: in std_logic;
			 clk_up: in std_logic;
			 clk_down: in std_logic;
			 en: in std_logic;
			 q: out std_logic_vector(3 downto 0)
	 );	 
end counter_rev;

architecture counter_rev_arch of counter_rev is
signal count: std_logic_vector(3 downto 0):=(others => '0');
begin
	process(en,clk_up,clk_down,clr)
	begin 
		if en = '1' then
			if clr = '1' then
				count <= (others => '0');  
			else
				if clk_up'event and clk_up = '1' and count<"1100"then
					count <= count + 1;
				elsif clk_down'event and clk_down = '1' and count>"0000" then
					count <= count - 1;		
					
				end if;	
			end if;	
		 end if;
	end process;  
	q <= count;
end counter_rev_arch;