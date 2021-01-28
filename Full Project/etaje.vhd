library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 

entity etaje is
	port( c_gs:in std_logic;
	etaj: in std_logic_vector(3 downto 0); 
	clk:in std_logic;
	et_c:out std_logic_vector(3 downto 0);
	egall:out std_logic;
	sens_etaje:in std_logic;
	interior: in std_logic;
	exterior: in std_logic;
	sens_ext:in std_logic;
	enable: in std_logic;
	qreg:out std_logic_vector(3 downto 0));
end etaje;

architecture et of etaje is

component reg
	port(	etaj_cerut: in std_logic_vector(3 downto 0);
	   		GS: in std_logic;  	-- memorare/load
		  	clk: in std_logic;
			q_reg:out std_logic_vector(3 downto 0);
			reset:in std_logic
			);
end component ;

component comparator
	port(  
			x: in std_logic_vector(3 downto 0);
			y: in std_logic_vector(3 downto 0);
			gt: out std_logic;
			eq: out std_logic;
			lt: out std_logic
	);
end component ;

component mux4
	port(
			a: out std_logic;
			b: out std_logic;
			c: out std_logic;
			d: out std_logic;
			sel: in std_logic_vector (1 downto 0);
			y: in std_logic:='1'
	); 
end component ;

component counter_rev
	port(
			 clr: in std_logic;
			 clk_up: in std_logic;
			 clk_down: in std_logic;
			 en: in std_logic;
			 q: out std_logic_vector(3 downto 0)
	 );	 
end component ;	
					   					  

signal q_reg:std_logic_vector(3 downto 0);
signal q_num: std_logic_vector(3 downto 0);
signal sel:std_logic_vector(1 downto 0);
signal mare,mic,egal,sel2,cd,cu,clr,a,b,c,d,Mm,m,e:std_logic;
signal sens:std_logic:='1';
signal gs:std_logic:='1';
signal y:std_logic:='1';
signal din:std_logic:='1'; 

begin 
	P0: comparator port map(etaj,q_num,Mm,e,m);
	process(clk,enable,interior,exterior,sens,q_reg,q_num,etaj)
	begin 
	if (enable'event and enable='1') or enable='1'  then
		sens<=sens_etaje;
		if interior='1'  then
			--if q_num="0000" then
				--sens<='1';
			--elsif q_num="1100" then
				--sens<='0';
			--elsif etaj="XXXX" and clk'event and clk='1' then
				--sens<=not sens;
			--end if;	
			--if rising_edge(enable) then
				--gs<='1';
			--if sens='1' then
			--	gs<=(sens and Mm)or egal;
			--else
			--	gs<=((not sens) and m)or egal;
			--end if;
			gs<=c_gs;
			--if q_reg="XXXX" and q_num/=etaj then
				--gs<='1';
			--else 
				--gs<='0';
			--end if;
		elsif exterior='1'then
			if sens=sens_ext then
				gs<=c_gs;
			elsif q_reg="XXXX" then
				gs<=c_gs;
				sens<=sens_ext;
			else
				gs<='0';
			end if;	
		else 
			gs<='0';
		end if;
		--if (m='1' or Mm='1') and egal='1' then
			--gs<='1';
		--else 
			--gs<='0';
		--end if;
	end if;
	end process;
	
	P1:	reg port map(etaj,gs,clk,q_reg,egal);
	
	P2:	comparator port map(q_reg,q_num,mare,egal,mic);	
	sel(0)<=mare;
	sel(1)<=mic;
	P3: mux4 port map(a,b,c,d,sel,y); 
	cu<=b and clk;
	cd<=c and clk;
	P6: counter_rev port map(clr,cu,cd,enable,q_num);
	et_c<=q_num; 
	egall<=egal;
	qreg<=q_reg;
end et;