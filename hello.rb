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

  t = "🐣Hello, "

  wait(60) do |i|
    text_at(t, center_x, center_y)
  end

  a = "ClipScript!".split("")
  a.each do |e|
    t += e
    wait(4) do 
      text_at(t, center_x, center_y)
    end
  end

  t += "💃"
  wait(64) do 
    text_at(t, center_x, center_y)
  end

  wait(120) do
    text_at(t, center_x, center_y)
    text("Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam.", 0, 300)
  end
end

run
