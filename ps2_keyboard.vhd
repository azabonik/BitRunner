library ieee;
use ieee.std_logic_1164.all;
entity ps2_keyboard is 
port(rst			 : in  bit;
	  ps2c		 : in  bit;
	  ps2d		 : in  bit;
	  key_code	 : out bit_vector (7 downto 0);
	  break		 : out bit;			-- 1 if make, 0 if break
	  data_ready : out bit);
end ps2_keyboard;

architecture behavioral of ps2_keyboard is
begin
	shift: process(rst, ps2c)
		variable clk_count :	natural;
		variable data_reg1, data_reg2, data_reg3 : bit_vector (10 downto 0);
	begin
		if(rst = '0') then
			-- initialize signals and variables
			key_code   <= (others => '0');
			break      <= '0';
			data_ready <= '0';
			clk_count  := 0;
			data_reg1  := (others => '0');
			data_reg2  := (others => '0');
			data_reg3  := (others => '0');
		elsif(ps2c'event and ps2c = '0') then	-- falling edge of ps2c
			data_reg3 := data_reg2(0) & data_reg3(10 downto 1);
			data_reg2 := data_reg1(0) & data_reg2(10 downto 1);	-- shift to the right
			data_reg1 := ps2d & data_reg1(10 downto 1);			   -- shift to the right

			if(clk_count = 10) then
				if((data_reg3(8 downto 1) = x"E0") and (data_reg2 (8 downto 1) = x"F0")) then
					key_code <= data_reg1(8 downto 1);
					data_ready <= '1';
					break <= '1';
				elsif((data_reg2(8 downto 1) = x"E0") and (data_reg1 (8 downto 1) /= x"F0")) then
					key_code <= data_reg1(8 downto 1);
					data_ready <= '1';
					break <= '0';
				elsif((data_reg2(8 downto 1)) = x"F0") then
					key_code <= data_reg1(8 downto 1);
					data_ready <= '1';
					break <= '1';
				elsif((data_reg1(8 downto 1) /= x"F0") and (data_reg1(8 downto 1) /= x"E0"))then
					key_code <= data_reg1(8 downto 1);
					data_ready <= '1';
					break <= '0';
				end if;
				clk_count := 0;
				
			else
				clk_count := clk_count + 1; -- increment counter
				--data_ready <= '0';
				
			end if; 
			
		end if;
	end process shift;
end behavioral;
