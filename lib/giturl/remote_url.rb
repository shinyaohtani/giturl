# frozen_string_literal: true

module Giturl
  # The URL of a git remote, as `remote.origin.url` reports it, and the https
  # page that serves the same repository.
  #
  # A remote is written either as an scp-style address
  # (git@github.com:owner/repo.git) or as a URL carrying a scheme
  # (https://, ssh://, git://). Only the scp-style form can name a Host alias
  # from ~/.ssh/config (git@github.com-work:owner/repo.git) in place of a real
  # hostname, so that is the only form ssh is asked about.
  class RemoteUrl
    SCHEMED = %r{\A[a-z][a-z0-9+.-]*://(?:[^@/]*@)?(?<host>[^/:]+)(?::\d+)?/(?<path>.*)\z}i
    SCP = %r{\A(?:[^@/]+@)?(?<host>[^/:]+):(?<path>.*)\z}

    def initialize(raw)
      @raw = raw
    end

    # Anything neither form recognizes is handed back untouched: it names no
    # host, so there is no page to point at.
    #
    # @return [String] the https URL of the page this remote is served from
    def https
      schemed = SCHEMED.match(@raw)
      return page(schemed[:host], schemed[:path]) if schemed

      scp = SCP.match(@raw)
      return @raw unless scp

      page(hostname(scp[:host]) || scp[:host], scp[:path])
    end

    private

    # @return [String] https://<host>/<path>, without the .git git clones carry
    def page(host, path)
      "https://#{host}/#{path.delete_suffix('.git')}"
    end

    # @param host_alias [String] a Host entry from ~/.ssh/config
    # @return [String, nil] the HostName ssh resolves it to, nil if ssh says nothing
    def hostname(host_alias)
      output = IO.popen(['ssh', '-G', host_alias], err: File::NULL, &:read)
      line = output.lines.find { |candidate| candidate =~ /^hostname / }
      return nil unless line

      line.split[1]
    end
  end
end
