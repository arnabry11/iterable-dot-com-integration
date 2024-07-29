# Iterable Integration

A project for demonstrating integration of [iterable.com](https://api.iterable.com/api/docs). This is a very project which lets users sign_in/sign_up and subscribe themselves to some ongoing events. After that they will receive notifications for some of the events.

# Development

### System dependencies
- Install Ruby 3.3.4 with [RVM](https://rvm.io/rvm/install).

### Install dependencies
```
gem install bundler

bundle install
```

### Setup database
`rails db:setup`

### Code style and linting
```
rubocop         # Check Ruby code style warning and errors
rubocop -A      # Auto fix Ruby code style warning and errors

```

### Start servers
```
rails s
```

### Unit tests
The project uses rspec for unit tests.

