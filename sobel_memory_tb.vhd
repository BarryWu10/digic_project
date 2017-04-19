--
--Barry Wu and Chris Ranc
--Sobel_tb.vhd
--
--This is our lovely outter test bench of our lovely sobel project
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.math_real.all;

entity sobel_memory_tb is
end entity;

architecture behavioral of sobel_memory_tb

	component sobel_memory
	Generic(N: integer := 3);
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
	end component;
	
	signal i_clock: std_logic := '0';
	signal i_valid: std_logic := '0';
	signal i_pixel: std_logic_vector(7 downto 0) := (others -> '0');
	signal i_reset: std_logic := '0';
	signal i_request: std_logic := '0';
	
	signal o_top : std_logic_vector(23 downto 0) := (others -> '0');
	signal o_mid : std_logic_vector(23 downto 0) := (others -> '0');
	signal o_bot : std_logic_vector(23 downto 0) := (others -> '0');
	signal o_valid : std_logic := '0';
	signal o_isFull : std_logic := '0';
	signal o_busy : std_logic := '0';
	
	type img_block is array(2 downto 0, 2 downto 0) of std_logic_vector(7 downto 0);
	signal img_block0: img_block;
	signal img_block1: img_block;
	signal img_block2: img_block;
	signal img_block3: img_block;
	signal img_block4: img_block;
	signal img_block5: img_block;
	signal img_block6: img_block;
	signal img_block7: img_block;
	signal img_block8: img_block;
	signal img_block9: img_block;
	signal img_block10: img_block;
	
	signal all_zero: std_logic_vector(7 downto 0) := (others => '0');
	signal all_ones: std_logic_vector(7 downto 0) := (others => '1');
	
	constant clk_period : time := 10 ns;

