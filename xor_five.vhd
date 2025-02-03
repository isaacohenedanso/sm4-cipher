library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_five is
	port (
		INPT_A, INPT_B, INPT_C, INPT_D, INPT_E: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end xor_five;

architecture Behavioral of xor_five is

begin
OUTP <= INPT_A xor INPT_B xor INPT_C xor INPT_D xor INPT_E;

end Behavioral;

