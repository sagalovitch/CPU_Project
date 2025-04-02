onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /DataPath_tb/Clock
add wave -noupdate -radix hexadecimal /DataPath_tb/Clear
add wave -noupdate -radix hexadecimal /DataPath_tb/Stop
add wave -noupdate -radix hexadecimal /DataPath_tb/Outport_Out
add wave -noupdate -radix hexadecimal /DataPath_tb/Inport_In
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R0
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R1
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R2
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R3
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R4
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R5
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R6
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R7
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R8
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R9
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R10
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R11
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R12
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R13
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R14
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_R15
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_MDR
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MARoutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_HI
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_LO
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_Zhigh
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_Zlow
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IRout
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/BusMuxIn_PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {159070 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 199
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1189870 ps}
