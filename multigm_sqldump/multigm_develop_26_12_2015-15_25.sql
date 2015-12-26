-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 26. Dez 2015 um 15:24
-- Server-Version: 5.6.25
-- PHP-Version: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `multigm_develop`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_account`
--

CREATE TABLE IF NOT EXISTS `multigm_account` (
  `Id` int(10) unsigned NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `PublicKey` varchar(32) DEFAULT NULL,
  `Password` varchar(64) DEFAULT NULL,
  `LastSerial` varchar(32) DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `EMail` varchar(50) DEFAULT NULL,
  `Type` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `multigm_account`
--

INSERT INTO `multigm_account` (`Id`, `Name`, `PublicKey`, `Password`, `LastSerial`, `LastLogin`, `EMail`, `Type`) VALUES
(32, 'Hans', '30a5be3ef92c09cf0e1e22302ebfa011', 'b636e12da4ba90df2f629bdc81751055ec7ec7218dcd00f0ad53f047916cf3ef', '0EC04F8BF8711457C804A67BCD76FAF2', '2015-12-14 16:42:42', '', 0),
(1, 'StiviK', '30a5be3ef92c09cf0e1e22302ebfa011', 'b636e12da4ba90df2f629bdc81751055ec7ec7218dcd00f0ad53f047916cf3ef', '71B947A4FF2929B905F4EE55B9182F02', '2015-12-26 15:24:44', '', 3),
(46, 'Sepp', 'fac3764ecc8ff01ea40f90874b5f64c8', '82728dcb66dd46c7c63db96c6502ac4461cacb6d864196813cd5e54e15ae231b', '71B947A4FF2929B905F4EE55B9182F02', '2015-11-24 19:57:32', NULL, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_character`
--

