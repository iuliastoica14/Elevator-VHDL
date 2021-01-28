library	IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divizor_lift is
   port	( clk :in std_logic; 
   		  speed : in std_logic; 
         clk_div :out std_logic);
end divizor_lift;				 

architecture arh_divizor_lift of divizor_lift is
begin		 
	
	process (clk, speed)
	
	variable nr: STD_LOGIC_VECTOR(26 downto 0):=(others => '0');	   
	variable nr2: STD_LOGIC_VECTOR(25 downto 0):=(others => '0');	  
	begin 
		
	if(speed = '0') then	
		if (clk'EVENT and clk='1') then 
			nr:=nr+1; 				 
		end if;
		clk_div <= nr(26);  
	else
		if (clk'EVENT and clk='1') then 
			nr2:=nr2+1; 				 
		end if;
		clk_div <= nr2(25);
	end if;		 
	
   		end process;
end arh_divizor_lift;