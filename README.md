ten-pin-bowling
===================
A command-line application to score a game of  ten-pin bowling

Developed by: `Harold Rangel Charris`

# Requirements

* Ruby 2.6.4
* RVM

# Installation

Some of the following steps are not strictly required. i.e: you can use a different ruby version manager.

* [Install RVM](https://rvm.io/rvm/install)
* rvm install ruby-2.6.4 (if needed)
* cd ten-pin_bowling
* gem install bundler (if needed)
* bundle install

# Getting Started

``
  $ rake ten_pin_bowling:load 'spec/fixtures/normal_input.txt'
``

More fixtures are included in "spec/fixtures" folder.

# Testing

The testing framework that was used is `RSpec`

In order to run the test suite, just run the following command:

```sh

  $ rspec spec

  ................................................................
  Finished in 0.02687 seconds (files took 0.11221 seconds to load)
  64 examples, 0 failures
```
