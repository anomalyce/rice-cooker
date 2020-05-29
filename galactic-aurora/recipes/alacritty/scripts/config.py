#!/usr/bin/env python

import os, yaml, sys

cwd = os.path.dirname(os.path.realpath(__file__))
with open(cwd + '/../stubs/colours.yml', 'r') as newConfig:
    newConfigFile = newConfig.read()

with open(sys.argv[1] + '/alacritty.yml', 'r') as oldConfig:
    oldConfigFile = oldConfig.read()

newJson = yaml.safe_load(newConfigFile)
oldJson = yaml.safe_load(oldConfigFile)

oldJson['colors'] = newJson['colors']

print(oldJson['colors'])

# with open(sys.argv[1] + '/alacritty.yml', 'w') as yaml_file:
    # yaml_file.write(yaml.dump(oldJson, default_flow_style=False))
