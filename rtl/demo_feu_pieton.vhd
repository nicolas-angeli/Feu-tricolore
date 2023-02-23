-------------------------------------------------
--  Feux tricolores sur DE1_SOC
-------------------------------------------------
-- Creation     : 01/2023, A. Exertier
-------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- paquetage pour le calcul automatique des constantes
-- les etudiants pre-calculeront les valeurs des constantes
use ieee.math_real.all;


entity demo_feu_pieton is
  port(
    clk       : in  std_logic;
    resetn    : in  std_logic;
    p         : in  std_logic;
    hex0      : out std_logic_vector(6 downto 0);
    R        : out std_logic;
    O        : out std_logic;
    V        : out std_logic
  );
end entity;


architecture rtl of demo_feu_pieton is
  signal R_int : std_logic;
  signal O_int : std_logic;
  signal V_int : std_logic;
 
begin
  -- HEX : g f e d c b a
  -- segments actifs a 0
  -- rouge  : a
  -- orange : g
  -- vert   : d
  
  hex0 <= (not O_int)&"11"&(not V_int)&"11"&(not R_int); 

  R  <= R_int ; 
  O  <= O_int ;
  V  <= V_int ;

  
  dut : entity work.feu_pieton  
    port map(
      clk       => clk    ,
      resetn    => resetn ,
      p         => p     ,
      R         => R_int , 
      O         => O_int ,
      V         => V_int 
    );
end architecture ;
