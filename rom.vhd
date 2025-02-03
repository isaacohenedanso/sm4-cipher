LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity rom IS
	port (
		INPT : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		OUTP : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end rom;

architecture Behavioral of rom is
begin
	with INPT select 
		OUTP <= 
			x"00070E15" when "00000",
			x"1C232A31" when "00001",
			x"383F464D" when "00010",
			x"545B6269" when "00011",
			x"70777E85" when "00100",
			x"8C939AA1" when "00101",
			x"A8AFB6BD" when "00110",
			x"C4CBD2D9" when "00111",
			x"E0E7EEF5" when "01000",
			x"FC030A11" when "01001",
			x"181F262D" when "01010",
			x"343B4249" when "01011",
			x"50575E65" when "01100",
			x"6C737A81" when "01101",
			x"888F969D" when "01110",
			x"A4ABB2B9" when "01111",
			x"C0C7CED5" when "10000",
			x"DCE3EAF1" when "10001",
			x"F8FF060D" when "10010",
			x"141B2229" when "10011",
			x"30373E45" when "10100",
			x"4C535A61" when "10101",
			x"686F767D" when "10110",
			x"848B9299" when "10111",
			x"A0A7AEB5" when "11000",
			x"BCC3CAD1" when "11001",
			x"D8DFE6ED" when "11010",
			x"F4FB0209" when "11011",
			x"10171E25" when "11100",
			x"2C333A41" when "11101",
			x"484F565D" when "11110",
			x"646B7279" when "11111",
			x"00000000" when OTHERS;
END Behavioral;