Begin
	-----------------------------------------------
	-- image block 0
	--		0	255		255
	--		0	0		255
	--		0	0		0
	-----------------------------------------------
	img_block0(0,0) <= all_zero;
	img_block0(0,1) <= all_ones;
	img_block0(0,2) <= all_ones;
	img_block0(1,0) <= all_zero;
	img_block0(1,1) <= all_zero;
	img_block0(1,2) <= all_ones;
	img_block0(2,0) <= all_zero;
	img_block0(2,1) <= all_zero;
	img_block0(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 1
	--		0	0		255
	--		0	0		255
	--		0	0		255
	-----------------------------------------------
	img_block1(0,0) <= all_zero;
	img_block1(0,1) <= all_zero;
	img_block1(0,2) <= all_ones;
	img_block1(1,0) <= all_zero;
	img_block1(1,1) <= all_zero;
	img_block1(1,2) <= all_ones;
	img_block1(2,0) <= all_zero;
	img_block1(2,1) <= all_zero;
	img_block1(2,2) <= all_ones;
	
	-----------------------------------------------
	-- image block 2
	--		255	0		0
	--		0	255		0
	--		0	0		255
	-----------------------------------------------
	img_block2(0,0) <= all_ones;
	img_block2(0,1) <= all_zero;
	img_block2(0,2) <= all_zero;
	img_block2(1,0) <= all_zero;
	img_block2(1,1) <= all_ones;
	img_block2(1,2) <= all_zero;
	img_block2(2,0) <= all_zero;
	img_block2(2,1) <= all_zero;
	img_block2(2,2) <= all_ones;
	
	-----------------------------------------------
	-- image block 3
	--		0	0		0
	--		255	0		0
	--		255	255		0
	-----------------------------------------------
	img_block3(0,0) <= all_zero;
	img_block3(0,1) <= all_zero;
	img_block3(0,2) <= all_zero;
	img_block3(1,0) <= all_ones;
	img_block3(1,1) <= all_zero;
	img_block3(1,2) <= all_zero;
	img_block3(2,0) <= all_ones;
	img_block3(2,1) <= all_ones;
	img_block3(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 4
	--		255	0		0
	--		255	0		0
	--		255	0		0
	-----------------------------------------------
	img_block4(0,0) <= all_ones;
	img_block4(0,1) <= all_zero;
	img_block4(0,2) <= all_zero;
	img_block4(1,0) <= all_ones;
	img_block4(1,1) <= all_zero;
	img_block4(1,2) <= all_zero;
	img_block4(2,0) <= all_ones;
	img_block4(2,1) <= all_zero;
	img_block4(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 5
	--		0	0		0
	--		255	255		255
	--		0	0		0
	-----------------------------------------------
	img_block5(0,0) <= all_zero;
	img_block5(0,1) <= all_zero;
	img_block5(0,2) <= all_zero;
	img_block5(1,0) <= all_ones;
	img_block5(1,1) <= all_ones;
	img_block5(1,2) <= all_ones;
	img_block5(2,0) <= all_zero;
	img_block5(2,1) <= all_zero;
	img_block5(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 6
	--		255	255		255
	--		0	0		0
	--		0	0		0
	-----------------------------------------------
	img_block6(0,0) <= all_ones;
	img_block6(0,1) <= all_ones;
	img_block6(0,2) <= all_ones;
	img_block6(1,0) <= all_zero;
	img_block6(1,1) <= all_zero;
	img_block6(1,2) <= all_zero;
	img_block6(2,0) <= all_zero;
	img_block6(2,1) <= all_zero;
	img_block6(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 7
	--		255	255		0
	--		255	0		0
	--		0	0		0
	-----------------------------------------------
	img_block7(0,0) <= all_ones;
	img_block7(0,1) <= all_ones;
	img_block7(0,2) <= all_zero;
	img_block7(1,0) <= all_ones;
	img_block7(1,1) <= all_zero;
	img_block7(1,2) <= all_zero;
	img_block7(2,0) <= all_zero;
	img_block7(2,1) <= all_zero;
	img_block7(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 8
	--		0	255		0
	--		255	0		255
	--		0	255		0
	-----------------------------------------------
	img_block8(0,0) <= all_zero;
	img_block8(0,1) <= all_ones;
	img_block8(0,2) <= all_zero;
	img_block8(1,0) <= all_ones;
	img_block8(1,1) <= all_zero;
	img_block8(1,2) <= all_ones;
	img_block8(2,0) <= all_zero;
	img_block8(2,1) <= all_ones;
	img_block8(2,2) <= all_zero;
	
	-----------------------------------------------
	-- image block 9
	--		0	0		0
	--		0	0		0
	--		255	255		255
	-----------------------------------------------
	img_block9(0,0) <= all_zero;
	img_block9(0,1) <= all_zero;
	img_block9(0,2) <= all_zero;
	img_block9(1,0) <= all_zero;
	img_block9(1,1) <= all_zero;
	img_block9(1,2) <= all_zero;
	img_block9(2,0) <= all_ones;
	img_block9(2,1) <= all_ones;
	img_block9(2,2) <= all_ones;
	
	-----------------------------------------------
	-- image block 10
	--		0	0		0
	--		0	0		255
	--		0	255		255
	-----------------------------------------------
	img_block10(0,0) <= all_zero;
	img_block10(0,1) <= all_zero;
	img_block10(0,2) <= all_zero;
	img_block10(1,0) <= all_zero;
	img_block10(1,1) <= all_zero;
	img_block10(1,2) <= all_ones;
	img_block10(2,0) <= all_zero;
	img_block10(2,1) <= all_ones;
	img_block10(2,2) <= all_ones;
	
	-----------------------------------------------
	-- uut (Unit under test)
	-----------------------------------------------
	uut: sobel_memory port map(
		-----------------------------------------------
		-- Inputs
		-----------------------------------------------
		i_clock => i_clock;
		i_valid => i_valid;
		i_pixel => i_pixel;
		i_reset => i_reset;
		i_request => i_request;
		-----------------------------------------------
		-- Outputs
		-----------------------------------------------
		o_top => o_top;
		o_mid => o_mid;
		o_bot => o_bot;
		o_valid => o_valid;
		o_isFull => o_isFull;
		o_busy => o_busy;
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
	
	test: Process
		
		-----------------------------------------------
		-- test image block 0
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block0(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 1
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block1(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 2
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block2(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 3
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block3(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 4
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block4(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 5
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block5(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		
		-----------------------------------------------
		-- test image block 6
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block6(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 7
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block7(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 8
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block8(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 9
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block9(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
		-----------------------------------------------
		-- test image block 10
		-----------------------------------------------
		wait for clk_period;
		i_reset <= '1';
		wait for clk_period;
		i_reset <= '0';
		wait for clk_period;
		--reads in data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_pixel <= img_block10(i, j);
				i_valid <= '1';
				wait for 5*clk_period;
				i_valid <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		--reads out data
		for row in 0 to 2 loop
			for column	in 0 to 2 loop
				i_request <= '1';
				wait for 5*clk_period;
				i_request <= '0';
				wait for 5*clk_period;
			end loop;
		end loop;
		
		wait for 20*clk_period;
		
	
	end process;
	
end;