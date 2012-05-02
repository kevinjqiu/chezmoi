import os
from fabric.colors import yellow
from fabric.colors import green

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
        print(yellow("dot_bash folder already exists. Skipping"))
        return
    print(green("Fetch dot_bash..."))
    os.system("git clone %s" % DOT_BASH_URLS.get('ro' if readonly else 'rw'))
    print(green("Install dot_bash..."))
    os.system('dot_bash/install.sh')

def vim(readonly=False):
    """Bring in and setup my vim related customizations"""
    pass
