library	IEEE; 
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity usi is	
	port( greutate:in std_logic;
	clk: in std_logic;
	senzor_usi:in std_logic;
	error:out std_logic;
	oke: out std_logic;
	egal: in std_logic;
	et_cur:in std_logic_vector(3 downto 0);
	exterior: in std_logic;
	etaj:in  std_logic_vector(3 downto 0)
	);
end usi;

architecture usii of usi is

component counter_usi 
	port(
		clk:in std_logic;
		q_counter_usi:out std_logic_vector(3 downto 0);
		en: in std_logic;
		rst: in std_logic);
end component; 

component t10
	port(t: in std_logic_vector(3 downto 0);
	ok: out std_logic);
end component;
	


signal q_counter_usi: std_logic_vector(3 downto 0);
signal en,err,clk_usi,rst: std_logic;
signal okk: std_logic:='0';

begin
	en<=not(greutate or senzor_usi);
	err<=greutate or senzor_usi;
	--P2: ok port map(okk,err,en,clk);
	clk_usi<=clk;
	process(okk,exterior,clk)
	begin 
		
			if okk='1' and (et_cur=etaj) and exterior='1' then
				rst<='1'; 
			else
				rst<= egal;
			end if;
	
	end process;
	P3: counter_usi port map(clk_usi,q_counter_usi,en,rst);
	P4: t10 port map(q_counter_usi,okk);
	error<=err;
	oke<=okk;
	
end usii;