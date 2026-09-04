# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

# A throwaway git repository for the specs to point giturl at, built locally
# rather than cloned from the real remote. That keeps the suite hermetic: no
# network, no SSH keys, and no branch that has to keep existing upstream.
class FixtureRepository
  attr_reader :path

  # @param branch [String] branch to check out, e.g. a symbol-heavy name to exercise encoding
  # @param remote [String] value to record as `remote.origin.url`
  # @param subdir [String, nil] directory to create inside the repository, to exercise path prefixes
  def initialize(branch:, remote: 'git@github.com:shinyaohtani/giturl.git', subdir: nil)
    @root = Dir.mktmpdir('giturl-spec-')
    @path = File.join(@root, 'giturl')
    FileUtils.mkdir_p(@path)
    Dir.chdir(@path) { build(branch: branch, remote: remote, subdir: subdir) }
  end

  # Deletes the temporary tree this repository lives in.
  def remove!
    FileUtils.rm_rf(@root)
  end

  private

  # @return [void]
  def build(branch:, remote:, subdir:)
    git('init', '-q', '.')
    git('config', 'user.email', 'giturl-spec@example.com')
    git('config', 'user.name', 'giturl spec')
    git('checkout', '-q', '-b', branch)
    commit(subdir)
    git('remote', 'add', 'origin', remote)
  end

  # @param subdir [String, nil] directory to include in the commit
  def commit(subdir)
    File.write('README.md', "fixture repo for giturl specs\n")
    if subdir
      FileUtils.mkdir_p(subdir)
      File.write(File.join(subdir, '.keep'), '')
    end
    git('add', '-A')
    git('commit', '-q', '-m', 'initial commit')
  end

  def git(*)
    system('git', *, exception: true)
  end
end
