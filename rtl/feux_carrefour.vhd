library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity feux_carrefour is
  port(
    clk       : in  std_logic;
    resetn    : in  std_logic;
    sw0       : in  std_logic;
    R1        : out std_logic;
    O1        : out std_logic;
    V1        : out std_logic;
    R2        : out std_logic;
    O2        : out std_logic;
    V2        : out std_logic
  );
end entity;


architecture rtl of feux_carrefour is
  
begin

end architecture ;