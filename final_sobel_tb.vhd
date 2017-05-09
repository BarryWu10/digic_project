--
--Barry Wu and Chris Ranc
--Sobel_tb.vhd
--
--This is our lovely outter test bench of our lovely sobel project
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
--use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
--use IEEE.math_real.all;
library std;
use std.textio.all;


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

    type imagePixel is array (255 downto 0, 255 downto 0) of std_logic_vector(7 downto 0);
    signal imageArray: imagePixel;

    --File testFile1: TEXT OPEN READ_MODE is "../content/enforced2/611950-CMPE63001.2161/test1.txt";
    --File testFile2: TEXT OPEN READ_MODE is "..content/enforced2/611950-CMPE63001.2161/test2.txt";
    --File testFile3: TEXT OPEN READ_MODE is "../content/enforced2/611950-CMPE63001.2161/test3.txt";
    --File testFile4: TEXT OPEN READ_MODE is "../content/enforced2/611950-CMPE63001.2161/test4.txt";
    --file inputFile  : text;
    --file outputFile : text;

Begin
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
        file inputFile    : text;
        file outputFile   : text;
        variable vPixel   : integer;
        variable lcv      : integer;
        variable inputLn  : line;
        variable outputLn : line;

    begin
        -----------------------------------------------
        -- test image 1
        -----------------------------------------------
        w_pixel_top <= (others => '0');
        w_pixel_mid <= (others => '0');
        w_pixel_bot <= (others => '0');

        lcv := 0;
        file_open(inputFile, "../content/enforced2/611950-CMPE63001.2161/test1.txt", read_mode);                            --reads a line
        file_open(outPutFile, "./result_file_1.pgm", write_mode);
        while not endfile(inputFile) loop                            --while we are not at the end of the file
            readline(inputFile, inputLn);                        --reads a line, pray to Xenu that its 256 pixels
            for index in 0 to 255 loop
                read(inputLn, vPixel);                            --read pixel
                imageArray(lcv, index) <= std_logic_vector(to_unsigned(vPixel, 8));                    --add to array
            end loop;
            lcv := lcv + 1;                                            --increment lcv by 1, for next row
        end loop;
        --humanely shove inside the sobel
        write(outputLn, string'("P2 254 254 255"));
        writeLine(outputFile, outputLn);
        for row in 1 to 254 loop
            for column in 1 to 254 loop
                w_reset <= '1';
                w_valid <= '0';
                wait for 5*clk_period;
                w_reset <= '0';
                w_valid <= '1';
                w_pixel_top <= imageArray(row-1, column-1) & imageArray(row-1, column) & imageArray(row-1, column+1);
                w_pixel_mid <= imageArray(row,   column-1) & imageArray(row,   column) & imageArray(row,   column+1);
                w_pixel_bot <= imageArray(row+1, column-1) & imageArray(row+1, column) & imageArray(row+1, column+1);
                wait for clk_period;
                w_valid <= '0';
                wait for clk_period;
                if (w_ovalid = '1' and w_edge = '1') then
                    write(outputLn, string'("255 "));
                else
                    write(outputLn, string'("0 "));
                end if;
                wait for 4*clk_period;

            end loop;
            writeLine(outputFile, outputLn);
        end loop;
        file_close(inputFile);
        file_close(outPutFile);
        -----------------------------------------------
        -- test image 2
        -----------------------------------------------
        lcv := 0;
        file_open(inputFile, "../content/enforced2/611950-CMPE63001.2161/test2.txt", read_mode);                            --reads a line
        file_open(outPutFile, "./result_file_2.pgm", write_mode);
        while not endfile(inputFile) loop                            --while we are not at the end of the file
            readline(inputFile, inputLn);                        --reads a line, pray to Xenu that its 256 pixels
            for index in 0 to 255 loop
                read(inputLn, vPixel);                            --read pixel
                imageArray(lcv, index) <= std_logic_vector(to_unsigned(vPixel, 8));                    --add to array
            end loop;
            lcv := lcv + 1;                                            --increment lcv by 1, for next row
        end loop;
        --humanely shove inside the sobel
        write(outputLn, string'("P2 254 254 255"));
        writeLine(outputFile, outputLn);
        for row in 1 to 254 loop
            for column in 1 to 254 loop
                w_reset <= '1';
                w_valid <= '0';
                wait for 5*clk_period;
                w_reset <= '0';
                w_valid <= '1';
                w_pixel_top <= imageArray(row-1, column-1) & imageArray(row-1, column) & imageArray(row-1, column+1);
                w_pixel_mid <= imageArray(row,   column-1) & imageArray(row,   column) & imageArray(row,   column+1);
                w_pixel_bot <= imageArray(row+1, column-1) & imageArray(row+1, column) & imageArray(row+1, column+1);
                wait for clk_period;
                w_valid <= '0';
                wait for clk_period;
                if (w_ovalid = '1' and w_edge = '1') then
                    write(outputLn, string'("255 "));
                else
                    write(outputLn, string'("0 "));
                end if;
                wait for 4*clk_period;

            end loop;
            writeLine(outputFile, outputLn);
        end loop;
        file_close(inputFile);
        file_close(outPutFile);
        -----------------------------------------------
        -- test image 3
        -----------------------------------------------
        lcv := 0;
        file_open(inputFile, "../content/enforced2/611950-CMPE63001.2161/test3.txt", read_mode);                            --reads a line
        file_open(outPutFile, "./result_file_3.pgm", write_mode);
        while not endfile(inputFile) loop                            --while we are not at the end of the file
            readline(inputFile, inputLn);                        --reads a line, pray to Xenu that its 256 pixels
            for index in 0 to 255 loop
                read(inputLn, vPixel);                            --read pixel
                imageArray(lcv, index) <= std_logic_vector(to_unsigned(vPixel, 8));                    --add to array
            end loop;
            lcv := lcv + 1;                                            --increment lcv by 1, for next row
        end loop;
        --humanely shove inside the sobel
        write(outputLn, string'("P2 254 254 255"));
        writeLine(outputFile, outputLn);
        for row in 1 to 254 loop
            for column in 1 to 254 loop
                w_reset <= '1';
                w_valid <= '0';
                wait for 5*clk_period;
                w_reset <= '0';
                w_valid <= '1';
                w_pixel_top <= imageArray(row-1, column-1) & imageArray(row-1, column) & imageArray(row-1, column+1);
                w_pixel_mid <= imageArray(row,   column-1) & imageArray(row,   column) & imageArray(row,   column+1);
                w_pixel_bot <= imageArray(row+1, column-1) & imageArray(row+1, column) & imageArray(row+1, column+1);
                wait for clk_period;
                w_valid <= '0';
                wait for clk_period;
                if (w_ovalid = '1' and w_edge = '1') then
                    write(outputLn, string'("255 "));
                else
                    write(outputLn, string'("0 "));
                end if;
                wait for 4*clk_period;

            end loop;
            writeLine(outputFile, outputLn);
        end loop;
        file_close(inputFile);
        file_close(outPutFile);
        -----------------------------------------------
        -- test image 4
        -----------------------------------------------
        lcv := 0;
        file_open(inputFile, "../content/enforced2/611950-CMPE63001.2161/test4.txt", read_mode);                            --reads a line
        file_open(outPutFile, "./result_file_4.pgm", write_mode);
        while not endfile(inputFile) loop                            --while we are not at the end of the file
            readline(inputFile, inputLn);                        --reads a line, pray to Xenu that its 256 pixels
            for index in 0 to 255 loop
                read(inputLn, vPixel);                            --read pixel
                imageArray(lcv, index) <= std_logic_vector(to_unsigned(vPixel, 8));                    --add to array
            end loop;
            lcv := lcv + 1;                                            --increment lcv by 1, for next row
        end loop;
        --humanely shove inside the sobel
        write(outputLn, string'("P2 254 254 255"));
        writeLine(outputFile, outputLn);
        for row in 1 to 254 loop
            for column in 1 to 254 loop
                w_reset <= '1';
                w_valid <= '0';
                wait for 5*clk_period;
                w_reset <= '0';
                w_valid <= '1';
                w_pixel_top <= imageArray(row-1, column-1) & imageArray(row-1, column) & imageArray(row-1, column+1);
                w_pixel_mid <= imageArray(row,   column-1) & imageArray(row,   column) & imageArray(row,   column+1);
                w_pixel_bot <= imageArray(row+1, column-1) & imageArray(row+1, column) & imageArray(row+1, column+1);
                wait for clk_period;
                w_valid <= '0';
                wait for clk_period;
                if (w_ovalid = '1' and w_edge = '1') then
                    write(outputLn, string'("255 "));
                else
                    write(outputLn, string'("0 "));
                end if;
                wait for 4*clk_period;

            end loop;
            writeLine(outputFile, outputLn);
        end loop;
        file_close(inputFile);
        file_close(outPutFile);
    end process;

end;
