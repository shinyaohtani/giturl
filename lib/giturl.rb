#!/usr/bin/env ruby
# frozen_string_literal: true

require 'giturl/version'

# converter module from path to url
module Giturl
  require 'erb'
  # Main class of `Giturl` module.
  #
  # `self.url` is recommended to get URL like: Giturl.url('./lib')
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
      stderr_old = $stderr.dup
      $stderr.reopen('/dev/null')
      inside = `git -C #{path} rev-parse --is-inside-work-tree`.chomp
      $stderr.flush
      $stderr.reopen stderr_old
      inside == 'true'
    end

    # Convert path to git-managed directory to GitHub web page URL
    #
    # @param path [String] path for a git-managed directory. Both relative and absolute forms are accepted.
    # @return [String] GitHub web page URL for the given git-managed directory
    def self.convert(path)
      gitdir_prefix = `git -C #{path} rev-parse --show-prefix`.chomp
      gitdir_branch = `git -C #{path} rev-parse --abbrev-ref HEAD`.chomp
      remote_origin_url = `git -C #{path} config --get remote.origin.url`.chomp

      # remote_origin_url:  git@github.com:shinyaohtani/giturl.git
      baseurl = remote_origin_url.gsub(/:/, '/').gsub(/^.*@/, 'https://').gsub(/\.git$/, '')
      # gitdir_branch: feature/#1_user_named_branch
      encoded_branch = gitdir_branch.split('/').map { |e| ERB::Util.url_encode(e) }.join('/')

      "#{baseurl}/tree/#{encoded_branch}/#{gitdir_prefix}"
    end
  end
end
