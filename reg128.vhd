library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg128 is	
	port(
		CLK, LOAD: in std_logic;
		D: in std_logic_vector(127 downto 0);
		Q: out std_logic_vector(127 downto 0)
	);
end reg128;

architecture Behavioral of reg128 is
begin
	process(CLK) is
		begin
			if(rising_edge(CLK)) then
				if(LOAD = '1') then
					Q <= D;
				end if;
			end if;
	end process;
end Behavioral;