CREATE TABLE IF NOT EXISTS `multigm_character` (
  `Id` tinyint(10) NOT NULL,
  `Rank` tinyint(1) NOT NULL DEFAULT '0',
  `Locale` varchar(3) NOT NULL DEFAULT 'de',
  `Skin` int(11) NOT NULL,
  `XP` int(11) NOT NULL,
  `Money` int(11) NOT NULL,
  `PlayTime` int(255) NOT NULL,
  `FriendId` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `multigm_character`
--

INSERT INTO `multigm_character` (`Id`, `Rank`, `Locale`, `Skin`, `XP`, `Money`, `PlayTime`, `FriendId`) VALUES
(1, 6, 'de', 0, 0, 0, 8445, 'f5baab99fcc896a24ecec41fb39b489d '),
(32, 1, 'en', 0, 0, 1345346, 47, ''),
(46, 1, 'de', 0, 0, 1, 32, '4575983d0f1c473377e32b53115506c3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_cheatlog`
--

CREATE TABLE IF NOT EXISTS `multigm_cheatlog` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Severity` int(11) NOT NULL,
  `SessionId` varchar(100) NOT NULL,
  `SessionToken` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `multigm_cheatlog`
--

INSERT INTO `multigm_cheatlog` (`Id`, `UserId`, `Name`, `Severity`, `SessionId`, `SessionToken`) VALUES
(15, 1, 'Fake-Data', 4, '976', '151b0a4abb94d195db5ba4806a0e3190'),
(16, 1, 'Fake-Data', 4, '976', '151b0a4abb94d195db5ba4806a0e3190'),
(17, 1, 'Fake-Data', 4, '976', '151b0a4abb94d195db5ba4806a0e3190');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_cnr`
--

CREATE TABLE IF NOT EXISTS `multigm_cnr` (
  `ID` int(11) NOT NULL,
  `Name` text,
  `Position` text,
  `Skin` tinyint(4) DEFAULT NULL,
  `Fraction` text,
  `Weapons` text,
  `Dimension` tinyint(4) DEFAULT NULL,
  `Interior` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `multigm_cnr`
--

INSERT INTO `multigm_cnr` (`ID`, `Name`, `Position`, `Skin`, `Fraction`, `Weapons`, `Dimension`, `Interior`) VALUES
(27, 'Guest_29084', '[ { "y": -1682.66796875, "x": 1543.3466796875, "rot": 69.1187744140625, "z": 13.55627632141113 } ]', 127, 'Cops', 'xxxxxxx', 4, 0),
(28, 'Guest_75185', '[ { "y": -1672.6298828125, "x": 1540.1328125, "rot": 31.39114379882813, "z": 13.54999732971191 } ]', 127, 'Cops', 'xxxxxxx', 4, 0),
(29, 'Guest_16898', '[ { "y": -1674.9775390625, "x": 1549.3828125, "rot": 57.08859252929688, "z": 14.93722057342529 } ]', 127, 'Cops', 'xxxxxxx', 4, 0),
(35, 'StiviK', '[ { "y": -903.859375, "x": 1314.3193359375, "rot": 191.2171936035156, "z": 39.0175895690918 } ]', 127, 'Cops', 'xxxxxxx', 4, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_errlog`
--

CREATE TABLE IF NOT EXISTS `multigm_errlog` (
  `Id` int(11) NOT NULL,
  `sRayID` varchar(8) NOT NULL,
  `lRayID` varchar(100) NOT NULL,
  `Type` int(1) NOT NULL,
  `Timestamp` mediumtext NOT NULL,
  `AccountId` mediumtext NOT NULL,
  `ErrHash` varchar(1100) NOT NULL,
  `ErrSource` mediumtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `multigm_errlog`
--

INSERT INTO `multigm_errlog` (`Id`, `sRayID`, `lRayID`, `Type`, `Timestamp`, `AccountId`, `ErrHash`, `ErrSource`) VALUES
(7, '8b459b24', '8b459b2448122721eeb1079ddf131272f06a7b80', 1, '2015-12-26 14:51:02', '1', '0xEBB175DD', 'Lua->@[multigm]\\develop\\server\\classes\\Player\\Player.lua:73(67)'),
(8, '1584d6e7', '1584d6e7b042d1ffb2d5e2a95a9c5eda8e4b26ad', 1, '2015-12-26 14:54:08', '1', '0xEBB175DD', 'Lua->@[multigm]\\develop\\server\\classes\\Player\\Player.lua:64(36)'),
(9, '804a81aa', '804a81aa94796d93bec448636c819c68103375c2', 1, '2015-12-26 14:56:28', '1', '0xEBB175DD', 'Lua->@[multigm]\\develop\\server\\classes\\Player\\Player.lua:64(36)'),
(10, 'ffd8cd4e', 'ffd8cd4e44272de8a04c96600c6965de795e5e3c', 1, '2015-12-26 14:58:53', '1', '0xEBB175DD', 'Lua->@[multigm]\\develop\\server\\classes\\Player\\Player.lua:64(36)'),
(11, '23438c98', '23438c987c330c17b57abd0421d7a9c2328fb2d3', 1, '2015-12-26 15:00:31', '1', '0xEBB175DD', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "name": "loadCharacter", "currentline": 64, "namewhat": "method", "linedefined": 36, "lastlinedefined": 68 } ]'),
(12, '1521ae05', '1521ae056cdb1af4ffd7b97f8a167dc33c7d7257', 1, '2015-12-26 15:03:26', '1', '0xEBB175DD', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "name": "loadCharacter", "currentline": 64, "namewhat": "method", "linedefined": 36, "lastlinedefined": 68 } ]'),
(13, '255241cc', '255241cc607662302e2d7105a08ef0c8fc41ea0d', 1, '2015-12-26 15:04:01', '-1', '0xFFABA5D6', '[ { "short_src": "develop\\\\client\\\\classes\\\\Provider.lua", "source": "@develop\\\\client\\\\classes\\\\Provider.lua", "nups": 0, "what": "Lua", "currentline": 66, "namewhat": "", "linedefined": 51, "lastlinedefined": 82 } ]'),
(14, 'f37a058b', 'f37a058bc63b68ec9a7b6b74ce0528f9dd978896', 1, '2015-12-26 15:05:15', '1', '0xEBB175DD', '[ { "source": "=(tail call)", "what": "tail", "nups": 0, "short_src": "(tail call)", "name": "", "currentline": -1, "namewhat": "", "linedefined": -1, "lastlinedefined": -1 } ]'),
(15, '6332b993', '6332b993a381b5c2e3598a0cac095e7a0b344191', 1, '2015-12-26 15:14:35', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "...ultigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "name": "addPlayer", "currentline": 60, "namewhat": "method", "linedefined": 51, "lastlinedefined": 82 } ]'),
(16, 'ffff9172', 'ffff9172b8856679a3c03816f04ee31d56d15138', 1, '2015-12-26 15:16:10', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "...ultigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "name": "addPlayer", "currentline": 60, "namewhat": "method", "linedefined": 51, "lastlinedefined": 82 } ]'),
(17, 'ddbf9ed9', 'ddbf9ed9cd4e7ab04b5b4fcffff79f510efd49bf', 1, '2015-12-26 15:19:27', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "...ultigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "name": "addPlayer", "currentline": 61, "namewhat": "method", "linedefined": 52, "lastlinedefined": 84 } ]'),
(18, 'c02220fe', 'c02220fe33143fe92384c7d6228a7d954349aa57', 1, '2015-12-26 15:20:42', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "name": "loadCharacter", "currentline": 64, "namewhat": "method", "linedefined": 36, "lastlinedefined": 65 } ]'),
(19, '2d4ae114', '2d4ae114674c462491e71085a16055cf1ff467ce', 1, '2015-12-26 15:23:12', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "[multigm]\\\\develop\\\\server\\\\classes\\\\Player\\\\Player.lua", "name": "loadCharacter", "currentline": 64, "namewhat": "method", "linedefined": 36, "lastlinedefined": 65 } ]'),
(20, '5f9a6ce5', '5f9a6ce51d749efcabd426b60a105068ffd186d7', 1, '2015-12-26 15:23:36', '1', '0xEC075CB3', '[ { "nups": 1, "what": "Lua", "func": 0, "lastlinedefined": 61, "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "currentline": 61, "namewhat": "", "linedefined": 61, "short_src": "...ultigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua" } ]'),
(21, '9dc221cf', '9dc221cf20cb542b840ba6724565fdc37dc0b613', 1, '2015-12-26 15:24:44', '1', '0xEC075CB3', '[ { "source": "@[multigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "what": "Lua", "func": 0, "nups": 0, "short_src": "...ultigm]\\\\develop\\\\server\\\\classes\\\\Gamemode\\\\Gamemode.lua", "name": "addPlayer", "currentline": 61, "namewhat": "method", "linedefined": 52, "lastlinedefined": 84 } ]');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multigm_sessions`
--

CREATE TABLE IF NOT EXISTS `multigm_sessions` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Token` varchar(100) NOT NULL,
  `IP` varchar(100) NOT NULL,
  `Serial` varchar(100) NOT NULL,
  `Valid` int(11) NOT NULL DEFAULT '1',
  `sStart` int(11) NOT NULL,
  `sEnd` int(11) NOT NULL DEFAULT '0',
  `PlayerInfo` varchar(10000) NOT NULL DEFAULT '[ [ ] ]'
) ENGINE=InnoDB AUTO_INCREMENT=4298 DEFAULT CHARSET=latin1;


--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `multigm_account`
--
ALTER TABLE `multigm_account`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `multigm_character`
--
ALTER TABLE `multigm_character`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `multigm_cheatlog`
--
ALTER TABLE `multigm_cheatlog`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `multigm_cnr`
--
ALTER TABLE `multigm_cnr`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `multigm_errlog`
--
ALTER TABLE `multigm_errlog`
  ADD PRIMARY KEY (`Id`);

--
-- Indizes für die Tabelle `multigm_sessions`
--
ALTER TABLE `multigm_sessions`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `multigm_account`
--
ALTER TABLE `multigm_account`
  MODIFY `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT für Tabelle `multigm_cheatlog`
--
ALTER TABLE `multigm_cheatlog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT für Tabelle `multigm_cnr`
--
ALTER TABLE `multigm_cnr`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT für Tabelle `multigm_errlog`
--
ALTER TABLE `multigm_errlog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT für Tabelle `multigm_sessions`
--
ALTER TABLE `multigm_sessions`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
