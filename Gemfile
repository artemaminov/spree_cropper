source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree_core', '~> 3.7', github: 'spree/spree', branch: '3-7-stable'
gem 'spree_backend'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise'
gem 'rails-controller-testing'

gem 'mry'
gem 'rubocop', '~> 0.81.0', require: false
gem 'rubocop-rails'
gem 'rubocop-rspec', require: false

gemspec
