Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

Pry::Commands.command /^$/, "repeat" do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end
