
def pip_install(egg_name)
  safe_exec("pip", "install proselint", "-V") do
    puts "Command 'pip' is not available"
    puts "Installing 'pip' using 'easy_install' ..."
    pretty_print(`sudo easy_install pip`, "easy_install: ")
  end
end

def bundle_install
  safe_exec("bundle", "install") do
    puts "Command 'bundle' is not available"
    puts "Installing 'bundle' using 'gem install' ..."
    pretty_print(`gem install bundler`, "gem: ")
  end
end

def safe_exec(command, command_args, command_check_args = "-v")
  execute_command = ->() { pretty_print(`#{command} #{command_args}`, "#{command}: ") }
  if system("#{command} #{command_check_args} 2>&1 1> /dev/null")
    execute_command.call()
  elsif block_given?
    yield
    execute_command.call()
  else
    puts "Error: command '#{command}' is not available"
    exit 1
  end
end

def pretty_print(message, prefix = "")
  puts message.split("\n").map { |line| "\t#{prefix}#{line}" }.join("\n")
end