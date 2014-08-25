require 'rspec'
require 'canvas'

describe Canvas do
  subject(:canvas) {Canvas.new(20, 4)}
  
  describe "#initialize" do
    it "initializes a canvas with the correct dimensions" do
      expect(canvas.render).to eq([
      "----------------------", 
      "|                    |",
      "|                    |",
      "|                    |",
      "|                    |",
      "----------------------"
    ])
    end
  
    it "raises error when invalid dimensions are given" do
      expect {Canvas.new(0, 8)}.to raise_error("Invalid canvas size.")
      expect {Canvas.new(1, -3)}.to raise_error("Invalid canvas size.")
    end
  end
  
  describe "#draw_line" do
    it "draws a horizontal line" do
      # the user's coordinates will begin at origin (1, 1), but our code will refer to the origin as (0, 0)
      expect(canvas.draw_line(0, 1, 5, 1).render).to eq([
        "----------------------", 
        "|                    |",
        "|xxxxxx              |",
        "|                    |",
        "|                    |",
        "----------------------"
      ])
    end
    
    it "draws a vertical line" do
      expect(canvas.draw_line(5, 2, 5, 3).render).to eq([
        "----------------------", 
        "|                    |",
        "|                    |",
        "|     x              |",
        "|     x              |",
        "----------------------"
      ])
    end
    
    it "raises error if line is drawn off the canvas" do
      expect {canvas.draw_line(1, 2, 3, 40)}.to raise_error(
        "You can't draw off the canvas."
      )
    end
    
    it "raises error if line is not orthogonal (i.e. it is diagonal)" do
      expect {canvas.draw_line(1, 2, 3, 3)}.to raise_error(
        "Draw Line doesn't support diagonal lines (yet!)"
      )
    end
  end
  
  describe "#draw_rect" do
    it "draws a rectange" do
      expect(canvas.draw_rect(15, 0, 19, 2).render).to eq([
        "----------------------", 
        "|               xxxxx|",
        "|               x   x|",
        "|               xxxxx|",
        "|                    |",
        "----------------------"
      ])
    end
    
    it "doesn't allow drawing off the canvas" do
      expect {canvas.draw_rect(1, 2, 3, 40)}.to raise_error(
        "You can't draw off the canvas."
      )
    end
  end
  
  let(:drawn_canvas) do 
    canvas.draw_line(0, 1, 5, 1)
          .draw_line(5, 2, 5, 3)
          .draw_rect(15, 0, 19, 2)
  end
  
  it "displays board correctly after multiple drawings" do
    expect(drawn_canvas.render).to eq([
      "----------------------", 
      "|               xxxxx|",
      "|xxxxxx         x   x|",
      "|     x         xxxxx|",
      "|     x              |",
      "----------------------"
    ])
  end
  
  describe "#fill" do
    it "fills the board" do
      expect(drawn_canvas.fill(9, 2, "o").render).to eq([
        "----------------------", 
        "|oooooooooooooooxxxxx|",
        "|xxxxxxooooooooox   x|",
        "|     xoooooooooxxxxx|",
        "|     xoooooooooooooo|",
        "----------------------"
      ])
    end
    
    it "doesn't allow drawing off the canvas" do
      expect {canvas.fill(3, 40, "o")}.to raise_error(
        "You can't draw off the canvas."
      )
    end
  end
  
  describe ".create_from_command" do
    it "creates a canvas" do
      expect(Canvas.create_from_command("C 3 4")
                   .instance_variable_get("@canvas")
      ).to eq(Array.new(4) { Array.new(3) })
    end
    
    it "raises error on invalid input" do
      expect {Canvas.create_from_command("C3 4")}.to raise_error(
        "Invalid canvas."
      )
      
      expect {Canvas.create_from_command("C 3 D")}.to raise_error(
        "Invalid canvas size."
      )
    end
  end
  
  describe "#process_command" do 
    it "processes a draw line command" do
      expect(blank_canvas.process_command("L 1 2 6 2").render).to eq(
        "----------------------", 
        "|                    |",
        "|xxxxxx              |",
        "|                    |",
        "|                    |",
        "----------------------"
      )
    end
    
    it "processes a draw rectange command" do
      expect(blank_canvas.process_command("R 16 1 2 0 3").render).to eq(
        "----------------------", 
        "|               xxxxx|",
        "|               x   x|",
        "|               xxxxx|",
        "|                    |",
        "----------------------"
      )
    end
    
    it "processes a fill command" do
      expect(drawn_canvas.process_command("B 10 3 o").render).to eq(
        "----------------------", 
        "|oooooooooooooooxxxxx|",
        "|xxxxxxooooooooox   x|",
        "|     xoooooooooxxxxx|",
        "|     xoooooooooooooo|",
        "----------------------"
      )
    end
    
    it "tells the user when he/she gives bad input" do
      expect {drawn_canvas.process_command("E 10 3 o")}.to eq("Bad command!")
      expect {drawn_canvas.process_command("B 10")}.to eq("Bad command!")
    end
  end
end