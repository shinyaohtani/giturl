# frozen_string_literal: true

require 'giturl/location'
require 'giturl/remote_url'

module Giturl
  # A directory on disk, asked about through git: whether git manages it, and
  # what GitHub page shows it. Every git invocation in giturl happens here.
  class GitDirectory
    FAILURE = 'Git commands failed. Please check if the directory is a git repository.'

    def initialize(path)
      @path = path
    end

    # git prints to stderr when the path is not a repository, which is noise for
    # a question that is allowed to answer "no", so stderr is silenced around it.
    #
    # @return [Boolean] whether the directory is inside a git work tree
    def managed?
      stderr_old = $stderr.dup
      $stderr.reopen(File::NULL)
      inside, = capture('rev-parse', '--is-inside-work-tree')
      $stderr.flush
      $stderr.reopen stderr_old
      inside == 'true'
    end

    # @return [String] the GitHub page URL for this directory, or '' (after a
    #   warning) when git could not answer
    def url
      here = location
      unless here
        warn FAILURE
        return ''
      end

      "#{RemoteUrl.new(here.remote).https}/tree/#{here.encoded_branch}/#{here.prefix}"
    end

    private

    # All three commands run before the result is judged, so git reports every
    # problem it has with the directory rather than only the first.
    #
    # @return [Location, nil] nil when any command failed or answered empty
    def location
      prefix, prefix_ok = capture('rev-parse', '--show-prefix')
      branch, branch_ok = capture('rev-parse', '--abbrev-ref', 'HEAD')
      remote, remote_ok = capture('config', '--get', 'remote.origin.url')
      return nil unless prefix_ok && branch_ok && remote_ok

      here = Location.new(prefix: prefix, branch: branch, remote: remote)
      here.complete? ? here : nil
    end

    # git is run without a shell, so a directory name is never split on its
    # spaces nor read for metacharacters.
    #
    # @return [Array(String, Boolean)] the command's output and whether it succeeded
    def capture(*args)
      output = IO.popen(['git', '-C', @path, *args], &:read).chomp
      [output, Process.last_status.success?]
    end
  end
end
