Config { font = "xft:Terminus-9"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Top
       , lowerOnStart = True
       , commands = [ Run Network "enp0s25" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Network "wlp3s0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run BatteryP ["BAT0"]
                                   ["-t", "<acstatus><watts> (<left>%)",
                                    "--", "-O", "<fc=green>On</fc> -", "-i", "",
                                    "-L", "-15", "-H", "-5",
                                    "-l", "red", "-m", "blue", "-h", "green"]
                                   600
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% } { %cpu% | %memory% | %battery% | %enp0s25% - %wlp3s0% | <fc=#ee9a00>%date%</fc>| %whoami%"
       }
