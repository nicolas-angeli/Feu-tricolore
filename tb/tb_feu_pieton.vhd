----------------------------------------
--  Gestion de feux tricolores
--   testbench
----------------------------------------
-- Creation     : 11/2013, A. Exertier
-- Modification : 09/2015, A. Exertier
----------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_feu_pieton is
end entity;


architecture testbench of tb_feu_pieton is
  constant hp      : time := 10 ns;  -- half-period
  constant per     : time := 2*hp;   -- period
  signal clk       : std_logic:='0';
  signal resetn    : std_logic;
  signal p         : std_logic;
  signal e2         : std_logic;
  signal e10        : std_logic;
  signal e15         : std_logic;
    

  
begin
  clk       <= not clk after hp;

  process is
  begin
    resetn <= '0';
    p <= '0';
    wait for per;
    resetn <= '1';
    p <= '1';
    wait for per;
    p <= '0';
    e10 <= '1';
    wait for per;
    p <= '0';
    e2 <= '1';
    wait for per;
    p <= '0';
    e15 <= '1';
    wait for per;
    p <= '1';
    e10 <= '1';
    
    
    --
    wait;
  end process;
  
  dut : entity work.feu_pieton  
    port map(
      clk       => clk    ,
      resetn    => resetn ,
      p       =>  p     
      
    );

end architecture ;
