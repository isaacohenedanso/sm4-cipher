library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic;
			OUTP: out std_logic
	);
end mux1;

architecture Behavioral of mux1 is

begin
	with SEL select 
		OUTP <= INPT_A when '0',
					INPT_B when '1',
					'Z' when others;


end Behavioral;