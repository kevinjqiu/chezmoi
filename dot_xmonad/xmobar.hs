Config { font = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "grey"
       , position = Top
       , lowerOnStart = True
       , commands = [ Run Weather "EGPF" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run Network "enp0s25" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Network "wlp3s0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% | %cpu% | %memory% | %enp0s25% - %wlp3s0% }{ <fc=#ee9a00>%date%</fc>| %EGPF% | %uname%"
       }
