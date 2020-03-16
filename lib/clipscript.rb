module Clipscript
  @@scripts = []
  @@drawers = []

  @@font = Font.new(30)

  COLORS = {
    :black => [0, 0, 0, 255],
    :dark_blue => [29, 43, 83, 255],
    :dark_purple => [126, 37, 83, 255],
    :dark_green => [0, 135, 81, 255],
    :brown => [171, 82, 54, 255],
    :dark_gray => [95, 87, 79, 255],
    :light_gray => [194, 195, 199, 255],
    :white => [255, 241, 232, 255],
    :red => [255, 0, 77, 255],
    :orange => [255, 163, 0, 255],
    :yellow => [255, 236, 39, 255],
    :green => [0, 228, 54, 255],
    :blue => [41, 173, 255, 255],
    :indigo => [131, 118, 156, 255],
    :pink => [255, 119, 168, 255],
    :peach => [255, 204, 170, 255], 
  }

  def cls(c = :light_gray)
    Graphics.set_background(to_color(c))
  end

  def circle(x, y, r = 30, c = :black, frame = 5)
    Circle.new(x, y, r).draw_frame(frame, to_color(c))
  end

  def circle_fill(x, y, r = 30, c = :black)
    Circle.new(x, y, r).draw(to_color(c))
  end

  def text(str, x, y, c = :black)
    @@font[str].draw(x, y, to_color(c))
  end

  def text_at(str, x, y, c = :black)
    @@font[str].draw_at(x, y, to_color(c))
  end

  def set_color_hash(key, value)
    COLORS[key] = value
  end

  def to_color(c)
    if c.is_a?(Symbol)
      COLORS[c]
    else
      c
    end
  end

  def hex_color(code)
    [
      (code >> 16) & 0xff,
      (code >> 8) & 0xff,
      code & 0xff,
      255
    ]
  end

  def mouse_x
    Cursor.pos.x
  end

  def mouse_y
    Cursor.pos.y
  end

  def center_x
    Window.center.x
  end

  def center_y
    Window.center.y
  end

  def deg2rad(deg)
    deg * (Math::PI * 2) / 360
  end

  def sin(rad)
    Math::sin(rad)
  end

  def cos(rad)
    Math::cos(rad)
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
