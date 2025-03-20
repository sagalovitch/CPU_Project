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
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInZlow
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInR4
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/BusMuxInMDR
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/selectEncode/instruction
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IRout
add wave -noupdate /DataPath_tb/DUT/ram/memRead
add wave -noupdate /DataPath_tb/DUT/ram/memWrite
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/ram/address
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/ram/dataIn
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/ram/dataOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MAR/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MAR/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/PC_data_out
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/IncPC
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/PC_enable
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/BusMuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/PC/conOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/selectEncode/instruction
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/selectEncode/C_sign_extended
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/C_sign_extended
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/bus/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MDR_Mux/select
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MDR_Mux/Input1
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MDR_Mux/Input0
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MDR_Mux/MuxOut
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/MDR_Mux/q
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IR/RegisterInput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/IR/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/Y/RegisterOutput
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/A
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/B
add wave -noupdate -radix hexadecimal /DataPath_tb/DUT/alu/C
add wave -noupdate /DataPath_tb/DUT/selectEncode/R4in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R0out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R1out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R2out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R3out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R4out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R5out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R6out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R7out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R8out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R9out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R10out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R11out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R12out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R13out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R14out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R15out
add wave -noupdate /DataPath_tb/DUT/selectEncode/R0in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R1in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R2in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R3in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R4in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R5in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R6in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R7in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R8in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R9in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R10in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R11in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R12in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R13in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R14in
add wave -noupdate /DataPath_tb/DUT/selectEncode/R15in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43076 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
configure wave -valuecolwidth 134
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
WaveRestoreZoom {0 ps} {211581 ps}
