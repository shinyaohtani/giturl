# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giturl/version'

Gem::Specification.new do |spec|
  spec.name          = 'giturl'
  spec.version       = Giturl::VERSION
  spec.authors       = ['Shinya Ohtani (shinyaohtani@github)']
  spec.email         = ['shinya_ohtani@yahoo.co.jp']

  spec.homepage      = 'https://github.com/shinyaohtani/giturl'
  spec.license       = 'MIT'
  spec.summary       = 'Show or open GitHub URL for your local directory'
  spec.description   = <<~DESCRIPTION
    Show or open GitHub URL for your local directory.
    You can use giturl to display the URL corresponding to the git-managed directory given as an argument, and you can open the URL directly in your browser if needed.
  DESCRIPTION

  #:spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/shinyaohtani/giturl'
  spec.metadata['changelog_uri'] = 'https://github.com/shinyaohtani/giturl/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = ['giturl']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'github_changelog_generator', '>= 1.15.0'
  spec.add_development_dependency 'irb'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rubocop', '>= 0.80.1'
end
