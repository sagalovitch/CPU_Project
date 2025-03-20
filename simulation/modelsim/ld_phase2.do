onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DataPath_tb/Clock
add wave -noupdate /DataPath_tb/Clear
add wave -noupdate /DataPath_tb/Read
add wave -noupdate /DataPath_tb/Gra
add wave -noupdate /DataPath_tb/Grb
add wave -noupdate /DataPath_tb/Grc
add wave -noupdate /DataPath_tb/Rin
add wave -noupdate /DataPath_tb/Rout
add wave -noupdate /DataPath_tb/BAout
add wave -noupdate /DataPath_tb/HIout
add wave -noupdate /DataPath_tb/HIin
add wave -noupdate /DataPath_tb/LOout
add wave -noupdate /DataPath_tb/LOin
add wave -noupdate /DataPath_tb/Zlowout
add wave -noupdate /DataPath_tb/Zin
add wave -noupdate /DataPath_tb/Yin
add wave -noupdate /DataPath_tb/MDRout
add wave -noupdate /DataPath_tb/MDRin
add wave -noupdate /DataPath_tb/MARin
add wave -noupdate /DataPath_tb/PCout
add wave -noupdate /DataPath_tb/PCin
add wave -noupdate /DataPath_tb/IRin
add wave -noupdate /DataPath_tb/IncPC
add wave -noupdate /DataPath_tb/Cout
add wave -noupdate /DataPath_tb/AND
add wave -noupdate /DataPath_tb/opcode
add wave -noupdate -radix unsigned /DataPath_tb/Present_state
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/A
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/B
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/C
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/C_sign_extended
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInZlow
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInR4
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInMDR
add wave -noupdate /DataPath_tb/DUT/selectEncode/instruction
add wave -noupdate /DataPath_tb/DUT/IRout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {142287 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
configure wave -valuecolwidth 180
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
WaveRestoreZoom {0 ps} {236250 ps}
