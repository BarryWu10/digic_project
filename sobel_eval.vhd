library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity sobel_eval is
    port(i_enable  : in std_logic;                      --| Input Enable
         i_D_NE_SW : in std_logic_vector (11 downto 0);  --| NE SW Derivative
         i_D_N_S   : in std_logic_vector (11 downto 0);  --| N S Derivative
         i_D_E_W   : in std_logic_vector (11 downto 0);  --| E W Derivative
         i_D_NW_SE : in std_logic_vector (11 downto 0);  --| NW SE Derivative
         o_dir     : out std_logic_vector (2 downto 0); --| Direction code
                                                        --  of pixel
         o_edge    : out std_logic;                     --| Edge indicator
                                                        --  signal
         o_valid   : out std_logic                     --| Valid output
                                                        --  edge signal
        );                                              
end sobel_eval;

architecture Behavioral of sobel_eval is
    type array_int is array (integer range <>) of Integer;
    signal w_dir     : std_logic_vector(2 downto 0) := "000";
    signal w_edge    : std_logic := '0';
    signal w_valid   : std_logic := '0';
    signal w_D_NE_SW : signed(11 downto 0);
    signal w_D_N_S   : signed(11 downto 0);
    signal w_D_E_W   : signed(11 downto 0);
    signal w_D_NW_SE : signed(11 downto 0);
begin
    o_dir   <= w_dir;
    o_edge  <= w_edge;
    w_valid <= i_enable;
    o_valid <= w_valid;
    w_D_NE_SW <= signed(i_D_NE_SW);
    w_D_N_S   <= signed(i_D_N_S);
    w_D_E_W   <= signed(i_D_E_W);
    w_D_NW_SE <= signed(i_D_NW_SE);

    eval : process (w_D_NW_SE, w_D_N_S, w_D_E_W, w_D_NW_SE)
    variable derivs  : array_int(0 to 3);
    variable max     : integer := 0;
    variable pos     : integer := 0;
    variable perp    : integer := 0;

    begin
        derivs(0) := to_integer(w_D_NE_SW);
        derivs(1) := to_integer(w_D_N_S);
        derivs(2) := to_integer(w_D_E_W);
        derivs(3) := to_integer(w_D_NW_SE);

        for I in 0 to 3 loop
            if (max < abs(derivs(I))) then
                pos := I;
                max := abs(derivs(I));
                perp := abs(derivs(3 - I));
            end if;
        end loop;

        if ((max + (perp/8)) < 80) then
            w_edge <= '0';
            w_dir  <= "000";
        else
            w_edge <= '1';
            case pos is
                when 0 =>
                    if (derivs(0) > 0) then
                        w_dir <= "110"; --| NE
                    else
                        w_dir <= "111"; --| SW
                    end if;
                when 1 =>
                    if (derivs(1) > 0) then
                        w_dir <= "010"; --| N
                    else
                        w_dir <= "011"; --| S
                    end if;
                when 2 =>
                    if (derivs(2) > 0) then
                        w_dir <= "000"; --| E
                    else
                        w_dir <= "001"; --| W
                    end if;
                when 3 =>
                    if (derivs(3) > 0) then
                        w_dir <= "100"; --| NW
                    else
                        w_dir <= "101"; --| SE
                    end if;
                when others => 
                    null;
            end case;
        end if;
    end process;
end Behavioral;
