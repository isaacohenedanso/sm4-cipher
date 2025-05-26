LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY KeyExpansionCU IS
	PORT (
		CLR, CLK : IN STD_LOGIC;
		Ilt32 : IN STD_LOGIC;
		RST, WRITE_EN, MKLOAD, ILOAD, MUXSEL1, MUXSEL2, ROLLOVER : OUT STD_LOGIC
	);
END KeyExpansionCU;

ARCHITECTURE Behavioral OF KeyExpansionCU IS
	TYPE state_type IS (s0, s1, s2, s3, s4);
	SIGNAL NS, PS : state_type;

BEGIN
	sync_proc : PROCESS (CLK, CLR, NS) IS
	BEGIN
		IF (CLR = '1') THEN
			PS <= s0;
		ELSIF (rising_edge(CLK)) THEN
			PS <= NS;
		END IF;
	END PROCESS;

	comb_proc : PROCESS (PS, Ilt32) IS
	BEGIN
		CASE PS IS
			WHEN s0 =>
				RST <= '1';
				WRITE_EN <= '0';
				MKLOAD <= '0';
				ILOAD <= '0';
				MUXSEL1 <= '0';
				MUXSEL2 <= '0';
				ROLLOVER <= '0';
				NS <= s1;
			WHEN s1 =>
				RST <= '0';
				WRITE_EN <= '0';
				MKLOAD <= '1';
				ILOAD <= '0';
				MUXSEL1 <= '0';
				MUXSEL2 <= '0';
				ROLLOVER <= '0';
				NS <= s2;
			WHEN s2 =>
				RST <= '0';
				WRITE_EN <= '1';
				MKLOAD <= '1';
				ILOAD <= '1';
				MUXSEL1 <= '1';
				MUXSEL2 <= '1';
				ROLLOVER <= '0';
				NS <= s3;
			WHEN s3 =>
				RST <= '0';
				MKLOAD <= '1';
				ILOAD <= '1';
				MUXSEL1 <= '1';
				MUXSEL2 <= '0';
				ROLLOVER <= '0';
				IF (Ilt32 = '1') THEN
					WRITE_EN <= '1';
					NS <= s3;
				ELSE
					WRITE_EN <= '0';
					NS <= s4;
				END IF;
			WHEN s4 =>
				RST <= '0';
				WRITE_EN <= '0';
				MKLOAD <= '0';
				ILOAD <= '0';
				MUXSEL1 <= '0';
				MUXSEL2 <= '0';
				ROLLOVER <= '1';
				NS <= s4;
			WHEN OTHERS =>
				RST <= '0';
				WRITE_EN <= '0';
				MKLOAD <= '0';
				ILOAD <= '0';
				MUXSEL1 <= '0';
				MUXSEL2 <= '0';
				ROLLOVER <= '0';
				NS <= s1;
		END CASE;
	END PROCESS;
END Behavioral;