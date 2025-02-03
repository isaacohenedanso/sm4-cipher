library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RoundFunc is
	port(
		XLOAD, CLK, MUXSEL3,OUTEN: in std_logic;
		INPUTTEXT: in std_logic_vector(127 downto 0);
		ROUNDKEY: in std_logic_vector(31 downto 0);
		OUTPUTTEXT: out std_logic_vector(127 downto 0)
	);
end RoundFunc;

architecture Behavioral of RoundFunc is
component reg128 is	
	port(
		CLK, LOAD: in std_logic;
		D: in std_logic_vector(127 downto 0);
		Q: out std_logic_vector(127 downto 0)
	);
end component;

component xor_four is
	port(
		INPT_A, INPT_B, INPT_C, INPT_D: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

component sbox is
	port(
		INPT: in std_logic_vector(7 downto 0);
		OUTP: out std_logic_vector(7 downto 0)
	);
end component;

component xor_two is
	port(
		INPT_A, INPT_B: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

component tribuffer is
	port(
		INPT: in std_logic_vector(127 downto 0);
		EN: in std_logic;
		OUTP: out std_logic_vector(127 downto 0)
	);
end component;

component mux128 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic_vector(127 downto 0);
			OUTP: out std_logic_vector(127 downto 0)
	);
end component;

component xor_five is
	port (
		INPT_A, INPT_B, INPT_C, INPT_D, INPT_E: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

signal FROMSBOXES, TOSBOXES,FROMXOR5, FROMXOR2: std_logic_vector(31 downto 0);
signal FROMSBOX1, FROMSBOX2, FROMSBOX3, FROMSBOX4: std_logic_vector(7 downto 0);
signal FROMREGX, TOARRANGE, RESHUFFLE, FROMMUX: std_logic_vector(127 downto 0);
signal SHIFT2, SHIFT10, SHIFT18, SHIFT24: std_logic_vector(31 downto 0);

begin
FROMSBOXES <= FROMSBOX1 & FROMSBOX2 & FROMSBOX3 & FROMSBOX4;
TOARRANGE <= FROMREGX(95 downto 0) & FROMXOR2;
SHIFT2 <= FROMSBOXES(29 downto 0) & FROMSBOXES(31 downto 30);
SHIFT10 <= FROMSBOXES(21 downto 0) & FROMSBOXES(31 downto 22);
SHIFT18 <= FROMSBOXES(13 downto 0) & FROMSBOXES(31 downto 14);
SHIFT24 <= FROMSBOXES(7 downto 0) & FROMSBOXES(31 downto 8);
RESHUFFLE <= (TOARRANGE(31 downto 0) & TOARRANGE(63 downto 32) & TOARRANGE(95 downto 64) & TOARRANGE(127 downto 96));



mux0: mux128 port map(
								INPT_A => INPUTTEXT,
								INPT_B => TOARRANGE,
								SEL => MUXSEL3,
								OUTP => FROMMUX
							);
regP: reg128 port map(
								CLK => CLK,
								LOAD => XLOAD,
								D => FROMMUX,
								Q => FROMREGX
							);
xor_four0: xor_four port map(
										INPT_A => FROMREGX(95 downto 64),
										INPT_B => FROMREGX(63 downto 32),
										INPT_C => FROMREGX(31 downto 0),
										INPT_D => ROUNDKEY,
										OUTP => TOSBOXES
									);
sbox0: sbox port map(
								INPT => TOSBOXES(31 downto 24),
								OUTP => FROMSBOX1
							);
sbox1: sbox port map(
								INPT => TOSBOXES(23 downto 16),
								OUTP => FROMSBOX2
							);
sbox2: sbox port map(
								INPT => TOSBOXES(15 downto 8),
								OUTP => FROMSBOX3
							);
sbox3: sbox port map(
								INPT => TOSBOXES(7 downto 0),
								OUTP => FROMSBOX4
							);		
xor_five5: xor_five port map(
										INPT_A => SHIFT2,
										INPT_B => SHIFT10,
										INPT_C => SHIFT18,
										INPT_D => SHIFT24,
										INPT_E => FROMSBOXES,
										OUTP => FROMXOR5
									);
xor_two0: xor_two port map(
										INPT_A => FROMXOR5,
										INPT_B => FROMREGX(127 downto 96),
										OUTP => FROMXOR2
									);						
buffer1: tribuffer port map(
										INPT => RESHUFFLE,
										EN => OUTEN,
										OUTP => OUTPUTTEXT
									);
end Behavioral;

