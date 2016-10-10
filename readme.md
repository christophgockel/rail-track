# Rail Track

This is the example Rails application that is used for a refactoring blog post series published on [8thlight.com](https://8thlight.com/blog):

- [Getting Rails on Track - Part 1: Models](https://8thlight.com/blog/christoph-gockel/2016/10/19/getting-rails-on-track-part-1-models.html)
- [Getting Rails on Track - Part 2: Views](https://8thlight.com/blog/christoph-gockel/2016/10/26/getting-rails-on-track-part-2-views.html)
- [Getting Rails on Track - Part 3: Controllers](https://8thlight.com/blog/christoph-gockel/2016/11/02/getting-rails-on-track-part-3-controllers.html)

The three different branches ([`part-1-models`](https://github.com/christophgockel/rail-track/tree/part-1-models), [`part-2-views`](https://github.com/christophgockel/rail-track/tree/part-2-views), [`part-3-controllers`](https://github.com/christophgockel/rail-track/tree/part-3-controllers)) build upon each other and show step by step &ndash; or commit by commit &ndash; how to separate the specific concerns discussed in the corresponding blog posts.


## Motivation

Traditionally Rails follows an MVC approach to structure our application.
Models represent database tables&mdash;for the most part.
Views are the HTML pages we interact with through the browser.
Controllers mediate between actions triggered via the view and corresponding modifications on a model (think submitting a form to update a database record).

That's a great and straight forward approach for small applications.
But having only three &ldquo;buckets&rdquo; to put the different parts of our application into is not enough anymore once our application starts growing.

In the blog post series we're going hands-on through the steps that can help transform the design of a default Rails application into one with clearer responsibilities and that is easier to test.


## Setup

After cloning the repository make sure to bundle all dependencies.

```
bundle install
```

Then set up the inital database structure and content.

```
bundle exec rake db:setup
```

Once that's done start up the application.

```
bundle exec rails s
```

The application should be available at [localhost:3000](http://localhost:3000) now.


### Environment Components

- Ruby 2.3.1
- Rails 4.2.1
- SQLite


#### Acknowledgements

Source of the movie description data used for [seeds](https://github.com/christophgockel/rail-track/blob/master/db/seeds.rb) is from [imdb.com](https://www.imdb.com).

