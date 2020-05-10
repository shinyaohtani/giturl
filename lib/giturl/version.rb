# frozen_string_literal: true

module Giturl
  VERSION = '1.3.1'
  DESCRIPTION = <<~DESC
    A tiny helper for accessing GitHub web pages corresponding to local
    working directories.

    Have you ever wanted to access a GitHub web page while working on
    a git-cloned local directory?
    You can use 'giturl' to display the URL corresponding to the git-managed
    directory given as an argument. And furthermore, if you want to access
    the URL immediately with your browser, 'giturl' opens your browser and
    automatically accesses the URL without your any operation on the browser.
  DESC
  REPOSITORY_URL = 'https://github.com/shinyaohtani/giturl'
end
