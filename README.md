# CoffeeRun Social App (version 1.0)

## Getting started

1. clone the repo, `cd` into directory
```
$ git clone https://github.com/seantan22/coffeerun-social.git
$ cd coffeerun-social
```

2. install packages
```
$ yarn add jquery@3.5.1 bootstrap@3.4.1
$ bundle install
```

3. migrate the database
```
$ rails db:migrate
```
4. seed the database with sample users (optional)
```
$ rails db:seed

```

5. run app in local server
```
$ rails server

```
You can then register a new user or log in as the seed admin user with the email `coffeerun@coffeerun.com` and password `coffeerun`.
