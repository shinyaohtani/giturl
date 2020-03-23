# frozen_string_literal: true

RSpec.describe Giturl::Giturl do
  it 'nil for Non-git managed dir' do
    expect(described_class.url('/dev/null')).to eq nil
  end
end
