import json
import os


TEMPLATE = """\
Host {host_name}
    StrictHostKeyChecking no
    HostName {host_ip}
    User ubuntu
    IdentityFile %d/.ssh/ubuntu.pem
"""


def get_friendly_host_name(host_name):
    friendly_host_name, _ = host_name.split('.', 1)
    return friendly_host_name


def main():
    PROFILE_DIR = os.path.expandvars("$HOME/src/pointsaws/profiles")
    profiles = [profile for profile in os.listdir(PROFILE_DIR)
                if profile.endswith('.json')]
    for profile in profiles:
        with open(os.path.join(PROFILE_DIR, profile)) as f:
            hosts = json.load(f)['environment']['hosts']
        for type_ in hosts.keys():
            for tier in hosts[type_].keys():
                for host_ip, host_name, subnet in hosts[type_][tier]:
                    friendly_host_name = get_friendly_host_name(host_name)
                    print TEMPLATE.format(host_name=friendly_host_name, host_ip=host_ip)


if __name__ == '__main__':
    main()
