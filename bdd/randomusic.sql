-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 18 sep. 2019 à 10:12
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `randomusic`
--

-- --------------------------------------------------------

--
-- Structure de la table `artists`
--

DROP TABLE IF EXISTS `artists`;
CREATE TABLE IF NOT EXISTS `artists` (
  `ARTIST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PSEUDO_ARTISTE` varchar(255) NOT NULL,
  PRIMARY KEY (`ARTIST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `compose`
--

DROP TABLE IF EXISTS `compose`;
CREATE TABLE IF NOT EXISTS `compose` (
  `ARTIST_ID` int(11) NOT NULL,
  `MUSIC_ID` int(11) NOT NULL,
  PRIMARY KEY (`ARTIST_ID`,`MUSIC_ID`),
  KEY `FK_COMPOSE_MUSICS0` (`MUSIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `conf_playlists`
--

DROP TABLE IF EXISTS `conf_playlists`;
CREATE TABLE IF NOT EXISTS `conf_playlists` (
  `CONF_PLAY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONF_RED_MUSIC` varchar(50) NOT NULL,
  `CONF_RED_ARTIST` varchar(50) NOT NULL,
  `CONF_PLAY_TYPE` varchar(50) NOT NULL,
  `CONF_MUSIC_TOKEN` varchar(50) NOT NULL,
  PRIMARY KEY (`CONF_PLAY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `content`
--

DROP TABLE IF EXISTS `content`;
CREATE TABLE IF NOT EXISTS `content` (
  `MUSIC_ID` int(11) NOT NULL,
  `PLAYLIST_ID` int(11) NOT NULL,
  PRIMARY KEY (`MUSIC_ID`,`PLAYLIST_ID`),
  KEY `FK_CONTENT_PLAYLISTS0` (`PLAYLIST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `entite`
--

DROP TABLE IF EXISTS `entite`;
CREATE TABLE IF NOT EXISTS `entite` (
  `CONF_MUSIC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONF_MUSIC_COLOR` varchar(50) NOT NULL,
  `CONF_MUSIC_PREF` varchar(50) NOT NULL,
  PRIMARY KEY (`CONF_MUSIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `musics`
--

DROP TABLE IF EXISTS `musics`;
CREATE TABLE IF NOT EXISTS `musics` (
  `MUSIC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MUSIC_TITLE` varchar(255) NOT NULL,
  `MUSIC_TYPE` varchar(255) NOT NULL,
  `DUREE_MUSIQUE` time NOT NULL,
  PRIMARY KEY (`MUSIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `music_param`
--

DROP TABLE IF EXISTS `music_param`;
CREATE TABLE IF NOT EXISTS `music_param` (
  `CONF_PLAY_ID` int(11) NOT NULL,
  `PLAYLIST_ID` int(11) NOT NULL,
  PRIMARY KEY (`CONF_PLAY_ID`,`PLAYLIST_ID`),
  KEY `FK_MUSIC_PARAM_PLAYLISTS0` (`PLAYLIST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `music_preferences`
--

DROP TABLE IF EXISTS `music_preferences`;
CREATE TABLE IF NOT EXISTS `music_preferences` (
  `CONF_MUSIC_ID` int(11) NOT NULL,
  `MUSIC_ID` int(11) NOT NULL,
  PRIMARY KEY (`CONF_MUSIC_ID`,`MUSIC_ID`),
  KEY `FK_MUSIC_PREFERENCES_MUSICS0` (`MUSIC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `playlists`
--

DROP TABLE IF EXISTS `playlists`;
CREATE TABLE IF NOT EXISTS `playlists` (
  `PLAYLIST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_PLAYLIST` varchar(255) NOT NULL,
  PRIMARY KEY (`PLAYLIST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(55) DEFAULT NULL,
  `USER_LASTNAME` varchar(55) DEFAULT NULL,
  `USER_LOGIN` varchar(255) NOT NULL,
  `USER_MAIL` varchar(255) NOT NULL,
  `PLAYLIST_ID` int(11) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `AK_USERS` (`USER_MAIL`),
  KEY `FK_USERS_PLAYLISTS` (`PLAYLIST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `compose`
--
ALTER TABLE `compose`
  ADD CONSTRAINT `FK_COMPOSE_ARTISTS` FOREIGN KEY (`ARTIST_ID`) REFERENCES `artists` (`ARTIST_ID`),
  ADD CONSTRAINT `FK_COMPOSE_MUSICS0` FOREIGN KEY (`MUSIC_ID`) REFERENCES `musics` (`MUSIC_ID`);

--
-- Contraintes pour la table `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `FK_CONTENT_MUSICS` FOREIGN KEY (`MUSIC_ID`) REFERENCES `musics` (`MUSIC_ID`),
  ADD CONSTRAINT `FK_CONTENT_PLAYLISTS0` FOREIGN KEY (`PLAYLIST_ID`) REFERENCES `playlists` (`PLAYLIST_ID`);

--
-- Contraintes pour la table `music_param`
--
ALTER TABLE `music_param`
  ADD CONSTRAINT `FK_MUSIC_PARAM_CONF_PLAYLISTS` FOREIGN KEY (`CONF_PLAY_ID`) REFERENCES `conf_playlists` (`CONF_PLAY_ID`),
  ADD CONSTRAINT `FK_MUSIC_PARAM_PLAYLISTS0` FOREIGN KEY (`PLAYLIST_ID`) REFERENCES `playlists` (`PLAYLIST_ID`);

--
-- Contraintes pour la table `music_preferences`
--
ALTER TABLE `music_preferences`
  ADD CONSTRAINT `FK_MUSIC_PREFERENCES_ENTITE` FOREIGN KEY (`CONF_MUSIC_ID`) REFERENCES `entite` (`CONF_MUSIC_ID`),
  ADD CONSTRAINT `FK_MUSIC_PREFERENCES_MUSICS0` FOREIGN KEY (`MUSIC_ID`) REFERENCES `musics` (`MUSIC_ID`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_USERS_PLAYLISTS` FOREIGN KEY (`PLAYLIST_ID`) REFERENCES `playlists` (`PLAYLIST_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
