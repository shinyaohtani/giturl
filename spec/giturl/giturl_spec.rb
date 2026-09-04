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
end
