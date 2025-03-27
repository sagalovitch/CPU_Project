onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/clock
add wave -noupdate -radix hexadecimal /DataPath_tb/Present_state
add wave -noupdate -radix hexadecimal /DataPath_tb/PCout
add wave -noupdate -radix hexadecimal /DataPath_tb/MARin
add wave -noupdate -radix hexadecimal /DataPath_tb/IncPC
add wave -noupdate -radix hexadecimal /DataPath_tb/Zin
add wave -noupdate -radix hexadecimal /DataPath_tb/Zlowout
add wave -noupdate -radix hexadecimal /DataPath_tb/PCin
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/PC_data_out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/MDRout
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IR/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IR/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IR/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Gra
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Rout
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Yin
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Cout
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/Add
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R1out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/R1in
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/conIn
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/conOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInPC
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/PC_data_out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/clock
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/IncPC
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/PC_enable
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/busIn
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/c2
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/conIn
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/clock
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/conOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/decoder_out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/isZero
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/isNeg
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/myConFF/isPos
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {191954 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 253
configure wave -valuecolwidth 61
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
WaveRestoreZoom {0 ps} {272817 ps}
