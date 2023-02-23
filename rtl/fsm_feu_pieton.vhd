library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_feu_pieton is
  port (
    clk        : in  std_logic;
    resetn     : in  std_logic;
    -- a completer 
    e10      : in std_logic;
    e15      : in std_logic;
    e2      : in std_logic;
    k      : in std_logic;
    
    V    : out std_logic;
    Vp    : out std_logic;
    V10    : out std_logic;
    O   :  out  std_logic;
    R   :  out  std_logic
  );
end entity;

architecture rtl of fsm_feu_pieton is
  type state is (Vert, Vert10, Vertp, Orange, Rouge);
  signal current_state : state;
  signal next_state    : state;

begin

  -- registre d'etat : complet
  process (clk,resetn) is
  begin
    if resetn = '0' then
      current_state <= Vert ;
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;
  
 
  -- combinatoire pour l'etat futur et les actions  => a completer
  
  process (current_state, k, e2, e10, e15)      -- a completer avec les autres entrees
     is
  begin
    -- valeurs par defaut de l'etat futur et des actions
    next_state <= current_state;
    V        <= '1';
    V10      <= '0';
    Vp       <= '0';
    O        <= '0';
    R        <= '0';    
    
    case current_state is
      when Vert  => 
        V        <= '1';
        V10      <= '0';
        Vp       <= '0';
        O        <= '0';
        R        <= '0';
        
        if e10='1' and k='1' then
            next_state <= Orange;
        elsif e10='1' then
        	next_state <= Vert10;
	    elsif k='1' then
        	next_state <= Vertp;
        end if;
                
      when Vert10 =>
        V        <= '1';
        V10      <= '1';
        Vp       <= '0';
        O        <= '0';
        R        <= '0';
       	if k='1' then
     	  next_state <= Orange;
        end if;
       
         
      when Orange   => 
        V        <= '0';
        V10      <= '0';
        Vp       <= '0';
        O        <= '1';
        R        <= '0';
       if e2='1' then next_state <= Rouge;
        end if;
        
       when Rouge   => 
        V        <= '0';
        V10      <= '0';
        Vp       <= '0';
        O        <= '0';
        R        <= '1';
       if e15='1' then next_state <= Vert;
        end if;
        
        when Vertp   => 
        V        <= '1';
        V10      <= '0';
        Vp       <= '1';
        O        <= '0';
        R        <= '0';
       if e10='1' then next_state <= Orange;
        end if;
       
    end case;
  end process;

end architecture;
