# frozen_string_literal: true

RSpec.describe Giturl::Giturl do
  context 'when non-git-managed dir was given' do
    describe '#url' do
      it 'returns nil' do
        expect(described_class.url(File::NULL)).to be_nil
      end
    end

    describe '#git_managed?' do
      it 'returns false' do
        expect(described_class).not_to be_git_managed(File::NULL)
      end
    end
  end

  context 'when git-managed directory was specified' do
    let(:test_branch) { "test/#3_SampleRepo/\"-'_!-<>()" }
    let(:top_url) { 'https://github.com/shinyaohtani/giturl/tree/test/%233_SampleRepo/%22-%27_%21-%3C%3E%28%29/' }
    let(:repository) { FixtureRepository.new(branch: test_branch) }

    after { repository.remove! }

    describe '#url' do
      it 'outputs github URL for giturl on testing branch #url' do
        expect(described_class.url(repository.path)).to eq top_url
      end
    end

    describe '#convert' do
      it 'outputs github URL for giturl on testing branch #convert' do
        expect(described_class.convert(repository.path)).to eq top_url
      end
    end

    describe '#git_managed?' do
      it 'outputs github URL for giturl on testing branch' do
        expect(described_class).to be_git_managed(repository.path)
      end
    end
  end

  context 'when the directory name contains a space and a quote' do
    let(:page_url) { 'https://github.com/shinyaohtani/giturl/tree/main/' }
    let(:repository) { FixtureRepository.new(branch: 'main', name: "it's my repo", subdir: 'lib') }

    after { repository.remove! }

    it 'is recognized as git-managed' do
      expect(described_class).to be_git_managed(repository.path)
    end

    it 'outputs the github URL' do
      expect(described_class.url(repository.path)).to eq page_url
    end

    it 'outputs the github URL for a subdirectory of it' do
      expect(described_class.url(File.join(repository.path, 'lib'))).to eq "#{page_url}lib/"
    end
  end

  context 'when the remote is written as a URL rather than an scp-style address' do
    let(:page_url) { 'https://github.com/shinyaohtani/giturl/tree/main/' }

    it 'converts an https remote' do
      expect(url_for('https://github.com/shinyaohtani/giturl.git')).to eq page_url
    end

    it 'converts an https remote carrying a username' do
      expect(url_for('https://shinyaohtani@github.com/shinyaohtani/giturl.git')).to eq page_url
    end

    it 'converts an ssh remote' do
      expect(url_for('ssh://git@github.com/shinyaohtani/giturl.git')).to eq page_url
    end

    it 'converts an ssh remote carrying a port' do
      expect(url_for('ssh://git@github.com:22/shinyaohtani/giturl.git')).to eq page_url
    end

    it 'converts a git remote' do
      expect(url_for('git://github.com/shinyaohtani/giturl.git')).to eq page_url
    end
  end

  context 'when the remote is an scp-style address' do
    let(:page_url) { 'https://github.com/shinyaohtani/giturl/tree/main/' }

    it 'converts it' do
      expect(url_for('git@github.com:shinyaohtani/giturl.git')).to eq page_url
    end

    it 'converts it when the repository name carries no .git' do
      expect(url_for('git@github.com:shinyaohtani/giturl')).to eq page_url
    end
  end

  # Builds a repository on `remote`, reads its URL, and throws the repository away.
  def url_for(remote)
    repository = FixtureRepository.new(branch: 'main', remote: remote)
    described_class.url(repository.path)
  ensure
    repository&.remove!
  end
end
