library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_ROUNDFUNC is
	port(
		RST,CLK: in std_logic;
		Ilt32: in std_logic;
		WRITE_EN_ROUND, XLOAD, ILOAD_ROUND, MUXSEL3, MUXSEL4_ROUND, OUTEN: out std_logic		
	);
end FSM_ROUNDFUNC;

architecture Behavioral of FSM_ROUNDFUNC is
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
			WRITE_EN_ROUND <= '0';
			XLOAD <= '0';
			ILOAD_ROUND <= '0';
			MUXSEL3 <= '0';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			NS <= s1;
		when s1 => 
			WRITE_EN_ROUND <= '0';
			XLOAD <= '1';
			ILOAD_ROUND <= '0';
			MUXSEL3 <= '0';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			NS <= s1;
		when s2 => 
			WRITE_EN_ROUND <= '0';
			XLOAD <= '1';
			ILOAD_ROUND <= '1';
			MUXSEL3 <= '1';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			NS <= s1;
		when s3 => 
			WRITE_EN_ROUND <= '0';
			XLOAD <= '1';
			ILOAD_ROUND <= '1';
			MUXSEL3 <= '1';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			if(Ilt32 = '1') then
				NS <= s3;
			else 
				NS <= s4;
			end if;			
		when s4 => 
			WRITE_EN_ROUND <= '0';
			XLOAD <= '0';
			ILOAD_ROUND <= '0';
			MUXSEL3 <= '0';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			NS <= s1;
		when others => 
			WRITE_EN_ROUND <= '0';
			XLOAD <= '0';
			ILOAD_ROUND <= '0';
			MUXSEL3 <= '0';
			MUXSEL4_ROUND <= '1';
			OUTEN <= '0';
			NS <= s1;
	end case;
end process;
end Behavioral;

