#!/usr/bin/env ruby
# frozen_string_literal: true

# converter module from path to url
module Giturl
  require 'optparse'
  require 'giturl'
  require 'launchy'

  # command line wrapper
  class CommandGiturl
    attr_accessor :params

    def parse_options
      @params = {}
      OptionParser.new do |opts|
        opts = define_options(opts)
        opts.parse!(ARGV, into: @params)
        @params[:open] = true if @params.key?(:app)
      end
    end

    def run
      ARGV << '.' if ARGV.empty?
      ARGV.each do |arg|
        if Giturl.git_managed?(arg)
          url = Giturl.convert(arg)
          print "#{url}\n"
          browser_open(url) if @params[:open]
        elsif @params[:verbose]
          print "Not git-managed-dir:  #{arg}\n"
        end
      end
    end

    private

    def define_options(opts)
      opts.version = VERSION
      opts.on('-o', '--open', 'Open the URL in your browser. default: no') { |v| v }
      opts.on('-a [APPNAME]', '--app [APPNAME]', 'Specify a browser. i.e. "Safari.app"') { |v| v }
      opts.on('-v', '--verbose', 'Verbose mode. default: no') { |v| v }
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
      opts.on_tail('-V', '--version', 'Show version') do
        puts opts.ver
        exit
      end
      opts.banner = <<~BANNER

        #{opts.ver}
        A tiny utility that displays and opens GitHub URLs for your local directory.
          visit: https://github.com/shinyaohtani/giturl

        Usage: #{opts.program_name} [options] [dirs]
         [dirs]:
           Target directories. Omit this when you only specify "."

         [options]:
      BANNER
      opts
    end

    def browser_open(url)
      if @params[:app] && Launchy::Detect::HostOsFamily.detect.darwin?
        comm = +"open #{url}"
        comm << " -a #{@params[:app]}" if @params[:app]
        system(comm)
      else
        Launchy.open(url)
      end
    end
  end
end
