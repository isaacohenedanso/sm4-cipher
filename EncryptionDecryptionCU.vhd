LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EncryptionDecryptionCU IS
	PORT (
		CLR, CLK : IN STD_LOGIC;
		ILT32 : IN STD_LOGIC;
		RST, WRITE_EN, XLOAD, ILOAD, MUXSEL3, OUTEN : OUT STD_LOGIC
	);
END EncryptionDecryptionCU;

ARCHITECTURE Behavioral OF EncryptionDecryptionCU IS
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

	comb_proc : PROCESS (PS, ILT32) IS
	BEGIN
		CASE PS IS
			WHEN s0 =>
				RST <= '1';
				WRITE_EN <= '0';
				XLOAD <= '0';
				ILOAD <= '0';
				MUXSEL3 <= '0';
				OUTEN <= '0';
				NS <= s1;
			WHEN s1 =>
				RST <= '0';
				WRITE_EN <= '0';
				XLOAD <= '1';
				ILOAD <= '0';
				MUXSEL3 <= '0';
				OUTEN <= '0';
				NS <= s2;
			WHEN s2 =>
				RST <= '0';
				WRITE_EN <= '0';
				XLOAD <= '1';
				ILOAD <= '1';
				MUXSEL3 <= '0';
				OUTEN <= '0';
				NS <= s3;
			WHEN s3 =>
				RST <= '0';
				WRITE_EN <= '0';
				XLOAD <= '1';
				ILOAD <= '1';
				MUXSEL3 <= '1';
				OUTEN <= '0';
				IF (ILT32 = '1') THEN
					NS <= s3;
				ELSE
					NS <= s4;
				END IF;
			WHEN s4 =>
				RST <= '0';
				WRITE_EN <= '0';
				XLOAD <= '0';
				ILOAD <= '0';
				MUXSEL3 <= '0';
				OUTEN <= '1';
				NS <= s4;
			WHEN OTHERS =>
				RST <= '0';
				WRITE_EN <= '0';
				XLOAD <= '0';
				ILOAD <= '0';
				MUXSEL3 <= '0';
				OUTEN <= '0';
				NS <= s1;
		END CASE;
	END PROCESS;
END Behavioral;