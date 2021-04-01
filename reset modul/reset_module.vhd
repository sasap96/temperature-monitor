library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_module is
	port
	(
		-- Input ports
		config_mode	: in  std_logic;
		clk	: in  std_logic;
		button_a : in std_logic;
		button_b : in std_logic;
		button_c : in std_logic;
		button_d : in std_logic;
		-- Output ports
		reset	: out std_logic
	);
end reset_module;


architecture reset_module_arch of reset_module is

constant CONSTANT_1HZ : natural := 50000000;
signal counter : natural range 0 to CONSTANT_1HZ;
signal tik : natural range 0 to 11;

signal ed_button_a : std_logic_vector(1 downto 0):="00";
signal ed_button_b : std_logic_vector(1 downto 0):="00";
signal ed_button_c : std_logic_vector(1 downto 0):="00";
signal ed_button_d : std_logic_vector(1 downto 0):="00";

begin

process(clk)
begin
if(clk'event and clk='1')then
		ed_button_a<=ed_button_a(0) & button_a;
		ed_button_b<=ed_button_b(0) & button_b;
		ed_button_c<=ed_button_c(0) & button_c;
		ed_button_d<=ed_button_d(0) & button_d;
end if;
end process;

process(clk)
begin
if(rising_edge(clk)) then
	if(config_mode='0') then
		if(counter=CONSTANT_1HZ-1) then
			counter<=0;
			if(tik<10 ) then
				tik<=tik+1;
			else
				tik<=0;
			end if;
		else
			counter<=counter+1;
			if(ed_button_a="01" or ed_button_b="01" or ed_button_c="01" or ed_button_d="01") then
				tik<=0;
			end if;
		end if;
	else
		counter<=0;
		tik<=0;
   end if;
end if;
end process;
reset <= '1' when config_mode='0' and tik=9 else
			'0';

end reset_module_arch;