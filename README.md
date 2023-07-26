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

Fork the AgeSQL repository.

Create a new branch for your feature or bug fix.

Commit your changes to your branch.

Push your branch to your forked repository.

Submit a pull request to the main AgeSQL repository.

Please ensure that your code adheres to the existing coding style and includes appropriate tests.

### License
AgeSQL is released under the MIT License.
