library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity feu_pieton is
  port(
    clk       : in  std_logic;
    resetn    : in  std_logic;
    p         : in  std_logic;

    R         : out std_logic;
    O         : out std_logic;
    V         : out std_logic


  );
end entity;


architecture rtl of feu_pieton is
  
  signal ctr15        : std_logic_vector (29 downto 0);
  signal next_ctr15   : std_logic_vector (29 downto 0);
  signal e15       : std_logic;
  
  signal ctr10        : std_logic_vector (28 downto 0);
  signal next_ctr10   : std_logic_vector (28 downto 0);
  signal e10       : std_logic;
  
  signal ctr2        : std_logic_vector (26 downto 0);
  signal next_ctr2   : std_logic_vector (26 downto 0);
  signal e2       : std_logic;
  
  signal k       : std_logic;
  signal Vp       : std_logic;
  signal V10       : std_logic;
  signal pb       : std_logic;
  
  signal V1       : std_logic;
  signal O1       : std_logic;
  signal R1       : std_logic;
  
begin

ctrl_part : entity work.fsm_feu_pieton
    port map (
        clk        => clk,
        resetn => resetn,
        e10      => e10,
        e15     => e15,
        e2      => e2,
        k    => k,
        
        V   => V1,
        Vp   => Vp,
        V10   => V10,
        O  => O1,
        R => R1
        );

        
bp : process(clk,resetn) is
begin
    if resetn = '0' then
        pb <= '0';
    elsif rising_edge(clk) then
        pb <= p ;
    end if;
end process;

k <= (pb and not(p));

-- description du comparateur O
    e2 <= '1' when unsigned(ctr2) = 100_000_000
        else '0';
        
-- description du comparateur V
    e10 <= '1' when unsigned(ctr10) = 500_000_000
        else '0';
        
-- description du comparateur R
    e15 <= '1' when unsigned(ctr15) = 750_000_000
        else '0';
        
-- description du registre du compteur O
process (clk,resetn) is
begin
    if resetn = '0' then
        ctr2 <= (others => '0');
    elsif rising_edge(clk) then
        ctr2 <= next_ctr2;
    end if;
end process;

-- description du registre du compteur V
process (clk,resetn) is
begin
    if resetn = '0' then
        ctr10 <= (others => '0');
    elsif rising_edge(clk) then
        ctr10 <= next_ctr10;
    end if;
end process;

-- description du registre du compteur R
process (clk,resetn) is
begin
    if resetn = '0' then
        ctr15 <= (others => '0');
    elsif rising_edge(clk) then
        ctr15 <= next_ctr15;
    end if;
end process;

--description du comparateur et de l'incrémenteur O
next_ctr2 <= std_logic_vector(unsigned(ctr2)+1) when (e2 ='0' and O1 ='1')
    else (others => '0');
    
--description du comparateur et de l'incrémenteur V
next_ctr10 <= std_logic_vector(unsigned(ctr10)+1) when (e10 ='0' and V10='0' and (V1 ='1' or Vp='1'))
    else (others => '0');
    
--description du comparateur et de l'incrémenteur R
next_ctr15 <= std_logic_vector(unsigned(ctr15)+1) when (e15 ='0' and R1 ='1')
    else (others => '0');

	V <= V1;
	R <= R1;
	O <= O1;

end architecture ;
