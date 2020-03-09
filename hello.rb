require "./lib/clipscript"

script do
  (1..360).each do |e|
    radian = 32
    rad = e * (Math::PI * 2) / 360
    0.upto(6) do |y|
      y *= 100
      circfill(Window.center.x,       y, radian * Math::sin(rad), [Math::sin(rad) * 127 + 128, 64, 64])
      circfill(Window.center.x + 100, y, radian * Math::cos(rad), [64, Math::cos(rad) * 127 + 128, 64])
      circfill(Window.center.x - 100, y, radian * Math::cos(rad), [64, 64, Math::cos(rad) * 127 + 128])
    end

    wait
  end
end

script do
  t = "🐣Hello, "

  wait(60) do |i|
    text_at(t, Window.center.x, Window.center.y, 7)
  end

  a = "ClipScript!".split("")
  a.each do |e|
    t += e
    wait(4) do 
      text_at(t, Window.center.x, Window.center.y, 7)
    end
  end

  t += "💃"
  wait(64) do 
    text_at(t, Window.center.x, Window.center.y, 7)
  end

  wait(120) do
    text_at(t, Window.center.x, Window.center.y, 7)
    text("Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam.", 0, 300, 7)
  end
end

draw do
  circfill(mouse_x, mouse_y, 30, 1)
  circfill(mouse_x, mouse_y, 20, 2)
end

run
