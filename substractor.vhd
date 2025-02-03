library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--
entity substractor is
	port(
		INPT: in unsigned(4 downto 0);
		OUTP: out std_logic_vector(4 downto 0)
	);
end substractor;

architecture Behavioral of substractor is
begin
	OUTP <= std_logic_vector(31 - INPT);
end Behavioral;
