-- Copyright (C) 2016  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "01/23/2021 22:18:39"
                                                            
-- Vhdl Test Bench template for design  :  data_conv
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

library ieee;                                               
use ieee.std_logic_1164.all;                                
use ieee.numeric_std.all;

use std.textio.all;
use ieee.std_logic_textio.all;
                       

ENTITY data_conv_vhd_tst IS
END data_conv_vhd_tst;
ARCHITECTURE data_conv_arch OF data_conv_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL input : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL output0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL output1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL output2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL output3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL output4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL output5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL prec : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL sign : STD_LOGIC;
COMPONENT data_conv
	PORT (
	input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	output0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	output1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	output2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	output3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	output4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	output5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	prec : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	sign : OUT STD_LOGIC
	);
END COMPONENT;

file output_buf : text;
BEGIN
	i1 : data_conv
	PORT MAP (
-- list connections between master ports and signals
	input => input,
	output0 => output0,
	output1 => output1,
	output2 => output2,
	output3 => output3,
	output4 => output4,
	output5 => output5,
	prec => prec,
	sign => sign
	);
init : PROCESS                                               
-- variable declarations
 variable write_col_to_output_buf : line;
BEGIN
		file_open(output_buf, "data_files/data.csv", write_mode);
		write(write_col_to_output_buf, string'("input,prec,o0,o1,o2,o3,o4,o5,sign"));
		writeline(output_buf, write_col_to_output_buf);
		
      for j in 0 to 3 loop
		prec<=std_logic_vector(to_unsigned(j, prec'length));
			for i in 0 to 2048 loop
			input(10 downto 0)<=std_logic_vector(to_unsigned(i, 11));
			input(15 downto 11)<="00000";
			wait for 10 ns;
			write(write_col_to_output_buf, input);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, prec);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output0);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output1);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output2);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output3);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output4);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output5);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, sign);
			writeline(output_buf, write_col_to_output_buf);

			end loop;
		end loop;
		
      for j in 0 to 3 loop
		prec<=std_logic_vector(to_unsigned(j, prec'length));
			for i in 0 to 2048 loop
			input(10 downto 0)<=std_logic_vector(to_unsigned(i, 11));
			input(15 downto 11)<="11111";
			wait for 10 ns;
			write(write_col_to_output_buf, input);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, prec);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output0);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output1);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output2);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output3);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output4);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, output5);
			write(write_col_to_output_buf, string'(","));
			write(write_col_to_output_buf, sign);
			writeline(output_buf, write_col_to_output_buf);

			end loop;
		end loop;	 
WAIT;                                                       
END PROCESS init;                                           
                                        
END data_conv_arch;
