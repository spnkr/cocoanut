# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name          = "cocoanut"
  spec.version       = "0.16.0"
  spec.authors       = ["Will Jessop"]
  spec.email         = ["wjessop@gmail.com"]
  spec.description   = %q{Syntactic sugar for cocoa and ruby motion}
  spec.summary       = %q{A rubymotion library along the lines of bubblewrap and sugarcube. For iOS.}
  spec.homepage      = "https://github.com/spnkr/cocoanut/"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
