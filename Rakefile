# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require 'github_changelog_generator/task'
GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.base = 'CHANGELOG.md'
  config.future_release = "v#{Giturl::VERSION}"
  config.project = 'giturl'
  config.user = 'shinyaohtani'
  config.verbose = false

  # other changelog options (values are default)
  #
  # -- labels
  #:config.breaking_labels = ["backwards-incompatible", "Backwards incompatible", "breaking"]
  #:config.bug_labels = ["bug", "Bug", "Type: Bug"]
  #:config.deprecated_labels = ["deprecated", "Deprecated", "Type: Deprecated"]
  #:config.enhancement_labels = ["enhancement", "Enhancement", "Type: Enhancement"]
  #:config.exclude_labels = ['duplicate', 'question', 'invalid', 'wontfix',
  #:                         'Duplicate', 'Question', 'Invalid', 'Wontfix',
  #:                         'Meta: Exclude From Changelog']
  #:config.removed_labels = ["removed", "Removed", "Type: Removed"]
  #:config.security_labels = ["security", "Security", "Type: Security"]
  #:config.summary_labels = ["Release summary", "release-summary", "Summary", "summary"]
  # -- prefix
  #:config.breaking_prefix = "**Breaking changes:**"
  #:config.bug_prefix = "**Fixed bugs:**"
  #:config.deprecated_prefix = "**Deprecated:**"
  #:config.enhancement_prefix = "**Implemented enhancements:**"
  #:config.header = "# Changelog"
  #:config.issue_prefix = "**Closed issues:**"
  #:config.merge_prefix = "**Merged pull requests:**"
  #:config.removed_prefix = "**Removed:**"
  #:config.security_prefix = "**Security fixes:**"
  #:config.summary_prefix = ""
  # -- others
  #:config.add_issues_wo_labels = true
  #:config.add_pr_wo_labels = true
  #:config.add_sections = {}
  #:config.author = true
  #:config.compare_link = true
  #:config.configure_sections = {}
  #:config.date_format = "%Y-%m-%d"
  #:config.filter_issues_by_milestone = true
  #:config.http_cache = true
  #:config.issue_line_labels = []
  #:config.issues = true
  #:config.max_issues = nil
  #:config.output = "CHANGELOG.md"
  #:config.pulls = true
  #:config.require = []
  #:config.simple_list = false
  #:config.ssl_ca_file = nil
  #:config.unreleased = true
  #:config.unreleased_label = "Unreleased"
end

task default: :spec
