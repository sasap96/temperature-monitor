

#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLOCK_50} -period 20.000 [get_ports {CLOCK_50}]


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {key[0]} ] -to [all_registers]
set_false_path -from [get_ports {key[1]} ] -to [all_registers]
set_false_path -from [get_ports {key[2]} ] -to [all_registers]
set_false_path -from [get_ports {key[3]} ] -to [all_registers]

set_false_path -from [get_ports {GPIO_0[0]} ] -to [all_registers]
set_false_path -from [all_registers ] -to [get_ports {GPIO_1[0]}]
set_false_path -from [all_registers ] -to [get_ports {GPIO_0[0]}]

set_false_path -from [all_registers ] -to [get_ports {HEX5[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX5[6]}]

set_false_path -from [all_registers ] -to [get_ports {HEX4[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX4[6]}]

set_false_path -from [all_registers ] -to [get_ports {HEX3[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX3[6]}]

set_false_path -from [all_registers ] -to [get_ports {HEX2[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX2[6]}]

set_false_path -from [all_registers ] -to [get_ports {HEX1[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX1[6]}]

set_false_path -from [all_registers ] -to [get_ports {HEX0[0]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[1]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[2]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[3]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[4]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[5]}]
set_false_path -from [all_registers ] -to [get_ports {HEX0[6]}]

set_false_path -from [all_registers ] -to [get_ports {LEDR[0]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[1]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[2]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[3]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[4]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[5]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[6]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[7]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[8]}]
set_false_path -from [all_registers ] -to [get_ports {LEDR[9]}]


