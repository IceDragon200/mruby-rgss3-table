module RGSS3
  class Table
    attr_reader :dimensions
    attr_reader :xsize
    attr_reader :ysize
    attr_reader :zsize
    attr_reader :size
    attr_accessor :default

    attr_reader :data
    protected :data

    # @overload initialize(xsize)
    #   @param [Integer] xsize
    # @overload initialize(xsize, ysize)
    #   @param [Integer] xsize
    #   @param [Integer] ysize
    # @overload initialize(xsize, ysize, zsize)
    #   @param [Integer] xsize
    #   @param [Integer] ysize
    #   @param [Integer] zsize
    # @return [self]
    def initialize(*args)
      @dimensions = args.size
      if @dimensions <= 0 || @dimensions > 3
        raise ArgumentError, "wrong argument count (expected 1..3)"
      end
      @default = 0
      @xsize = args[0]
      @ysize = args[1] || 1
      @zsize = args[2] || 1
      @size = @xsize * @ysize * @zsize
      @data = NArray.int16 @size
    end

    def initialize_copy(other)
      super
      @dimensions = other.dimensions
      @default = other.default
      @xsize = other.xsize
      @ysize = other.ysize
      @zsize = other.zsize
      @size = other.size
      @data = other.data.dup
    end

    private def assert_dimensions(size)
      if size != @dimensions
        raise ArgumentError, "wrong argument count (expected #{@dimensions})"
      end
    end

    private def coords_to_index(*args)
      assert_dimensions(args.size)
      x, y, z = *args
      case @dimensions
      when 2 then
        return nil if x < 0 || xsize <= x
        return nil if y < 0 || ysize <= y
        x + y * xsize
      when 3 then
        return nil if x < 0 || xsize <= x
        return nil if y < 0 || ysize <= y
        return nil if z < 0 || zsize <= z
        x + y * xsize + z * xsize * ysize
      else
        return nil if x < 0 || xsize <= x
        x
      end
    end

    # @overload resize(xsize)
    #   @param [Integer] xsize
    # @overload resize(xsize, ysize)
    #   @param [Integer] xsize
    #   @param [Integer] ysize
    # @overload resize(xsize, ysize, zsize)
    #   @param [Integer] xsize
    #   @param [Integer] ysize
    #   @param [Integer] zsize
    # @return [self]
    def resize(*args)
      assert_dimensions(args.size)
      @xsize = args[0] || @xsize
      @ysize = args[1] || @ysize
      @zsize = args[2] || @zsize
      @size = @xsize * @ysize * @zsize
      @data.resize!(@size)
      self
    end

    # @overload [](x)
    #   @param [Integer] x
    # @overload [](x, y)
    #   @param [Integer] x
    #   @param [Integer] y
    # @overload [](x, y, z)
    #   @param [Integer] x
    #   @param [Integer] y
    #   @param [Integer] z
    # @return [Integer]
    def [](*args)
      if index = coords_to_index(*args)
        @data[index]
      else
        @default
      end
    end

    # @overload [](x, value)
    #   @param [Integer] x
    #   @param [Integer] value
    # @overload [](x, y, value)
    #   @param [Integer] x
    #   @param [Integer] y
    #   @param [Integer] value
    # @overload [](x, y, z, value)
    #   @param [Integer] x
    #   @param [Integer] y
    #   @param [Integer] z
    #   @param [Integer] value
    # @return [self]
    def []=(*args)
      if index = coords_to_index(*args.slice(0, @dimensions))
        @data[index] = args.last
      end
      self
    end

    # Clears all data to default
    #
    # @return [self]
    def clear
      @data.fill(@default)
      self
    end
  end
end
