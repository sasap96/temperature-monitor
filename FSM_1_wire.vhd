library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_1_wire is
port
(
  clk             : IN STD_LOGIC;
  --clk1mhz			: IN		STD_LOGIC;

  dataOut			: OUT		STD_LOGIC_VECTOR(71 downto 0);
  ds_data_bus		: INOUT	STD_LOGIC;
  byte :IN STD_LOGIC;
  SIGNAL not_end :STD_LOGIC;
  SIGNAL presence_signal : STD_LOGIC ;
SIGNAL send_data :STD_LOGIC;
  precision_input : IN     STD_LOGIC_VECTOR(1 downto 0)
);
end FSM_1_wire;

architecture arch of FSM_1_wire is

-- stanja FSM
TYPE STATE_TYPE is (INITIALIZATION_SEQUENCE, PRESENCE, SEND, WRITE_BYTE, WRITE_LOW, WRITE_HIGH, GET_DATA, READ_BIT);
-- trenutno stanje FSM
SIGNAL state: STATE_TYPE;

begin


	process(clk,not_end,byte) 

	begin
	
	
		if rising_edge(clk) then
		--if(clk1mhz='1') then
			case	state is
				when INITIALIZATION_SEQUENCE =>																
					 
						state <= PRESENCE;												
			
				when PRESENCE =>															
					-- kad je senzor detektovan na magistrali
						if presence_signal='0' then
																
						state	  <= SEND;													
						else 
							state <=INITIALIZATION_SEQUENCE;
						end if;
				when SEND =>																 
	
						state 		  <= WRITE_BYTE;									
					                 				
					                          								

				when GET_DATA =>															
					
					if	(precision_input="00")	 then	
					state 		 <= READ_BIT;
					else 
					state <= INITIALIZATION_SEQUENCE;
					end if;	

				when READ_BIT =>															
																												
						state 		  <= GET_DATA;								
						
				when WRITE_BYTE =>													
																	
					if(not_end='0') then														
							if (byte = '0') then		
								state <= WRITE_LOW; 										
							else																
								state <= WRITE_HIGH;										
							end if;
							
					else 															
							if (send_data='1')	then								
                		state				<= SEND;	
							else
									state <=GET_DATA;
							end if;
					end if;											
													
				
				        
						
				when WRITE_LOW =>															
																
							state 		   <= WRITE_BYTE;								
																	
				when WRITE_HIGH =>														
															
							state 			 <= WRITE_BYTE;							
						
				when others =>																
					state <= INITIALIZATION_SEQUENCE;														
					
			end case;
		end if;
	
	end process;

	
end arch;