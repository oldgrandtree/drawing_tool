class Canvas
  def initialize(x, y)
    @canvas = Array.new(y) { Array.new(x) }
  end
end