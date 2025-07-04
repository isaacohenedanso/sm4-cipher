LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux5 IS
	PORT (
		SEL : IN STD_LOGIC;
		INPT_A, INPT_B : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		OUTP : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END mux5;

ARCHITECTURE Behavioral OF mux5 IS

BEGIN
	WITH SEL SELECT
		OUTP <= INPT_A WHEN '0',
		INPT_B WHEN '1',
		(OTHERS => '0') WHEN OTHERS;
END Behavioral;