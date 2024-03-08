# Bgit::FrontendAuth
Provides beegood it end user frontend authentication.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "bgit-frontend_auth"
```

And then execute:
```bash
$ bundle
```

Install the database migrations:
```bash
$ rails bgit_frontend_auth:install:migrations
$ rails db:migrate && rails db:test:prepare
```

Install the initializer and the routes:
```bash
$ rails generate bgit:frontend_auth:install
```

## Generating feature specs

```bash
$ rails g bgit:frontend_auth:feature_specs
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
