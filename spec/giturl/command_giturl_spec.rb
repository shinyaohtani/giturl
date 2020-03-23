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
      let(:general_work) { File.expand_path('../../test/', __dir__) }
      let(:test_name) { Time.now.to_s.gsub(' ', '_').gsub(':', '') + '-' + SecureRandom.alphanumeric(4) }
      let(:repository) { 'git@github.com:shinyaohtani/giturl.git' }
      let(:repo_url) { 'https://github.com/shinyaohtani/giturl/' }
      let(:test_branch) { "test/#3_SampleRepo/\\\"-'_\"'!'\"-<>()" }

      before do
        system("mkdir -p #{general_work}/#{test_name}")
        system("git -C #{general_work}/#{test_name} clone -q -b \"#{test_branch}\" #{repository}")
      end

      after do
        system("tar cfz #{general_work}/#{test_name}.tgz -C #{general_work} #{test_name}")
        system("rm -rf #{general_work}/#{test_name}")
      end

      it 'outputs github URL for giturl on testing branch' do
        top_url = repo_url + 'tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/'
        expect(`bundle exec giturl #{general_work}/#{test_name}/giturl`.chomp).to eq top_url
      end

      it 'outputs github URL for giturl under lib' do
        lib_url = repo_url + 'tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/lib/'
        expect(`bundle exec giturl #{general_work}/#{test_name}/giturl/lib/`.chomp).to eq lib_url
      end

      it 'outputs plural URLs' do
        top_url = repo_url + 'tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/'
        lib_url = repo_url + 'tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/lib/'
        top_dir = "#{general_work}/#{test_name}/giturl"
        lib_dir = "#{general_work}/#{test_name}/giturl/lib"
        expect(`bundle exec giturl #{top_dir} #{lib_dir}`.chomp).to eq "#{top_url}\n#{lib_url}"
      end
    end
  end
end
