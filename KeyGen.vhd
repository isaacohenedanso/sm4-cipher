library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity KeyGen is
	port(
		MASTERKEY: in std_logic_vector(127 downto 0);
		ADDRESS: in std_logic_vector(4 downto 0);
		MKLOAD, CLK, MUXSEL1, MUXSEL2: in std_logic;
		RKi: out std_logic_vector(31 downto 0)
	);
end KeyGen;

architecture Behavioral of KeyGen is
--component declaration
component mux128 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic_vector(127 downto 0);
			OUTP: out std_logic_vector(127 downto 0)
	);
end component;

component reg128 is	
	port(
		CLK, LOAD: in std_logic;
		D: in std_logic_vector(127 downto 0);
		Q: out std_logic_vector(127 downto 0)
	);
end component;

component rom IS
	port (
		INPT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		OUTP : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end component;

component sbox is
	port(
		INPT: in std_logic_vector(7 downto 0);
		OUTP: out std_logic_vector(7 downto 0)
	);
end component;

component mux96 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic_vector(95 downto 0);
			OUTP: out std_logic_vector(95 downto 0)
	);
end component;

component mux32 is
	port(
			SEL: in  std_logic;
			INPT_A, INPT_B: in std_logic_vector(31 downto 0);
			OUTP: out std_logic_vector(31 downto 0)
	);
end component;

component xor_two is
	port(
		INPT_A, INPT_B: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

component xor_three is
	port(
		INPT_A, INPT_B, INPT_C: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

component xor_four is
	port(
		INPT_A, INPT_B, INPT_C, INPT_D: in std_logic_vector(31 downto 0);
		OUTP: out std_logic_vector(31 downto 0)
	);
end component;

signal FROMMUX1, FROMREGMK, NEXTINPUT: std_logic_vector(127 downto 0);
signal FROMXOR3, FROMXOR4_0, FROMXOR4_1, FROMROM, FROMSBOXES, TOSBOXES, FROMLASTMUX, FROMXOR2_0, FROMXOR2_1, FROMXOR2_2, FROMXOR2_3, RNDKEY: std_logic_vector(31 downto 0);
signal SHIFT13, SHIFT23: std_logic_vector(31 downto 0);
signal FROMSBOX1, FROMSBOX2, FROMSBOX3, FROMSBOX0: std_logic_vector(7 downto 0);
signal FROMMUXFORNEXTINPUT, INPT_TO_DET_NEXTINPUT: std_logic_vector(95 downto 0);


begin
FROMSBOXES <= FROMSBOX0 & FROMSBOX1 & FROMSBOX2 & FROMSBOX3;
NEXTINPUT <= (FROMMUXFORNEXTINPUT & RNDKEY);
INPT_TO_DET_NEXTINPUT <= FROMXOR2_1 & FROMXOR2_2 & FROMXOR2_3;
SHIFT13 <= FROMSBOXES(18 downto 0) & FROMSBOXES(31 downto 19);
SHIFT23 <= FROMSBOXES(8 downto 0) & FROMSBOXES(31 downto 9);

muxtoregMK: mux128 port map(
								INPT_A => MASTERKEY,
								INPT_B => NEXTINPUT,
								SEL => MUXSEL1,
								OUTP => FROMMUX1
							);
regMK: reg128 port map(
								CLK => CLK,
								LOAD => MKLOAD,
								D => FROMMUX1,
								Q => FROMREGMK
							);
romCK: rom port map(
							INPT => ADDRESS,
							OUTP => FROMROM
						);
K0: xor_two port map(
									INPT_A => FROMREGMK(127 downto 96),
									INPT_B => x"A3B1BAC6",
									OUTP => FROMXOR2_0
								);	
K1: xor_two port map(
									INPT_A => FROMREGMK(95 downto 64),
									INPT_B => x"56AA3350",
									OUTP => FROMXOR2_1
								);	
K2: xor_two port map(
									INPT_A => FROMREGMK(63 downto 32),
									INPT_B => x"677D9197",
									OUTP => FROMXOR2_2
								);	
K3: xor_two port map(
									INPT_A => FROMREGMK(31 downto 0),
									INPT_B => x"B27022DC",
									OUTP => FROMXOR2_3
								);	
xor4_0: xor_four port map(
									INPT_A => FROMXOR2_1,
									INPT_B => FROMXOR2_2,
									INPT_C => FROMXOR2_3,
									INPT_D => FROMROM,
									OUTP => FROMXOR4_0
								);	
xor4_1: xor_four port map(
									INPT_A => FROMREGMK(95 downto 64),
									INPT_B => FROMREGMK(63 downto 32),
									INPT_C => FROMREGMK(31 downto 0),
									INPT_D => FROMROM,
									OUTP => FROMXOR4_1
								);								
muxfornextinput: mux96 port map(
								INPT_A => FROMREGMK(95 downto 0),
								INPT_B => INPT_TO_DET_NEXTINPUT,
								SEL => MUXSEL2,
								OUTP => FROMMUXFORNEXTINPUT
							);
muxtosboxes: mux32 port map(
								INPT_A => FROMXOR4_1,
								INPT_B => FROMXOR4_0,
								SEL => MUXSEL2,
								OUTP => TOSBOXES
							);
sbox0: sbox port map(
								INPT => TOSBOXES(31 downto 24),
								OUTP => FROMSBOX0
							);
sbox1: sbox port map(
								INPT => TOSBOXES(23 downto 16),
								OUTP => FROMSBOX1
							);
sbox2: sbox port map(
								INPT => TOSBOXES(15 downto 8),
								OUTP => FROMSBOX2
							);
sbox3: sbox port map(
								INPT => TOSBOXES(7 downto 0),
								OUTP => FROMSBOX3
							);
xor3_0: xor_three port map(
									INPT_A => FROMSBOXES,
									INPT_B => SHIFT13,
									INPT_C => SHIFT23,
									OUTP => FROMXOR3
								);
lastmux: mux32 port map(
								INPT_A => FROMREGMK(127 downto 96),
								INPT_B => FROMXOR2_0,
								SEL => MUXSEL2,
								OUTP => FROMLASTMUX
							);
xor2_last: xor_two port map(
									INPT_A => FROMXOR3,
									INPT_B => FROMLASTMUX,
									OUTP => RNDKEY
								);							
RKI <= RNDKEY;


end Behavioral;

