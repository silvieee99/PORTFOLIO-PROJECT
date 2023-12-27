SELECT sport,COUNT(games) AS NoOfGames 
FROM spotify

SELECT track_artist,COUNT(*)
FROM spotify
GROUP BY track_artist

SELECT track_artist,track_popularity,track_album_release_date,playlist_name,playlist_genre,playlist_subgenre
FROM spotify
WHERE track_artist = 'ed sheeran'

--UPDATING NULL VALUES




--UPDATE TRACK ALBUM RELEASE DATE
SELECT track_album_release_date, convert(date,track_album_release_date)
FROM spotify

ALTER TABLE spotify
ADD ReleaseDate date;

UPDATE spotify
SET ReleaseDate = convert(date,track_album_release_date)

SELECT track_artist,track_popularity,ReleaseDate,playlist_name,playlist_genre,playlist_subgenre
FROM spotify
WHERE ReleaseDate IS NOT NULL
ORDER BY ReleaseDate 

--TOTAL SONGS IN EACH PLAYLIST GENRE
SELECT DISTINCT(playlist_genre),COUNT(playlist_genre)
FROM spotify
GROUP BY playlist_genre

SELECT DISTINCT(track_artist),COUNT(track_artist),track_name
FROM spotify 
GROUP BY track_artist,track_name

--COUNT HOW MANY TIMES A TRACK ARTIST NAME APPEARED
SELECT track_artist,COUNT(*)
FROM spotify
GROUP BY track_artist

--BREAKING TRACK_NAME INTO INDIVIDUAL COLUMNS(SongTitle,Track)
SELECT track_name,substring(track_name,-1,CHARINDEX('-',track_name)) AS SongTitle, 
SUBSTRING(track_name,CHARINDEX('-',track_name)+1,len(track_name)) AS Track
FROM spotify

ALTER TABLE spotify
ADD SongTitle nvarchar(255);

UPDATE spotify
SET SongTitle = substring(track_name,-1,CHARINDEX('-',track_name))

ALTER TABLE spotify
ADD Track nvarchar(255);

UPDATE spotify
SET Track = SUBSTRING(track_name,CHARINDEX('-',track_name)+1,len(track_name))

SELECT*
FROM spotify

									--OR
SELECT track_name,PARSENAME(REPLACE(track_name,'-','.'),2),
PARSENAME(REPLACE(track_name,'-','.'),1)
FROM spotify

ALTER TABLE spotify
ADD TrackSplit nvarchar(255);
UPDATE spotify
SET TrackSplit = PARSENAME(REPLACE(track_name,'-','.'),2)

ALTER TABLE spotify
ADD TrackSplit2 nvarchar(255);
UPDATE spotify
SET TrackSplit2 = PARSENAME(REPLACE(track_name,'-','.'),1)
	
	--BREAKING PLAYLIST NAME INTO DIFFERENT COLUMNS

SELECT playlist_name, PARSENAME(replace(playlist_name,' ','.'),2),
PARSENAME(replace(playlist_name,' ','.'),1)
FROM spotify

ALTER TABLE spotify
ADD PlaylistSplit nvarchar(255);
UPDATE spotify
SET PlaylistSplit = PARSENAME(replace(playlist_name,' ','.'),2)

ALTER TABLE spotify
ADD PlaylistSplit2 nvarchar(255);
UPDATE spotify
SET PlaylistSplit2 = PARSENAME(replace(playlist_name,' ','.'),1)



SELECT*
FROM spotify

--DELETING COLUMNS

SELECT*
FROM spotify

ALTER TABLE spotify
DROP COLUMN track_album_release_date

ALTER TABLE spotify
DROP COLUMN playlistsplit,playlistsplit2

--HOW MANY UNIQUE PLAYLISTS ARE THERE IN THE DATASET
SELECT COUNT(DISTINCT playlist_id) AS UniquePlaylist
FROM spotify

--What are the top 5 most popular playlists based on the sum of track popularity?
SELECT playlist_id ,sum(track_popularity) as TotalPopularity
FROM spotify
GROUP BY playlist_id
ORDER BY 2 DESC

--What is the average popularity of tracks in each playlist genre?
SELECT playlist_id, playlist_genre,AVG(track_popularity)
FROM spotify
GROUP BY playlist_genre,playlist_id
ORDER BY playlist_id

--How many sub-genres are associated with each main playlist genre?
SELECT COUNT(DISTINCT playlist_subgenre) AS SubGenreCount, playlist_genre
FROM spotify
GROUP BY playlist_genre
ORDER BY 2

--What are the top 10 most popular tracks in the entire dataset?
SELECT top 10 track_name, track_popularity
FROM spotify
ORDER BY track_popularity DESC

--Which track has the highest popularity?
SELECT top 1 track_name, track_popularity
FROM spotify
ORDER BY track_popularity DESC

									--OR

SELECT track_name, track_popularity
FROM spotify
WHERE track_popularity = (SELECT max(track_popularity) FROM spotify)

--How many unique artists are featured in the dataset?
SELECT COUNT(DISTINCT track_artist) AS UniqueArtist
FROM spotify

--What is the average popularity of tracks in a specific playlist?
SELECT Track,avg(track_popularity), playlist_name
FROM spotify
GROUP BY playlist_name,track
ORDER BY 2 DESC

--How many tracks belong to a specific sub-genre?

SELECT playlist_subgenre ,COUNT(track_name) 
FROM spotify
GROUP BY playlist_subgenre

--How many unique albums are included in the dataset?
SELECT COUNT(DISTINCT track_album_name)
FROM spotify

--What is the average popularity of tracks in each album?
SELECT track_album_name,avg(track_popularity),track_name
FROM spotify
GROUP BY track_name,track_album_name

--Which album has the highest number of tracks?
SELECT track_name ,COUNT(DISTINCT track_album_name)
FROM spotify
GROUP BY track_name


;WITH music AS
(SELECT track_album_name ,COUNT(DISTINCT track_name) AS TrackCount
FROM spotify
GROUP BY track_album_name)
SELECT top 5 track_album_name, TrackCount
FROM music
ORDER BY TrackCount DESC

--What are the top 5 most popular albums based on track popularity?
SELECT track_album_name, track_popularity
FROM spotify
GROUP BY track_popularity,track_album_name
ORDER BY track_popularity DESC



















