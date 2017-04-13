--
--Barry Wu and Chris Ranc
--Sobel_tb.vhd
--
--This is our lovely outter test bench of our lovely sobel project
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.math_real.all;
use ieee.std_logic_textio.all;			--for text io

--add these things to make it a text I/O
library std;
use std.textio.all;

entity sobel_outter is 
	Port(
	--empty cause this is a test bench
	-----------------------------------------------
	-- Input signals
	-----------------------------------------------
	-----------------------------------------------
	-- Output signals
	-----------------------------------------------
end entity;

ARCHITECTURE behavioral OF sobel_outter IS 
	-----------------------------------------------
	-- Add our components here
	-----------------------------------------------
	--sobel component
	component sobel 
	port(
		-----------------------------------------------
		-- Input signals
		-----------------------------------------------
		i_clock : in std_logic; 					-- input clock
		i_valid : in std_logic; 					-- is input valid?
		i_pixel : in std_logic_vector(7 downto 0); 	-- 8-bit input
		i_reset : in std_logic; 					-- reset signal
		
		-----------------------------------------------
		-- Output signals
		-----------------------------------------------
		o_edge : out std_logic; 					-- 1-bit output for edge
		o_dir : out std_logic_vector(2 downto 0); 	-- 3-bit output for direction
		o_valid : out std_logic; 					-- is output valid?
		o_mode : out std_logic_vector(1 downto 0) 	-- 2-bit output for mode 
	);
	end component;
	
	-----------------------------------------------
	-- list of signals and constants
	-----------------------------------------------	
	--input
	signal i_clock: std_logic := '0';								--clock signal
	constant clk_period : time := 10 ns;							--clock rate
	signal i_valid: std_logic := '0';								--input valid signal
	signal i_pixel: std_logic_vector(7 downto 0) := (others => '0');--pixel signal
	signal i_reset: std_logic := '0';								--reset signal
	
	--output
	signal o_edge: std_logic := '0';								--edge signal
	signal o_dir: std_logic_vector(2 downto 0) := (others => '0');	--direction signal
	signal o_valid: std_logic := '0';								--output valid signal
	signal o_mode: std_logic_vector(1 downto 0) := (others => '0');	--mode signal
	
	--internal signals
	signal loop_boolean: std_logic := '0';
	
	-----------------------------------------------
	-- list of files
	-----------------------------------------------
	file testFile1: TEXT OPEN READ_MODE is "\DIC_final_project_image_files\content\enforced2\611950-CMPE63001.2161\test1.txt";
	File testFile2: TEXT OPEN READ_MODE is "\DIC_final_project_image_files\content\enforced2\611950-CMPE63001.2161\test2.txt";
	File testFile3: TEXT OPEN READ_MODE is "\DIC_final_project_image_files\content\enforced2\611950-CMPE63001.2161\test3.txt";
	File testFile4: TEXT OPEN READ_MODE is "\DIC_final_project_image_files\content\enforced2\611950-CMPE63001.2161\test4.txt";
begin
	-----------------------------------------------
	-- unit under test
	-----------------------------------------------
	uut: sobel port map(
		-----------------------------------------------
		-- Input signals
		-----------------------------------------------
		i_clock => i_clock,
		i_valid => i_valid,
		i_pixel => i_pixel,
		i_reset => i_reset,
		
		-----------------------------------------------
		-- Output signals
		-----------------------------------------------
		o_edge => o_edge,
		o_dir => o_dir,
		o_valid => o_valid,
		o_mode => o_mode
	);
	
	-----------------------------------------------
	-- Our fabulous clock
	-----------------------------------------------
	Clk: Process
	Begin
		i_clock <= '0';
		wait for clk_period/2;  --for 0.5 ns signal is '0'.
		i_clock <= '1';
		wait for clk_period/2;  --for next 0.5 ns signal is '1'.
	end Process;
	
	-----------------------------------------------
	-- Read!!! Read!! Read!! Read!! Read!! 
	-----------------------------------------------	
	readVar: Process
		Variable vectorLine:	LINE;								--reads a line
		Variable vectorValid:	BOOLEAN;							--bit to know if the line is valid
		Variable vPixel:		std_logic_vector(7 downto 0);		--pixel signal	
		Variable space:			CHARACTER;							--reads space, tabs, white space, nonsene. some people call it garbage
   --stim_proc: process
   begin
		wait For clk_period;										--juicing up the waves, make sure everything is 0
		i_reset <= '1';												--reset, again, ikr
		wait for clk_period;									
		i_reset <= '0';												--finish reset
		
		-----------------------------------------------
		-- Our first victim: testfile1
		-----------------------------------------------	
		while not endfile(testfile1) loop							--while we are not at the end of the file
			readline(testFile1, vectorLine);						--reads a line
			isValid <= '1';											--pixels incoming!!
			loop_boolean <= '1';									--set the loop boolean to 1 to make it true
			while loop_boolean = '1' loop							--loop until there is no more pixels in the line
				read(vectorLine, vPixel, good => vectorValid);		--checks a line
				Next when not vectorValid;
				read(vectorLine, space);							--reads nonsense
				pixel <= vectorpixel;								--shoves pixel to the sobel
				wait for clk_period;
			end loop;
			isValid <= '0';
		end loop;
		
		-----------------------
		
		wait For clk_period;										--juicing up the waves, make sure everything is 0
		i_reset <= '1';												--reset, again, ikr
		wait for clk_period;									
		i_reset <= '0';												--finish reset
		
		-----------------------------------------------
		-- Our second victim: testfile2
		-----------------------------------------------	
		while not endfile(testfile2) loop							--while we are not at the end of the file
			readline(testFile2, vectorLine);						--reads a line
			isValid <= '1';											--pixels incoming!!
			loop_boolean <= '1';									--set the loop boolean to 1 to make it true
			while loop_boolean = '1' loop							--loop until there is no more pixels in the line
				read(vectorLine, vPixel, good => vectorValid);		--checks a line
				Next when not vectorValid;
				read(vectorLine, space);							--reads nonsense
				pixel <= vectorpixel;								--shoves pixel to the sobel
				wait for clk_period;
			end loop;
			isValid <= '0';
		end loop;
		
		-----------------------
		
		wait For clk_period;										--juicing up the waves, make sure everything is 0
		i_reset <= '1';												--reset, again, ikr
		wait for clk_period;									
		i_reset <= '0';												--finish reset
		
		-----------------------------------------------
		-- Our third victim: testfile3
		-----------------------------------------------	
		while not endfile(testfile3) loop							--while we are not at the end of the file
			readline(testFile3, vectorLine);						--reads a line
			isValid <= '1';											--pixels incoming!!
			loop_boolean <= '1';									--set the loop boolean to 1 to make it true
			while loop_boolean = '1' loop							--loop until there is no more pixels in the line
				read(vectorLine, vPixel, good => vectorValid);		--checks a line
				Next when not vectorValid;
				read(vectorLine, space);							--reads nonsense
				pixel <= vectorpixel;								--shoves pixel to the sobel
				wait for clk_period;
			end loop;
			isValid <= '0';
		end loop;
		
		-----------------------
		
		wait For clk_period;										--juicing up the waves, make sure everything is 0
		i_reset <= '1';												--reset, again, ikr
		wait for clk_period;									
		i_reset <= '0';												--finish reset
		
		-----------------------------------------------
		-- Our fourth victim: testfile4
		-----------------------------------------------	
		while not endfile(testfile4) loop							--while we are not at the end of the file
			readline(testFile4, vectorLine);						--reads a line
			isValid <= '1';											--pixels incoming!!
			loop_boolean <= '1';									--set the loop boolean to 1 to make it true
			while loop_boolean = '1' loop							--loop until there is no more pixels in the line
				read(vectorLine, vPixel, good => vectorValid);		--checks a line
				Next when not vectorValid;
				read(vectorLine, space);							--reads nonsense
				pixel <= vectorpixel;								--shoves pixel to the sobel
				wait for clk_period;
			end loop;
			isValid <= '0';
		end loop;
		
		-----------------------------------------------
		-- Dont want to do these test again. STOP!!!!!
		-----------------------------------------------	
		
		wait;
   end process;

end behavioral;