#!/usr/bin/env ruby
# frozen_string_literal: true

require 'giturl/version'
require 'giturl/git_directory'

# converter module from path to url
module Giturl
  # Published entry point of the `Giturl` module, kept as class methods because
  # that is the interface released gems call:
  #
  #   url = Giturl::Giturl.url('./lib')
  #
  # Nothing is decided here; every answer comes from a GitDirectory.
  class Giturl
    # Check if path is a git-managed directory and return the URL of the GitHub web page for that path
    #
    # @param path [String] path to any directory. Both relative and absolute forms are accepted.
    # @return [String] GitHub web page URL. This returns nil if the path is NOT a git-managed dir.
    def self.url(path)
      convert(path) if git_managed?(path)
    end

    # Check if the path is in the git-managed directory
    #
    # @param path [String] path to check. Both relative and absolute forms are accepted.
    # @return [Boolean] git-managed directory or not.
    def self.git_managed?(path)
      GitDirectory.new(path).managed?
    end

    # Convert path to git-managed directory to GitHub web page URL
    #
    # @param path [String] path for a git-managed directory. Both relative and absolute forms are accepted.
    # @return [String] GitHub web page URL for the given git-managed directory
    def self.convert(path)
      GitDirectory.new(path).url
    end
  end
end
