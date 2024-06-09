library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Motor_Control is
    Port (
        Hall_State         : in std_logic_vector(2 downto 0);
        Clock              : in std_logic;
        Switch_Reset       : in std_logic;
        Ahigh              : out std_logic;
        Alow               : out std_logic;
        Bhigh              : out std_logic;
        Blow               : out std_logic;
        Chigh              : out std_logic;
        Clow               : out std_logic
        

    );
end Motor_Control;

architecture Behavioral of Motor_Control is
    type State_Type is (S4, S6, S2, S3, S1, S5);
    signal Current_State, Next_State : State_Type;
    constant PERIOD : integer := 360; -- Motor dönme periyodu (derece cinsinden)
    constant STEP_ANGLE : integer := 60; -- Faz geçiþ adým açýsý (derece cinsinden)
    
begin
--     Durumlarý tanýmla
    process(Clock, Switch_Reset)
    begin
        if Switch_Reset = '0' then
            Current_State <= S4;
        elsif rising_edge(Clock) then
            Current_State <= Next_State;
        end if;
    end process;
    
    -- Hall durumlarýna göre bir sonraki durumu belirle
    process(Hall_State, Current_State)
    begin
        case Current_State is
            when S4 =>
                case Hall_State is
                    when "100" =>
                        Next_State <= S6;
                    when others =>
                        Next_State <= S5;
                end case;
            when S6 =>
                case Hall_State is
                    when "110" =>
                        Next_State <= S2;
                    when others =>
                        Next_State <= S4;
                end case;
            when S2 =>
                case Hall_State is
                    when "010" =>
                        Next_State <= S3;
                    when others =>
                        Next_State <= S6;
                end case;
            when S3 =>
                case Hall_State is
                    when "011" =>
                        Next_State <= S1;
                    when others =>
                        Next_State <= S2;
                end case;
            when S1 =>
                case Hall_State is
                    when "001" =>
                        Next_State <= S5;
                    when others =>
                        Next_State <= S3;
                end case;
            when S5 =>
                case Hall_State is
                    when "101" =>
                        Next_State <= S4;
                    when others =>
                        Next_State <= S1;
                end case;
            when others =>
                Next_State <= S4;
        end case;
    end process;
    
    -- Motor fazlarýný belirle
    process(Current_State)
    begin
        case Current_State is
            when S4 =>
                    Ahigh <= '0';
                    Alow  <= '0';
                    Bhigh <= '1';
                    Blow  <= '0';
                    Chigh <= '0';
                    Clow  <= '1';
                    
              
            when S6 =>
                     Ahigh <= '0';
                     Alow  <= '1';
                     Bhigh <= '1';
                     Blow  <= '0';
                     Chigh <= '0';
                     Clow  <= '0';
                     
              
            when S2 =>
                      Ahigh <= '0';
                      Alow  <= '1';
                      Bhigh <= '0';
                      Blow  <= '0';
                      Chigh <= '1';
                      Clow  <= '0';
                     
             
            when S3 =>
                     Ahigh <= '0';
                     Alow  <= '0';
                     Bhigh <= '0';
                     Blow  <= '1';
                     Chigh <= '1';
                     Clow  <= '0';
                     
            
           
            when S1 =>
            Ahigh <= '1';
            Alow  <= '0';
            Bhigh <= '0';
            Blow  <= '1';
            Chigh <= '0';
            Clow  <= '0';

            when S5 =>
             Ahigh <= '1';
             Alow  <= '0';
             Bhigh <= '0';
             Blow  <= '0';
             Chigh <= '0';
             Clow  <= '1';

            when others =>
              Ahigh <= '0';
              Alow  <= '0';
              Bhigh <= '0';
              Blow  <= '0';
              Chigh <= '0';
              Clow  <= '0';
               
        end case;
    end process;
    
end Behavioral;
