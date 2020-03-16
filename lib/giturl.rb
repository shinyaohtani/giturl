#!/usr/bin/env ruby
# frozen_string_literal: true

require 'giturl/version'

module Giturl
  class Giturl
    def self.git_managed?(path)
      stderr_old = $stderr.dup
      $stderr.reopen('/dev/null')
      inside = `git -C #{path} rev-parse --is-inside-work-tree`.chomp
      $stderr.flush
      $stderr.reopen stderr_old
      inside == 'true'
    end

    def self.url(path)
      gitdir_prefix = `git -C #{path} rev-parse --show-prefix`.chomp
      gitdir_branch = `git -C #{path} rev-parse --abbrev-ref HEAD`.chomp
      remote_origin_url = `git -C #{path} config --get remote.origin.url`.chomp

      # remote_origin_url:  git@github.com:shinyaohtani/giturl.git
      baseurl = remote_origin_url.gsub(/:/, '/').gsub(/^.*@/, 'https://').gsub(/\.git$/, '')

      "#{baseurl}/tree/#{gitdir_branch}/#{gitdir_prefix}"
    end

    def self.safe_url(path)
      url(path) if git_managed?(path)
    end
  end
end
