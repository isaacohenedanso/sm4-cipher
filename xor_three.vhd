library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_three is
	port(
		INPT_A, INPT_B, INPT_C: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end xor_three;

architecture Behavioral of xor_three is

begin
	OUTP <= INPT_A xor INPT_B xor INPT_C;
end Behavioral;

