library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sobel is
    port (i_clock : in std_logic;
          i_valid : in std_logic;
          i_pixel : in std_logic_vector (7 downto 0);
          i_reset : in std_logic;
          o_edge  : out std_logic;
          o_dir   : out std_logic_vector (2 downto 0);
          o_valid : out std_logic;
          o_mode  : out std_logic_vector (1 downto 0)
        );
end sobel;

architecture Behavioral of sobel is

    component sobel_memory
        port( i_clock   : in std_logic;
              i_valid   : in std_logic;
              i_pixel   : in std_logic_vector (7 downto 0);
              i_reset   : in std_logic;
              i_request : in std_logic;
              o_top     : out std_logic_vector (23 downto 0); 
              o_mid     : out std_logic_vector (23 downto 0); 
              o_bot     : out std_logic_vector (23 downto 0); 
              o_valid   : out std_logic;
              o_isFull  : out std_logic
            );
    end sobel_memory;

    component sobel_derivative
        port(i_clock   : in std_logic;
             i_enable  : in std_logic;
             i_reset   : in std_logic;
             i_top     : in std_logic_vector (23 downto 0);
             i_mid     : in std_logic_vector (23 downto 0);
             i_bot     : in std_logic_vector (23 downto 0);
             o_dbusy   : out std_logic;
             o_D_NE_SE : out std_logic_vector (7 downto 0);
             o_D_N_S   : out std_logic_vector (7 downto 0);
             o_D_E_W   : out std_logic_vector (7 downto 0);
             o_D_NE_SW : out std_logic_vector (7 downto 0);
             o_request : out std_logic
            );
    end sobel_derivative;

    component sobel_eval
        port(i_clock   : in std_logic;
             i_enable  : in std_logic;
             i_reset   : in std_logic;
             i_D_NE_SW : in std_logic_vector (7 downto 0);
             i_D_N_S   : in std_logic_vector (7 downto 0);
             i_D_E_W   : in std_logic_vector (7 downto 0);
             i_D_NW_SE : in std_logic_vector (7 downto 0);
             o_ebusy   : out std_logic;
             o_dir     : out std_logic_vector (2 downto 0);
             o_edge    : out std_logic;
             o_request : out std_logic
            );
    end sobel_eval;

    type state_type is (IDLE, BUSY, RESET);
    signal state : state_type := IDLE;
    signal s_clock : std_logic;
    signal 

begin
    proc : process (i_pixel, i_valid, i_clock, i_reset)
    begin
        if i_reset = '1 then
            o_mode <= "01";
            state <= RESET;
        elsif (clk'event and clk='1') then
            case state is 
                when RESET =>
                     state <= IDLE;
                     o_mode <="10";
                when IDLE =>
                    if o_dbusy & o_ebusy & o_mbusy /= "000" then
                        state <= BUSY;
                        o_mode <= "11";
                when BUSY =>
                    if  o_dbusy & o_ebusy & o_mbusy = "000" then
                        state <= IDLE;
                        o_mode <= "10";


