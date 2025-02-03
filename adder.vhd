library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--
entity adder is
	port(
		INPT: in unsigned(4 downto 0);
		OUTP: out std_logic_vector(4 downto 0)
	);
end adder;

architecture Behavioral of adder is
begin
	OUTP <= std_logic_vector(INPT	+ 1);
end Behavioral;
