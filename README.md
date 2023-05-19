# AgeSQL

AgeSQL is a command-line interface (CLI) client for PostgreSQL that extends its capabilities to support Cypher queries along with traditional SQL. This tool leverages the Age extension for PostgreSQL, enabling graph queries within the database.
AgeSQL provides a powerful and flexible solution for working with both  structured and graph data within PostgreSQL. With AgeSQL, you can  seamlessly integrate Cypher queries into your PostgreSQL workflow,  allowing you to leverage the full power of graph database capabilities  alongside traditional SQL operations.

## Features

- Seamless integration of Cypher queries into PostgreSQL using the Age extension.
- Allows running Cypher queries directly from the AgeSQL CLI.
- Converts Cypher queries into PostgreSQL functions internally, eliminating the need for manual function calls.
- Supports standard SQL queries in addition to Cypher queries.
- Provides a familiar psql-like interface for easy interaction with the database.

## Installation

To install AgeSQL, follow these steps:

1. Ensure that you have PostgreSQL installed on your system with the Age extension enabled.
2. Clone the AgeSQL repository from GitHub using the command: 

```bash
git clone https://github.com/AGEDB-INC/AgeSQL.git
```

3. Change to the AgeSQL directory:

```bash
cd agesql
```
4. Run the installation script.
```
export CFLAGS='-I/{PATH TO PG15}/src/include -I/{PATH TO PG15}/src/interfaces/libpq'
```

```
export PATH=/usr/local/postgresql/15/bin:$PATH
where /usr/local/postgresql/15  is to be the path of your PostgreSQL 15 installation
```
```
make
```

## How To Use (Usage) 

Once AgeSQL is installed, you can use it from the command line. Here are some examples of how to use AgeSQL:

- To start the AgeSQL CLI, simply run: `agesql`.
- Inside the AgeSQL CLI, you can run SQL queries as you would in psql. For example: 

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

1. Fork the AgeSQL repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes to your branch.
4. Push your branch to your forked repository.
5. Submit a pull request to the main AgeSQL repository.

Please ensure that your code adheres to the existing coding style and includes appropriate tests. You can learn from the code review process, how to merge pull  requests, and from code style compliance to documentation, by visiting  the Apache AGE official site - Developer Guidelines.

## License

AgeSQL is released under the MIT License.