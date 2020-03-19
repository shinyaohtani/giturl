# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'shinyaohtani'
  config.project = 'giturl'
  config.base = 'CHANGELOG.md'
  config.future_release = Giturl::VERSION
end

task default: :spec
