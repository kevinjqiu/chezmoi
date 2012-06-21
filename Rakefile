DOT_BASH_READONLY_URL="git://github.com/kevinjqiu/dot_bash.git"
DOT_VIM_READONLY_URL="git://github.com/kevinjqiu/vimmy.git"

def _link(src, target, msg)
  cmd = "ln -s `pwd`/#{src} #{target}"
  if system(cmd)
    puts msg
  else
    puts "`#{cmd}` failed"
  end
end

desc "Link dot files"
task :link, :target do |t, args|
  LINK_CANDIDATES = {
    'bin' => 'bin',
    'gitconfig' => '.gitconfig',
    'inputrc' => '.inputrc',
    'tmux.conf' => '.tmux.conf',
    'dot_xmonad' => '.xmonad'
  }

  src = args[:target]
  target = "#{ENV['HOME']}/#{LINK_CANDIDATES[src]}"
  _link src, target, "#{target} linked"
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

