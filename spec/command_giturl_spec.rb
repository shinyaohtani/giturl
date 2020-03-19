# frozen_string_literal: true

RSpec.describe 'giturl command' do
  it 'nil for Non-git managed dir' do
    expect(`bundle exec giturl /dev/null`.chomp).to eq ''
    expect(`bundle exec giturl -v /dev/null`.chomp).to eq 'Not git-managed-dir:  /dev/null'
    expect(`bundle exec giturl --verbose /dev/null`.chomp).to eq 'Not git-managed-dir:  /dev/null'
  end
end
