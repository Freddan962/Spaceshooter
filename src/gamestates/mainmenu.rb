class MainMenu < GameState
  include RectangularCollision

  def initialize(window, sm)
    super window, sm
    @window = window
    @GUI.set_font(@rm["hyperspace"])
    @GUI.add_text("Title", "Spaceshooter", 50, 50)
    @GUI.add_icon("white_rectangle_183px", @rm["white_rectangle_183px"], 50, 85)

    @GUI.set_font(@rm["hyperspace_24"])
    
    @GUI.add_text("Play", "Play", 50, 175)
    @GUI.add_text("Settings", "Settings", 50, 210)
    @GUI.add_text("Multiplayer", "Multiplayer", 50, 245)

    @GUI.set_font(@rm["hyperspace_14"])
    @GUI.add_text("Version", "0.01a", 250, 80)

    @background = Background.new(@rm["background_solid"], @rm["background_stars"], @speed, true)
    @objects << @background
  end

  def handle_input(key, type)
    if type == "up"
      case key
      when Gosu::MsLeft
        handle_collision if gui_collision?
      end
    end
  end

  def gui_collision?
    collision = false
    @GUI.items.each {|key, element| collision = true if collision_mouse?(element, @window.mouse_x, @window.mouse_y)}
    collision
  end

  def handle_collision
    object = nil
    @GUI.items.each {|key, element| object = key if collision_mouse?(element, @window.mouse_x, @window.mouse_y)}
    
    if object
      case object
        when "Play"
          @sm.next
      end
    end
  end
end