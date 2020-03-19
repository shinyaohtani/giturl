# frozen_string_literal: true

RSpec.describe 'Giturl module' do
  it 'nil for Non-git managed dir' do
    expect(Giturl::Giturl.url('/dev/null')).to eq nil
  end
end
