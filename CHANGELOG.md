# Changelog

## [v1.4.1](https://github.com/shinyaohtani/giturl/tree/v1.4.1) (2026-09-05)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.4.0...v1.4.1)

- The first release on RubyGems to require Ruby 3.2, since v1.4.0 was
  tagged but never pushed there. Everything v1.4.0 describes applies
  here too, so read its entry below as part of this release.
- Directories whose name contains a space or a shell metacharacter now
  work, and remotes written as a URL (`https://`, `ssh://`, `git://`)
  now convert correctly.

**Fixed bugs:**

- https:// remotes produce a malformed URL \(https///github.com/...\) [\#41](https://github.com/shinyaohtani/giturl/issues/41)
- Paths containing spaces or shell metacharacters are not escaped [\#40](https://github.com/shinyaohtani/giturl/issues/40)

**Merged pull requests:**

- Run git without a shell, and parse remotes properly [\#44](https://github.com/shinyaohtani/giturl/pull/44) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.4.0](https://github.com/shinyaohtani/giturl/tree/v1.4.0) (2026-09-04)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.6...v1.4.0)

- Tagged but never published to RubyGems: two bugs were found before it
  was pushed, so v1.4.1 went out in its place with the same changes plus
  those fixes. `gem install giturl` never sees this version.
- **Ruby 3.2 or later is now required.**
  - On Ruby 2.x, install the last release that supported it: `gem install giturl -v 1.3.6`
- No changes in behavior
  - `Giturl::Giturl.url` / `.convert` / `.git_managed?` keep their signatures and results.
  - The code behind them was reorganized into classes that each hold one responsibility.

**Closed issues:**

- Refactor into noun classes: behavior lives in class methods, responsibilities are mixed [\#43](https://github.com/shinyaohtani/giturl/issues/43)

**Merged pull requests:**

- Refactor into noun classes per the Ruby refactoring standard [\#42](https://github.com/shinyaohtani/giturl/pull/42) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.3.6](https://github.com/shinyaohtani/giturl/tree/v1.3.6) (2026-09-03)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.5...v1.3.6)

- Same code as v1.3.5. Re-released solely to link the fixes below to
  the issues that describe them, which v1.3.5 shipped without.

**Fixed bugs:**

- bundle exec rubocop crashes on Ruby 4.0 \(LoadError: benchmark\) [\#36](https://github.com/shinyaohtani/giturl/issues/36)
- rspec suite fails: fixture branch no longer exists on GitHub [\#35](https://github.com/shinyaohtani/giturl/issues/35)
- giturl . outputs nothing at the repository root [\#34](https://github.com/shinyaohtani/giturl/issues/34)

**Closed issues:**

- Dependencies and Ruby version are far behind current releases [\#38](https://github.com/shinyaohtani/giturl/issues/38)
- No CI workflow to catch regressions [\#37](https://github.com/shinyaohtani/giturl/issues/37)

## [v1.3.5](https://github.com/shinyaohtani/giturl/tree/v1.3.5) (2026-09-03)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.4...v1.3.5)

- Yanked: shipped without the tracking issues linked below, so it's
  undiscoverable what this release actually fixed. Superseded by
  v1.3.6, which has the same code plus the corrected changelog.

**Merged pull requests:**

- Fix root-dir bug, make specs hermetic, add CI, update all deps to latest [\#33](https://github.com/shinyaohtani/giturl/pull/33) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.3.4](https://github.com/shinyaohtani/giturl/tree/v1.3.4) (2024-02-24)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.3...v1.3.4)

- No changes in behavior
  - code refactoring only.

**Closed issues:**

- none

## [v1.3.3](https://github.com/shinyaohtani/giturl/tree/v1.3.3) (2024-02-24)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.2...v1.3.3)

- No changes in behavior
  - code refactoring only.

**Closed issues:**

- none

## [[v1.3.2](https://github.com/shinyaohtani/giturl/tree/v1.3.2) (2020-05-10)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.1...v1.3.2)

- No changes in behavior
  - code refactoring only.

**Closed issues:**

- Refactoring that isn't needed [\#27](https://github.com/shinyaohtani/giturl/issues/27)

**Merged pull requests:**

- Non urgent refactoring \#27 [\#28](https://github.com/shinyaohtani/giturl/pull/28) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.3.1](https://github.com/shinyaohtani/giturl/tree/v1.3.1) (2020-04-14)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.3.0...v1.3.1)

**Summary:**

- No changes for users are included.

**Closed issues:**

- Introduce Rubocop-performance for readability [\#23](https://github.com/shinyaohtani/giturl/issues/23)

**Merged pull requests:**

- Introduced Rubocop-performance [\#24](https://github.com/shinyaohtani/giturl/pull/24) ([shinyaohtani](https://github.com/shinyaohtani))

**Other related topic:**
- Created PR [\#794](https://github.com/github-changelog-generator/github-changelog-generator/pull/794) about github_changelog_generator on which giturl depends

## [v1.3.0](https://github.com/shinyaohtani/giturl/tree/v1.3.0) (2020-04-08)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.2.1...v1.3.0)

**Implemented enhancements:**

- Support for Windows and Linux! [\#2](https://github.com/shinyaohtani/giturl/issues/2)

**Merged pull requests:**

- Feature/\#2 support windows linux [\#17](https://github.com/shinyaohtani/giturl/pull/17) ([shinyaohtani](https://github.com/shinyaohtani))
- fixed an Abc warning from rubocop [\#16](https://github.com/shinyaohtani/giturl/pull/16) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.2.1](https://github.com/shinyaohtani/giturl/tree/v1.2.1) (2020-03-27)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.2.0...v1.2.1)

**Implemented enhancements:**

- Open application even if --app alone without --open [\#13](https://github.com/shinyaohtani/giturl/issues/13)

**Merged pull requests:**

- Issue \#13 support for forgetting `--open` with `--app` [\#14](https://github.com/shinyaohtani/giturl/pull/14) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.2.0](https://github.com/shinyaohtani/giturl/tree/v1.2.0) (2020-03-24)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.6...v1.2.0)

**Implemented enhancements:**

- Basic UI changed
  - Current directory is processed, even if no directory is specified. [\#8](https://github.com/shinyaohtani/giturl/issues/8)
    - i.e. `giturl -o .` and `giturl -o` behave exactly same.

**Merged pull requests:**

- Feature/\#8 if no directories are specified [\#11](https://github.com/shinyaohtani/giturl/pull/11) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.1.6](https://github.com/shinyaohtani/giturl/tree/v1.1.6) (2020-03-23)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.5...v1.1.6)

**Implemented enhancements:**

- Test code should be prepared [\#3](https://github.com/shinyaohtani/giturl/issues/3)

**Merged pull requests:**

- Feature/\#3 test code [\#9](https://github.com/shinyaohtani/giturl/pull/9) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.1.5](https://github.com/shinyaohtani/giturl/tree/v1.1.5) (2020-03-18)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.4...v1.1.5)

**Implemented enhancements:**

- Specify a browser to open [\#1](https://github.com/shinyaohtani/giturl/issues/1)

**Fixed bugs:**

- Encoding is required if the branch name contains '\#' etc. [\#4](https://github.com/shinyaohtani/giturl/issues/4)

**Merged pull requests:**

- bugfix: encoded the target branch name [\#6](https://github.com/shinyaohtani/giturl/pull/6) ([shinya-ohtani](https://github.com/shinya-ohtani))
- Feature/\#1 specify a browser to open [\#5](https://github.com/shinyaohtani/giturl/pull/5) ([shinyaohtani](https://github.com/shinyaohtani))

## [v1.1.4](https://github.com/shinyaohtani/giturl/tree/v1.1.4) (2020-03-16)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.3...v1.1.4)

**Implemented enhancements:**

- Changed method name
  - url to convert:  low level method. git-managed dir only
  - safe_url to url: check if git-managed and convert to url

## [v1.1.3](https://github.com/shinyaohtani/giturl/tree/v1.1.3) (2020-03-16)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.2...v1.1.3)

**Implemented enhancements:**

- Improved README.md so that you can understand what `giturl` is immediately
- Improved description for `--help` and `--version` options

## [v1.1.2](https://github.com/shinyaohtani/giturl/tree/v1.1.2) (2020-03-13)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.1...v1.1.2)

**Implemented enhancements:**

- Described CHANGELOG.md and linked to it from README.md
- Added license item to README.md

## [v1.1.1](https://github.com/shinyaohtani/giturl/tree/v1.1.1) (2020-03-12)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.1.0...v1.1.1)

**Implemented enhancements:**

- Updated description for giturl in the giturl.gemspec to make it easier to understand what giturl is.

**Fixed bugs:**

- Fatal: Fixed an issue that giturl could not be run at all from the command line 

## [v1.1.0](https://github.com/shinyaohtani/giturl/tree/v1.1.0) (2020-03-12)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.5...v1.1.0)

**Implemented enhancements:**

- Modularized main function, so now you can call Giturl as a module from your ruby code.

## [v1.0.5](https://github.com/shinyaohtani/giturl/tree/v1.0.5) (2020-03-12)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.4...v1.0.5)

**Implemented enhancements:**

- Updated README.md
- Formatted code by rubocop automatically

## [v1.0.4](https://github.com/shinyaohtani/giturl/tree/v1.0.4) (2020-03-12)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.3...v1.0.4)

**Implemented enhancements:**

- Described how to install and how to use on README.md

## [v1.0.3](https://github.com/shinyaohtani/giturl/tree/v1.0.3) (2020-03-11)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.2...v1.0.3)

**Fixed bugs:**

- Fatal: Fixed not following RubyGems format so it works correctly

## [v1.0.2](https://github.com/shinyaohtani/giturl/tree/v1.0.2) (2020-03-11)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.1...v1.0.2)

**Fixed bugs:**

- Fatal: Fixed not following RubyGems format so it works correctly

## [v1.0.1](https://github.com/shinyaohtani/giturl/tree/v1.0.1) (2020-03-11)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/v1.0.0...v1.0.1)

**Fixed bugs:**

- Fatal: Fixed not following RubyGems format so it works correctly

## [v1.0.0](https://github.com/shinyaohtani/giturl/tree/v1.0.0) (2020-03-11)

[Full Changelog](https://github.com/shinyaohtani/giturl/compare/65c0df17e303408e2c8752b70b706ef3595f0b49...v1.0.0)

**Implemented enhancements:**

- First release!


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
