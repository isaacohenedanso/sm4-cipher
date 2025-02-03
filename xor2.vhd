library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor2 is
	port(
		INPT_A, INPT_B: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end xor2;

architecture Behavioral of xor2 is

begin
	OUTP <= INPT_A xor INPT_B;
end Behavioral;

