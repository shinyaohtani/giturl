# Welcome to giturl !

## What is giturl?

`giturl` is a helper for accessing GitHub web pages. Do you often want to access the GitHub web page from the terminal you are working on? You can use `giturl` to display the URL corresponding to the git-managed directory given as an argument. If you want to open the URL in a browser immediately, you can specify the `girurl` option to open the URL in the browser without operating the browser. `giturl` is a simple command. you can easily use from now on.

You can use `giturl` like:

```sh
$ giturl .
https://github.com/shinyaohtani/giturl/tree/master/lib/giturl/
```

and `--open`, or simply `-o` option is given, your browser opens the URLs

```sh
$ giturl -o .
https://github.com/shinyaohtani/giturl/tree/master/lib/giturl/
# == your default browser automatically opens the URL ==
```

## Usage

    giturl [-o or --open] [-v or --verbose]  dir1 [dir2, dir3, ...]

Then you will get a list of URLs:

    URL1 [URL2, URL3, ...] (one URL for each line)

If `--verbose` is specified, print warnings for non-git-managed dirs:

```sh
$ giturl -v ~
Not git-managed-dir:  /Users/myhome
```

## Usecase

Here is a example to open GitHub web page for current directory:

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
