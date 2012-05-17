import os
from fabric.colors import yellow
from fabric.colors import green
from fabric.operations import local
from fabric.context_managers import lcd

DOT_BASH_URLS = dict(
    ro="git://github.com/kevinjqiu/dot_bash.git",
    rw="https://kevinjqiu@github.com/kevinjqiu/dot_bash.git"
)

DOT_VIM_URLS = dict(
    ro="https://kevinjqiu@github.com/kevinjqiu/vimmy.git",
    rw="git://github.com/kevinjqiu/vimmy.git"
)

def bash(readonly=False):
    """Bring in and setup my bash related customizations"""
    if os.path.exists('dot_bash'):
        print(yellow("folder 'dot_bash' already exists. Skipping"))
        return
    print(green("Fetch dot_bash..."))
    os.system("git clone %s" % DOT_BASH_URLS.get('ro' if readonly else 'rw'))
    print(green("Install dot_bash..."))
    with lcd('dot_bash'):
        local('install.sh')

def vim(readonly=False):
    """Bring in and setup my vim related customizations"""
    if os.path.exists('vimmy'):
        print(yellow("folder 'vimmy' already exists. Skipping"))
        return
    print(green("Fetch vimmy..."))
    os.system("git clone %s" % DOT_VIM_URLS.get('ro' if readonly else 'rw'))
    print(green("Install vimmy"))

def _link(source, target, message):
    real_target = os.path.abspath(os.path.expanduser(target))
    if os.path.exists(real_target):
        target_backup = os.path.join(real_target, "bak")
        os.system('mv %s %s' % (real_target, target_backup))
        print(yellow("%s exists. Renamed to %s" % (real_target, target_backup)))
    os.system('ln -s %s %s' % (os.path.abspath(source), real_target))
    print(green(message))

def link():
    """Make symbolic links"""
    _link('bin', '~/bin', "~/bin linked")
    _link('inputrc', '~/.inputrc', ".inputrc linked")
    _link('tmux.conf', '~/.tmux.conf', ".tmux.conf linked")
