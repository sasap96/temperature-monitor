library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity WIRE_1_MASTER is
    Port ( 
           CLOCK_50  : in STD_LOGIC;    -- podijelimo sa 50 jer je 1MHz = 1us mikrosekunda,
           Reset      : in    STD_LOGIC_vector(1 downto 1);       --  a vrijem senzora u mikrosekundama   
			  DATA_OUT: out STD_LOGIC_VECTOR(15 downto 0);
           IN_OUT_PIN     : inout  STD_LOGIC;
			  power     :in std_logic;
			  precision : in std_logic_vector(1 downto 0)
		--HEX0	: out std_logic_vector(6 downto 0);    -- displeji, 0 najlaksa, 5 najteza pozicija
		--HEX1  : out std_logic_vector(6 downto 0);
		--HEX2  : out std_logic_vector(6 downto 0);
		--HEX3  : out std_logic_vector(6 downto 0);
		--HEX4  : out std_logic_vector(6 downto 0);
		--HEX5  : out std_logic_vector(6 downto 0);
		
		--LEDR  : out std_logic_vector(9 downto 0);  -- sing, ako svijetli onda je minus
		--SW    : in  std_logic_vector(9 downto 0)  -- za podesavanje preciznosti		
		
			  );
end WIRE_1_MASTER;

architecture Behavioral of WIRE_1_MASTER is


   COMPONENT DS18xx
	PORT(
  clk             : IN STD_LOGIC;
  enable			   : IN		STD_LOGIC;  -- pojavljuje se sa frekvencijom od 1 MHz, tj 1us
  crc_en				: OUT		STD_LOGIC;
  dataOut			: OUT		STD_LOGIC_VECTOR(71 downto 0);
  ds_data_bus		: INOUT	STD_LOGIC;
  power           : in std_logic;
  config_data     : OUT    STD_LOGIC_VECTOR(7 downto 0);
  precision_input : IN     STD_LOGIC_VECTOR(1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT divider1MHz
	PORT(
		clk_in : IN std_logic;          
		clk_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT CRC
	PORT(
		clk : IN std_logic;
	   enable: IN std_logic;
		data_en : IN std_logic;
		power : in std_logic;
		dataIn : IN std_logic_vector(71 downto 0);          
		dataOut : OUT std_logic_vector(15 downto 0);
		dataValid : OUT std_logic
		);
	END COMPONENT;
	
	
SIGNAL CLK1MHZ	: STD_LOGIC;
SIGNAL DOK   	: STD_LOGIC;
signal REQUEST : STD_LOGIC;
SIGNAL DATA    : STD_LOGIC_VECTOR(71 downto 0);
--SIGNAL SET_PRECISION : STD_LOGIC_VECTOR(1 downto 0) :="11";
SIGNAL TEMPERATURE_REGISTER : STD_LOGIC_VECTOR (15 downto 0);
SIGNAL PREC_OUT : STD_LOGIC_VECTOR(1 downto 0) ;

begin
	
	U1: DS18xx PORT MAP(
		clk=>CLOCK_50,
		enable => CLK1MHZ,
		crc_en => DOK,
		dataOut => DATA,
		--power =>SW(0),
		power=>power,
		--precision_input=>precision_in,
		--precision_input=>SW(9 downto 8),
		precision_input=>precision,
		ds_data_bus => IN_OUT_PIN		
	);

	U2: divider1MHz PORT MAP(
		clk_in => CLOCK_50,
		clk_out => CLK1MHZ
	);

	U3: CRC PORT MAP(
		clk=> CLOCK_50,
		enable => CLK1MHZ,
		--clk=>CLK1MHZ,
		data_en => DOK,
		dataIn => DATA,
		--power =>SW(0),
		power=>power,
		dataOut=>DATA_OUT,
		--dataOut => TEMPERATURE_REGISTER,
		dataValid =>REQUEST 
	);

end Behavioral;
