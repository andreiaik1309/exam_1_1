DO $$
DECLARE
    year INT;
BEGIN
    FOR year IN 2013..2017 LOOP
        EXECUTE '
            CREATE MATERIALIZED VIEW my_view_' || year || ' AS
            with start_stations as (
                select start_station_id as station_id, count(*) as count_start_trips,
                round(avg(duration_minutes), 3) as avg_duration_for_start
                from austin_bikeshare_trips as abt
                join austin_bikeshare_stations as abs
                on abt.start_station_id = abs.station_id
                where status = ''active'' and DATE_PART(''Year'', start_time) = ' || year || '
                group by start_station_id	
            ),
            end_stations as (
                select end_station_id as station_id, count(*) as count_end_trips,
                round(avg(duration_minutes), 3) as avg_duration_for_end
                from austin_bikeshare_trips as abt
                join austin_bikeshare_stations as abs
                on abt.end_station_id = abs.station_id
                where status = ''active'' and DATE_PART(''Year'', start_time) = ' || year || '
                group by end_station_id	
            ),
            start_ens_stations as (
                select station_id, count(*) as count_start_end_trips from
                (select trip_id, Z.station_id from
                (select trip_id, end_station_id as station_id, start_time  from austin_bikeshare_trips
                union 
                select trip_id, start_station_id as station_id, start_time from austin_bikeshare_trips) Z
                join austin_bikeshare_stations as abs on Z.station_id = abs.station_id
                where status = ''active'' and DATE_PART(''Year'', start_time) = ' || year || ') Z
                group by station_id
            )
            select abs.station_id, 
            coalesce(count_start_trips, 0) as count_start_trips, 
            coalesce(count_end_trips, 0) as count_end_trips, 
            coalesce(count_start_end_trips, 0) as count_start_end_trips,
            avg_duration_for_start, 
            avg_duration_for_end
            from austin_bikeshare_stations as abs
            left join start_stations as ss on abs.station_id = ss.station_id
            left join end_stations as es on abs.station_id = es.station_id
            left join start_ens_stations as ses on abs.station_id = ses.station_id
            where status = ''active''
            order by avg_duration_for_start desc NULLS LAST
        ';
    END LOOP;
END $$;