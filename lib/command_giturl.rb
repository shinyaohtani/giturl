#!/usr/bin/env ruby
# frozen_string_literal: true

# converter module from path to url
module Giturl
  require 'optparse'
  require 'giturl'

  # command line wrapper
  class CommandGiturl
    attr_accessor :params

    def parse_options
      @params = {}
      OptionParser.new do |opts|
        opts.version = VERSION
        opts.on('-o', '--open', 'Open the URL in your browser. default: no') { |v| v }
        opts.on('-a APPNAME', '--app=APPNAME', 'Specify a browser. "Safari.app"') { |v| v }
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
           [options] are:
        BANNER

        opts.parse!(ARGV, into: @params)
      end
    end

    def run
      ARGV.each do |arg|
        if Giturl.git_managed?(arg)
          url = Giturl.convert(arg)
          print "#{url}\n"
          if @params[:open]
            comm = +"open #{url}"
            comm << " -a #{@params[:app]}" if @params[:app]
            system(comm)
          end
        elsif @params[:verbose]
          print "Not git-managed-dir:  #{arg}\n"
        end
      end
    end
  end
end
