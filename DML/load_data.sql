-- Загрузка данных из austin_bikeshare_trips.csv
COPY austin_bikeshare_trips FROM '/data/austin_bikeshare_trips.csv' DELIMITER ',' CSV HEADER;
-- Загрузка данных из austin_bikeshare_stations.csv
COPY austin_bikeshare_stations FROM '/data/austin_bikeshare_stations.csv' DELIMITER ',' CSV HEADER;

-- Изменение типа данных в таблице austin_bikeshare_trips
ALTER TABLE austin_bikeshare_trips
ALTER COLUMN bikeid SET DATA TYPE INT,
ALTER COLUMN end_station_id SET DATA TYPE INT,
ALTER COLUMN month  SET DATA TYPE INT,
ALTER COLUMN start_station_id SET DATA TYPE INT,
ALTER COLUMN year SET DATA TYPE INT
;