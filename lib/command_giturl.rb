#!/usr/bin/env ruby
# frozen_string_literal: true

require 'launchy'
require 'giturl'
require 'giturl/options'

# converter module from path to url
module Giturl
  # The giturl command: the directories named on the command line, and what the
  # user asked to have done with them.
  class CommandGiturl
    attr_accessor :params

    def initialize
      @options = Options.new
      @params = {}
    end

    # @return [Hash] the options given on the command line
    def parse_options
      @params = @options.parse!(ARGV)
    end

    # Prints a URL per target directory, and opens each in a browser when asked.
    # With no target given, the current directory is the target.
    def run
      ARGV << '.' if ARGV.empty?
      ARGV.each { |target| show(target) }
    end

    private

    # @param target [String] a directory named on the command line
    def show(target)
      directory = GitDirectory.new(target)
      unless directory.managed?
        print "Not git-managed-dir:  #{target}\n" if @params[:verbose]
        return
      end

      url = directory.url
      print "#{url}\n"
      browser_open(url) if @params[:open]
    end

    # Launchy cannot pick a specific application, so a named browser goes
    # through macOS `open` instead, where that is what the user is running.
    #
    # @param url [String] the URL to show
    def browser_open(url)
      if @params[:app] && Launchy::Detect::HostOsFamily.detect.darwin?
        system("open #{url} -a #{@params[:app]}")
      else
        Launchy.open(url)
      end
    end
  end
end
