require_relative '../martabak.rb'

describe Martabak do
  it "is enak" do
    martabak = Martabak.new
    expect(martabak.taste).to(eq("martabak is enak"))
  end
end
