# Stock & Finance Tracker
* Dependency and security updates not supported.

#### Versions

- Ruby version: 2.6.1
- Rails version: 6.0.3

### App Covers:

- [Devise](https://rubygems.org/gems/devise/versions/4.2.0) Flexible authentication solution for Rails with Warden.
  - `gem "devise"`
  - [https://github.com/hisea/devise-bootstrap-views](https://github.com/hisea/devise-bootstrap-views)

- [Bootstrap](https://getbootstrap.com/) CSS Library
  - `yarn add bootstrap@4.3.1 jquery popper.js`
  - `application.css`, `environment.js`, `custom.css.scss`, `application.js`

- Intergrating API
  - This particular api is [IEX Cloud](https://iexcloud.io/) Financial Data
  - [https://github.com/dblock/iex-ruby-client](https://github.com/dblock/iex-ruby-client)

- Handle API exceptions.
  - `stock.rb`, `stocks_controller.rb` - A basic handling of the exception.

- Using `credentials.yml.enc` & `master.key`.
  - `rails credentials:edit` - To specify VS Code - `EDITOR="code --wait" rails credentials:edit`
  - `Rails.application.credentials.key_name[:value]`

- Stock Model
  - `rails g model Stock ticker:string name:string last_price:decimal`

- Using ajax
  - `my_portfolio.html.erb`, `_stock_result.js.erb`, `stocks_controller.rb`
  - `remote: true`

- Adding columns to devise and using them.
  - `application_controller`, `user.rb`, `20200514015736_add_first_last_name_to_users.rb`

- Searching multiple fields of a table.
  - `user.rb`, `users_controller.rb`, `friendships_controller.rb`, `user_stocks_controller.rb`, `_friend_result.html.erb`, `_stock_result.html.erb`
  - Using also create and build to add what is searched.

* Based on course from Udemy: Instructors - Rob Percival & Mashrur Hossain

##### Notes
  - [https://github.com/bokmann/font-awesome-rails](https://github.com/bokmann/font-awesome-rails)

#### Potentially unneeded files

- app/helpers/welcome_helper.rb
- app/assets/stylesheets/welcome.scss
