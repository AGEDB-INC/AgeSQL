## AgeSQL
AgeSQL is a command-line interface (CLI) client for PostgreSQL that extends its capabilities to support Cypher queries along with traditional SQL. This tool leverages the Age extension for PostgreSQL, which enables graph queries within the database.

The aim of AgeSQL is to create a CLI tool that operates similarly to the existing PostgreSQL CLI (psql) and provides complete functionality for working with graph databases. In addition, AgeSQL wraps Cypher commands to simplify their usage within PostgreSQL.

Implementing a CLI tool like AgeSQL comes with several challenges which has been addressed:

- Determining the graph to use: The CLI tool has a mechanism to identify the graph to be queried. The CLI tool can handle different graphs based on user input.


- Determining the number of output parameters: The CLI tool knows the number of parameters to expect in the final result. This information is crucial for processing and presenting the query results accurately.


- Determining the output type: The CLI tool identifies the appropriate output type for each parameter in the result. Different data types supported by PostgreSQL are accounted for, such as pg_float8 or agtype, to ensure proper handling and interpretation of the data.

These challenges may impact the ability to use commands across multiple graph databases and limit the use of hybrid SQL/Cypher commands. These factors are considered when designing and implementing the CLI tool.


## Features
AgeSQL extends the PostgreSQL CLI by adding support for executing Cypher queries within the database. This allows users to work with graph data using familiar SQL syntax while benefiting from the expressive power of Cypher.

The key features of AgeSQL include:

1. Seamless integration of Cypher queries into PostgreSQL using the Age extension: Supports standard SQL queries in addition to Cypher queries and converts Cypher queries into PostgreSQL functions internally, eliminating the need for manual function calls


2. Execution of Cypher queries: AgeSQL allows you to execute Cypher queries directly within the PostgreSQL database. This enables graph traversal, pattern matching, and graph analysis operations.

3. Integration with traditional SQL: AgeSQL seamlessly integrates Cypher queries with traditional SQL. It wraps Cypher commands in SQL syntax to execute them within PostgreSQL.

4. Support for graph-specific operations: AgeSQL supports graph-specific operations, such as traversing nodes and edges, retrieving properties, and performing graph analytics.

5. Ease of use: Provides a familiar psql-like interface for easy interaction with the database.


## Installation
To install AgeSQL, follow these steps:

1. Ensure that you have PostgreSQL 15 installed on your system.
2. AgeSQL requires PostgreSQL with the Age extension enabled. Currently, the AGE extension is compatible with PostgreSQL 11, 12, and 13. Ensure that you have one of these versions installed.

3. Clone the AgeSQL repository from GitHub using the following command:

    ```bash
    git clone https://github.com/AGEDB-INC/AgeSQL
    ```

4. Change to the AgeSQL directory:

    ```bash
    cd AgeSQL
    ```

5. Export the path to PostgreSQL 15, replacing `/path/to/postgresql` with the path to your installation and enable `PGXS`:

    ```bash
    export PATH=/path/to/postgresql/15/bin:$PATH
    export USE_PGXS=TRUE
    ```

6. Run the installation script:

    ```bash
    make
    ```

## Post Installation

To use AgeSQL, first, update the `PATH` variable to a PostgreSQL version compatible with Age (e.g., 12):


```bash
export PATH=/path/to/postgresql/12/bin:$PATH

```

Then, create the database and set up the extension:

```bash
initdb agesqldb
```

```bash
pg_ctl -D agesqldb -l logfile start
```

```bash
createdb agesqldb
```

```bash
./agesql agesqldb
```

```sql
CREATE EXTENSION age;

```

```sql
LOAD 'age';

```

```sql
SET search_path = ag_catalog, "$user", public;

```

## Quick Start
Once AgeSQL is set up, you can use it from the command line. Here are some examples of how to use AgeSQL:

To create a graph, run the `CREATE GRAPH` command:

```sql
CREATE GRAPH network;
```

Set the `network` graph as default:

```sql
SET GRAPH = network;
```

Show the graph path to confirm the change:

```sql
SHOW GRAPH_PATH;
```

Inside the AgeSQL CLI, you can run SQL queries as you would in psql. For example:

```sql
SELECT * FROM users;
```

Use Cypher queries to manage the data. For example, to create vertices, use the `CREATE` clause:

```sql
CREATE (:person {name: 'John'});
```

```sql
CREATE (:person {name: 'David'});
```

Use `MATCH CREATE` to create an edge between the vertices:

```
MATCH (p:person {name: 'John'}),(k:person{name: 'David'}) 
CREATE (p)-[e:KNOWS]->(k)
RETURN e;
```

Use the `MATCH` clause to query the graph:

```
MATCH (a)
OPTIONAL MATCH (a)-[e]->(b)
RETURN a, e, b;
```

AgeSQL seamlessly converts Cypher queries to PostgreSQL functions internally. You can execute Cypher queries without the need to call functions explicitly.

## Contributing
Contributions to AgeSQL are welcome! If you would like to contribute, please follow these guidelines:

1. Fork the AgeSQL repository.

2. Create a new branch for your feature or bug fix.

3. Commit your changes to your branch.

4. Push your branch to your forked repository.

5. Submit a pull request to the main AgeSQL repository.

Please ensure that your code adheres to the existing coding style and includes appropriate tests.

## License
AgeSQL is released under the MIT License.
