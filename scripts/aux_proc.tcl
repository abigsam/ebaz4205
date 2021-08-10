
#Create batch cleanup file for remove unused Vivado folders/files
proc create_prj_cleanup { prj_path prj_name } {
    set bfile_path ${prj_path}/xcleanup.bat

    set fid [open ${bfile_path} w]
    
    puts $fid {del "%~dp0\*.jou"}
    puts $fid {del "%~dp0\*.log"}
    puts $fid {del "%~dp0\*.dmp"}
    puts $fid {del "%~dp0\*.str"}

    puts $fid {rmdir /s /q "%~dp0\.Xil"}

    set strg "rmdir /s /q \"%~dp0\\"
    set strg ${strg}${prj_name}
    append strg ".cache\""
    puts $fid ${strg}

    close $fid
}