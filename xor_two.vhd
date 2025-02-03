library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_two is
	port(
		INPT_A, INPT_B: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end xor_two;

architecture Behavioral of xor_two is

begin
	OUTP <= INPT_A xor INPT_B;
end Behavioral;

