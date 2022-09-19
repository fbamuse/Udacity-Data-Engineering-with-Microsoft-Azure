"""
This file defines the Queries used in etl.py, cerate_tables.py and etl.ipynb.
"""

# DROP TABLES
songplay_table_drop = "DROP TABLE IF EXISTS sparkifydb.songplay"
user_table_drop     = "DROP TABLE IF EXISTS sparkifydb.users"
song_table_drop     = "DROP TABLE IF EXISTS sparkifydb.songs"
artist_table_drop   = "DROP TABLE IF EXISTS sparkifydb.artists"
time_table_drop     = "DROP TABLE IF EXISTS sparkifydb.time"




# CREATE TABLES

songplay_table_create = ("""
                      CREATE TABLE IF NOT EXISTS songplay(
                      songplay_id integer Not Null UNIQUE PRIMARY KEY,
                      start_time timestamp NOT NULL,
                      user_id integer NOT NULL,
                      level VARCHAR,
                      song_id VARCHAR,
                      artist_id VARCHAR,
                      session_id VARCHAR,
                      location VARCHAR,
                      user_agent VARCHAR
                      );
                      """)

user_table_create = ("""
                    CREATE TABLE IF NOT EXISTS users (
                    user_id integer NOT NULL UNIQUE PRIMARY KEY,
                    first_name VARCHAR,
                    last_name VARCHAR,
                    gender VARCHAR,
                    level VARCHAR
                    );
                    """)

song_table_create = ("""
                    CREATE TABLE IF NOT EXISTS songs(
                    song_id VARCHAR NOT NULL UNIQUE PRIMARY KEY,
                    title VARCHAR NOT NULL,
                    artist_id VARCHAR,
                    year integer,
                    duration numeric NOT NULL
                    );
                    """)

artist_table_create = ("""
                    CREATE TABLE IF NOT EXISTS artists(
                    artist_id VARCHAR NOT NULL UNIQUE PRIMARY KEY,
                    name VARCHAR NOT NULL,
                    location VARCHAR,
                    latitude double precision,
                    longitude double precision);
                    """)

time_table_create = ("""
                    CREATE TABLE IF NOT EXISTS time (
                    start_time timestamp,
                    hour integer,
                    day integer,
                    week integer,
                    month integer,
                    year integer,
                    weekday integer
                    );
                    """)
# INSERT RECORDS

songplay_table_insert = ("""
    INSERT INTO songplay (
                        songplay_id,
                        start_time,
                        user_id,
                        level,
                        song_id,
                        artist_id,
                        session_id,
                        location,
                        user_agent
                        ) VALUES (%s, %s, %s, %s, %s,%s, %s, %s, %s)
                        ON CONFLICT (songplay_id)  DO NOTHING;
                        """)

user_table_insert = ("""
    INSERT INTO users (
                        user_id,
                        first_name,
                        last_name,
                        gender,
                        level
                        ) VALUES (%s, %s, %s, %s, %s)
                        ON CONFLICT (user_id)  DO NOTHING;
                        """)

song_table_insert = ("""
    INSERT INTO songs (
                        song_id,
                        title,
                        artist_id,
                        year,
                        duration
                        ) VALUES (%s, %s, %s, %s, %s)
                        ON CONFLICT (song_id)  DO NOTHING;
                        """)

artist_table_insert = ("""
    INSERT INTO artists (
                        artist_id,
                        name,
                        location,
                        latitude,
                        longitude
                        ) VALUES (%s, %s, %s, %s, %s)
                        ON CONFLICT (artist_id)  DO NOTHING;
                        """)


time_table_insert = ("""
    INSERT INTO time (
                        start_time,
                        hour,
                        day,
                        week,
                        month,
                        year,
                        weekday 
                        ) VALUES (%s, %s, %s,%s,%s,%s,%s)
                        """)

# FIND SONGS
# the song ID and artist ID based on the title, artist name, and duration of a song
song_select = ("""
    SELECT song_id,songs.artist_id FROM songs 
                    LEFT JOIN artists 
                    ON songs.artist_id = artists.artist_id 
                    WHERE artists.name = %s  AND songs.title = %s  AND songs.duration = %s
                        
""")

# QUERY LISTS

create_table_queries = [songplay_table_create, user_table_create, song_table_create, artist_table_create, time_table_create]
drop_table_queries = [songplay_table_drop, user_table_drop, song_table_drop, artist_table_drop, time_table_drop]