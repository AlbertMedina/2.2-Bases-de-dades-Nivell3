# MySQL Queries

## Description - Exercise Statement
Perform MySQL queries on the given databases.

### Shop
Perform MySQL queries on the given shop database.

### University
Perform MySQL queries on the given university database.

## Technologies Used
- MySQL Workbench 8.0 CE
- MySQL 8
- SQL
- Docker

## Requirements
- MySQL Workbench 8.0 CE
- MySQL 8
- Docker

## Installation
1. Clone repository (https://github.com/AlbertMedina/2.2-Bases-de-dades-Nivell3.git).
`git clone https://github.com/AlbertMedina/2.2-Bases-de-dades-Nivell3.git`
2. Start a MySQL 8 container using Docker
`docker run --name [container-name] -e MYSQL_ROOT_PASSWORD=[password] -p 3306:3306 -d mysql:8`

## Execution
1. Open MySQL Workbench and connect to your Docker container.
2. Import the .sql scripts (they can be found in their respective folders (Shop, University)).
3. Execute each one to create the given databases with the given inserted data and run the queries.
