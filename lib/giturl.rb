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
      $stderr.reopen(File::NULL)
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
      gitdir_prefix, gitdir_branch, remote_origin_url, ok = git_location_info(path)
      unless ok
        warn 'Git commands failed. Please check if the directory is a git repository.'
        return ''
      end
      baseurl = construct_base_url(remote_origin_url)
      encoded_branch = gitdir_branch.split('/').map { |e| ERB::Util.url_encode(e) }.join('/')
      "#{baseurl}/tree/#{encoded_branch}/#{gitdir_prefix}"
    end

    # Run the git commands needed to build the URL, and report whether they succeeded.
    #
    # @param path [String] path for a git-managed directory
    # @return [Array(String, String, String, Boolean)] prefix, branch, remote origin URL, and
    #   whether the info is usable. gitdir_prefix may legitimately be empty (path is the
    #   repository root), so only command success and non-empty branch/remote are required.
    def self.git_location_info(path)
      prefix, prefix_ok = run_git(path, 'rev-parse', '--show-prefix')
      branch, branch_ok = run_git(path, 'rev-parse', '--abbrev-ref', 'HEAD')
      remote, remote_ok = run_git(path, 'config', '--get', 'remote.origin.url')
      ok = prefix_ok && branch_ok && remote_ok && !branch.empty? && !remote.empty?
      [prefix, branch, remote, ok]
    end
    private_class_method :git_location_info

    def self.run_git(path, *args)
      output = `git -C #{path} #{args.join(' ')}`.chomp
      [output, $?.success?] # rubocop:disable Style/SpecialGlobalVars
    end
    private_class_method :run_git

    def self.construct_base_url(remote_origin_url)
      baseurl = remote_origin_url
      if remote_origin_url =~ /@(.*?):/
        host_alias = ::Regexp.last_match(1)
        real_hostname = get_real_hostname(host_alias)
        baseurl = remote_origin_url.sub(host_alias, real_hostname) if real_hostname && real_hostname != host_alias
      end
      baseurl.tr(':', '/').gsub(/^.*@/, 'https://').gsub(/\.git$/, '')
    end

    def self.get_real_hostname(host_alias)
      ssh_output = `ssh -G #{host_alias} 2>#{File::NULL}`
      real_hostname_line = ssh_output.lines.find { |line| line =~ /^hostname / }
      return nil unless real_hostname_line

      real_hostname_line.split[1]
    end
  end
end
