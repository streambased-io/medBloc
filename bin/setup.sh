#!/bin/bash

echo "Starting Services..."
docker-compose up -d
# Schema registry and superset are slow to start
sleep 30


echo "Creating Topics..."
docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:9092 --topic customerData --create --partitions 1
docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:9092 --topic manufacturingData --create --partitions 1
docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:9092 --topic pallets --create --partitions 1
docker-compose exec kafka1 kafka-topics --bootstrap-server kafka1:9092 --topic purchaseOrders --create --partitions 1

echo "Loading Data..."
cat data/customerData.txt |
    docker-compose exec -T schema-registry kafka-avro-console-producer \
      --bootstrap-server kafka1:9092 \
      --topic customerData \
      --property schema.registry.url=http://schema-registry:8081 \
      --property value.schema='{
          "name": "customerData",
          "type": "record",
          "fields": [
            {
              "name":"item",
              "type":"string"
            },
            {
              "name":"description",
              "type":"string"
            },
            {
              "name":"quantity",
              "type":"int"
            },
            {
              "name":"soNumber",
              "type":"string"
            },
            {
              "name":"dateRaised",
              "type":"string"
            },
            {
              "name":"requestedDeliveryDate",
              "type":"string"
            },
            {
              "name":"promisedDeliveryDate",
              "type":"string"
            },
            {
              "name":"batchNumber",
              "type":"string"
            },
            {
              "name":"dateOfManufacture",
              "type":"string"
            },
            {
              "name":"operator",
              "type":"string"
            },
            {
              "name":"countryOfOrigin",
              "type":"string"
            },
            {
              "name":"qcChecked",
              "type":"string"
            }
          ]
      }'
cat data/manufacturingData.txt |
    docker-compose exec -T schema-registry kafka-avro-console-producer \
      --bootstrap-server kafka1:9092 \
      --topic manufacturingData \
      --property schema.registry.url=http://schema-registry:8081 \
      --property value.schema='{
          "name": "manufacturingData",
          "type": "record",
          "fields": [
            {
              "name":"item",
              "type":"string"
            },
            {
              "name":"description",
              "type":"string"
            },
            {
              "name":"quantity",
              "type":"int"
            },
            {
              "name":"poNumber",
              "type":"int"
            },
            {
              "name":"dateRaised",
              "type":"string"
            },
            {
              "name":"requestedDeliveryDate",
              "type":"string"
            },
            {
              "name":"promisedDeliveryDate",
              "type":"string"
            },
            {
              "name":"batchNumber",
              "type":"string"
            },
            {
              "name":"dateOfManufacture",
              "type":"string"
            },
            {
              "name":"operator",
              "type":"string"
            },
            {
              "name":"countryOfOrigin",
              "type":"string"
            },
            {
              "name":"qcChecked",
              "type":"string"
            }
          ]
      }'
cat data/pallets.txt |
    docker-compose exec -T schema-registry kafka-avro-console-producer \
      --bootstrap-server kafka1:9092 \
      --topic pallets \
      --property schema.registry.url=http://schema-registry:8081 \
      --property value.schema='{
          "name": "pallets",
          "type": "record",
          "fields": [
            {
              "name":"item",
              "type":"string"
            },
            {
              "name":"description",
              "type":"string"
            },
            {
              "name":"quantity",
              "type":"int"
            },
            {
              "name":"poNumber",
              "type":"int"
            },
            {
              "name":"dateRaised",
              "type":"string"
            },
            {
              "name":"requestedDeliveryDate",
              "type":"string"
            },
            {
              "name":"promisedDeliveryDate",
              "type":"string"
            },
            {
              "name":"batchNumber",
              "type":"string"
            },
            {
              "name":"dateOfManufacture",
              "type":"string"
            },
            {
              "name":"operator",
              "type":"string"
            },
            {
              "name":"pallet",
              "type":"string"
            },
            {
              "name":"tariffCode",
              "type":"string"
            },
            {
              "name":"haulier",
              "type":"string"
            },
            {
              "name":"trackingNo",
              "type":"string"
            },
            {
              "name":"pod",
              "type":"string"
            }
          ]
      }'
cat data/purchaseOrders.txt |
    docker-compose exec -T schema-registry kafka-avro-console-producer \
      --bootstrap-server kafka1:9092 \
      --topic purchaseOrders \
      --property schema.registry.url=http://schema-registry:8081 \
      --property value.schema='{
          "name": "purchaseOrders",
          "type": "record",
          "fields": [
            {
              "name":"item",
              "type":"string"
            },
            {
              "name":"description",
              "type":"string"
            },
            {
              "name":"quantity",
              "type":"int"
            },
            {
              "name":"unitPrice",
              "type":"double"
            },
            {
              "name":"uom",
              "type":"string"
            },
            {
              "name":"total",
              "type":"double"
            },
            {
              "name":"poNumber",
              "type":"int"
            },
            {
              "name":"dateRaised",
              "type":"string"
            },
            {
              "name":"requestedDeliveryDate",
              "type":"string"
            },
            {
              "name":"promisedDeliveryDate",
              "type":"string"
            },
            {
              "name":"actualDeliveryDate",
              "type":"string"
            }
          ]
      }'

echo "Environment ready"