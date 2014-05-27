class Play < GameState
  include RectangularCollision

  def initialize(window)
    super
    @speed = 1
    @player = Player.new(@rm.get("player", "player_left", "player_right", "player_flame"), @rm.get("player_projectile"), GameWindow::WIDTH/2, GameWindow::HEIGHT - 50, 100, 1.5, 0.95)
    @background = Background.new(@rm.get("background_solid"), @rm.get("background_stars"), @speed, true)
    @objects << @player
    @objects << @background
    @loot_spawn_timer, @loot_spawn_counter = 1*60, 0
  end

  def draw
    super
  end

  def update
    super
    @objects += @player.projectiles
    
    if @loot_spawn_counter > @loot_spawn_timer
      @objects << generate_loot
      @loot_spawn_counter = 0
    else
      @loot_spawn_counter += 1
    end
    
    @cm.update(@objects)
    @cm.get_surrounding_objects(@player).each do |object|
      next if object.class == Background
      if rectangular_collision?(@player, object)
        @player.on_collide
        object.on_collide


        case object.type
        when "Health"
          @player.health += object.get_health
        when "Ammo"
          @player.ammo += object.get_ammo
        end
      end  
    end

    @objects.each_with_index do |object, index|
      @objects.delete_at(index) if !object.alive?
    end
  end

  def handle_input(key, type)
    if type == "down"
      case key
      when Gosu::KbLeft
        @player.KbLeft = true
      when Gosu::KbRight  
        @player.KbRight = true
      end    
    else
      case key
      when Gosu::KbLeft
        @player.KbLeft = false
      when Gosu::KbRight
        @player.KbRight = false
      when Gosu::KbSpace
        @player.fire
      end
    end
  end

  def generate_loot
    random_number = rand(0..1)
    return Loot.new("Health", @rm.get("health"), rand(30..GameWindow::WIDTH-30), -50, 2.5, 7.5) if random_number == 0
    return Loot.new("Ammo", @rm.get("ammo"), rand(30..GameWindow::WIDTH-30), -50, 2.5, 7.5) if random_number == 1
  end
end