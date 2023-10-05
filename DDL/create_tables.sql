DROP TABLE IF EXISTS austin_bikeshare_trips, austin_bikeshare_stations;

-- Создание таблицы для austin_bikeshare_trips.csv
CREATE TABLE IF NOT EXISTS austin_bikeshare_trips (
    bikeid              FLOAT,
    checkout_time       TIME,
    duration_minutes    INT,
    end_station_id      FLOAT,
    end_station_name    TEXT,
    month               FLOAT,
    start_station_id    FLOAT,
    start_station_name  TEXT,
    start_time          TIMESTAMP,
    subscriber_type     TEXT,
    trip_id             BIGINT,
    year                FLOAT
);

-- Создание таблицы для austin_bikeshare_stations.csv
CREATE TABLE IF NOT EXISTS austin_bikeshare_stations (
    latitude    FLOAT,
    location    TEXT,
    longitude   FLOAT,
    name        TEXT,
    station_id  INT,
    status      TEXT
);



