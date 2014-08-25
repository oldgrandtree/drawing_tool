require 'rspec'
require 'drawing_tool'

describe Canvas do
  subject(:canvas) {Canvas.new(20, 4)}
  describe "#initialize" do
    it "initializes a canvas with the correct dimensions" do
      expect(canvas.render).to eq(
        ["-" * 22] + (["|#{" " * 20}|"] * 4) + ["-" * 22]
      )
    end
  end
end