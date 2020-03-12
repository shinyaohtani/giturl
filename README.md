# giturl

Welcome to giturl!  Do you often want to access the GitHub web page from the terminal you are working on? You can use `giturl` to display the URL corresponding to the git-managed directory given as an argument, and open the URL directly in your browser if needed. `giturl` is a simple command. you can easily use from now on.

## Installation

Install `giturl` as:

    $ gem install giturl

Or add `giturl` to your application's Gemfile and run `bundle` command:

```ruby
gem 'giturl'
```

## Usage

If you have it installed, you can use `giturl` as follows:

    giturl [-o or --open] dir1 [dir2, dir3, ...]

Then you will get a list of URLs:

    URL1 [URL2, URL3, ...] (one URL for each line)

and if `--open` is given, open the URLs on your browser.
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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shinyaohtani/giturl
