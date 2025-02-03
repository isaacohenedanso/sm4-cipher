library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
	port(
		CLK: in std_logic;
		ROUNDKEY: in std_logic_vector(31 downto 0);
		ADDRESS: in std_logic_vector(4 downto 0);
		WRITE_READ: in std_logic;
		RKi: out std_logic_vector(31 downto 0)
	);
end ram;

architecture Behavioral of ram is
type ram is array(0 to 31) of std_logic_vector(31 downto 0);
signal RAMDATA: ram;
begin
	process(CLK) is 
		begin
			if(rising_edge(CLK)) then
				if (WRITE_READ = '0') then
                -- Read operation
                RKi <= RAMDATA(to_integer(unsigned(ADDRESS)));
            else
                -- Write operation
                RAMDATA(to_integer(unsigned(ADDRESS))) <= ROUNDKEY;
            end if;
			end if;
	end process;
end Behavioral;

