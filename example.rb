require_relative './command_script'

profile times: 5, seconds: 1 do
  var name: 'x', value: 1

  say_hello to: 'Zee'

  add values: [1, 2, 3]

  log message: 'x = {x}'
end
