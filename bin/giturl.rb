#!/usr/bin/env ruby
# frozen_string_literal: true

#
# usage
#  giturl.rb [-o or --open] dir1 [dir2, dir3, ...]
# output
#  <url of dir1> [<url of dir2>, <url of dir3>, ...]
#  and if -o is given, open urls on a browser.
#

require 'optparse'
opt = OptionParser.new
opt.on('-o', '--open', 'Open corresponding URLs with your browser.') { |v| v }
params = {}
opt.parse!(ARGV, into: params)

ARGV.each do |arg|
  remote_origin_url = `git -C #{arg} config --get remote.origin.url`.chomp
  baseurl = remote_origin_url.gsub(/^.*@/, '').gsub(/\.git$/, '').gsub(/:/, '/').gsub(/^/, 'https://')

  gitdir_prefix = `git -C #{arg} rev-parse --show-prefix`.chomp
  gitdir_branch = `git -C #{arg} rev-parse --abbrev-ref HEAD`.chomp
  url = "#{baseurl}/tree/#{gitdir_branch}/#{gitdir_prefix}"

  print "#{url}\n"
  system("open #{url}") if params[:open]
end
