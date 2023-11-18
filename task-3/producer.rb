#!/usr/bin/ruby

def generate_random_number(min, max)
  rand(min..max)
end

def generate_random_operator
  operators = ['+', '-', '*', '/']
  operators.sample
end

N = generate_random_number(120, 180)

N.times do
  x = generate_random_number(1, 9)
  y = generate_random_number(1, 9)
  operator = generate_random_operator()

  expression = "#{x} #{operator} #{y}"
  puts expression
  $stdout.flush

  sleep(1)
end

exit(0)
