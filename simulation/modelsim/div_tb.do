onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /DataPath_tb/Clock
add wave -noupdate -radix hexadecimal /DataPath_tb/Clear
add wave -noupdate -radix hexadecimal /DataPath_tb/Read
add wave -noupdate -radix hexadecimal /DataPath_tb/R2out
add wave -noupdate -radix hexadecimal /DataPath_tb/R2in
add wave -noupdate -radix hexadecimal /DataPath_tb/R6out
add wave -noupdate -radix hexadecimal /DataPath_tb/R6in
add wave -noupdate -radix hexadecimal /DataPath_tb/HIin
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
add wave -noupdate -radix hexadecimal /DataPath_tb/Mdatain
add wave -noupdate -radix hexadecimal /DataPath_tb/AND
add wave -noupdate -radix hexadecimal /DataPath_tb/opcode
add wave -noupdate -radix hexadecimal /DataPath_tb/Present_state
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInR2
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInR6
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInZhigh
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInZlow
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInHI
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInLO
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/A
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/B
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/C
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/opcode
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/div_out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/div_remainder
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {449629 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {472500 ps}
restart
run 450ns
