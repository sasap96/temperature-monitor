library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CRC is
    Port (	clk			: IN	STD_LOGIC;
				enable      : IN STD_LOGIC;
				data_en		: IN	STD_LOGIC;
				dataIn 		: IN	STD_LOGIC_VECTOR (71 downto 0);
				dataOut	 	: OUT	STD_LOGIC_VECTOR (15 downto 0);
				dataValid	: OUT STD_LOGIC
	 );
end CRC;

architecture Behavioral of CRC is

-- primljeni podaci sa senzora + primljeni CRC
SIGNAL data : STD_LOGIC_VECTOR(71 downto 0);

-- stanja FSM
TYPE STATE_TYPE IS (IDLE, CRC_CALC, CRC_CHECK);
-- trenutna stanja FSM
SIGNAL crc_state: STATE_TYPE;
SIGNAL clock_1mhz : STD_LOGIC_VECTOR(2 downto 0);

begin
	-- Proces za izračunavanje i provjeru CRC-a primljenih podataka 
	process(clk)
	
	-- dužina primljenih podataka u bitovima
	CONSTANT DATA_WIDTH_C	: INTEGER := 72;	

	VARIABLE i					: integer range 0 to DATA_WIDTH_C := 0;
	
	-- pomoćni registar za izračunavanje CRC-a 
	VARIABLE CRC_temp			: STD_LOGIC_VECTOR(7 downto 0);
	
	-- registar s izračunatim CRC-om 
	VARIABLE CRC_val			: STD_LOGIC_VECTOR(7 downto 0);
	
	-- izlazni podaci koji ukazuju na CRC grešku
	CONSTANT CRC_ERROR_C 		: STD_LOGIC_VECTOR(15 downto 0) := "0111111111111111";
	
	-- izlazni podaci koji pokazuju da nema veze ka senzoru
	CONSTANT PRESENCE_ERROR_C 	: STD_LOGIC_VECTOR(15 downto 0) := "0011111111111111";
	-- ulazni podaci koji pokazuju da nema veze senzora
	CONSTANT PRESENCE_ERROR_DATA_C : STD_LOGIC_VECTOR(71 downto 0) := "101010101010101010101010101010101010101010101010101010101010101010101010";
	
	
	begin
		
		if (rising_edge(clk)) then
			clock_1mhz<=(clock_1mhz(clock_1mhz'left-1 downto 0))& (enable);
		if (clock_1mhz(clock_1mhz'left downto clock_1mhz'left-1)="01") then
			case (crc_state) is
				when IDLE =>											
					dataValid <= '0';									-- poništavanje signala koji ukazuje na završetak računanja CRC-a
					if (data_en = '1') then							-- zahtjev za računanje CRC-a
						crc_state <= CRC_CALC;						
					end if;

				when CRC_CALC =>										
					if (i < DATA_WIDTH_C) then						-- nastavak postavljanja podataka u pomjerački registar						
						CRC_temp(7):= dataIn(i) XOR CRC_val(0);
						CRC_temp(2):= CRC_val(3) XOR (dataIn(i) XOR CRC_val(0));
						CRC_temp(3):= CRC_val(4) XOR (dataIn(i) XOR CRC_val(0));
						CRC_val(0) := CRC_val(1);
						CRC_val(1) := CRC_val(2);
						CRC_val(2) := CRC_temp(2);
						CRC_val(3) := CRC_temp(3);
						CRC_val(4) := CRC_val(5);
						CRC_val(5) := CRC_val(6);
						CRC_val(6) := CRC_val(7);
						CRC_val(7) := CRC_temp(7);
						i:=i+1;											
					else
						crc_state <= CRC_CHECK;						
					end if;

				when CRC_CHECK =>										
					if (CRC_val = "00000000") then				
						--dataOut <="0000"& dataIn(23 downto 16)&"0000";
						
						dataOut <= dataIn(15 downto 0); 			-- podaci su pravilno primljeni, izlaz postavljen na podatke koji sadrže izmjerenu temperaturu
					else													-- primljeni CRC nije isti kao izračunati
						if (dataIn /= PRESENCE_ERROR_DATA_C) then	-- ulazni podaci sadrže podatke sa senzora
							dataOut <= CRC_ERROR_C; 				-- podaci nisu primljeni ispravno, izlaz postavljen na vrijednost greške
						else
							dataOut <= PRESENCE_ERROR_C;			-- senzor nije spojen, izlaz postavljen na vrijednost greške
						end if;
					end if;
					CRC_temp	 := "00000000";						-- reset izračunatog CRC-a
					CRC_val   := "00000000";						-- reset pomoćnog registra
					i 			 := 0;									-- reset trenutno obrađenog bit-a
					dataValid <= '1';									-- indikacija završetka računanja CRC-a
					crc_state <= IDLE;								
			end case;
		end if;
	end if;
	end process;

end Behavioral;