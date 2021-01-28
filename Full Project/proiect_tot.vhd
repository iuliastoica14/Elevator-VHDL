library	IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity proiect is
	port( viteza:in std_logic;
	senzor_greutate: in std_logic;
	senzor_usi: in std_logic;
	interior: in std_logic;
	exterior: in std_logic;
	sens_exterior: in std_logic;
	clock: in std_logic;
	etaje: in std_logic_vector(12 downto 0);
	led_eroare: out std_logic;
	etaj_curent: out std_logic_vector(3 downto 0);
	afisor1: out std_logic_vector(6 downto 0);
	afisor2: out std_logic_vector(6 downto 0));
end proiect; 

architecture proiect_arch of proiect is

component usi
	port( greutate:in std_logic;
	clk: in std_logic;
	senzor_usi:in std_logic;
	error:out std_logic;
	oke: out std_logic;
	egal: inout std_logic;
	et_cur:in std_logic_vector(3 downto 0);
	exterior: in std_logic;
	etaj:in  std_logic_vector(3 downto 0));
end component ;

component blackbox_etaje 
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
end component ;

component divizor_lift 
   port	( clk :in std_logic; 
   		  speed : in std_logic; 
         clk_div :out std_logic);
end component;	

signal ok,egal,enable,etaj_egal,clk: std_logic;
signal et_cur,etaj,iesire_reg,etaj_cer:std_logic_vector(3 downto 0);

begin 
	
	P0:divizor_lift port map(clock,viteza,clk);
	
	enable<= ok and (interior or exterior);	
	egal<=etaj_egal;  

	P1: usi port map(senzor_greutate,clk,senzor_usi,led_eroare,ok,egal,et_cur,exterior,etaj);
	P2: blackbox_etaje port map(etaje,clk,enable,et_cur,interior,exterior,sens_exterior,etaj_egal,etaj,afisor1,afisor2);
	etaj_curent<=et_cur;
end;