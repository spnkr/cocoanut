# -*- encoding: utf-8 -*-
VERSION = "0.0.12"

Gem::Specification.new do |spec|
  spec.name          = "rapidmotion"
  spec.version       = VERSION
  spec.authors       = [""]
  spec.email         = ["wjessop@gmail.com"]
  spec.description   = %q{More rapid rubymotion development}
  spec.summary       = %q{Extensions to various classes, and more.}
  spec.homepage      = ""
  spec.license       = ""

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
