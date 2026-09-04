# frozen_string_literal: true

require 'optparse'
require 'giturl/version'

module Giturl
  # The options giturl accepts on the command line, and the values a given
  # command line puts in them.
  class Options
    def initialize
      @values = {}
    end

    # Consumes the options from argv, leaving the target directories behind.
    # `--app` names a browser, which only makes sense together with `--open`,
    # so it turns `--open` on by itself.
    #
    # @param argv [Array<String>] the command line, modified in place
    # @return [Hash] the values given, keyed by long option name
    def parse!(argv)
      OptionParser.new do |opts|
        definitions(opts).parse!(argv, into: @values)
        @values[:open] = true if @values.key?(:app)
      end
      @values
    end

    private

    # @return [OptionParser] opts, with every giturl option declared on it
    def definitions(opts)
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
      opts.banner = banner(opts)
      opts
    end

    # @return [String] the description and usage shown above the option list
    def banner(opts)
      <<~BANNER

        #{opts.ver}
        #{DESCRIPTION}
        Usage: #{opts.program_name} [options] [dirs]
         [dirs]:
           Target directories. Omit this when you only specify "."

         [options]:
      BANNER
    end
  end
end
