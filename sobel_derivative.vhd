library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;

--| Sobel Derivative Module i/o
entity sobel_derivative is
    port(i_clock   : in std_logic;                      --| Clock Input
         i_enable  : in std_logic;                      --| Input Enable
         i_reset   : in std_logic;                      --| Reset Input
         i_request : in std_logic;                      --| Request Derivatives
         --| 23 downto 16 => byte 0
         --  15 downto 8  => byte 1
         --  7  downto 0  => byte 2
         i_top     : in std_logic_vector (23 downto 0); --| Top pixel
                                                        --  neighbors
         i_mid     : in std_logic_vector (23 downto 0); --| Pixel with left
                                                        --  and right
                                                        --  neighbors
         i_bot     : in std_logic_vector (23 downto 0); --| Bottom pixel
                                                        --  neighbors
         o_dbusy   : out std_logic;                     --| Derivative busy
                                                        --  signal
         o_D_NE_SW : out std_logic_vector (7 downto 0); --| NE SW Derivative
         o_D_N_S   : out std_logic_vector (7 downto 0); --| N S Derivative
         o_D_E_W   : out std_logic_vector (7 downto 0); --| E W Derivative
         o_D_NW_SE : out std_logic_vector (7 downto 0); --| NW SE Derivative
         o_valid   : out std_logic;                     --| Valid Derivative
         o_request : out std_logic                      --| Memory request
        );                                              --  signal
end sobel_derivative;

architecture Behavioral of sobel_derivative is

    type state_type is (HOLD, PROC);
    signal state     : state_type := HOLD;
    signal w_request : std_logic := '1';
    signal D_NE_SW   : unsigned (7 downto 0) := (others => '0');
    signal D_N_S     : unsigned (7 downto 0) := (others => '0');
    signal D_E_W     : unsigned (7 downto 0) := (others => '0');
    signal D_NW_SE   : unsigned (7 downto 0) := (others => '0');
    signal testing   : unsigned (7 downto 0);

begin
    o_D_NE_SW <= std_logic_vector(D_NE_SW);
    o_D_N_S   <= std_logic_vector(D_N_S);
    o_D_E_W   <= std_logic_vector(D_E_W);
    o_D_NW_SE <= std_logic_vector(D_NW_SE);
    o_request <= w_request;

    deriv : process (i_clock, i_enable, i_reset, i_request, i_top, i_mid, i_bot)
    begin
        if i_reset = '1' then
        elsif (i_clock'event and i_clock='1') then
            case state is
                when HOLD =>
                    o_valid   <= '0';
                    if i_enable = '1' then
                        o_dbusy <= '1';
                        state <= PROC;
                        w_request <= '0';

                        D_NE_SW <= unsigned(i_top(15 downto 8))
                                   + shift_left(unsigned(i_top(7 downto 0)), 1)
                                   + unsigned(i_mid(7 downto 0))
                                   - unsigned(i_mid(23 downto 16))
                                   - shift_left(unsigned(i_bot(23 downto 16)), 1)
                                   - unsigned(i_bot(15 downto 8));

                        D_N_S   <= unsigned(i_top(23 downto 16))
                                   + shift_left(unsigned(i_top(15 downto 8)), 1)
                                   + unsigned(i_top(7 downto 0))
                                   - unsigned(i_bot(23 downto 16))
                                   - shift_left(unsigned(i_bot(15 downto 8)), 1)
                                   - unsigned(i_bot(7 downto 0));

                        D_E_W   <= unsigned(i_top(7 downto 0))
                                   + shift_left(unsigned(i_mid(7 downto 0)), 1)
                                   + unsigned(i_bot(7 downto 0))
                                   - unsigned(i_top(23 downto 16))
                                   - shift_left(unsigned(i_mid(23 downto 16)), 1)
                                   - unsigned(i_bot(23 downto 16));

                        D_NW_SE <= unsigned(i_mid(23 downto 16))
                                   + shift_left(unsigned(i_top(23 downto 16)), 1)
                                   + unsigned(i_top(15 downto 8))
                                   - unsigned(i_bot(15 downto 8))
                                   - shift_left(unsigned(i_bot(7 downto 0)), 1)
                                   - unsigned(i_mid(7 downto 0));
                    else
                        o_dbusy <= '0';
                    end if;
                when PROC =>
                    if i_request = '1' then
                        state <= HOLD;
                        w_request <= '1';
                        o_valid   <= '1';
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
