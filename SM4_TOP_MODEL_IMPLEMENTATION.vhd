library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SM4_TOP_MODEL_IMPLEMENTATION is
	port(
		INPUTTEXT, MASTERKEY: in std_logic_vector(127 downto 0);
		ENC_DEC, CLK, RST: in std_logic;
		OUTPUTTEXT: out std_logic_vector(127 downto 0)
	);
end SM4_TOP_MODEL_IMPLEMENTATION;

architecture Behavioral of SM4_TOP_MODEL_IMPLEMENTATION is

component FSM_KEYGEN is
	port(
		RST,CLK: in std_logic;
		Ilt32: in std_logic;
		WRITE_EN_KEY, MKLOAD, ILOAD_KEY, MUXSEL1, MUXSEL2, MUXSEL4_KEY: out std_logic		
	);
end component;

component FSM_ROUNDFUNC is
	port(
		RST,CLK: in std_logic;
		Ilt32: in std_logic;
		WRITE_EN_ROUND, XLOAD, ILOAD_ROUND, MUXSEL3, MUXSEL4_ROUND, OUTEN: out std_logic		
	);
end component;

component DP is
	port(
		INPUTTEXT, MASTERKEY: in std_logic_vector(127 downto 0);
		OUTPUTTEXT: out std_logic_vector(127 downto 0);
		ENC_DEC, CLK, RST, MKLOAD, ILOAD, XLOAD, MUXSEL1, MUXSEL2, MUXSEL3, MUXSEL4, OUTEN, WRITE_EN: in std_logic;
		ILT32: out std_logic
	);
end component;

signal SIG_MKLOAD, SIG_ILOAD, SIG_XLOAD, IL32, MUX1, MUX2, MUX3, MUX4, OUTPUT_EN, SIG_WRITE_EN, MUX4_KEY, MUX4_ROUND: std_logic;
signal SIG_ILOAD_KEY, SIG_ILOAD_ROUND: std_logic;  -- Separate ILOAD signals
signal SIG_WRITE_EN_KEY, SIG_WRITE_EN_ROUND: std_logic;
begin

 SIG_WRITE_EN <= SIG_WRITE_EN_KEY or SIG_WRITE_EN_ROUND;  -- Combine write enables
 SIG_ILOAD <= SIG_ILOAD_KEY or SIG_ILOAD_ROUND;  -- Combine ILOAD signals
-- READ_RAM <= not SIG_XLOAD;
 MUX4 <= MUX4_KEY or MUX4_ROUND;

 DP0: DP port map(
	  INPUTTEXT => INPUTTEXT,
	  MASTERKEY => MASTERKEY,
	  ENC_DEC => ENC_DEC,
	  OUTPUTTEXT => OUTPUTTEXT,
	  CLK => CLK,
	  RST => RST,
	  MKLOAD => SIG_MKLOAD,
	  ILOAD => SIG_ILOAD,
	  XLOAD => SIG_XLOAD,
	  MUXSEL1 => MUX1,
	  MUXSEL2 => MUX2,
	  MUXSEL3 => MUX3,
	  MUXSEL4 => MUX4,
	  ILT32 => IL32,
	  OUTEN => OUTPUT_EN,
	  WRITE_EN => SIG_WRITE_EN
 );
 FSM_KEYGEN0: FSM_KEYGEN port map(
	  RST => RST,
	  CLK => CLK,
	  ILT32 => IL32,
	  WRITE_EN_KEY => SIG_WRITE_EN_KEY,
	  MKLOAD => SIG_MKLOAD,
	  ILOAD_KEY => SIG_ILOAD_KEY,
	  MUXSEL1 => MUX1,
	  MUXSEL2 => MUX2,
	  MUXSEL4_KEY => MUX4_KEY
 );
 FSM_ROUNDFUNC0: FSM_ROUNDFUNC port map(
	  RST => RST,
	  CLK => CLK,
	  ILT32 => IL32,
	  WRITE_EN_ROUND => SIG_WRITE_EN_ROUND,
	  XLOAD => SIG_XLOAD,
	  ILOAD_ROUND => SIG_ILOAD_ROUND,
	  MUXSEL3 => MUX3,
	  MUXSEL4_ROUND => MUX4_ROUND,
	  OUTEN => OUTPUT_EN
 );

end Behavioral;

