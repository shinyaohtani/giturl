# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

# Builds a throwaway local git repository to exercise Giturl against,
# instead of cloning a fixture branch from the real GitHub remote.
# This keeps the spec suite hermetic: no network access, no SSH keys,
# and no dependency on a branch continuing to exist upstream.
module FixtureRepository
  # @param branch [String] branch name to create, e.g. a name with symbols to test URL-encoding
  # @param remote [String] value to set as `remote.origin.url`
  # @param subdir [String, nil] optional subdirectory (with a file in it) to exercise path prefixes
  # @return [String] path to the repository's working directory
  def build_fixture_repo(branch:, remote: 'git@github.com:shinyaohtani/giturl.git', subdir: nil)
    root = Dir.mktmpdir('giturl-spec-')
    repo = File.join(root, 'giturl')
    FileUtils.mkdir_p(repo)

    Dir.chdir(repo) do
      run_git('init', '-q', '.')
      run_git('config', 'user.email', 'giturl-spec@example.com')
      run_git('config', 'user.name', 'giturl spec')
      run_git('checkout', '-q', '-b', branch)
      File.write('README.md', "fixture repo for giturl specs\n")
      if subdir
        FileUtils.mkdir_p(subdir)
        File.write(File.join(subdir, '.keep'), '')
      end
      run_git('add', '-A')
      run_git('commit', '-q', '-m', 'initial commit')
      run_git('remote', 'add', 'origin', remote)
    end

    repo
  end

  # Removes the temp directory tree that build_fixture_repo created.
  # @param repo [String] the path returned by build_fixture_repo
  def cleanup_fixture_repo(repo)
    FileUtils.rm_rf(File.dirname(repo))
  end

  private

  def run_git(*args)
    system('git', *args, exception: true)
  end
end

RSpec.configure do |config|
  config.include FixtureRepository
end
