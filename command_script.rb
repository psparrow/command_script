require_relative './lib/command_script/command_set'
require_relative './lib/command_script'
require_relative './lib/command_script/command'
require_relative './lib/command_script/profile'

extend CommandScript::DSL

command :var, name: nil, value: nil do
  profile.set(name, value)
end

command :log, level: 'notice', message: '' do
  puts profile.sub_vars(message)
end

command :say_hello, to: 'World' do
  puts "Hello #{to}!"
end

command :add, values: [] do
  sum = 0

  values.each do |value|
    sum += value
  end

  puts sum
end
