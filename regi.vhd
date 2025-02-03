library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regi is	
	port(
		CLK, LOAD, RST: in std_logic;
		D: in std_logic_vector(4 downto 0);
		Q: out std_logic_vector(4 downto 0)
	);
end regi;

architecture Behavioral of regi is
begin
	process(CLK, RST) is
		begin
			if(RST = '1') then
				Q <= "00000";
			elsif(rising_edge(CLK)) then
				if(LOAD = '1') then
					Q <= D;
				end if;
			end if;
	end process;
end Behavioral;
