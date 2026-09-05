# frozen_string_literal: true

RSpec.describe Giturl::CommandGiturl do
  describe '#run' do
    context 'when no directories are specified' do
      it 'returns version message for -V' do
        expect(`bundle exec giturl -V`.chomp).to eq "giturl #{Giturl::VERSION}"
      end

      it 'returns version message for --VERSION' do
        expect(`bundle exec giturl --VERSION`.chomp).to eq "giturl #{Giturl::VERSION}"
      end
    end

    context 'when not git-managed directory was specified' do
      it 'does not print warnings' do
        expect(`bundle exec giturl /dev/null`.chomp).to eq ''
      end

      it 'prints a warning to stdout (short)' do
        expect(`bundle exec giturl -v /dev/null`.chomp).to eq 'Not git-managed-dir:  /dev/null'
      end

      it 'prints a warning to stdout (long)' do
        expect(`bundle exec giturl --verbose /dev/null`.chomp).to eq 'Not git-managed-dir:  /dev/null'
      end
    end

    context 'when git-managed directory was specified' do
      let(:repo_url) { 'https://github.com/shinyaohtani/giturl/' }
      let(:test_branch) { "test/#3_SampleRepo/\"-'_!-<>()" }
      let(:encoded_branch) { 'test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29' }
      let(:repository) { FixtureRepository.new(branch: test_branch, subdir: 'lib') }
      let(:repo_path) { repository.path }

      after { repository.remove! }

      it 'outputs github URL for giturl on testing branch' do
        top_url = "#{repo_url}tree/#{encoded_branch}/"
        expect(`bundle exec giturl #{repo_path}`.chomp).to eq top_url
      end

      it 'outputs github URL for giturl under lib' do
        lib_url = "#{repo_url}tree/#{encoded_branch}/lib/"
        expect(`bundle exec giturl #{repo_path}/lib/`.chomp).to eq lib_url
      end

      it 'outputs plural URLs' do
        top_url = "#{repo_url}tree/#{encoded_branch}/"
        lib_url = "#{repo_url}tree/#{encoded_branch}/lib/"
        expect(`bundle exec giturl #{repo_path} #{repo_path}/lib`.chomp).to eq "#{top_url}\n#{lib_url}"
      end

      it 'outputs github URL for current directory' do
        lib_url = "#{repo_url}tree/#{encoded_branch}/lib/"
        lib_dir = "#{repo_path}/lib"
        expect(`bundle exec \'(cd #{lib_dir} > /dev/null && giturl .)\'`.chomp).to eq lib_url
      end

      it 'outputs github URL for current directory without being specified dirs' do
        lib_url = "#{repo_url}tree/#{encoded_branch}/lib/"
        lib_dir = "#{repo_path}/lib"
        expect(`bundle exec \'(cd #{lib_dir} > /dev/null && giturl)\'`.chomp).to eq lib_url
      end
    end

    # Run without a shell of our own, so that what is tested is giturl handling
    # the directory name rather than this spec quoting it.
    context 'when the directory name contains a space and a quote' do
      let(:repository) { FixtureRepository.new(branch: 'main', name: "it's my repo") }

      after { repository.remove! }

      it 'outputs github URL' do
        out, = Open3.capture2('bundle', 'exec', 'giturl', repository.path)
        expect(out.chomp).to eq 'https://github.com/shinyaohtani/giturl/tree/main/'
      end
    end
  end
end
