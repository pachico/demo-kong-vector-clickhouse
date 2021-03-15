CREATE DATABASE IF NOT EXISTS `kong`;

CREATE TABLE IF NOT EXISTS `kong`.`log` (
    `timestamp` DateTime,
    `consumer_username` Nullable(String),
    `request_method` LowCardinality(String),
    `request_size` UInt32,
    `request_uri` String,
    `request_url` String,
    `service_name` String,
    `response_status` UInt16,
    `latency_kong` UInt32,
    `latency_proxy` UInt32,
    `latency_request` UInt32
) ENGINE = MergeTree()
ORDER BY
    toYYYYMMDD(timestamp);