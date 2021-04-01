library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity configuration_fsm is
	port
	(
		-- Input ports
		clk : in std_logic;
		up_next_button	: in  std_logic;
		down_mode_button : in  std_logic;
		set_button : in std_logic;
		reset : in std_logic_vector(1 downto 1);
		
		-- Output ports
		output : out std_logic_vector(9 downto 0):="0000000000";--izlaz za 7s displeje
		power : out std_logic;
		interval_out : out std_logic_vector(6 downto 0);
		preciznost_out : out std_logic_vector(1 downto 0);
		enable_out : out std_logic
	);
end configuration_fsm;

architecture configuration_fsm_arch of configuration_fsm is

type state is (idle,config,int_setup,prec_setup);
signal state_out,state_next : state;

signal ed_up_next : std_logic_vector(1 downto 0):="00";
signal ed_down_mode : std_logic_vector(1 downto 0):="00";
signal ed_set : std_logic_vector(1 downto 0):="00";

type parameter_type is (interval,precision);

signal int : integer := 0;
signal preciznost : integer := 0;
signal param : parameter_type := interval;
signal output_pom : std_logic_vector(9 downto 0):="0000000000";
signal power_on : std_logic;
signal enable : std_logic:='1';

signal next_int : integer;
signal next_preciznost : integer;
signal next_param : parameter_type;
signal next_output : std_logic_vector(9 downto 0):="0000000000";
signal next_power_on : std_logic:='0';
signal next_enable : std_logic;

begin

process(clk)
begin
if(clk'event and clk='1')then
		ed_up_next<=ed_up_next(0) & up_next_button;
		ed_down_mode<=ed_down_mode(0) & down_mode_button;
		ed_set<=ed_set(0) & set_button;
end if;
end process;

process(clk,reset)
begin
	if(reset="1") then
		state_out<=idle;
	elsif(clk'event and clk='1') then
		state_out<=state_next;
	end if;
end process;

process (clk)
begin
	if (rising_edge(clk)) then
		int <= next_int;
	end if;
end process;

process (clk)
begin
	if (rising_edge(clk)) then
		param <= next_param;
	end if;
end process;

process (clk)
begin
	if (rising_edge(clk)) then
		preciznost <= next_preciznost;
	end if;
end process;

process (clk)
begin
	if (rising_edge(clk)) then
		power_on <= next_power_on;
	end if;
end process;

process (clk)
begin
	if (rising_edge(clk)) then
		output_pom <= next_output;
	end if;
end process;

process (clk,reset)
begin
	if(reset="1")then
		enable<='1';
	elsif (rising_edge(clk)) then
		enable <= next_enable;
	end if;
end process;

process(clk,state_out)
begin
	case state_out is
		when idle=>
			next_output<=output_pom;
			next_power_on<='1';
			next_int<=int;
			next_preciznost<=preciznost;
			next_param<=param;
			next_enable<=enable;
			if ed_down_mode="01" then
				state_next<=config;
				next_enable<='0';
			else
				state_next<=idle;
			end if;
		when config=>
			next_output<=output_pom;
			next_power_on<='1';
			next_int<=int;
			next_preciznost<=preciznost;
			next_enable<=enable;
			if ed_up_next="01" and param=interval then
				next_param<=precision;
				state_next<=config;
				next_output<="010"&"1100100";--kodovano P
			elsif ed_up_next="01" and param=precision then
				next_param<=interval;
				state_next<=config;
				next_output<="010"&"1100101";--kodovano I
			elsif ed_set="01" then
				if param=interval then
					state_next<=int_setup;
					next_output<="100" & std_logic_vector(to_unsigned(int,7));
					next_param<=param;
				else
					state_next<=prec_setup;
					next_output<="011" & std_logic_vector(to_unsigned(preciznost,7));
					next_param<=param;
				end if;
			else
				next_param<=param;
				state_next<=config;
			end if;
		when int_setup=>
			next_enable<=enable;
			next_power_on<='0';
			next_preciznost<=preciznost;
			next_param<=param;
			next_output<="100" & std_logic_vector(to_unsigned(int,7));
			if ed_up_next="01" and int<99 then
				next_int<=int+1;
				state_next<=int_setup;
				next_output<="100" & std_logic_vector(to_unsigned(int+1,7));
			elsif ed_down_mode="01" and int>0 then
				next_int<=int-1;
				state_next<=int_setup;
				next_output<="100" & std_logic_vector(to_unsigned(int-1,7));
			elsif ed_set="01" then
				next_enable<='1';
				state_next<=idle;
				next_int<=int;
				next_output<="0000000000";
			else
				next_int<=int;
				state_next<=int_setup;
			end if;
		when prec_setup=>
			next_enable<=enable;
			next_power_on<='1';
			next_int<=int;
			next_param<=param;
			next_output<="011" & std_logic_vector(to_unsigned(preciznost,7));
			if ed_up_next="01" and preciznost<3 then
				next_preciznost<=preciznost+1;
				state_next<=prec_setup;
				next_output<="011" & std_logic_vector(to_unsigned(preciznost+1,7));
			elsif ed_down_mode="01" and preciznost>0 then
				next_preciznost<=preciznost-1;
				state_next<=prec_setup;
				next_output<="011" & std_logic_vector(to_unsigned(preciznost-1,7));
			elsif ed_set="01" then
				next_enable<='1';
				state_next<=idle;
				next_preciznost<=preciznost;
				next_output<="0000000000";
			else
				state_next<=prec_setup;
				next_preciznost<=preciznost;
			end if;
	end case;
end process;
interval_out<=std_logic_vector(to_unsigned(int,7));
preciznost_out<=std_logic_vector(to_unsigned(preciznost,7))(1 downto 0);
output<=output_pom;
power<=power_on;
enable_out<=enable;
end configuration_fsm_arch; 
