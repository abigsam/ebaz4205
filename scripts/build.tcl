
#Configure project
set prj_name "ebaz4205"
set script_path [file dirname [file normalize [info script]]]
set part_name "xc7z010clg400-1"
set prj_path ${script_path}/../vivado
set constr_files ${script_path}/../board
set bd_name "design_1"
# set ps_name "proc_sys"

#Aux. processes
source ${script_path}/aux_proc.tcl

#Gets arguments
set use_gui 1
set exit_when_end 0
if { [llength $argv] > 0 } {
    if { [lindex $argv 0] == 0} {
        set use_gui 0
    }
}
if { [llength $argv] > 1 } {
    if { [lindex $argv 1] == 1} {
        set exit_when_end 1
    }
}

#Configure arguments
if { ${use_gui} > 0 } {
    start_gui
}

#Create project
create_project ${prj_name} ${prj_path} -part ${part_name} -force
source ${script_path}/ebaz4205.tcl
cr_bd_ebaz4205 "" ${bd_name}

#Make wrapper
set wrapper_path [make_wrapper -fileset sources_1 -files [ get_files -norecurse ${bd_name}.bd] -top]
add_files -norecurse -fileset sources_1 $wrapper_path

#Add constrains
add_files -fileset constrs_1 -norecurse ${constr_files}/ebaz4205_exported.xdc

#Create xcleanup.bat file
create_prj_cleanup ${prj_path} ${prj_name}

if { ${exit_when_end} > 0} {
    exit
}