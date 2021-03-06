module GUI
  class GUI
    attr_reader :items
    def initialize(visible = true)
      @visible = visible
      @items = {}
    end

    def draw
      if @visible and @items.size > 0
        @items.each {|key, value| value.draw}
      end
    end

    def update
      @items.each {|key, value| value.update}
    end

    def set_font(font)
      @font = font
    end

    def add_text(key, text, x, y)
      raise ArgumentError, 'Font has not been set!' unless @font
      @items[key] = Text.new(text, @font, x, y)
    end

    def add_icon(key, image, x, y)
      @items[key] = Icon.new(image, x, y)
    end
    
    def [](key)
      @items[key]
    end
  end
end