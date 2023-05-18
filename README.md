## AgeSQL
AgeSQL is a command-line interface (CLI) client for PostgreSQL that extends its capabilities to support Cypher queries along with traditional SQL. This tool leverages the Age extension for PostgreSQL, which enables graph queries within the database.

## Features
Seamless integration of Cypher queries into PostgreSQL using the Age extension.

Allows you to run Cypher queries directly from the AgeSQL CLI.

Converts Cypher queries into PostgreSQL functions internally, eliminating the need for manual function calls.

Supports standard SQL queries in addition to Cypher queries.

Provides a familiar psql-like interface for easy interaction with the database.

## Installation
To install AgeSQL, follow these steps:

Ensure that you have PostgreSQL installed on your system. AgeSQL requires PostgreSQL with the Age extension enabled.

Clone the AgeSQL repository from GitHub using the following command:

```bash
git clone https://github.com/AGEDB-INC/AgeSQL
```

Change to the AgeSQL directory:

```bash
cd agesql
```

Run the installation script:

Usage
Once AgeSQL is installed, you can use it from the command line. Here are some examples of how to use AgeSQL:

To start the AgeSQL CLI, simply run:

```bash
agesql
```

Inside the AgeSQL CLI, you can run SQL queries as you would in psql. For example:

```sql
SELECT * FROM users;
```

To run Cypher queries, use the CY command followed by your Cypher query. For example:

```sql
MATCH (n:Person) RETURN n;
```

AgeSQL seamlessly converts Cypher queries to PostgreSQL functions internally. You can execute Cypher queries without the need to call functions explicitly.

## Contributing
Contributions to AgeSQL are welcome! If you would like to contribute, please follow these guidelines:

Fork the AgeSQL repository.

Create a new branch for your feature or bug fix.

Commit your changes to your branch.

Push your branch to your forked repository.

Submit a pull request to the main AgeSQL repository.

Please ensure that your code adheres to the existing coding style and includes appropriate tests.

### License
AgeSQL is released under the MIT License.
