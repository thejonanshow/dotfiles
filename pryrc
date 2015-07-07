Pry::Commands.command /^$/, "repeat" do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end
