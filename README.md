# RaceDay
Planning and database design for the RaceDay event management system

## System Description 
RaceDay is a web-focused event management software developed specifically for the road running, walking and cycling market in South Africa. Organisers and event directors use the site to create and manage events, participants can search for events and enter them and view their results.

## User Roles

### Organiser
Race organiser can add new event or edit existing event, add/edit event categories, see registered participants and results.

### Participant
Users can sign up and log in, search for events, participate in event, and check their performance record. 

## Project Documentation

The planning and database documentation for RaceDay is stored in the `/docs` folder.

The documentation includes:
- Entity Relationship Diagram (ERD)
- RESTful API Endpoint Plan
- SQL Server database creation and seed data script

## RESTful API

The RaceDay API is designed around REST principles and uses routes beginning with `/api/`.

The API supports:
- User registration and login
- User profile management
- Event management
- Category management
- Event enrolment
- Result recording and viewing

## Database

RaceDay uses Microsoft SQL Server for data storage.

The database contains the following entities:
- User
- Event
- Category
- EventCategory
- Enrolment
- Result

The SQL script creates the database schema, defines primary and foreign key relationships, applies data constraints, and inserts sample data for testing.

## Authentication and Security

RaceDay uses authentication to protect non-public areas of the system. Users register with an email address and password and select either the Organiser or Participant role.

Passwords are stored as hashed values rather than plain-text passwords. Role-based access control is used to restrict functionality according to the authenticated user's role.

## Repository Structure

RaceDay/
- `.github/workflows/` – GitHub Actions workflow files
- `docs/` – ERD, API endpoint plan, SQL script and CI evidence
- `README.md` – Project overview and documentation


## CI/CD

The repository uses GitHub Actions to validate the required project structure and documentation. The workflow completed successfully.

![Successful GitHub Actions Build](docs/CI-Success.png)


## Technology Stack

RaceDay uses the following technologies:

- Microsoft SQL Server for the relational database
- SQL Server Management Studio (SSMS) for database development and testing
- GitHub for version control and project hosting
- GitHub Actions for repository validation and CI/CD
- RESTful API design for system communication
