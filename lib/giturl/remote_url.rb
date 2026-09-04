# frozen_string_literal: true

module Giturl
  # The URL of a git remote, as `remote.origin.url` reports it, and the https
  # form of the same place. An scp-style URL may name a Host alias from
  # ~/.ssh/config (git@github.com-work:owner/repo.git) rather than a real
  # hostname, so the alias is resolved through ssh before the URL is rewritten.
  class RemoteUrl
    ALIAS = /@(.*?):/

    def initialize(raw)
      @raw = raw
    end

    # @return [String] the https form of this remote
    def https
      resolved.tr(':', '/').gsub(/^.*@/, 'https://').gsub(/\.git$/, '')
    end

    private

    # @return [String] the raw URL with any Host alias replaced by the real hostname
    def resolved
      matched = @raw.match(ALIAS)
      return @raw unless matched

      host_alias = matched[1]
      real = hostname(host_alias)
      return @raw if real.nil? || real == host_alias

      @raw.sub(host_alias, real)
    end

    # @param host_alias [String] a Host entry from ~/.ssh/config
    # @return [String, nil] the HostName ssh resolves it to, nil if ssh says nothing
    def hostname(host_alias)
      line = `ssh -G #{host_alias} 2>#{File::NULL}`.lines.find { |candidate| candidate =~ /^hostname / }
      return nil unless line

      line.split[1]
    end
  end
end
