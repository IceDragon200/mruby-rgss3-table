assert 'RGSS3::Table#initialize with bad arguments' do
  assert_raise ArgumentError, "it should take at least 1 parameter" do
    RGSS3::Table.new
  end

  assert_raise ArgumentError, "it cannot take more than 3 parameters" do
    RGSS3::Table.new(2, 4, 8, 16)
  end
end

assert 'RGSS3::Table#initialize it will fail if a given size is less than or equal to 0' do
  assert_raise ArgumentError, "xsize must not be 0 or less" do
    RGSS3::Table.new(0)
  end

  assert_raise ArgumentError, "ysize must not be 0 or less" do
    RGSS3::Table.new(1, 0)
  end

  assert_raise ArgumentError, "zsize must not be 0 or less" do
    RGSS3::Table.new(1, 2, 0)
  end
end

assert 'RGSS3::Table#initialize 1D' do
  table = RGSS3::Table.new(10)

  assert_equal 10, table.xsize
end

assert 'RGSS3::Table#initialize 2D' do
  table = RGSS3::Table.new(10, 4)

  assert_equal 10, table.xsize
  assert_equal 4, table.ysize
end

assert 'RGSS3::Table#initialize 3D' do
  table = RGSS3::Table.new(2, 4, 8)

  assert_equal 2, table.xsize
  assert_equal 4, table.ysize
  assert_equal 8, table.zsize
end

assert 'RGSS3::Table copy' do
  a = RGSS3::Table.new(2, 4, 8)
  b = a.dup

  assert_equal a.xsize, b.xsize
  assert_equal a.ysize, b.ysize
  assert_equal a.zsize, b.zsize
  assert_equal a.size, b.size
  assert_equal a.dimensions, b.dimensions
end

assert 'RGSS3::Table#resize 1D' do
  table = RGSS3::Table.new(10)
  assert_equal 10, table.xsize
  table.resize 5
  assert_equal 5, table.xsize
end

assert 'RGSS3::Table#resize 2D' do
  table = RGSS3::Table.new(10, 8)
  assert_equal 10, table.xsize
  assert_equal 8, table.ysize
  table.resize 5, 4
  assert_equal 5, table.xsize
  assert_equal 4, table.ysize
end

assert 'RGSS3::Table#resize 3D' do
  table = RGSS3::Table.new(10, 8, 16)
  assert_equal 10, table.xsize
  assert_equal 8, table.ysize
  assert_equal 16, table.zsize
  table.resize 5, 4, 8
  assert_equal 5, table.xsize
  assert_equal 4, table.ysize
  assert_equal 8, table.zsize
end

assert 'RGSS3::Table#[]/= 1D' do
  table = RGSS3::Table.new(10)

  assert_equal 0, table[0]
  table[0] = 12
  assert_equal 12, table[0]

  assert_equal 0, table[10]
  table[10] = 12
  assert_equal 0, table[10]

  assert_equal 0, table[9]
  table[9] = 13
  assert_equal 13, table[9]
end

assert 'RGSS3::Table#[]/= 2D' do
  table = RGSS3::Table.new(4, 8)

  assert_equal 0, table[0, 0]
  table[0, 0] = 12
  assert_equal 12, table[0, 0]

  assert_equal 0, table[4, 0]
  table[4, 0] = 12
  assert_equal 0, table[4, 0]

  assert_equal 0, table[3, 7]
  table[3, 7] = 13
  assert_equal 13, table[3, 7]
end

assert 'RGSS3::Table#[]/= 3D' do
  table = RGSS3::Table.new(4, 8, 6)

  assert_equal 0, table[0, 0, 0]
  table[0, 0, 0] = 12
  assert_equal 12, table[0, 0, 0]

  assert_equal 0, table[4, 0, 0]
  table[4, 0, 0] = 12
  assert_equal 0, table[4, 0, 0]

  assert_equal 0, table[3, 7, 5]
  table[3, 7, 5] = 13
  assert_equal 13, table[3, 7, 5]
end

assert 'RGSS3::Table#clear' do
  table = RGSS3::Table.new(4, 8, 6)

  table[0, 0, 0] = 12
  assert_equal 12, table[0, 0, 0]

  table[3, 7, 5] = 13
  assert_equal 13, table[3, 7, 5]

  table.clear

  assert_equal 0, table[0, 0, 0]
  assert_equal 0, table[3, 7, 5]
end
