# frozen_string_literal: true

require 'erb'

module Giturl
  # Where a directory sits inside its repository: the path from the repository
  # root down to it, the branch checked out, and the URL of the remote it came
  # from. Immutable; built by GitDirectory from what git reports.
  Location = Data.define(:prefix, :branch, :remote) do
    # @return [Boolean] whether git answered with everything a URL needs.
    #   prefix is legitimately empty at the repository root, so it is not required.
    def complete?
      !branch.empty? && !remote.empty?
    end

    # @return [String] the branch in the form a URL path can carry, each segment
    #   percent-encoded but the separating slashes left intact
    def encoded_branch
      branch.split('/').map { |segment| ERB::Util.url_encode(segment) }.join('/')
    end
  end
end
