library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tribuffer is
	port(
		INPT: in std_logic_vector(127 downto 0);
		EN: in std_logic;
		OUTP: out std_logic_vector(127 downto 0)
	);
end tribuffer;

architecture Behavioral of tribuffer is

begin
with EN select
	OUTP <= INPT when  '1',
		(others => '0') when others;
end Behavioral;

