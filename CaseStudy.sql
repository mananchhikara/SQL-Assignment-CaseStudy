
create database virtualartgallery

-- create the artists table
create table artists(
artistid int primary key identity(1,1),
name varchar(100) not null,
biography varchar(max) null,
birthdate date null,
nationality varchar(50) null,
website varchar(200) null,
contactinformation varchar(max) null
)

-- create the artworks table
create table artworks(
artworkid int primary key identity(1,1),
title varchar(100) not null,
description varchar(max) null,
creationdate date null,
medium varchar(50) null,
imageurl varchar(200) null,
artistid int not null,
foreign key (artistid) references artists(artistid)
)

-- create the users table
create table users(
userid int primary key identity(1,1),
username varchar(50) not null unique,
password varchar(255) not null,
email varchar(100) not null unique,
firstname varchar(50) not null,
lastname varchar(50) not null,
dateofbirth date null,
profilepicture varchar(200) null
)

-- create the galleries table
create table galleries(
galleryid int primary key identity(1,1),
name varchar(100) not null,
description varchar(max) null,
location varchar(200) null,
curatorid int not null,
openinghours varchar(100) null,
foreign key (curatorid) references artists(artistid)
)

-- create the user_favorite_artwork junction table
create table user_favorite_artwork(
userid int not null,
artworkid int not null,
primary key (userid, artworkid),
foreign key (userid) references users(userid),
foreign key (artworkid) references artworks(artworkid)
)

-- create the artwork_gallery junction table
create table artwork_gallery(
artworkid int not null,
galleryid int not null,
primary key (artworkid, galleryid),
foreign key (artworkid) references artworks(artworkid),
foreign key (galleryid) references galleries(galleryid)
)
