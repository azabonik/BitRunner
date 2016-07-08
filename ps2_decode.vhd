library ieee;
use ieee.std_logic_1164.all;

entity ps2_decode is
	port(	code_in: in std_logic_vector(7 downto 0);
			udlr : out std_logic_vector(3 downto 0));
end ps2_decode;

architecture behavioral of ps2_decode is
begin
	process(code_in)
		begin
			case(code_in) is
				when "01110101" =>	udlr <= "0111"; --up
				when "01110010" =>	udlr <= "1011"; --down
				when "01101011" =>	udlr <= "1101"; --left
				when "01110100" =>	udlr <= "1110"; --right
				when others => udlr <="1111"; --non directional key pressed, do nothing
			end case;
	end process;
end architecture;