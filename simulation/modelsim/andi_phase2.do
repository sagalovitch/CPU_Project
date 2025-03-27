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
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/enable
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Zlo/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Zlo/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/and_32/Ra
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/and_32/Rb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14792 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 113
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
WaveRestoreZoom {0 ps} {262085 ps}
