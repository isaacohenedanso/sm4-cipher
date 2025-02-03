library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DP is
	port(
		INPUTTEXT, MASTERKEY: in std_logic_vector(127 downto 0);
		OUTPUTTEXT: out std_logic_vector(127 downto 0);
		ENC_DEC, CLK, RST, MKLOAD, ILOAD, XLOAD, MUXSEL1, MUXSEL2, MUXSEL3, MUXSEL4, OUTEN, WRITE_EN: in std_logic;
		ILT32: out std_logic
	);
end DP;

architecture Behavioral of DP is

component CounteWithRam is
	port(
		WRITE_EN, ENC_DEC, CLK, RST, ILOAD, MUXSEL4: in std_logic;
		Ilt32: out std_logic;
		RKi_INPT: in std_logic_vector(31 downto 0);
		RKi_OUTP : out std_logic_vector(31 downto 0);
		OUTP_FROM_REG_I: out std_logic_vector(4 downto 0)
	);
end component;

component RoundFunc is
	port(
		XLOAD, CLK, MUXSEL3,OUTEN: in std_logic;
		INPUTTEXT: in std_logic_vector(127 downto 0);
		ROUNDKEY: in std_logic_vector(31 downto 0);
		OUTPUTTEXT: out std_logic_vector(127 downto 0)
	);
end component;

component KeyGen is
	port(
		MASTERKEY: in std_logic_vector(127 downto 0);
		ADDRESS: in std_logic_vector(4 downto 0);
		MKLOAD, CLK, MUXSEL1, MUXSEL2: in std_logic;
		RKi: out std_logic_vector(31 downto 0)
	);
end component;

signal ADDRESS_OF_ROM: std_logic_vector(4 downto 0);
signal GENERATED_ROUND_KEYS, KEYS_FROM_RAM: std_logic_vector(31 downto 0);
 


begin
keygen0: KeyGen port map(
								MASTERKEY => MASTERKEY,
								ADDRESS => ADDRESS_OF_ROM,
								MKLOAD => MKLOAD,
								CLK => CLK,
								MUXSEL1 => MUXSEL1,
								MUXSEL2 => MUXSEL2,
								RKi => GENERATED_ROUND_KEYS
);
RoundFunc0: RoundFunc port map(
                              XLOAD => XLOAD,
										CLK => CLK,
										MUXSEL3 => MUXSEL3,
										OUTEN => OUTEN,
										INPUTTEXT => INPUTTEXT,
										ROUNDKEY => KEYS_FROM_RAM,
										OUTPUTTEXT => OUTPUTTEXT								
);
CounteWithRam0: CounteWithRam port map(
                                      WRITE_EN => WRITE_EN,
												  ENC_DEC => ENC_DEC,
												  CLK => CLK,
												  RST => RST,
												  ILOAD => ILOAD,
												  MUXSEL4 => MUXSEL4,
												  ILT32 => ILT32,
												  RKi_INPT => GENERATED_ROUND_KEYS,
												  RKi_OUTP => KEYS_FROM_RAM,
												  OUTP_FROM_REG_I => ADDRESS_OF_ROM
);

end Behavioral;

