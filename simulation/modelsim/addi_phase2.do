onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /DataPath_tb/Clock
add wave -noupdate -radix hexadecimal /DataPath_tb/Clear
add wave -noupdate -radix hexadecimal /DataPath_tb/Read
add wave -noupdate -radix hexadecimal /DataPath_tb/Gra
add wave -noupdate -radix hexadecimal /DataPath_tb/Grb
add wave -noupdate -radix hexadecimal /DataPath_tb/Grc
add wave -noupdate -radix hexadecimal /DataPath_tb/Rin
add wave -noupdate -radix hexadecimal /DataPath_tb/Rout
add wave -noupdate -radix hexadecimal /DataPath_tb/BAout
add wave -noupdate -radix hexadecimal /DataPath_tb/HIout
add wave -noupdate -radix hexadecimal /DataPath_tb/HIin
add wave -noupdate -radix hexadecimal /DataPath_tb/LOout
add wave -noupdate -radix hexadecimal /DataPath_tb/LOin
add wave -noupdate -radix hexadecimal /DataPath_tb/Zhighout
add wave -noupdate -radix hexadecimal /DataPath_tb/Zlowout
add wave -noupdate -radix hexadecimal /DataPath_tb/Zin
add wave -noupdate -radix hexadecimal /DataPath_tb/Yin
add wave -noupdate -radix hexadecimal /DataPath_tb/MDRout
add wave -noupdate -radix hexadecimal /DataPath_tb/MDRin
add wave -noupdate -radix hexadecimal /DataPath_tb/MARin
add wave -noupdate -radix hexadecimal /DataPath_tb/PCout
add wave -noupdate -radix hexadecimal /DataPath_tb/PCin
add wave -noupdate -radix hexadecimal /DataPath_tb/IRin
add wave -noupdate -radix hexadecimal /DataPath_tb/IncPC
add wave -noupdate -radix hexadecimal /DataPath_tb/Cout
add wave -noupdate -radix hexadecimal /DataPath_tb/opcode
add wave -noupdate -radix hexadecimal /DataPath_tb/Present_state
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R5/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R5/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R5/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R6/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R6/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R6/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/A
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/B
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/Cin
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/Sum
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/Cout
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/add_32/Overflow
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/enable
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/RegisterOutput
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160899 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 267
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {595688 ps}
