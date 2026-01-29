# sar

## Version und Hilfe

Version:
```bash
sar -V
```

Hilfe:
```bash
sar --help | less
```

allgemeiner Aufruf:
```bash
sar OPTIONEN [ interval [ count ] ]
```

## Alles sehen

```bash
sar -A = sar -bBdFHISvwWy -m ALL -n ALL -q ALL -r ALL -u ALL
```

## Einzelheiten sehen

```bash
sar -b # Bytes -> I/O transfer rates
sar -B # paging
sar -d # Device -> block device
sar -F [ MOUNT ] # Filesystem
sar -H # Hugepages
sar -I [ SUM | ALL ] # Interrupts
sar -S # Swap
sar -v # inode, file and other kernel tables
sar -w # sWitching activity and task creation
sar -W # sWapping statistics
sar -y # ttY activity
sar -m { keyword[,...] | ALL } # power Management statistics (BAT, CPU, FAN, FREQ, IN, TEMP, USB)
sar -n { keyword[,...] | ALL } # Network statistics (DEV, EDEV, FC, ICMP, EICMP, ICMP6, EICMP6, IP, EIP, IP6, EIP6, NFS, NFSD, SOCK, SOCK6, SOFT, TCP, ETCP, UDP and UDP6)
sar -q [ keyword[,...] | ALL ] # Queue (pressure) statistics (CPU, IO, LOAD, MEM, PSI)
sar -r [ ALL ] # memoRy
sar -u [ ALL ] # cpU utilization 
```

## weitere Optionen

```bash
sar -C # When reading data from a file, tell sar to display comments that have been inserted by sadc.
sar -D # Use saYYYYMMDD instead of saDD as the standard system activity daily data file name.
sar -h # equivalent to specifying --pretty --human.
sar -t # timestamps in local time 
sar -x # Extended reports: Display minimum and maximum values in addition to average ones at the end of the report.
sar -z # omit output for any devices for which there was no activity during the sample period.
sar --dec={ 0 | 1 | 2 } # Specify the number of decimal places to use (0 to 2, default value is 2).
sar --dev=dev_list # Specify the block devices for which statistics are to be displayed by sar.
sar --fs=fs_list # Specify the filesystems for which statistics are to be displayed by sar. 
sar --human # Print sizes in human readable format
sar --iface=iface_list # Specify the network interfaces
sar --int=int_list # Specify the interrupts names
sar -p | --pretty # Make reports easier to read by a human.
sar --sadc # Indicate which data collector is called by sar.
sar -P { cpu_list  |  ALL } # Processor statistics for specified processor; list of comma-separated values or range of values (e.g., 0,2,4-7,12-).
sar -j { SID | ID | LABEL | PATH | UUID | ... } # Display persistent device names. 
sar -f [ filename ] # Extract records from filename (created by the -o filename flag).
sar -o [ filename ] | -[0-9]+ # Save the readings in the file in binary form.
sar -i interval ] # 
sar -s [ hh:mm[:ss] ] | [ seconds_since_the_epoch ] # Set the starting time of the data
sar -e [ hh:mm[:ss] ] | [ seconds_since_the_epoch ] # Set the ending time of the report.
```
