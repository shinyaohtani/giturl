# frozen_string_literal: true

RSpec.describe Giturl::Giturl do
  context 'when non-git-managed dir was given' do
    describe '#url' do
      it 'returns nil' do
        expect(described_class.url('/dev/null')).to eq nil
      end
    end

    describe '#git_managed?' do
      it 'returns false' do
        expect(described_class).not_to be_git_managed('/dev/null')
      end
    end
  end

  context 'when git-managed directory was specified' do
    let(:general_work) { File.expand_path('../../test/', __dir__) }
    let(:test_name) { Time.now.to_s.tr(' ', '_').delete(':') + '-' + SecureRandom.alphanumeric(4) }
    let(:repository) { 'git@github.com:shinyaohtani/giturl.git' }
    let(:repo_url) { 'https://github.com/shinyaohtani/giturl/' }
    let(:test_branch) { "test/#3_SampleRepo/\\\"-'_\"'!'\"-<>()" }
    let(:top_url) { repo_url + 'tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/' }

    before do
      system("mkdir -p #{general_work}/#{test_name}")
      system("git -C #{general_work}/#{test_name} clone -q -b \"#{test_branch}\" #{repository}")
    end

    after do
      system("tar cfz #{general_work}/#{test_name}.tgz -C #{general_work} #{test_name}")
      system("rm -rf #{general_work}/#{test_name}")
    end

    describe '#url' do
      it 'outputs github URL for giturl on testing branch #url' do
        expect(described_class.url("#{general_work}/#{test_name}/giturl")).to eq top_url
      end
    end

    describe '#convert' do
      it 'outputs github URL for giturl on testing branch #convert' do
        expect(described_class.convert("#{general_work}/#{test_name}/giturl")).to eq top_url
      end
    end

    describe '#git_managed?' do
      it 'outputs github URL for giturl on testing branch' do
        expect(described_class).to be_git_managed("#{general_work}/#{test_name}/giturl")
      end
    end
  end
end
