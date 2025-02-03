library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CounteWithRam is
	port(
		WRITE_EN, ENC_DEC, CLK, RST, ILOAD, MUXSEL4: in std_logic;
		Ilt32: out std_logic;
		RKi_INPT: in std_logic_vector(31 downto 0);
		RKi_OUTP : out std_logic_vector(31 downto 0);
		OUTP_FROM_REG_I: out std_logic_vector(4 downto 0)
	);
end CounteWithRam;

architecture Behavioral of CounteWithRam is

component FF is
	port (
		D, ILOAD,CLK: in std_logic;
		Q: out std_logic
	);
end component;

component mux1 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic;
			OUTP: out std_logic
	);
end component;

component mux5 is
	port(
			SEL: in  std_logiC;
			INPT_A, INPT_B: in std_logic_vector(4 downto 0);
			OUTP: out std_logic_vector(4 downto 0)
	);
end component;

component adder is
	port(
		INPT: in unsigned(4 downto 0);
		OUTP: out std_logic_vector(4 downto 0)
	);
end component;

component substractor is
	port(
		INPT: in unsigned(4 downto 0);
		OUTP: out std_logic_vector(4 downto 0)
	);
end component;

component ram is
	port(
		CLK: in std_logic;
		ROUNDKEY: in std_logic_vector(31 downto 0);
		ADDRESS: in std_logic_vector(4 downto 0);
		WRITE_READ: in std_logic;
		RKi: out std_logic_vector(31 downto 0)
	);
end component;

component comparIlt32 is
	port(
		INPT: in std_logic_vector(4 downto 0);
		OUTP: out std_logic
	);
end component;

component regi is	
	port(
		CLK, LOAD, RST: in std_logic;
		D: in std_logic_vector(4 downto 0);
		Q: out std_logic_vector(4 downto 0)
	);
end component;

signal FROMFF, FROMMUXAFTERFF: std_logic;
signal FROMADDER, FROMSUBTRACTOR, FROMLASTMUX, FROMREGI: std_logic_vector(4 downto 0);

begin

OUTP_FROM_REG_I <= FROMREGI;
ff_E: FF port map(
						D => ENC_DEC,
						Q => FROMFF,
						ILOAD => ILOAD,
						CLK => CLK
					);
muxafterff: mux1 port map(
							SEL => MUXSEL4,
							INPT_A => '1',
							INPT_B => FROMFF,
							OUTP => FROMMUXAFTERFF
						);
regi0: regi port map(
								RST => RST,
								CLK => CLK,
								LOAD => ILOAD,
								D => FROMADDER,
								Q => FROMREGI								
							);
compare: comparIlt32 port map(
										INPT => FROMREGI,
										OUTP => ILT32
								);
add: adder port map(
							INPT => unsigned(FROMREGI),
							OUTP => FROMADDER
						);
sub: substractor port map(
										INPT => unsigned(FROMREGI),
										OUTP => FROMSUBTRACTOR
									);
lastmux: mux5 port map(
							SEL => FROMMUXAFTERFF,
							INPT_A => FROMSUBTRACTOR,
							INPT_B => FROMREGI,
							OUTP => FROMLASTMUX
							);
ramRK: ram port map(
								CLK => CLK,
								ROUNDKEY => RKi_INPT,
								WRITE_READ => WRITE_EN,
								ADDRESS => FROMLASTMUX,
								RKi => RKi_OUTP
						);


end Behavioral;

