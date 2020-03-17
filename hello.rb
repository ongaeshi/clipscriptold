require "./lib/clipscript"

script do
  (1..360).each do |e|
    radian = 32
    rad = deg2rad(e)
    0.upto(6) do |y|
      y *= 100

      circle_fill(center_x,       y, radian * sin(rad), [255, 0, 77, cos(rad) * 127 + 128])
      circle_fill(center_x + 100, y, radian * cos(rad), [0, 228, 54, sin(rad) * 127 + 128])
      circle_fill(center_x - 100, y, radian * cos(rad), [41, 173, 255, sin(rad) * 127 + 128])
    end

    circle(mouse_x, mouse_y, 30, :yellow)
    circle_fill(mouse_x, mouse_y, 20, :peach)
    
    wait
  end
end

script do
  cls

  @m = Message.new(center_x, center_y)
  @m2 = Message.new(0, 300)

  t = "🐣Hello, "
  @m.text(t)
  wait 60

  a = "ClipScript!".split("")
  a.each do |e|
    t += e
    @m.text(t)
    wait 4
  end

  t += "💃"
  @m.text(t)
  wait 64

  @m2.text("Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam.")
  wait 120
end

draw do
  @m.draw_at
  @m2.draw
end

run
