library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sobel_eval is 
    port(i_clock   : in std_logic;                      --| Clock Input
         i_enable  : in std_logic;                      --| Input Enable
         i_reset   : in std_logic;                      --| Reset Input
         i_D_NE_SW : in std_logic_vector (7 downto 0);  --| NE SW Derivative
         i_D_N_S   : in std_logic_vector (7 downto 0);  --| N S Derivative
         i_D_E_W   : in std_logic_vector (7 downto 0);  --| E W Derivative
         i_D_NW_SE : in std_logic_vector (7 downto 0);  --| NW SE Derivative
         o_ebusy   : out std_logic;                     --| Busy Signal
         o_dir     : out std_logic_vector (2 downto 0); --| Direction code
                                                        --  of pixel
         o_edge    : out std_logic;                     --| Edge indicator
                                                        --  signal
         o_valid   : out std_logic;                     --| Valid output
                                                        --  edge signal
         o_request : out std_logic                      --| Derivative
        );                                              --  request signal
end sobel_eval;

architecture Behavioral of sobel_eval is
begin
    type state_type is (HOLD, PROC);
    signal state     : state_type := HOLD;

