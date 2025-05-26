library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator_Ilt32 is
	port(
		INPT: in std_logic_vector(5 downto 0);
		OUTP: out std_logic
	);
end comparator_Ilt32;

architecture Behavioral of comparator_Ilt32 is
begin
	process(INPT) is
		begin
			if unsigned(INPT) < 32 then
				OUTP <= '1';
			else 
				OUTP <= '0';
			end if;
	end process;
end Behavioral;

