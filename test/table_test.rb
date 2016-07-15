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
