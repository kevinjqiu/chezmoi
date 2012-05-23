# DOT_VIM_URLS = {
#   ro:"https://kevinjqiu@github.com/kevinjqiu/vimmy.git",
#   rw:"git://github.com/kevinjqiu/vimmy.git"
# }
DOT_BASH_READONLY_URL="git://github.com/kevinjqiu/dot_bash.git"
DOT_VIM_READONLY_URL="git://github.com/kevinjqiu/vimmy.git"

def _link(src, target, msg)
  cmd = "ln -s #{src} #{target}"
  if system(cmd)
    puts msg
  else
    puts "`#{cmd}` failed"
  end
end

desc "Link dot files"
task :link do
  LINK_CANDIDATES = [
    ['bin', 'bin'],
    ['inputrc', '.inputrc'],
    ['tmux.conf', '.tmux.conf']
  ]

  LINK_CANDIDATES.each do |(src, target)|
    target = "#{ENV['HOME']}/#{target}"
    _link(src, target, "#{target} linked")
  end
end

desc "Install dot_bash"
task :dot_bash do
  unless File.directory? 'dot_bash'
    if system("git clone #{DOT_BASH_READONLY_URL}")
      system('cd dot_bash && ./install.sh')
    end
  else
    puts "dot_bash already exists"
  end
end

desc "Install vimmy"
task :vimmy do
  unless File.directory? 'vimmy'
    if system("git clone #{DOT_VIM_READONLY_URL}")
      system("cd vimmy && rake bootstrap")
    end
  else
    puts "vimmy already exists"
  end
end

