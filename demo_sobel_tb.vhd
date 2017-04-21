--
--Barry Wu and Chris Ranc
--Sobel_tb.vhd
--
--This is our lovely outter test bench of our lovely sobel project
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
--use IEEE.math_real.all;

entity sobel_demo_tb is
end entity;

architecture behavioral of sobel_demo_tb is

    component sobel_demo is
    port (i_clock : in std_logic;
          i_valid : in std_logic;
          i_pixel_top : in std_logic_vector (23 downto 0);
          i_pixel_mid : in std_logic_vector (23 downto 0);
          i_pixel_bot : in std_logic_vector (23 downto 0);
          i_reset : in std_logic;
          o_edge  : out std_logic;
          o_dir   : out std_logic_vector (2 downto 0);
          o_valid : out std_logic;
          o_mode  : out std_logic_vector (1 downto 0)
        );
    end component;

    signal w_clock: std_logic := '0';
    signal w_valid: std_logic := '0';
    signal w_pixel_top : std_logic_vector (23 downto 0);
    signal w_pixel_mid : std_logic_vector (23 downto 0);
    signal w_pixel_bot : std_logic_vector (23 downto 0);
    signal w_reset: std_logic := '0';
 
    signal w_edge   : std_logic;
    signal w_ovalid : std_logic;
    signal w_dir    : std_logic_vector (2 downto 0);
    signal w_mode   : std_logic_vector (1 downto 0);


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
    --        0    255        255
    --        0    0        255
    --        0    0        0
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
    --        0    0        255
    --        0    0        255
    --        0    0        255
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
    --        255    0        0
    --        0    255        0
    --        0    0        255
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
    --        0    0        0
    --        255    0        0
    --        255    255        0
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
    --        255    0        0
    --        255    0        0
    --        255    0        0
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
    --        0    0        0
    --        255    255        255
    --        0    0        0
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
    --       255    255      255
    --        0      0        0
    --        0      0        0
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
    --       255    255       0
    --       255     0        0
    --        0      0        0
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
    --        0    255     0
    --       255    0     255
    --        0    255     0
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
    --         0      0      0
    --         0      0      0
    --        255    255    255
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
    --        0    0        0
    --        0    0        255
    --        0    255        255
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
    uut: sobel_demo port map(
        -----------------------------------------------
        -- Inputs
        -----------------------------------------------
        i_clock     => w_clock,
        i_valid     => w_valid,
        i_pixel_top => w_pixel_top,
        i_pixel_mid => w_pixel_mid,
        i_pixel_bot => w_pixel_bot,
        i_reset     => w_reset,
        -----------------------------------------------
        -- Outputs
        -----------------------------------------------
        o_edge   => w_edge,
        o_dir    => w_dir,
        o_valid  => w_ovalid,
        o_mode   => w_mode
    );

    -----------------------------------------------
    -- Our fabulous clock
    -----------------------------------------------
    Clk: Process
    Begin
        w_clock <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        w_clock <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
    end Process;

    test: Process
    begin
        -----------------------------------------------
        -- test image block 0
        -----------------------------------------------

        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block0(0,0) & img_block0(0,1) & img_block0(0,2);
        w_pixel_mid <= img_block0(1,0) & img_block0(1,1) & img_block0(1,2);
        w_pixel_bot <= img_block0(2,0) & img_block0(2,1) & img_block0(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 1
        -----------------------------------------------

        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1'; 
        w_pixel_top <= img_block1(0,0) & img_block1(0,1) & img_block1(0,2);
        w_pixel_mid <= img_block1(1,0) & img_block1(1,1) & img_block1(1,2);
        w_pixel_bot <= img_block1(2,0) & img_block1(2,1) & img_block1(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 2
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block2(0,0) & img_block2(0,1) & img_block2(0,2);
        w_pixel_mid <= img_block2(1,0) & img_block2(1,1) & img_block2(1,2);
        w_pixel_bot <= img_block2(2,0) & img_block2(2,1) & img_block2(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 3
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block3(0,0) & img_block3(0,1) & img_block3(0,2);
        w_pixel_mid <= img_block3(1,0) & img_block3(1,1) & img_block3(1,2);
        w_pixel_bot <= img_block3(2,0) & img_block3(2,1) & img_block3(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 4
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block4(0,0) & img_block4(0,1) & img_block4(0,2);
        w_pixel_mid <= img_block4(1,0) & img_block4(1,1) & img_block4(1,2);
        w_pixel_bot <= img_block4(2,0) & img_block4(2,1) & img_block4(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 5
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block5(0,0) & img_block5(0,1) & img_block5(0,2);
        w_pixel_mid <= img_block5(1,0) & img_block5(1,1) & img_block5(1,2);
        w_pixel_bot <= img_block5(2,0) & img_block5(2,1) & img_block5(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 6
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block6(0,0) & img_block6(0,1) & img_block6(0,2);
        w_pixel_mid <= img_block6(1,0) & img_block6(1,1) & img_block6(1,2);
        w_pixel_bot <= img_block6(2,0) & img_block6(2,1) & img_block6(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 7
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block7(0,0) & img_block7(0,1) & img_block7(0,2);
        w_pixel_mid <= img_block7(1,0) & img_block7(1,1) & img_block7(1,2);
        w_pixel_bot <= img_block7(2,0) & img_block7(2,1) & img_block7(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 8
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block8(0,0) & img_block8(0,1) & img_block8(0,2);
        w_pixel_mid <= img_block8(1,0) & img_block8(1,1) & img_block8(1,2);
        w_pixel_bot <= img_block8(2,0) & img_block8(2,1) & img_block8(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 9
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block9(0,0) & img_block9(0,1) & img_block9(0,2);
        w_pixel_mid <= img_block9(1,0) & img_block9(1,1) & img_block9(1,2);
        w_pixel_bot <= img_block9(2,0) & img_block9(2,1) & img_block9(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

        -----------------------------------------------
        -- test image block 10
        -----------------------------------------------
        w_reset <= '1';
        w_valid <= '0';
        wait for 5*clk_period;
        w_reset <= '0';
        w_valid <= '1';
        w_pixel_top <= img_block10(0,0) & img_block10(0,1) & img_block10(0,2);
        w_pixel_mid <= img_block10(1,0) & img_block10(1,1) & img_block10(1,2);
        w_pixel_bot <= img_block10(2,0) & img_block10(2,1) & img_block10(2,2);
        wait for clk_period;
        w_valid <= '0';
        wait for 5*clk_period;

    end process;

end;
