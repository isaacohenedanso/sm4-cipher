library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_KEYGEN is
	port(
		RST,CLK: in std_logic;
		Ilt32: in std_logic;
		WRITE_EN_KEY, MKLOAD, ILOAD_KEY, MUXSEL1, MUXSEL2, MUXSEL4_KEY: out std_logic		
	);
end FSM_KEYGEN;

architecture Behavioral of FSM_KEYGEN is
type state_type is (s0, s1, s2, s3, s4);
signal NS, PS: state_type;

begin
sync_proc: process(CLK, RST, NS) is
	begin
		if(RST = '1') then
			PS <= s0;
		elsif(rising_edge(CLK)) then
			PS <= NS;
		end if;
end process;
	
comb_proc: process(PS, Ilt32) is
begin
	case PS is 
		when s0 => 
			WRITE_EN_KEY <= '0';
			MKLOAD <= '0';
			ILOAD_KEY <= '0';
			MUXSEL1 <= '0';
			MUXSEL2 <= '0';
			MUXSEL4_KEY <= '0';
			NS <= s1;
		when s1 => 
			WRITE_EN_KEY <= '0';
			MKLOAD <= '1';
			ILOAD_KEY <= '0';
			MUXSEL1 <= '0';
			MUXSEL2 <= '0';
			MUXSEL4_KEY <= '0';
			NS <= s2;
		when s2 => 
			WRITE_EN_KEY <= '1';
			MKLOAD <= '1';
			ILOAD_KEY <= '1';
			MUXSEL1 <= '1';
			MUXSEL2 <= '1';
			MUXSEL4_KEY <= '0';
			NS <= s3;
		when s3 => 
			WRITE_EN_KEY<= '1';
			MKLOAD <= '1';
			ILOAD_KEY <= '1';
			MUXSEL1 <= '1';
			MUXSEL2 <= '0';
			MUXSEL4_KEY <= '0';
			if(Ilt32 = '1') then
				NS <= s3;
			else 
				NS <= s4;
			end if;			
		when s4 => 
			WRITE_EN_KEY <= '0';
			MKLOAD <= '0';
			ILOAD_KEY<= '0';
			MUXSEL1 <= '0';
			MUXSEL2 <= '0';
			MUXSEL4_KEY <= '0';
			NS <= s4;
		when others => 
			WRITE_EN_KEY<= '0';
			MKLOAD <= '0';
			ILOAD_KEY <= '0';
			MUXSEL1 <= '0';
			MUXSEL2 <= '0';
			MUXSEL4_KEY <= '0';
			NS <= s1;
	end case;
end process;
end Behavioral;

