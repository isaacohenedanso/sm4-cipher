library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF is
	port (
		D, ILOAD,CLK: in std_logic;
		Q: out std_logic
	);
end FF;

architecture Behavioral of FF is

begin
process(CLK ) is 
	begin
		if(rising_edge(CLK)) then
			if(ILOAD = '1') then
				Q <= D;
			end if;
		end if;
	end process;
end Behavioral;

