# API Application Overview

## API Description
The API serves as the backend for the full stack project, providing endpoints for interacting with the database and performing CRUD operations on resources. The purpose of the API is to handle data management and communication between the front end and the database. The target audience includes users of the web application who need to access and modify data stored in the system. The scope of the API includes handling user authentication, data retrieval, and data manipulation requests.

## API Architecture
The API follows a RESTful architecture, with endpoints for different resources such as users, hospitals, addresses, etc. It interacts with the front end through HTTP requests, typically in JSON format. Authentication and authorization are implemented using tokens or sessions to ensure secure access to the API endpoints.

## Setup Instructions
To start the project:
1. Clone the repository from [GitHub Repo Link].
2. Install dependencies by running `bundle install`.
3. Set up the database using `rake db:create`, `rake db:migrate`, and `rake db:seed`.
4. Start the Rails server with `rails s`.
5. Access the API endpoints at `https://costohealthapp.onrender.com`.

## Gems
- `gem_name`: Description of the gem and its purpose.
- `gem_name`: Description of the gem and its purpose.

## Testing
Testing in the API is done using [RSpec](https://rspec.info/) for unit and integration tests. Factories with [FactoryBot](https://github.com/thoughtbot/factory_bot) are used to create test data. Controllers and models are tested to ensure functionality and reliability of the API endpoints.