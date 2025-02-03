library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparIlt32 is
	port(
		INPT: in std_logic_vector(4 downto 0);
		OUTP: out std_logic
	);
end comparIlt32;

architecture Behavioral of comparIlt32 is
begin
	process(INPT) is
		begin
			if(INPT /= "11111") then
				OUTP <= '1';
			else 
				OUTP <= '0';
			end if;
	end process;
end Behavioral;

