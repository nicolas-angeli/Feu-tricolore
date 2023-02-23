-------------------------------------------------
--  Feux tricolores sur DE1_SOC
-------------------------------------------------
-- Creation     : 01/2023, A. Exertier
-------------------------------------------------
-- pb  : (pb) passage en mode "orange clignotant" => SW0
-------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity demo_feux_carrefour is
  port(
    clk       : in  std_logic;
    resetn    : in  std_logic;
    sw0       : in  std_logic;
    hex1      : out std_logic_vector(6 downto 0);
    hex0      : out std_logic_vector(6 downto 0);
    R1        : out std_logic;
    O1        : out std_logic;
    V1        : out std_logic;
    R2        : out std_logic;
    O2        : out std_logic;
    V2        : out std_logic
  );
end entity;


architecture rtl of demo_feux_carrefour is
  signal R1_int : std_logic;
  signal O1_int : std_logic;
  signal V1_int : std_logic;
  signal R2_int : std_logic;
  signal O2_int : std_logic;
  signal V2_int : std_logic;  
begin
  -- HEX : g f e d c b a
  -- segments actifs a 0
  -- rouge  : a
  -- orange : g
  -- vert   : d
  
  hex0 <= (not O1_int)&"11"&(not V1_int)&"11"&(not R1_int); 
  hex1 <= (not O2_int)&"11"&(not V2_int)&"11"&(not R2_int);  
  R1   <= R1_int ; 
  O1   <= O1_int ;
  V1   <= V1_int ;
  R2   <= R2_int ;
  O2   <= O2_int ;
  V2   <= V2_int ;
  
  dut : entity work.feux_carrefour  
    port map(
      clk       => clk    ,
      resetn    => resetn ,
      sw0       => sw0    ,
      R1        => R1_int , 
      O1        => O1_int ,
      V1        => V1_int ,
      R2        => R2_int ,
      O2        => O2_int ,
      V2        => V2_int 
    );
end architecture ;