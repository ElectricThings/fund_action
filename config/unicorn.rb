APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

worker_processes (ENV['UNICORN_WORKERS'] || 4).to_i
working_directory APP_ROOT

preload_app true

timeout 30

listen APP_ROOT + "/tmp/pids/unicorn.sock", :backlog => 64

PIDFILE = ENV['PID'] || (APP_ROOT + "/tmp/pids/unicorn.pid")
pid PIDFILE

stderr_path APP_ROOT + "/log/unicorn.stderr.log"
stdout_path APP_ROOT + "/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = PIDFILE + '.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Old master already dead"
    end
  end
end

#require APP_ROOT+'/lib/scheduler'
#scheduler_pid_file = File.join(APP_ROOT, "tmp/pids/scheduler").to_s

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
  child_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
  system("echo #{Process.pid} > #{child_pid}")

#  Scheduler::start_unless_running scheduler_pid_file
end


