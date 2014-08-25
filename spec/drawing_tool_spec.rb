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
  
  describe "#draw_line" do
    it "draws a horizontal line" do
      # the user's coordinates will begin at origin (1, 1), but our code will refer to the origin as (0, 0)
      rendered_canvas = blank_canvas
      rendered_canvas[2] = ("x" * 6) + (" " * 14),
      expect(canvas.draw_line(0, 1, 5, 1).render).to eq(rendered_canvas)
    end
    

  end
end