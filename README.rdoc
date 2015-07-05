# React Todo Application (Rails + React)

This project is a todo sample application for learning Rails and React.

## Prerequisites

- Ruby (>= 2.0)

## How to setup

- Install bundler if not installed

```
$ gem install bundler
```

- Clone this project to the local

```
$ git clone git@github.com:mmasashi/react-todo.git
```

- Change the current directory to `react-todo` and install required gems through bundler

```
$ cd react-todo
$ bundle install
```

- Setup database(sqlite3)

```
$ bundle exec rake db:setup
```

- Start rails

```
$ bundle exec rails s
```

- Access `http://localhost:3000` through your browser

