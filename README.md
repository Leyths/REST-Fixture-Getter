REST-Fixture-Getter
===================

Downloads a Nitro feed and names and saves to appropriate fixture directory for testers and developers to use.

Usage instructions:

1. Download zip of this project and extract somewhere.
2. From your terminal change directory to the REST-Fixture-Getter directory you just extracted.
3. Make sure you have [RubyGems](http://rubygems.org/pages/download) installed
4. Run `gem install bundler`
5. Run `bundle install` to install project dependencies
6. Edit the `config.ini` file to include a path to your BBC certificate. 
7. Now run `ruby get-fixture.rb` and follow instructions to use