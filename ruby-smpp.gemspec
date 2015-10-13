# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smpp/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-smpp"
  spec.version       = Smpp::VERSION
  spec.authors       = ["Ray Krueger", "August Z. Flatby", "Thomas McTiernan"]
  spec.email         = ["thomasmctiernan@gmail.com"]
  spec.description   = %q{Ruby implementation of the SMPP protocol. SMPP is a protocol that allows ordinary people outside the mobile network to exchange SMS messages directly with mobile operators. Hacked version to remove EventMachine - this will only parse PDUs.}
  spec.summary       = %q{Ruby implementation of the SMPP protocol.}
  spec.homepage      = "http://github.com/tmct/ruby-smpp"
  spec.license       = "MIT"

  spec.files         = Dir['lib/ *.rb'] + Dir['lib/smpp/ *.rb'] + Dir['lib/pdu/ *.rb'] + Dir['test/ *.rb'] + [
    '.gitignore',
    '.ruby-version',
    '.travis.yml',
    'CHANGELOG',
    'CONTRIBUTORS.txt',
    'Gemfile',
    'Gemfile.lock',
    'LICENSE',
    'README.rdoc',
    'Rakefile',
    'VERSION',
    'examples/PDU1.example',
    'examples/PDU2.example',
    'ruby-smpp.gemspec'
  ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
