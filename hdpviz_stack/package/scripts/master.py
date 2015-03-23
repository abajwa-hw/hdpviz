import sys, os, pwd, signal, time
from resource_management import *
from subprocess import call

class Master(Script):
  def install(self, env):
    # Install packages listed in metainfo.xml
    self.install_packages(env)
    self.configure(env)
    import params
    #import status_params
    # Variable 'PROVIDERS' already exists more than once as a variable/configuration/kwarg parameter. Cannot evaluate it

    Execute('find '+params.stack_dir+' -iname "*.sh" | xargs chmod +x')
    Execute('echo "Running ' + params.stack_dir + '/package/scripts/setup.sh"')
    
    # run setup script which has simple shell setup
    Execute(params.stack_dir + '/package/scripts/setup.sh '+params.install_dir+' '+str(params.stack_host)+' '+str(params.stack_port)+' >> ' + params.stack_log)


  def configure(self, env):
    import params
    env.set_params(params)

  def stop(self, env):
    import params
    Execute(params.stack_dir + '/package/scripts/stop.sh >> ' + params.stack_log)
      
  def start(self, env):
    import params
    import status_params
    Execute(params.stack_dir + '/package/scripts/start.sh '+params.install_dir+' '+params.stack_log+' '+status_params.stack_pidfile+' >> ' + params.stack_log)


  def status(self, env):
    import status_params
    env.set_params(status_params)  
    check_process_status(status_params.stack_pidfile)    

      
if __name__ == "__main__":
  Master().execute()
