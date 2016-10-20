# /etc/unicorn/kakomon.ru
# this is configuration file for unicorn
# kumano dormitory kakomon system

working_directory "/srv/KAKOMON/Kakomon"
#pid "/tmp/pid/kakomon.pid"

preload_app true
timeout 60
worker_processes 2

# unix domain socket
listen 3000

# stdout_path "/var/log/unicorn/kakomon_unicorn_out.log"
# stderr_path "/var/log/unicorn/kakomon_unicorn_err.log"

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

#before_fork do |server, worker|
#  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
#  old_pid = "/tmp/pid/kakomon.pid.oldbin"

#  if old_pid != server.pid
#    begin
#      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
#      Process.kill(sig, File.read(old_pid).to_i)
#    rescue Errno::ENOENT, Errno::ESRCH
#    end
#  end
#end

#after_fork do |server, worker|
#  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
#end
