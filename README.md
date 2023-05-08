# Homey Project History Task

## About the application

Simple application serving as a project management tool here user can edit project, change its status and leave a comment.

## How to use
In order to access projects user must sign in or create a new account. On successful authorization, user will be redirected to the root page where all the available projects are listed.

There is no way outside of the console to create a new project.

In order to be able to edit a project or leave a comment click on the the name of available project. By clcking on a pencil icon, you will be able to edit project's name, description and status.

Status changes and comments posted will be listed in the project history section on the right side in reverse-chronological order meaning newest comments/status changes will be listed first.
    
## Technicalities

Ruby version: 3.1.2

Rails version: 7.0.4.3

Database: PostgreSQL

### Setup

1. clone the project locally
2. run `bundle install`
3. setup database with `bundle exec rails db:create db:migrate`
4. you can seed your databse with `bundle exec rails db:seed`
5. start rails server by running `bundle exec rails server`

If you seeded your database you can login with test user using
* email: `test@mail.com`
* password `123456`

### RSpec

Since there are not that many specs, you can simply run everything using `bundle exec rspec` or `bundle exec rspec spec`

