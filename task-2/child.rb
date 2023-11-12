#!/usr/bin/env ruby

sleep_time = ARGV[0].to_i

puts "Child[#{Process.pid}]: I am started. My PID #{Process.pid}. Parent PID #{Process.ppid}."

sleep(sleep_time)

puts "Child[#{Process.pid}]: I am ended. PID #{Process.pid}. Parent PID #{Process.ppid}."
exit(rand(0..1))
