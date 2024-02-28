# Streambased <> MedBloc Demo

## What does this demo do?

This demo simulates a supply chain use case where the concerned data is available in an organization's Apache Kafka 
deployment. This data is collated and surfaced to MedBloc via Streambased technology.

## Step 1: Setup and review the environment

First run the setup script, this will configure and start resources for the demo.

```bash
./bin/setup.sh
```

Our environment consists of the following components:

1. A single node Kafka cluster (containers kafka1 and zookeeper) - for data storage
2. A Schema Registry - for governance
3. Streambased Indexer - to create the indexes Streambased uses to be fast
4. Streambased Server - to make the Kafka data available via JDBC
5. Superset - a popular and easy to use database client

## Step 2: Start the environment

To bring up the environment run:

```bash
docker-compose up -d
```

## Step 3: Open superset

Now we can query the collected data and demonstrate the Streambased effect. 

From a web browser navigate to `localhost:8088`.

Log in with credentials `admin:admin`

## Step 4: Query with Streambased

Next from the menu at the top select `SQL -> SQL Lab`, you will see a familiar SQL query interface. In the query entry 
area add the following:

```
use kafka.streambased;
set session use_streambased=true;
select * from pallets pal join purchaseorders p on pal.item = p.item;
```

and click `RUN`

## Step 5: Explore!

Feel free to run other queries against this dataset with or without Streambased acceleration enabled

## Step 6: Tear down

To complete the demo run the following. This will stop and remove all demo resources:

```bash
docker-compose stop
docker-compsoe rm
```
