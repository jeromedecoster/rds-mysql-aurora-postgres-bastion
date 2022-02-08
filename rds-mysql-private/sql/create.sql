-- https://github.com/Evgenii-Zuev/Diploma/blob/main/test.sql
drop database if exists rds;
create database rds;
use rds;

--
-- Create table `the_beatles`
--
CREATE TABLE the_beatles (
  albumName varchar(60) DEFAULT NULL,
  trackName varchar(60) DEFAULT NULL,
  trackNumber varchar(2) DEFAULT NULL,
  releaseDate datetime DEFAULT NULL
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 655,
CHARACTER SET latin1,
COLLATE latin1_swedish_ci;

-- 
-- Dumping data for table the_beatles
--
INSERT INTO the_beatles VALUES
('The Beatles 1967-1970 (The Blue Album)', 'Hey Jude', '13', '1968-08-26 12:00:00'),
('The Beatles (The White Album)', 'While My Guitar Gently Weeps', '7', '1968-11-22 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'Revolution', '14', '1968-08-26 12:00:00'),
('Abbey Road (2019 Mix)', 'Here Comes the Sun', '7', '1969-09-26 12:00:00'),
('The Beatles (The White Album)', 'Dear Prudence', '2', '1968-11-22 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'Strawberry Fields Forever', '1', '1967-02-13 12:00:00'),
('The Beatles (The White Album)', 'I Will', '16', '1968-11-22 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'Across the Universe', '13', '1969-12-12 12:00:00'),
('The Beatles 1962-1966 (The Red Album)', 'I Want to Hold Your Hand', '5', '1963-11-29 12:00:00'),
('The Beatles (The White Album)', 'Mother Nature''s Son', '3', '1968-11-22 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'With a Little Help From My Friends', '4', '1967-06-01 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'Lucy In the Sky with Diamonds', '5', '1967-06-01 12:00:00'),
('The Beatles (The White Album)', 'Martha My Dear', '9', '1968-11-22 12:00:00'),
('The Beatles (The White Album)', 'Why Don''t We Do It In the Road?', '15', '1968-11-22 12:00:00'),
('The Beatles (The White Album)', 'Cry Baby Cry', '11', '1968-11-22 12:00:00'),
('The Beatles (The White Album)', 'Sexy Sadie', '5', '1968-11-22 12:00:00'),
('The Beatles 1967-1970 (The Blue Album)', 'Get Back', '4', '1969-04-11 12:00:00'),
('The Beatles (The White Album)', 'Yer Blues', '2', '1968-11-22 12:00:00');
