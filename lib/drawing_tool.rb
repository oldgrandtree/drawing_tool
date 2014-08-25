class Canvas
  def initialize(x, y)  
    # this condition ensures @canvas.first is an array, avoiding an error in #valid_pos? if y was equal to 0
    raise "Invalid canvas size." unless [x,y].all? {|coord| coord > 0}
    
    @canvas = Array.new(y) { Array.new(x) }
  end
  
  def [](*pos)
    x, y = pos
    
    raise "You can't draw off the canvas." unless valid_pos?(x, y)
    
    @canvas[y][x]
  end

  def []=(*pos, color)
    x, y = pos
    
    raise "You can't draw off the canvas." unless valid_pos?(x, y)
    
    @canvas[y][x] = color
  end
  
  def valid_pos?(x, y)
    x.between?(0, @canvas.first.length - 1) && y.between?(0, @canvas.length - 1)
  end
  
  def draw_line(x1, y1, x2, y2)
    self
  end
  
  def render
    output = []
    output << ("-" * (@canvas.first.length + 2))
    @canvas.each do |line| 
      output << "|#{line.map {|square| square || " "}.join}|"
    end
    output << ("-" * (@canvas.first.length + 2))
  end
  
  def display
    puts render
  end
end

c = Canvas.new(3,4)
c.hey