Spree Favorite Products
=======================

* Spree Favorite Products is an extension that allows the user to mark/unkmark a product as favorite from the product page.

* Admin can view which products have been marked as favorite, and by which users, on the Admin end.

* It gives user the ability to see all products marked as favorite by him/her.

Demo
----
Try Spree Favorite Products for Spree 3-1 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-favorite-products-3-1)

Try Spree Favorite Products for Spree 3-4 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-favorite-products-3-4)

Try Spree Favorite Products for Spree master with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/vinsol-spree-contrib/spree-demo-heroku/tree/spree-favorite-products-master)

Installation
------------

1. Add this extension to your Gemfile with this line:

  #### Spree >= 3.2

  ```ruby
  gem 'spree_favorite_products', github: 'vinsol-spree-contrib/spree_favorite_products'
  ```

  #### Spree < 3.2

  ```ruby
  gem 'spree_favorite_products', github: 'vinsol-spree-contrib/spree_favorite_products', branch: 'X-X-stable'
  ```

  The `branch` option is important: it must match the version of Spree you're using.
  For example, use `3-0-stable` if you're using Spree `3-0-stable` or any `3.0.x` version.

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Bundle your dependencies and run the installation generator:

  ```shell
  bundle
  bundle exec rails g spree_favorite_products:install
  ```

Testing
-------
  #### Spree >= 3.1

  For Building Dependencies:
  ```shell
  appraisal install
  ```

  The dummy app can be regenerated by using:
  ```shell
  appraisal spree-3-1 rake test_app

  ```
  This will run rake test_app using the dependencies configured for Spree 3.1. Similarly you can use spree-3-2 and spree-master for generating dummy applications using dependencies for Spree 3.2 and latest version of Spree


  ```shell
  appraisal spree-3-1 rspec
  ```
  This will run rspec using the dependencies configured for Spree 3.1. Similarly you can use spree-3-2 and spree-master to run rspec using dependencies for Spree 3.2 and latest version of Spree


  #### Spree 3.0 and Spree 2.x

  First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

  ```shell
  bundle
  bundle exec rspec spec
  ```

Contributing
------------

1. Fork the repo.
2. Clone your repo.
3. Run `bundle install`.
4. Run `bundle exec rake test_app` to create the test application in `spec/test_app`.
5. Make your changes.
6. Ensure specs pass by running `bundle exec rspec spec`.
7. Submit your pull request.

Credits
-------

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2017 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
