----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:49 09/11/2006 
-- Design Name: 
-- Module Name:    cadr2_mmu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity cadr2_vmem1 is
    Port (
			addr : in std_logic_vector(9 downto 0);
			di : in std_logic_vector(23 downto 0);
			do : out std_logic_vector(23 downto 0);
			wr : in std_logic;
			en : in std_logic;
			clk : in std_logic);
end cadr2_vmem1;

architecture Behavioral of cadr2_vmem1 is

signal dou : std_logic_vector(15 downto 0);
signal diu : std_logic_vector(15 downto 0);

begin

   mmu_l2_0 : RAMB16_S18
   generic map (
      INIT => X"00000", --  Value of output RAM registers at startup
      SRVAL => X"00000", --  Ouput value upon SSR assertion
      WRITE_MODE => "WRITE_FIRST") --  WRITE_FIRST, READ_FIRST or NO_CHANGE
      -- The following INIT_xx declarations specify the intial contents of the RAM
      -- Address 0 to 255
   port map (
      DO => DO(15 downto 0),      -- 16-bit Data Output
      ADDR => ADDR,  -- 10-bit Address Input
      CLK => CLK,    -- Clock
      DI => di(15 downto 0),      -- 16-bit Data Input
      EN => en,      -- RAM Enable Input
      WE => wr       -- Write Enable Input
   );

   mmu_l2_1 : RAMB16_S18
   generic map (
      INIT => X"00000", --  Value of output RAM registers at startup
      SRVAL => X"00000", --  Ouput value upon SSR assertion
      WRITE_MODE => "WRITE_FIRST") --  WRITE_FIRST, READ_FIRST or NO_CHANGE
      -- The following INIT_xx declarations specify the intial contents of the RAM
      -- Address 0 to 255
   port map (
		DO => dou,      -- 16-bit Data Output
      ADDR => ADDR,  -- 10-bit Address Input
      CLK => CLK,    -- Clock
      DI => diu,      -- 16-bit Data Input
      EN => en,      -- RAM Enable Input
      WE => wr       -- Write Enable Input
   );

diu <= "00000000" & di(23 downto 16);
do(23 downto 16) <= dou(7 downto 0);

end Behavioral;
