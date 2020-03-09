module Clipscript
  @@scripts = []
  @@drawers = []

  @@font = Font.new(30)

  COLORS = {
    0 => [0, 0, 0, 255], # black
    1 => [29, 43, 83, 255], # dark-blue
    2 => [126, 37, 83, 255], # dark-purple
    3 => [0, 135, 81, 255], # dark-green
    0 => [0, 0, 0, 255], # black
     1 => [29, 43, 83, 255], # dark-blue
     2 => [126, 37, 83, 255], # dark-purple
     3 => [0, 135, 81, 255], # dark-green
     4 => [171, 82, 54, 255], # brown
     5 => [95, 87, 79, 255], # dark-gray
     6 => [194, 195, 199, 255], # light-gray
     7 => [255, 241, 232, 255], # white
     8 => [255, 0, 77, 255], # red
     9 => [255, 163, 0, 255], # orange
    10 => [255, 236, 39, 255], # yellow
    11 => [0, 228, 54, 255], # green
    12 => [41, 173, 255, 255], # blue
    13 => [131, 118, 156, 255], # indigo
    14 => [255, 119, 168, 255], # pink
    15 => [255, 204, 170, 255],  # peach
  }

  def set_color_hash(key, value)
    COLORS[key] = value
  end

  def hex_color(code)
    [
      (code >> 16) & 0xff,
      (code >> 8) & 0xff,
      code & 0xff,
      255
    ]
  end

  def circfill(x, y, r = 4, col = 0)
    if col.is_a?(Array)
      Circle.new(x, y, r).draw(col)
    else
      Circle.new(x, y, r).draw(COLORS[col])
    end
  end

  def mouse_x
    Cursor.pos.x
  end

  def mouse_y
    Cursor.pos.y
  end

  def text(str, x, y, col = 7)
    @@font[str].draw(x, y, COLORS[col])
  end

  def text_at(str, x, y, col = 7)
    @@font[str].draw_at(x, y, COLORS[col])
  end

  def script(&block)
    @@scripts.push(Fiber.new { loop { block.call } })
  end

  def draw(&block)
    @@drawers.push(block)
  end

  def run
    while System.update do
      @@scripts.each do |e| 
        e.resume if e.alive?
      end

      @@drawers.each do |e| 
        e.call
      end
    end
  end

  def wait(wait = 1)
    1.upto(wait) do |e|
      yield e if block_given?
      Fiber.yield
    end
  end

end
include Clipscript
