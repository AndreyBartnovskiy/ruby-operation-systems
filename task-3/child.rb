#!/usr/bin/ruby

if ARGV.length != 1
  puts "Usage: ruby child.rb <S>"
  exit(1)
end

sleep_time = ARGV[0].to_i
pid = Process.pid
ppid = Process.ppid

puts "Child[#{pid}]: I am started. My PID #{pid}. Parent PID #{ppid}."

sleep(sleep_time)
exit_status = [0, 1].sample

puts "Child[#{pid}]: I am ended. PID #{pid}. Parent PID #{ppid}."
exit(exit_status)
