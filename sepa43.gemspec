# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sepa43/version'

Gem::Specification.new do |spec|
  spec.name          = 'sepa43'
  spec.version       = Sepa43::VERSION
  spec.authors       = ['Juan Salvador Perez Garcia']
  spec.email         = ['jsperezg@insitu.tools']

  spec.summary       = %q{Ruby gem for parsing SEPA 43 files. (Banking procedures and standards series #43).}
  spec.description   = %q{This gem implements a parser for SEPA 43 files. The original intent is implement a
mechanism to import easily supplier payments into InSitu (http://www.insitu.tools). It will be used to register
invoice payments as well.
}
  spec.homepage      = 'http://www.insitu.tools'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
