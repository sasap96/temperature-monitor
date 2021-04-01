library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity on_off_ds18xx is
    Port (clock_50	: IN	STD_LOGIC;
          enable 	: IN	STD_LOGIC;
			 --sw      : IN STD_LOGIC_VECTOR(9 downto 0);
			 measure_period: IN std_logic_vector(6 downto 0);    -- za sad 4 bita kasnije 7 vjerovatno
			 measure :  IN STD_LOGIC;
			 --ledr   :out std_logic_vector(9 downto 0);
			 power  :out std_logic;
			 POWER_PIN  :  OUT STD_LOGIC
	 );
end on_off_ds18xx;

architecture Behavioral of on_off_ds18xx is

SIGNAL i			: INTEGER RANGE 0 TO 100;
SIGNAL reset_timer	: STD_LOGIC :='0';
SIGNAL clk1s :std_logic ;
SIGNAL s       :STD_LOGIC_VECTOR(2 downto 0); 
SIGNAL taster  :STD_LOGIC_VECTOR(2 downto 0);
SIGNAL temp :std_logic_vector (3 downto 0);
SIGNAL measure_period_int:INTEGER;

component divider1Hz is
    Port ( clk_in 	: IN	STD_LOGIC;
           clk_out 	: OUT	STD_LOGIC
	 );
end component;


begin

U2: divider1Hz PORT MAP(
		clk_in => CLOCK_50,
		clk_out => clk1s
	);
	process (clock_50)

	begin
if rising_edge(clock_50) then	
	--if(sw(9)='1') then                      -- enable citav sklop
	if(enable='1') then 	                -- enable citav sklop
	   measure_period_int <= to_integer(unsigned(measure_period));  -- suvisno kasnije ce doci kao int
		--if(continual_measure/='1') then  -- ako nije kontinualno mjerenje
		--if(sw(0) /='1') then
			
			case measure_period_int is
			
				when 1 to 99 =>        -- ako je interval mjerenja od 1 do 99 tad upalimo pin 
					if i=measure_period_int-1 then  
						POWER_PIN<='1';
						power<='1';
					elsif i=(measure_period_int+1) then  -- sacekamo 2s i ugasimo pin i resetujemo tajmer
						POWER_PIN<='0';
						power<='0';
						reset_timer<='1';	
						
					else		
						reset_timer<='0';
					end if;
				when others =>
				  			
					taster<=(taster(taster'left-1 downto 0))& (measure);
					if (taster(taster'left downto taster'left-1)="10") then
							reset_timer<='0';
						  POWER_PIN<='1';
							power<='1';
					end if;
					if i=3 then
						POWER_PIN<='0';
						power<='0';
						reset_timer<='1';
					end if;
					
			end case;
		--else                 -- ako je kontinualno onda samo drzi visoko pin
			--gpio_0(1)<='1';
			
	--	end if;
	else
		POWER_PIN<='0';
		power<='0';
		reset_timer<='1';
			
	end if;
end if;
	end process;
	
	
	process(clock_50, reset_timer)
	--process(clock_50, reset_timer,continual_measure)	
	begin
		
		if (rising_edge(clock_50)) then
			s<=(s(s'left-1 downto 0))& (clk1s);
		if (s(s'left downto s'left-1)="01") then
			--if (reset_timer = '1' or continual_measure='1')then		-- ako je reset
			if (reset_timer = '1' )then		-- ako je reset
				i <= 0;							-- vrati i na 0 	
				--reset_timer<='0';
				--ledr(0)<='1';
			else
				i <= i + 1;				      -- na svaku rastucu ivicu clk se uveca i
				--ledr(0)<='0';
			end if;
		end if;
	end if;
	end process;

end Behavioral;