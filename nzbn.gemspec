# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nzbn/version"

Gem::Specification.new do |spec|
  spec.name          = "nzbn"
  spec.version       = Nzbn::VERSION
  spec.authors       = ["T Pearse"]
  spec.email         = ["t.pearse@gmail.com"]

  spec.summary       = %q{Simple and fast authenticating ruby API wrapper for the NZBN API}
  spec.description   = %q{Search, update details and manage New Zealand companies through the NZBN register.}
  spec.homepage      = "https://github.com/t-pearse/nzbn"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
