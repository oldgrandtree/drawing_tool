require 'debugger'

class Canvas
  DIRS = [[1, -1], [1, 0], [1, 1], [0, -1], [0, 1], [-1, -1], [-1, 0], [-1, 1]]
  
  def initialize(x, y)  
    # this condition ensures @canvas.first is an array, avoiding an error in #valid_pos? if y was equal to 0
    raise "Invalid canvas size." unless [x,y].all? {|coord| coord > 0}
    
    @canvas = Array.new(y) { Array.new(x) }
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
    unless valid_pos?(x1, y1) && valid_pos?(x2, y2)
      raise "You can't draw off the canvas."
    end
    
    unless x1 == x2 || y1 == y2
      raise "Draw Line doesn't support diagonal lines (yet!)"
    end
    
    if x1 != x2
      # horizontal line
      (x1..x2).each {|x| self[x, y1] = "x"}
    else
      # vertical line
      (y1..y2).each {|y| self[x1, y] = "x"}
    end
    
    self
  end
  
  def draw_rect(x1, y1, x2, y2)
    unless valid_pos?(x1, y1) && valid_pos?(x2, y2)
      raise "You can't draw off the canvas."
    end
    
    # draw horizontal lines
    (x1..x2).each do |x| 
      self[x, y1] = "x"
      self[x, y2] = "x"
    end
    
    # draw vertical lines
    (y1..y2).each do |y| 
      self[x1, y] = "x"
      self[x2, y] = "x"
    end
        
    self
  end
  
  def fill(x, y, color)
    #will raise error if (x, y) is off the board
    target_color = self[x, y]
    
    spaces_queue = [[x, y]]
    
    until spaces_queue.empty?
      current_space = spaces_queue.pop
      
      # if the current space in the queue has the color we are filling, fill it in with the new color and add its neighbors to the queue
      if valid_pos?(*current_space) && self[*current_space] == target_color
        self[*current_space] = color
        spaces_queue.concat(
          DIRS.map {|dx, dy| [current_space[0] + dx, current_space[1] + dy]}
        )
      end
    end 
    
    self
  end
end

