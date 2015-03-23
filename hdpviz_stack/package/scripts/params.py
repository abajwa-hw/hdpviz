#!/usr/bin/env python
from resource_management.libraries.functions.version import format_hdp_stack_version, compare_versions
from resource_management import *

# server configurations
config = Script.get_config()

stack_dir = config['configurations']['hdpviz-config']['stack.dir']
stack_log = config['configurations']['hdpviz-config']['stack.log']
install_dir = config['configurations']['hdpviz-config']['install.dir']
stack_host = config['configurations']['hdpviz-config']['stack.host']
stack_port = config['configurations']['hdpviz-config']['stack.port']



