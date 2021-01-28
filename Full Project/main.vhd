library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity etaje_p is
	port(
	interior:in std_logic;
	exterior:in std_logic;
	sens_exterior: in std_logic;
	q_reg:in std_logic_vector(3 downto 0);
	etaje: in std_logic_vector(12 downto 0);
	clk: in std_logic;	  
	senss: out std_logic; --1 urc, 0 cobor
	etaj_cerut: inout std_logic_vector(3 downto 0);
	enable: in std_logic;
	enable_dmux:in std_logic;
	etaj_cur:in std_logic_vector(3 downto 0);
	cond_gs:out std_logic
	); 
end etaje_p;

architecture etaje_arch of etaje_p is		 

signal cerere1:std_logic_vector(3 downto 0):=(others=>'0');
signal cerere2:std_logic_vector(3 downto 0):=(others=>'0');	
signal in_dmux: std_logic := '1';
signal etaje1: std_logic_vector(12 downto 0):=(others=>'0');
signal rst: std_logic_vector(12 downto 0):=(others => '0');

component bist_D 
	port(		 
			D: in std_logic;
			reset: in std_logic;
			clk: in std_logic;
			Q: out std_logic);
end component;	 

component priority
	port ( etaj_curent:std_logic_vector (3 downto 0);
	sel : in std_logic_vector (12 downto 0);  
	code :out std_logic_vector (3 downto 0));
end component;


component priority2
	port ( 	etaj_curent:std_logic_vector (3 downto 0);
	sel : in std_logic_vector (12 downto 0);  
    code :out std_logic_vector (3 downto 0));  	 
end component;

component dmux8
	port(	en: in std_logic;
			input: in std_logic :='0'; 
			sel: in std_logic_vector (3 downto 0);
			output: out std_logic_vector(12 downto 0));
end component;

signal sens:std_logic:='1';

begin  
		Etaj0: bist_D port map(etaje(0),rst(0),clk,etaje1(0));
		Etaj1: bist_D port map(etaje(1),rst(1),clk,etaje1(1));
		Etaj2: bist_D port map(etaje(2),rst(2),clk,etaje1(2));
		Etaj3: bist_D port map(etaje(3),rst(3),clk,etaje1(3));
		Etaj4: bist_D port map(etaje(4),rst(4),clk,etaje1(4));
		Etaj5: bist_D port map(etaje(5),rst(5),clk,etaje1(5));
		Etaj6: bist_D port map(etaje(6),rst(6),clk,etaje1(6));
		Etaj7: bist_D port map(etaje(7),rst(7),clk,etaje1(7));
		Etaj8: bist_D port map(etaje(8),rst(8),clk,etaje1(8));
		Etaj9: bist_D port map(etaje(9),rst(9),clk,etaje1(9));
		Etaj10: bist_D port map(etaje(10),rst(10),clk,etaje1(10));
		Etaj11: bist_D port map(etaje(11),rst(11),clk,etaje1(11));
		Etaj12: bist_D port map(etaje(12),rst(12),clk,etaje1(12));
	
		
		P1: priority port map(etaj_cur,etaje1,cerere1);
		P2: priority2 port map(etaj_cur,etaje1,cerere2);
		
		
		process(clk)
		begin
			if  clk'event and clk='1' then 
				if cerere1="XXXX" and cerere2="XXXX" then
					cond_gs<='0';
				else
					cond_gs<='1';
				end if;
				if sens='1' and cerere1="XXXX" and (q_reg="XXXX" or q_reg=etaj_cerut) then
					sens<='0';
				elsif sens='0' and cerere2="XXXX" and (q_reg="XXXX" or q_reg=etaj_cerut) then
					sens<='1';	
				end if;
				if interior='1' then 
					if cerere1/="XXXX" or cerere2/="XXXX" then
					if sens = '1' then
							etaj_cerut<=cerere1;
					else
							etaj_cerut<=cerere2;
					end if;	
					end if;
				elsif exterior='1' then	
					if cerere1/="XXXX" or cerere2/="XXXX" then
					if sens_exterior='1' and sens='1' then
						if cerere1/="XXXX" then
							etaj_cerut<=cerere1; 
						else
							etaj_cerut<=cerere2; 
						end if;
					elsif sens_exterior='0' and sens='0' then
						if cerere2/="XXXX" then
							etaj_cerut<=cerere2; 
						else
							etaj_cerut<=cerere1;
						end if;
					elsif sens_exterior='1' and sens='0' then
						if cerere2="XXXX" then
							etaj_cerut<=cerere1; 
						else
							etaj_cerut<=cerere2;
						end if;
					elsif sens_exterior='0' and sens='1' then
						if cerere1="XXXX" then
							etaj_cerut<=cerere2;
						else
							etaj_cerut<=cerere1;
						end if;
					end if;	
					end if;
				end if;
			end if;
		end process;
		
		senss<=sens;
	D1: dmux8 port map(enable_dmux,'1',etaj_cur,rst);
end etaje_arch;