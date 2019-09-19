CREATE DATABASE  IF NOT EXISTS `randomusic`;
USE `randomusic`;
#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: playlists
#------------------------------------------------------------

CREATE TABLE PLAYLISTS(
        PLAYLIST_ID  Int  Auto_increment  NOT NULL ,
        NOM_PLAYLIST Varchar (255) NOT NULL
	,CONSTRAINT PK_PLAYLISTS PRIMARY KEY (PLAYLIST_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: users
#------------------------------------------------------------

CREATE TABLE USERS(
        USER_ID       Int  Auto_increment  NOT NULL ,
        USER_NAME     Varchar (55) ,
        USER_LASTNAME Varchar (55) ,
        USER_LOGIN    Varchar (255) NOT NULL ,
        USER_MAIL     Varchar (255) NOT NULL ,
        PLAYLIST_ID   Int NOT NULL
	,CONSTRAINT AK_USERS UNIQUE (USER_MAIL)
	,CONSTRAINT PK_USERS PRIMARY KEY (USER_ID)

	,CONSTRAINT FK_USERS_PLAYLISTS FOREIGN KEY (PLAYLIST_ID) REFERENCES PLAYLISTS(PLAYLIST_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: musics
#------------------------------------------------------------

CREATE TABLE MUSICS(
        MUSIC_ID      Int  Auto_increment  NOT NULL ,
        MUSIC_TITLE   Varchar (255) NOT NULL ,
        MUSIC_TYPE    Varchar (255) NOT NULL ,
        DUREE_MUSIQUE Time NOT NULL
	,CONSTRAINT PK_MUSICS PRIMARY KEY (MUSIC_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: artists
#------------------------------------------------------------

CREATE TABLE ARTISTS(
        ARTIST_ID      Int  Auto_increment  NOT NULL ,
        PSEUDO_ARTISTE Varchar (255) NOT NULL
	,CONSTRAINT PK_ARTISTS PRIMARY KEY (ARTIST_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: conf_playlists
#------------------------------------------------------------

CREATE TABLE CONF_PLAYLISTS(
        CONF_PLAY_ID     Int  Auto_increment  NOT NULL ,
        CONF_RED_MUSIC   Varchar (50) NOT NULL ,
        CONF_RED_ARTIST  Varchar (50) NOT NULL ,
        CONF_PLAY_TYPE   Varchar (50) NOT NULL ,
        CONF_MUSIC_TOKEN Varchar (50) NOT NULL
	,CONSTRAINT PK_CONF_PLAYLISTS PRIMARY KEY (CONF_PLAY_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: conf_musics
#------------------------------------------------------------

CREATE TABLE ENTITE(
        CONF_MUSIC_ID    Int  Auto_increment  NOT NULL ,
        CONF_MUSIC_COLOR Varchar (50) NOT NULL ,
        CONF_MUSIC_PREF  Varchar (50) NOT NULL
	,CONSTRAINT PK_ENTITE PRIMARY KEY (CONF_MUSIC_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: content
#------------------------------------------------------------

CREATE TABLE CONTENT(
        MUSIC_ID    Int NOT NULL ,
        PLAYLIST_ID Int NOT NULL
	,CONSTRAINT PK_CONTENT PRIMARY KEY (MUSIC_ID,PLAYLIST_ID)

	,CONSTRAINT FK_CONTENT_MUSICS FOREIGN KEY (MUSIC_ID) REFERENCES MUSICS(MUSIC_ID)
	,CONSTRAINT FK_CONTENT_PLAYLISTS0 FOREIGN KEY (PLAYLIST_ID) REFERENCES PLAYLISTS(PLAYLIST_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: compose
#------------------------------------------------------------

CREATE TABLE COMPOSE(
        ARTIST_ID Int NOT NULL ,
        MUSIC_ID  Int NOT NULL
	,CONSTRAINT PK_COMPOSE PRIMARY KEY (ARTIST_ID,MUSIC_ID)

	,CONSTRAINT FK_COMPOSE_ARTISTS FOREIGN KEY (ARTIST_ID) REFERENCES ARTISTS(ARTIST_ID)
	,CONSTRAINT FK_COMPOSE_MUSICS0 FOREIGN KEY (MUSIC_ID) REFERENCES MUSICS(MUSIC_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: music_param
#------------------------------------------------------------

CREATE TABLE MUSIC_PARAM(
        CONF_PLAY_ID Int NOT NULL ,
        PLAYLIST_ID  Int NOT NULL
	,CONSTRAINT PK_MUSIC_PARAM PRIMARY KEY (CONF_PLAY_ID,PLAYLIST_ID)

	,CONSTRAINT FK_MUSIC_PARAM_CONF_PLAYLISTS FOREIGN KEY (CONF_PLAY_ID) REFERENCES CONF_PLAYLISTS(CONF_PLAY_ID)
	,CONSTRAINT FK_MUSIC_PARAM_PLAYLISTS0 FOREIGN KEY (PLAYLIST_ID) REFERENCES PLAYLISTS(PLAYLIST_ID)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: music_preferences
#------------------------------------------------------------

CREATE TABLE MUSIC_PREFERENCES(
        CONF_MUSIC_ID Int NOT NULL ,
        MUSIC_ID      Int NOT NULL
	,CONSTRAINT PK_MUSIC_PREFERENCES PRIMARY KEY (CONF_MUSIC_ID,MUSIC_ID)

	,CONSTRAINT FK_MUSIC_PREFERENCES_ENTITE FOREIGN KEY (CONF_MUSIC_ID) REFERENCES ENTITE(CONF_MUSIC_ID)
	,CONSTRAINT FK_MUSIC_PREFERENCES_MUSICS0 FOREIGN KEY (MUSIC_ID) REFERENCES MUSICS(MUSIC_ID)
)ENGINE=InnoDB;

