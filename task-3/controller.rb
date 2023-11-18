require 'fcntl'
require 'io/wait'
require 'pathname'

def handle_sigusr1(signum, _frame)
  puts "Produced: #{@produced}"

  $stdout.flush
end

pipe1_to_0 = IO.pipe
pipe0_to_2 = IO.pipe
pipe2_to_0 = IO.pipe

Signal.trap(:USR1, method(:handle_sigusr1))

p1 = fork do
  pipe1_to_0[0].close
  $stdout.reopen(pipe1_to_0[1])

  producer_script = File.join(File.dirname(File.absolute_path(__FILE__)), 'producer.rb')
  exec('ruby', producer_script)
end

p2 = fork do
  pipe0_to_2[1].close
  $stdin.reopen(pipe0_to_2[0])
  pipe2_to_0[0].close
  $stdout.reopen(pipe2_to_0[1])

  exec('/usr/bin/bc', 'bc')
end

pipe1_to_0[1].close
pipe0_to_2[0].close
pipe2_to_0[1].close

@produced = 0

loop do
  arithmetic_expression = pipe1_to_0[0].read_nonblock(1024, exception: false)
  break unless arithmetic_expression

  pipe0_to_2[1].puts(arithmetic_expression)

  result = pipe2_to_0[0].read_nonblock(1024, exception: false)
  puts "#{arithmetic_expression.strip} = #{result.strip}" if result

  @produced += 1
end

Process.kill('TERM', p1)
Process.kill('TERM', p2)
