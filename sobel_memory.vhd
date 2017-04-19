--
--Barry Wu and Chris Ranc
--Sobel_tb.vhd
--
--This is our lovely outter test bench of our lovely sobel project
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.math_real.all;

entity sobel_memory is
	-----------------------------------------------
	-- Generic: must be a number greater than 3
	-----------------------------------------------
	Generic(N: integer := 8);
	port(
		-----------------------------------------------
		-- Inputs
		-----------------------------------------------
		i_clock : in std_logic; 					-- input clock
		i_valid : in std_logic; 					-- is input valid?
		i_pixel : in std_logic_vector(7 downto 0); 	-- 8-bit input
		i_reset : in std_logic; 					-- reset signal
		i_request: in std_logic;					-- request the next array
		-----------------------------------------------
		-- Outputs
		-----------------------------------------------
		o_top: out std_logic_vector(23 downto 0);		-- top array
		o_mid: out std_logic_vector(23 downto 0);		-- mid array
		o_bot: out std_logic_vector(23 downto 0);		-- bot array
		o_valid: out std_logic;							-- can arrays export itself
		o_isFull: out std_logic;						-- memory is full
		o_busy: out std_logic							--determine if busy		
	);
end entity;

architecture behavioral of sobel_memory

	-----------------------------------------------
	-- list of signals and constants
	-----------------------------------------------		
	--internal signals
	--create the image array (n by n) with each index being a byte
	type imagePixel array (n-1 downto 0, n -1 downto 0) of std_logic_vector(7 downto 0);
	signal imageArray: imagePixel;
	
	--counter 
	--2**n is the max
	signal i_row_counter: integer;
	signal i_column_counter: integer;
	signal o_row_counter: integer;
	signal o_column_counter: integer;
	
	signal wait_brah: std_logic := '0';
	signal all_zero: std_logic_vector(n-1 downto 0) := (others => '0');
	signal all_ones: std_logic_vector(n-1 downto 0) := (others => '1');

Begin
	-----------------------------------------------
	-- produce output
	-----------------------------------------------
	release_the_hounds: process(i_request, wait_brah, i_clock)
	begin
		if(rising_edge(i_clock)) then
			if(i_request == '1' and wait_brah == '0' and o_valid_counter < n*n) then
				top <= imageArray(o_row_counter - 1, o_column_counter - 1) & imageArray(o_row_counter - 1, o_column_counter) & imageArray(o_row_counter - 1, o_column_counter + 1);
				mid <= imageArray(o_row_counter, o_column_counter - 1) & imageArray(o_row_counter, o_column_counter) & imageArray(o_row_counter, o_column_counter + 1);
				bot <= imageArray(o_row_counter + 1, o_column_counter - 1) & imageArray(o_row_counter + 1, o_column_counter) & imageArray(o_row_counter + 1, o_column_counter + 1);
				wait_brah <= '1';
				if(o_column_counter == n-2) then
					o_row_counter = o_row_counter + 1;
					o_column_counter 1;
				else
					o_column_counter = o_column_counter + 1;
				end if;
			elsif(i_request == '0' and wait_brah == '1') then
				wait_brah <= '0';
			end if;
		end if;
	end process;-
	
	-----------------------------------------------
	-- start spitting me some output
	-----------------------------------------------
	can_export: process(i_column_counter, i_row_counter)
	begin
		if(i_row_counter == 2) then
			if(i_column_counter >= 2)then
				o_valid <= '1';
			else
				o_valid <= '0';
			end if;
		else if(i_row_counter > 2) then
			o_valid <= '1';
		else
			o_valid <= '0';
		end if;
	end process;
	
	-----------------------------------------------
	-- fills up the array and reset
	-----------------------------------------------
	fill_Array: Process(i_valid, i_clock, i_reset)
	begin
		if (i_reset == '1') then
			i_column_counter = 0;
			i_row_counter = 0;
			o_column_counter <= 1;
			o_row_counter <= 1;
		else if(rising_edge(i_clock)) then
			if (i_valid == '1') then
				imageArray(i_column_counter, i_row_counter) <= i_pixel;
				if(i_column_counter == n-1 && i_column_counter < n) then
					i_row_counter = i_row_counter + 1;
					i_column_counter = 0;
				else
					i_column_counter = i_column_counter + 1;
				end if;
			end if;
		end if;
	end process;
	
	-----------------------------------------------
	-- checks if the array is full
	-----------------------------------------------
	check_Full: Process(i_column_counter, i_row_counter)
	begin
		if(i_column_counter == n-1 and i_row_counter == n-1) then
			isFull <= '1';
		else
			isFull <= '0';
		end if;	
	end process;

end;