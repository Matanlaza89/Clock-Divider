-----------------------------------------------------------------------------
----------------	This RTL Code written by Matan Leizerovich  ---------------
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-------			         Clock Divider TestBench			   	          -------
-----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity clockDividerTB is
end entity clockDividerTB;

architecture sim of clockDividerTB is
	-- constants
	constant c_FREQ : natural := 1_000_000; -- Desired frequency - 1 MHz
	constant C_PERIOD : time := 20 ns; -- T = 1/f => T=1/50*10^6 => T = 20nsec
	
	-- Stimulus signals --
	signal i_clk   : std_logic;
	signal i_reset : std_logic;
	
	-- Observed signal --
	signal o_clk  : std_logic;
	signal o_tick : std_logic;

	
begin

	-- Unit Under Test port map --
	UUT : entity work.clockDivider(rtl) 
	generic map(g_FREQ => c_FREQ)
	port map (
			i_clk   => i_clk ,
			i_reset => i_reset ,  
			o_clk   => o_clk,
			o_tick  => o_tick);


	-- Testbench process --
	p_TB : process
	begin
		i_reset <= '0'; wait for C_PERIOD;
		i_reset <= '1'; wait for C_PERIOD * 15; 
		wait;
	end process p_TB;
	
	
	-- 50 MHz clock in duty cycle of 50% - 20 ns --
	p_clock : process 
	begin 
		i_clk <= '0'; wait for C_PERIOD/2; -- 10 ns
		i_clk <= '1'; wait for C_PERIOD/2; -- 10 ns
	end process p_clock;

end architecture sim;