library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity blackbox_etaje is
	port( butoane_etaje : in std_logic_vector(12 downto 0);
	clk: in std_logic;
	enable_pe: in std_logic;
	etaj_curent:out std_logic_vector(3 downto 0);
	interior: in std_logic;
	exterior: in std_logic;
	sens_exterior: in std_logic;
	etaj_egal: out std_logic;
	etaj_cer:out std_logic_vector(3 downto 0);
	afis1:out std_logic_vector(6 downto 0);
	afis2:out std_logic_vector(6 downto 0)
	);
end;   

architecture blackbox_etaje_arch of blackbox_etaje is

component etaje
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
end component ;

component etaje_p  
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
end component ;

component decoder
	port(  
	etaj_c: in std_logic_vector(3 downto 0);
	Cod1: out std_logic_vector(6 downto 0);
	Cod2: out std_logic_vector(6 downto 0) );
end component ;

signal sens,egal,en,cond_gs: std_logic;
signal etaj_cerut,etaj_cur,q_reg:std_logic_vector(3 downto 0);

begin 
	process(clk)
	begin
		--if clk'event and clk='1' then
		if enable_pe='0' then
			etaj_egal<='0';
		else
			etaj_egal<=egal;
		end if;
		--end if;
	end process; 
	en<=enable_pe;
	P1: etaje_p port map(interior,exterior,sens_exterior,q_reg,butoane_etaje,clk,sens,etaj_cerut,'1',egal,etaj_cur,cond_gs);
	P2: etaje port map(cond_gs,etaj_cerut,clk,etaj_cur,egal,sens,interior,exterior,sens_exterior,en,q_reg);	 
	P3:	decoder port map(etaj_cur,afis1,afis2);
	etaj_cer<=q_reg;
	etaj_curent<=etaj_cur; 
end blackbox_etaje_arch;