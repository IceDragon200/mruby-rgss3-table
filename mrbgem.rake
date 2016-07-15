MRuby::Gem::Specification.new('mruby-rgss3-table') do |spec|
  spec.license = 'MIT'
  spec.authors = ['Corey Powell']
  spec.version = '0.0.0'
  spec.summary = 'RGSS3 Table class'
  spec.description = 'An implementation of RGSS3\'s Table Class'
  spec.homepage = 'https://github.com/IceDragon200/mruby-rgss3-table'
  # compiler config
  spec.cc.include_paths << ["#{build.root}/src"]

  spec.add_dependency 'mruby-idnarray'
end
