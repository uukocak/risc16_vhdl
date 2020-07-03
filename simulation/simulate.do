quit -sim
# Simulate
vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc" -nowlfdeleteonquit $1

# Add wave signals and run all
switch $argc {
 0 {echo Indicate file to simulate as a parameter}
 1 {add wave *}
 2 {do $2 }
 default {echo Too many arguments. The macro accepts 1-2 args. }
}
view structure
view signals
run -all
