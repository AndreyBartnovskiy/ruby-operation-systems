#!/usr/bin/env ruby

EXEC_COMMAND = "./child"

n = ARGV[0].to_i fork do

end

def run_child
  pid = fork { exec("#{EXEC_COMMAND} #{rand(5..10)}") }

  puts "Parent[#{Process.pid}]: I ran children process with PID #{pid}."
  pid
end

child_pids = []
n.times do
  child_pids << run_child
end

loop do
  pid, status = Process.wait2

  exit_status = "Parent[#{Process.pid}]: Child with PID #{pid} terminated with exit status #{status.exitstatus}."

  if status.exitstatus != 0
    puts "#{exit_status}"

    child_pids.delete(pid)
    child_pids << run_child
  else
    puts "#{exit_status}"

    child_pids.delete(pid)
    break if child_pids.empty?
  end
end
