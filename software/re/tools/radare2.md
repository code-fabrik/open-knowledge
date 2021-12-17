# Radare2

## Commands

* r2 filename: Load file
* i: Show information
* aaaa: Analyze
* iM: show main address
* afl: list functions
* s main: enter main function
* pdf: disassemble function
* VVV: enter gui mode

### Instructions

* MOVS: Copy string from source to destination, e.g. 
* STRB: Store byte from register in memory, e.g. STRB &lt;Rt&gt;, [&lt;Rn&gt;, &lt;Rm&gt;] with Rt=source register, Rn=base register, Rm=offset
* LDR: Load register with const or address, e.g. LDR register,=[expression | label-expression]
* B: Branch to label
