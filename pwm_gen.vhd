library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm_gen is
  generic (
    clk_frq : integer := 20_000_000;  -- Clock frekansý
    pwm_frq : integer := 20_000       -- PWM frekansý
  );
  port (
    clk      : in std_logic;          -- Clock giriþi
    Duty     : in integer range 0 to 100 := 0;  -- PWM görev döngüsü yüzdesi
    pwm_o    : out std_logic          -- PWM çýkýþý
  );
end pwm_gen;

architecture Behavioral of pwm_gen is
  signal counter : integer := 0;       -- Zamanlayýcý sayacý
  signal pwm_out : std_logic := '0';   -- PWM çýkýþý
  constant clk_period : time := 1 ns;  -- Clock periyodu
begin
  -- PWM sinyali oluþturma iþlemi
  process(clk)
  begin
    if rising_edge(clk) then
      counter <= counter + 1;
      if counter >= (clk_frq / pwm_frq) then
        counter <= 0;
        pwm_out <= '1';
      end if;
      if counter >= (Duty * (clk_frq / pwm_frq) / 100) then
        pwm_out <= '0';
      end if;
    end if;
  end process;

  -- PWM çýkýþýný ata
  pwm_o <= pwm_out;
end Behavioral;
