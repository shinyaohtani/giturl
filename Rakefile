# frozen_string_literal: true

require 'bundler/gem_tasks'
task default: :spec

require 'github_changelog_generator/task'

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'shinyaohtani'
  config.project = 'giturl'
  config.base = 'CHANGELOG.md'
  config.future_release = Giturl::VERSION
end
