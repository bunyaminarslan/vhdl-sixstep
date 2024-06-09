library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Motor_Control_Testbench is
end Motor_Control_Testbench;

architecture Behavioral of Motor_Control_Testbench is
    component Motor_Control is
        Port (
            Hall_State      : in std_logic_vector(2 downto 0);
            Clock           : in std_logic;
            Switch_Reset    : in std_logic;
            AHigh           : out std_logic;
            ALow            : out std_logic;
            BHigh           : out std_logic;
            BLow            : out std_logic;
            CHigh           : out std_logic;
            CLow            : out std_logic
        );
    end component;

    signal Clock       : std_logic := '0';
    signal Switch_Reset       : std_logic := '1';
    signal Hall_State  : std_logic_vector(2 downto 0) := "000";
    signal AHigh       : std_logic;
    signal ALow        : std_logic;
    signal BHigh       : std_logic;
    signal BLow        : std_logic;
    signal CHigh       : std_logic;
    signal CLow        : std_logic;
    constant PERIOD    : integer := 360; -- Motor dönme periyodu (derece cinsinden)
    constant STEP_ANGLE: integer := 60; -- Faz geçiþ adým açýsý (derece cinsinden)
    
begin

    DUT : Motor_Control
    port map (
        Hall_State      => Hall_State,
        Clock           => Clock,
        Switch_Reset    => Switch_Reset,
        AHigh           => AHigh,
        ALow            => ALow,
        BHigh           => BHigh,
        BLow            => BLow,
        CHigh           => CHigh,
        CLow            => CLow
    );

    Clock_Process : process
    begin
        while now < 2 * PERIOD * 2 * STEP_ANGLE * 1 ns loop -- Ýki periyot boyunca test et
            Clock <= '0';
            wait for 5 ns;
            Clock <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process Clock_Process;

    Stimulus_Process : process
    begin
        -- Her durumu test et
        for i in 0 to 11 loop
            case i is
                when 0 =>
                    Hall_State <= "100"; -- S4 durumu için Hall durumu
                when 1 =>
                    Hall_State <= "110"; -- S6 durumu için Hall durumu
                when 2 =>
                    Hall_State <= "010"; -- S2 durumu için Hall durumu
                when 3 =>
                    Hall_State <= "011"; -- S3 durumu için Hall durumu
                when 4 =>
                    Hall_State <= "001"; -- S1 durumu için Hall durumu
                when 5 =>
                    Hall_State <= "101"; -- S5 durumu için Hall durumu
                
                when 6 =>
                    Hall_State <= "100"; -- S4 durumu için Hall durumu
                when 7 =>
                    Hall_State <= "110"; -- S6 durumu için Hall durumu
                when 8 =>
                    Hall_State <= "010"; -- S2 durumu için Hall durumu
                when 9 =>
                    Hall_State <= "011"; -- S3 durumu için Hall durumu
                when 10 =>
                    Hall_State <= "001"; -- S1 durumu için Hall durumu
                when 11 =>
                    Hall_State <= "101"; -- S5 durumu için Hall durumu
                when others =>
                    null;
            end case;
            wait for 10 ns; -- Her durumda bir süre bekle
        end loop;
        switch_reset <='0';
        -- Testi bitir
        wait;
    end process Stimulus_Process;

end Behavioral;
