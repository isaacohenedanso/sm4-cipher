library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_four is
	port(
		INPT_A, INPT_B, INPT_C, INPT_D: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end xor_four;

architecture Behavioral of xor_four is

begin
	OUTP <= INPT_A xor INPT_B xor INPT_C xor INPT_D;
end Behavioral;

