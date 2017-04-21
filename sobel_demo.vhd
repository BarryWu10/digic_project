library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


--| Sobel Module i/o
entity sobel_demo is
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
end sobel_demo;

architecture Structural of sobel_demo is

    --| Sobel Derivative Module i/o
    component sobel_derivative is
        port(i_clock   : in std_logic;                      --| Clock Input
             i_enable  : in std_logic;                      --| Input Enable
             i_reset   : in std_logic;                      --| Reset Input
             i_top     : in std_logic_vector (23 downto 0); --| Top pixel
                                                            --  neighbors
             i_mid     : in std_logic_vector (23 downto 0); --| Pixel with left
                                                            --  and right
                                                            --  neighbors
             i_bot     : in std_logic_vector (23 downto 0); --| Bottom pixel
                                                            --  neighbors
             o_dbusy   : out std_logic;                     --| Derivative busy
                                                            --  signal
             o_D_NE_SW : out std_logic_vector (11 downto 0); --| NE SW Derivative
             o_D_N_S   : out std_logic_vector (11 downto 0); --| N S Derivative
             o_D_E_W   : out std_logic_vector (11 downto 0); --| E W Derivative
             o_D_NW_SE : out std_logic_vector (11 downto 0); --| NW SE Derivative
             o_valid   : out std_logic;                     --| Valid Derivative
             o_request : out std_logic                      --| Memory request
            );                                              --  signal
    end component;

    --| Sobel Eval Module i/o
    component sobel_eval is
        port(i_enable  : in std_logic;                      --| Input Enable
             i_D_NE_SW : in std_logic_vector (11 downto 0);  --| NE SW Derivative
             i_D_N_S   : in std_logic_vector (11 downto 0);  --| N S Derivative
             i_D_E_W   : in std_logic_vector (11 downto 0);  --| E W Derivative
             i_D_NW_SE : in std_logic_vector (11 downto 0);  --| NW SE Derivative
             o_dir     : out std_logic_vector (2 downto 0); --| Direction code
                                                            --  of pixel
             o_edge    : out std_logic;                     --| Edge indicator
                                                            --  signal
             o_valid   : out std_logic                      --| Valid output
                                                            --  edge signal
            );
    end component;

    --| Module Interconnections and State types
    type state_type is (IDLE, BUSY, RESET);
    signal state     : state_type := IDLE;
    signal w_clock   : std_logic;
    signal w_reset   : std_logic;
    signal w_valid   : std_logic;
    signal w_ovalid  : std_logic;
    signal w_edge    : std_logic;
    signal w_mvalid  : std_logic;
    signal w_der_en  : std_logic;
    signal w_mem_req : std_logic;
    signal w_eval_en : std_logic;
    signal w_dbusy   : std_logic;
    signal w_dir     : std_logic_vector (2 downto 0);
    signal w_mode    : std_logic_vector (1 downto 0) := "10";
    signal w_top     : std_logic_vector (23 downto 0);
    signal w_mid     : std_logic_vector (23 downto 0);
    signal w_bot     : std_logic_vector (23 downto 0);
    signal w_D_NE_SW : std_logic_vector (11 downto 0);
    signal w_D_N_S   : std_logic_vector (11 downto 0);
    signal w_D_E_W   : std_logic_vector (11 downto 0);
    signal w_D_NW_SE : std_logic_vector (11 downto 0);

begin




    --| Derivative Module Port Map
    derivative : sobel_derivative
        port map(i_clock         => w_clock,
                 i_enable        => w_valid,
                 i_reset         => w_reset,
                 i_top           => w_top,
                 i_mid           => w_mid,
                 i_bot           => w_bot,
                 o_dbusy         => w_dbusy,
                 o_D_NE_SW       => w_D_NE_SW,
                 o_D_N_S         => w_D_N_S,
                 o_D_E_W         => w_D_E_W,
                 o_D_NW_SE       => w_D_NW_SE,
                 o_valid         => w_eval_en,
                 o_request       => w_mem_req
                );

    --| Evaluation Module Port Map
    eval : sobel_eval
        port map(i_enable  => w_eval_en,
                 i_D_NE_SW => w_D_NE_SW,
                 i_D_N_S   => w_D_N_S,
                 i_D_E_W   => w_D_E_W,
                 i_D_NW_SE => w_D_NW_SE,
                 o_dir     => w_dir,
                 o_edge    => w_edge,
                 o_valid   => w_ovalid
                );

    --| Sobel i/o wire mapping
    w_clock <= i_clock;
    w_valid <= i_valid;
    w_reset <= i_reset;
    o_edge  <= w_edge;
    o_dir   <= w_dir;
    o_valid <= w_ovalid;
    o_mode  <= w_mode;
    w_top <= i_pixel_top;
    w_mid <= i_pixel_mid;
    w_bot <= i_pixel_bot;


    proc : process (i_valid, i_clock, i_reset)
    begin
        if i_reset = '1' then
            w_mode <= "01";
            state <= RESET;
        elsif (i_clock'event and i_clock='1') then
            case state is
                when RESET =>
                     state <= IDLE;
                     w_mode <="10";
                when IDLE =>
                    if (w_dbusy /= '0') then
                        state <= BUSY;
                        w_mode <= "11";
                    end if;
                when BUSY =>
                    if (w_dbusy = '0') then
                        state <= IDLE;
                        w_mode <= "10";
                    end if;
            end case;
        end if;
    end process;
end Structural;
