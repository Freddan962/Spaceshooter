class Loot < FloatingEntity
  def initialize(type, image, x, y, hp, velocity_y, speed)
    super image, x, y, hp, speed
    @velocity_y = 1
  end
end