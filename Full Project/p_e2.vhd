library ieee;  
use ieee.std_logic_1164.all;  
 
entity priority2 is  
port ( 	etaj_curent:std_logic_vector (3 downto 0);
		sel : in std_logic_vector (12 downto 0);  
        code :out std_logic_vector (3 downto 0));  
end priority2;  
architecture archi2 of priority2 is
begin  	 
code <= "1100" when (sel(12) = '1' and etaj_curent>="1100") else
		"1011" when (sel(11) = '1'and etaj_curent>="1011")else
		"1010" when (sel(10) = '1'and etaj_curent>="1010")else
		"1001" when (sel(9) = '1' and etaj_curent>="1001")else
		"1000" when (sel(8) = '1' and etaj_curent>="1000")else
		"0111" when (sel(7) = '1' and etaj_curent>="0111")else
		"0110" when (sel(6) = '1' and etaj_curent>="0110")else
		"0101" when (sel(5) = '1' and etaj_curent>="0101")else
		"0100" when (sel(4) = '1' and etaj_curent>="0100")else
		"0011" when (sel(3) = '1' and etaj_curent>="0011")else
		"0010" when (sel(2) = '1' and etaj_curent>="0010")else
		"0001" when (sel(1) = '1' and etaj_curent>="0001")else
		"0000" when (sel(0) = '1' and etaj_curent>="0000")else
		"XXXX";
end archi2;