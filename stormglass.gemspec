
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stormglass/version"

Gem::Specification.new do |spec|
  spec.name          = "stormglass"
  spec.version       = Stormglass::VERSION
  spec.authors       = ["Russell Jennings"]
  spec.email         = ["violentpurr@gmail.com"]

  spec.summary       = %q{Ruby client for the Stormglass weather API}
  spec.homepage      = "https://github.com/meesterdude/stormglass"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]


  spec.add_dependency("rest-client")
  spec.add_dependency("geocoder")
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.3"
end
