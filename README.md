Insight Data Engineering - Coding Challenge - John Richardson
===========================================================

Tools to help analyze the community of Twitter users.

## Tool summary

The tools consist of the following two classes:

1. TweetsClean: removes non-unicode and escape characters.

2. AverageDegree: calculates the average degree of a vertex in a Twitter hashtag graph for the last 60 seconds, and update this each time a new tweet appears.


## Dependencies

You must install `bundler` before and run `bundle install` before attempting to run shell script. See below for instructions on how to install and run bundler commands.


## Tests

Tests for both features are written in rspec. To insall rspec, first install bundler on you system with the following command:

```
gem install bundler
```

Once bundle is installed, run the following commanded to install the gems associated with this project

```
bundle install
```

To run test suite, run the following command from the project root directory

```
bundle exec rspec
```
