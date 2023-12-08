select*
from OlympicHistory
select*
from OlympicRegions

--IDENTIFY THE SPORTS THAT WAS PLAYED IN ALL SUMMER OLYMPICS
--1. TOTAL NO OF SUMMER OLYMPIC GAMES PLAYED
--2. FOR EACH SPORT,HOW MANY GAMES WERE PLAYED
--3. COMPARE 1 AND 2

select sport,count(games) as NoOfGames from (select distinct(Sport)select*
from spotify

select track_artist,count(*)
from spotify
group by track_artist

select track_artist,track_popularity,track_album_release_date,playlist_name,playlist_genre,playlist_subgenre
from spotify
where track_artist = 'ed sheeran'

--UPDATING NULL VALUES




--UPDATE TRACK ALBUM RELEASE DATE
select track_album_release_date, convert(date,track_album_release_date)
from spotify

alter table spotify
add ReleaseDate date;

update spotify
set ReleaseDate = convert(date,track_album_release_date)

select track_artist,track_popularity,ReleaseDate,playlist_name,playlist_genre,playlist_subgenre
from spotify
where ReleaseDate is not null
order by ReleaseDate 

--TOTAL SONGS IN EACH PLAYLIST GENRE
select distinct(playlist_genre),count(playlist_genre)
from spotify
group by playlist_genre

select distinct(track_artist),count(track_artist),track_name
from spotify 
group by track_artist,track_name

--COUNT HOW MANY TIMES A TRACK ARTIST NAME APPEARED
select track_artist,count(*)
from spotify
group by track_artist

--BREAKING TRACK_NAME INTO INDIVIDUAL COLUMNS(SongTitle,Track)
select track_name,substring(track_name,-1,CHARINDEX('-',track_name)) as SongTitle, 
SUBSTRING(track_name,CHARINDEX('-',track_name)+1,len(track_name)) as Track
from spotify

alter table spotify
add SongTitle nvarchar(255);

update spotify
set SongTitle = substring(track_name,-1,CHARINDEX('-',track_name))

alter table spotify
add Track nvarchar(255);

update spotify
set Track = SUBSTRING(track_name,CHARINDEX('-',track_name)+1,len(track_name))

select*
from spotify

									--OR
SELECT track_name,PARSENAME(REPLACE(track_name,'-','.'),2),
PARSENAME(REPLACE(track_name,'-','.'),1)
from spotify

alter table spotify
add TrackSplit nvarchar(255);
update spotify
set TrackSplit = PARSENAME(REPLACE(track_name,'-','.'),2)

alter table spotify
add TrackSplit2 nvarchar(255);
update spotify
set TrackSplit2 = PARSENAME(REPLACE(track_name,'-','.'),1)
	
	--BREAKING PLAYLIST NAME INTO DIFFERENT COLUMNS

select playlist_name, PARSENAME(replace(playlist_name,' ','.'),2),
PARSENAME(replace(playlist_name,' ','.'),1)
from spotify

alter table spotify
add PlaylistSplit nvarchar(255);
update spotify
set PlaylistSplit = PARSENAME(replace(playlist_name,' ','.'),2)

alter table spotify
add PlaylistSplit2 nvarchar(255);
update spotify
set PlaylistSplit2 = PARSENAME(replace(playlist_name,' ','.'),1)



select*
from spotify

--DELETING COLUMNS

select*
from spotify

alter table spotify
drop column track_album_release_date

alter table spotify
drop column playlistsplit,playlistsplit2

--HOW MANY UNIQUE PLAYLISTS ARE THERE IN THE DATASET
select count(distinct playlist_id) as UniquePlaylist
from spotify

--What are the top 5 most popular playlists based on the sum of track popularity?
select playlist_id ,sum(track_popularity) as TotalPopularity
from spotify
group by playlist_id
order by 2 desc

--What is the average popularity of tracks in each playlist genre?
select playlist_id, playlist_genre,AVG(track_popularity)
from spotify
group by playlist_genre,playlist_id
order by playlist_id

--How many sub-genres are associated with each main playlist genre?
select count(distinct playlist_subgenre) as SubGenreCount, playlist_genre
from spotify
group by playlist_genre
order by 2

--What are the top 10 most popular tracks in the entire dataset?
select top 10 track_name, track_popularity
from spotify
order by track_popularity desc

--Which track has the highest popularity?
select top 1 track_name, track_popularity
from spotify
order by track_popularity desc

									--OR

Select track_name, track_popularity
from spotify
where track_popularity = (select max(track_popularity) from spotify)

--How many unique artists are featured in the dataset?
select count(distinct track_artist) as UniqueArtist
from spotify

--What is the average popularity of tracks in a specific playlist?
select Track,avg(track_popularity), playlist_name
from spotify
group by playlist_name,track
order by 2 desc

--How many tracks belong to a specific sub-genre?

select playlist_subgenre ,count(track_name) 
from spotify
group by playlist_subgenre

--How many unique albums are included in the dataset?
select count(distinct track_album_name)
from spotify

--What is the average popularity of tracks in each album?
select track_album_name,avg(track_popularity),track_name
from spotify
group by track_name,track_album_name

--Which album has the highest number of tracks?
select track_name ,count(distinct track_album_name)
from spotify
group by track_name


;with music as
(select track_album_name ,count(distinct track_name) as TrackCount
from spotify
group by track_album_name)
select top 5 track_album_name, TrackCount
from music
order by TrackCount desc

--What are the top 5 most popular albums based on track popularity?
select track_album_name, track_popularity
from spotify
group by track_popularity,track_album_name
order by track_popularity desc



















