# AceBook
This is an API application. The controllers present are users, sessions, posts and the api controller. The user controller enables the creation of a user checking the uniqueness of the username and email against the database, whether the  email is valid and whether the password is between 6-10 characters. The sessions controller enables creation of a session, checking that the username is within the database and that it matches the saved password. The posts controller enables viewing of all posts, showing a singular post, creating, updating and deleting a post. The post must belong to the user in order for them to edit it. All methods return a json formatted output so they can be easily read by a frontend app.

## Set up
1) Fork and clone this repository.
2) In your terminal run:
```
$ bundle install
```
3) To create required databases run:
```
$ rails db:create
```
```
$ rails db:migrate
```
4) To run this API locally, run:
```
$ rails server
```
4) Link this deployed repository to a frontend application, we recommend using [this Acebook frontend](https://github.com/R34P3R44/AcebookFrontend)
5) To run the tests, in your terminal, run:
```
$ rspec
```

## Technologies Used
- Rails 
- Ruby
- RSpec: for testing
- Travis: checks code quality checks and rspec tests then deploys to heroku
- Simplecov: testing test coverage

## Group Planning
- [Trello board](https://trello.com/b/dhBtns1K/acebook)
