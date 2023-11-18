#!/usr/bin/ruby

def child_process
  sleep_time = rand(5..10)
  child_script = File.join(File.dirname(File.absolute_path(__FILE__)), 'child.rb')
  args = [child_script, sleep_time.to_s]
  exec(child_script, *args, :unsetenv_others => true)

  puts "Child process failed to execute child.rb"
end

if ARGV.length != 1
  puts "Usage: ruby parent.rb <N>"
  exit(1)
end

N = ARGV[0].to_i
puts "Parent[#{Process.pid}]: I ran children processes."

child_processes = []

1.upto(N) do |i|
  pid = fork do
    child_process
  end

  child_processes << pid
end

child_processes.each do |child_pid|
  _, status = Process.waitpid2(child_pid, 0)

  if status.exited?
    exit_status = status.exitstatus
    if exit_status == 0
      puts "Parent[#{Process.pid}]: Child with PID #{child_pid} terminated. Exit Status #{exit_status}"
    else
      puts "Parent[#{Process.pid}]: Child with PID #{child_pid} terminated. Exit Status #{exit_status}"

      new_pid = fork do
        child_process
      end
    end
  end
end

puts "Parent[#{Process.pid}]: All children have terminated."
