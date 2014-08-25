require 'rspec'
require 'drawing_tool'

describe Canvas do
  subject(:canvas) {Canvas.new(20, 4)}
  let(:blank_canvas) do 
    [
      "----------------------", 
      "|                    |",
      "|                    |",
      "|                    |",
      "|                    |",
      "----------------------"
    ]
  end
  
  describe "#initialize" do
    it "initializes a canvas with the correct dimensions" do
      expect(canvas.render).to eq(blank_canvas)
    end
  
    it "raises error when invalid dimensions are given" do
      expect {Canvas.new(0, 8)}.to raise_error("invalid canvas size")
      expect {Canvas.new(1, -3)}.to raise_error("invalid canvas size")
    end
  end
end