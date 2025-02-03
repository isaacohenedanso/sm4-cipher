library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux32 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic_vector(31 downto 0);
			OUTP: out std_logic_vector(31 downto 0)
	);
end mux32;

architecture Behavioral of mux32 is

begin
	with SEL select 
		OUTP <= INPT_A when '0',
					INPT_B when '1',
					(others => '0') when others;


end Behavioral;

