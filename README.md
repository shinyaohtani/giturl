[![Gem Version](https://badge.fury.io/rb/giturl.svg)](https://badge.fury.io/rb/giturl)
# Welcome to giturl !

## What is giturl?

`giturl`: A simple navigation tool for GitHub pages from local git-cloned directories Working deep in a git-cloned project and need to view its GitHub page? `giturl` simplifies this for you. A single command unveils your repository's URL. Want more? It also opens your browser and goes straight to the page -- no extra steps needed. `giturl` streamlines your workflow, merging simplicity with sophistication.

You can use `giturl` like:

```sh
$ giturl .
https://github.com/shinyaohtani/giturl/tree/master/lib/giturl/
```

and `--open`, or simply `-o` option is given, your default browser opens the URLs

```sh
$ giturl -o .
https://github.com/shinyaohtani/giturl/tree/master/lib/giturl/
# == your default browser automatically opens the URL ==
```
Browser cooperation works on any OS of macOS, Windows and Linux.

## Usage

```usage
Usage: giturl [options] [dirs]
 [dirs]:
   Target directories. Omit this when you only specify "."

 [options]:
    -o, --open                       Open the URL in your browser. default: no
    -a, --app [APPNAME]              Specify a browser. i.e. "Safari.app"
    -v, --verbose                    Verbose mode. default: no
    -h, --help                       Show this message
    -V, --version                    Show version
```

You can specify several directories at once. If `--verbose` is specified, print warnings for non-git-managed dirs:

```sh
$ giturl --verbose ~
Not git-managed-dir:  /Users/myhome
```

You can specify a browser to open:

```sh
### Chrome ###
$ giturl --open --app="Google\ Chrome.app" .
### Safari ###
$ giturl --open --app="Safari.app" .
### any other is ok ###
$ giturl --open --app="/Applications/any_browser_you_have.app" .
```

When you specify `--app`, you often forget to specify `--open` at the same time, but don't worry. If `--app` is specified and `--open` is forgotten, it automatically operates as if `--open` was specified.

If no directory is specified, the behavior is the same as when the current directory is specified.

```sh
$ giturl -o
$ giturl
#   These are completely same as:
$ giturl -o  .
$ giturl  .
```

## Usecase

The following is an example of opening a GitHub web page for the current directory:

```sh
$ git clone git@github.com:shinyaohtani/giturl.git
$ cd giturl/lib/giturl/

# (working here)
# (some editing, like vim version.rb......)
# (then you want to access the GitHub web page for current dir.)

$ giturl -o .
https://github.com/shinyaohtani/giturl/tree/master/lib/giturl/

# == your default browser automatically opens the URL ==
```

## Installation

Install `giturl` as:

    $ gem install giturl

Or add `giturl` to your application's Gemfile and run `bundle` command:

```ruby
gem 'giturl'
```

## Giturl module

`Giturl` is also a module, so you can get urls from your ruby code.
(*G*iturl is a name of module version of `giturl`)

```ruby
require 'giturl'

path = './lib'
url = Giturl::Giturl.url(path)
p url unless url.nil?
```

See [code](./lib/giturl.rb)

## Changelog

Refer to [Changelog.md](./CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome!
1. Fork it ( https://github.com/shinyaohtani/giturl )
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
Refer to [LICENSE file](./LICENSE)

## RubyGems

https://rubygems.org/gems/giturl
