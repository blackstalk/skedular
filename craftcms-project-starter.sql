# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.6.38)
# Database: craftcms-project-starter
# Generation Time: 2018-03-02 09:09:52 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;

INSERT INTO `assetindexdata` (`id`, `sessionId`, `volumeId`, `uri`, `size`, `timestamp`, `recordId`, `inProgress`, `completed`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'31f04ecd-b249-431d-9224-eac1428d8ed0',1,'.gitkeep',0,'2017-09-19 19:12:12',NULL,0,1,'2018-02-09 18:06:34','2018-02-09 18:06:34','211f4da5-a114-4dc9-97ad-9d5a39b0d9d6');

/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_body` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_body`)
VALUES
	(1,1,1,NULL,'2017-09-08 18:35:49','2018-01-04 10:29:55','73edc9f7-d43e-4545-a4c6-6c957ac828cd',NULL),
	(2,2,1,'Homepage','2017-09-08 19:09:37','2017-09-08 19:13:09','6dc5221d-bf62-4a8e-b4c7-6e5b49504616',NULL),
	(5,5,1,'Blog Index','2017-09-08 20:07:15','2017-09-08 20:07:15','f2f7247c-694d-4997-9698-24d70cdb2917',NULL),
	(6,6,1,'Hello World','2017-09-08 20:07:37','2017-09-08 20:07:37','81e37f01-d563-427c-b152-04d2b670dc0c','<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vero tempore reiciendis laudantium laborum quos nesciunt suscipit dolorem aperiam cumque sequi ullam nisi cum sed, dolorum. Obcaecati iste totam minima nostrum magnam, dolor? Vel consequuntur quae magnam, molestias obcaecati laudantium. Tenetur facilis, corporis distinctio deleniti ipsum. Delectus quidem, dignissimos ad voluptatem.</p>');

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2017-09-08 18:35:49','2018-01-04 10:29:55','105c3650-4497-4d27-a617-526aa94c9be9'),
	(2,1,'craft\\elements\\Entry',1,0,'2017-09-08 19:09:37','2017-09-08 19:13:08','2e959aee-0fcb-4006-87eb-7cd41ab2ad3f'),
	(5,5,'craft\\elements\\Entry',1,0,'2017-09-08 20:07:15','2017-09-08 20:07:15','e93bcca6-b4d7-48ec-b467-9640138fe889'),
	(6,4,'craft\\elements\\Entry',1,0,'2017-09-08 20:07:37','2017-09-08 20:07:37','53fb0ce9-b10c-4b9f-b839-d68cdce85091');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2017-09-08 18:35:49','2018-01-04 10:29:55','96a24547-6dc2-42e2-b007-1bc41d857923'),
	(2,2,1,'homepage','__home__',1,'2017-09-08 19:09:37','2017-09-08 19:13:09','5955212b-e34f-400c-aba2-fcbedafb6d67'),
	(5,5,1,'blog-index','blog',1,'2017-09-08 20:07:15','2017-09-08 20:07:15','457b40af-ee84-4c93-8207-baa17e93fb90'),
	(6,6,1,'hello-world','blog/hello-world',1,'2017-09-08 20:07:37','2017-09-08 20:07:37','b31198b2-3b55-41d6-b3ce-b12327677393');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,1,NULL,'2017-09-08 19:09:37',NULL,'2017-09-08 19:09:37','2017-09-08 19:13:09','3bc3eed1-038d-4b3f-ad66-89a8f08e351b'),
	(5,5,5,NULL,'2017-09-08 20:07:15',NULL,'2017-09-08 20:07:15','2017-09-08 20:07:15','fef364e8-c6b1-4f49-b2f0-1ce0df6bbbd6'),
	(6,4,4,1,'2017-09-08 20:07:37',NULL,'2017-09-08 20:07:37','2017-09-08 20:07:37','da6aac94-5ccb-4fac-a7ac-28343a16f6d0');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Homepage','homepage',0,NULL,'{section.name|raw}',1,'2017-09-08 19:09:37','2017-09-08 19:13:08','7f4690cd-0a2d-4e87-8809-f40b3be31ffe'),
	(4,4,4,'Article','article',1,'Title',NULL,1,'2017-09-08 20:06:37','2017-09-08 20:06:55','fe756228-5895-40ca-a138-026d51a19ad7'),
	(5,5,5,'Blog Index','blogIndex',0,NULL,'{section.name|raw}',1,'2017-09-08 20:07:15','2017-09-08 20:07:15','47830f36-8ddc-4ed5-874a-b9826f36e370');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,6,4,1,1,1,'','{\"typeId\":\"4\",\"authorId\":\"1\",\"title\":\"Hello World\",\"slug\":\"hello-world\",\"postDate\":1504901257,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vero tempore reiciendis laudantium laborum quos nesciunt suscipit dolorem aperiam cumque sequi ullam nisi cum sed, dolorum. Obcaecati iste totam minima nostrum magnam, dolor? Vel consequuntur quae magnam, molestias obcaecati laudantium. Tenetur facilis, corporis distinctio deleniti ipsum. Delectus quidem, dignissimos ad voluptatem.</p>\"}}','2017-09-08 20:07:37','2017-09-08 20:07:37','3446b8e7-4e0f-4f48-b495-3c90711d1ca0');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Default','2017-09-08 19:12:43','2017-09-08 19:12:43','f63ad89a-254d-4d4b-86c6-d73a3e689519');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,0,1,'2017-09-08 19:13:08','2017-09-08 19:13:08','bbca84c4-f09c-4422-bd4f-cdfcd34f2cee'),
	(3,4,3,1,0,1,'2017-09-08 20:06:55','2017-09-08 20:06:55','e2fbf6da-b97f-4b4b-9974-76471ee4ba94');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2017-09-08 19:09:37','2017-09-08 19:13:08','d8ddc405-cd8f-4b50-9b1e-14f08874e114'),
	(4,'craft\\elements\\Entry','2017-09-08 20:06:37','2017-09-08 20:06:55','cf1cafbd-44ba-4dea-b9f1-7f6d1590d505'),
	(5,'craft\\elements\\Entry','2017-09-08 20:07:15','2017-09-08 20:07:15','6a9b89e9-c216-431c-a096-487b35aa17e2'),
	(6,'craft\\elements\\Asset','2017-09-19 19:09:28','2017-09-19 19:09:28','df6b8323-bf0b-4cf5-82e3-9154f102a668');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Content',1,'2017-09-08 19:13:08','2017-09-08 19:13:08','7e4c9db8-7f04-4770-b94c-d7720c38fc2e'),
	(3,4,'Content',1,'2017-09-08 20:06:55','2017-09-08 20:06:55','7cb8f135-1780-4ad7-94b0-f992b0dc3dfe');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'Body','body','global','','none',NULL,'craft\\redactor\\Field','{\"redactorConfig\":\"\",\"purifierConfig\":\"\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\",\"availableVolumes\":\"*\",\"availableTransforms\":\"*\"}','2017-09-08 19:12:54','2018-01-03 08:53:31','dd939d7d-5ef4-4d06-8d9f-8fa1315e0721');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` tinyint(3) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.0-RC13','3.0.83',0,'Europe/Amsterdam','Craft CMS Project Starter',1,0,'KMDKnOO1coJF','2017-09-08 18:35:49','2018-03-02 09:08:38','9e700176-fdb7-45e1-b688-dc97de7038a0');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','e2fe80fa-28de-4d25-9bc9-6ff5f4658aca'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','3c520d89-81b6-4993-891c-80873c36f689'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','1e436045-8be3-4e1f-8fea-802c0ac174af'),
	(4,NULL,'app','m150403_184533_field_version','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','1c6d142c-4f73-4261-b0b6-f406e66d9f3b'),
	(5,NULL,'app','m150403_184729_type_columns','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','82195004-ad05-4b45-bedd-b2293065609c'),
	(6,NULL,'app','m150403_185142_volumes','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','6734f67f-8fb4-4267-9b3e-a2e014770c06'),
	(7,NULL,'app','m150428_231346_userpreferences','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','1da1969f-6c5a-48d4-8e50-acc63ec420ae'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','964decc8-1bd2-4403-8bb5-b0c58b575258'),
	(9,NULL,'app','m150617_213829_update_email_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','53a727eb-51f5-47da-b520-6beaa88d15f4'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','7b4484aa-ab65-4686-91af-1933db69ce08'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','891d2b96-38ec-476a-98e8-ba2f63041612'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','145399f6-45bf-4df2-b625-c781d9e2f28e'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','e74b8fb2-9cdc-4bb8-8595-72b4785252f5'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','e716fead-8079-43af-a13e-2bbf53c4d95c'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','48019c61-b308-459a-9270-86fab47f264b'),
	(16,NULL,'app','m151209_000000_move_logo','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','967f15ff-0bdf-477d-ab0c-2396c5fb8615'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','0b6f67d8-0101-4bc0-9d5b-02e09dc70d6d'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','ceae5aa6-bfce-4641-a327-92db497589eb'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','3c2ffbd7-d328-45c4-a60a-6a30b31cc11a'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','62afaa42-e76f-4a28-bc01-031912fed41d'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','b8346b08-8465-4c37-8de8-0f5c359f945b'),
	(22,NULL,'app','m160727_194637_column_cleanup','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','e81d760f-d452-4640-bf14-0d2ed0fe0591'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','aa418b8a-d33a-4162-af21-60f1babeeb74'),
	(24,NULL,'app','m160807_144858_sites','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','640bb029-7369-45b4-a4ab-8047b5038321'),
	(25,NULL,'app','m160817_161600_move_assets_cache','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','9862b9a7-f490-4ca3-8919-6a1136fdbdbc'),
	(26,NULL,'app','m160829_000000_pending_user_content_cleanup','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','2618671d-ec71-46a0-87cd-c243f0b34937'),
	(27,NULL,'app','m160830_000000_asset_index_uri_increase','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','f55c52a5-b2be-4b23-83eb-f2ebe78517c2'),
	(28,NULL,'app','m160912_230520_require_entry_type_id','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','dd9acf9f-1d4d-459a-9999-148f56cb51f8'),
	(29,NULL,'app','m160913_134730_require_matrix_block_type_id','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','15801e31-0f4a-44cd-890f-ad8d8442039e'),
	(30,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','b0b33f21-0e8b-4a87-8f98-511e063c5f58'),
	(31,NULL,'app','m160920_231045_usergroup_handle_title_unique','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','7a04600d-a28c-47f6-b143-0f5569648e55'),
	(32,NULL,'app','m160925_113941_route_uri_parts','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','3b42e915-a163-449c-a23b-2d2387519fb1'),
	(33,NULL,'app','m161006_205918_schemaVersion_not_null','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','76ab589d-a9ec-4366-b23d-676f96e10c1c'),
	(34,NULL,'app','m161007_130653_update_email_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','1540eeff-03e9-46fc-82a6-bea868bc3258'),
	(35,NULL,'app','m161013_175052_newParentId','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','fc3a8b41-4150-4abe-9642-748c389aa855'),
	(36,NULL,'app','m161021_102916_fix_recent_entries_widgets','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','33d9d69b-8b37-43f6-9de9-1ac3c0b790c0'),
	(37,NULL,'app','m161021_182140_rename_get_help_widget','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','20359dce-8f58-4d63-b2b1-78c3ec36a266'),
	(38,NULL,'app','m161025_000000_fix_char_columns','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','527ffc58-bbcd-4ace-9c9d-ee0cd8948c34'),
	(39,NULL,'app','m161029_124145_email_message_languages','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','3457e2c5-902d-4ab1-973e-ee2148fbb28a'),
	(40,NULL,'app','m161108_000000_new_version_format','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','583fb082-2766-4f7e-92b6-f7f00512a1a5'),
	(41,NULL,'app','m161109_000000_index_shuffle','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','a4dd88c7-8070-49f9-8870-8b66363d981c'),
	(42,NULL,'app','m161122_185500_no_craft_app','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','fd01b37a-958b-45fa-b3e5-cde1c6a93f07'),
	(43,NULL,'app','m161125_150752_clear_urlmanager_cache','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','a1af3a36-fad2-4d4a-9b6d-0e97df62d87f'),
	(44,NULL,'app','m161220_000000_volumes_hasurl_notnull','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','5435c6a9-d82c-40e3-a746-58d1eb5b1314'),
	(45,NULL,'app','m170114_161144_udates_permission','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','5fe45b8a-4b04-49d1-ae5b-3b7eb8b46f5c'),
	(46,NULL,'app','m170120_000000_schema_cleanup','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','2c4146dc-67d8-4711-863c-b8d5fafb21ae'),
	(47,NULL,'app','m170126_000000_assets_focal_point','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','542ec148-56fa-4fc0-be75-5acf2a3b86aa'),
	(48,NULL,'app','m170206_142126_system_name','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','69d199e6-f242-4a54-95b0-c92504fe28b5'),
	(49,NULL,'app','m170217_044740_category_branch_limits','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','99240779-5539-411d-ad19-514b3f0625bc'),
	(50,NULL,'app','m170217_120224_asset_indexing_columns','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','28ce122f-33a5-440a-ace6-cf74ce39cf98'),
	(51,NULL,'app','m170223_224012_plain_text_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','a1d52179-8414-442a-8183-e0b10d5fe22b'),
	(52,NULL,'app','m170227_120814_focal_point_percentage','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','87d4b198-9cce-4179-8849-95cab57f841e'),
	(53,NULL,'app','m170228_171113_system_messages','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','0226b6f7-d41f-4c32-a083-61b7533ca0e5'),
	(54,NULL,'app','m170303_140500_asset_field_source_settings','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','536eaebe-0293-484e-a513-23ec2569c8c1'),
	(55,NULL,'app','m170306_150500_asset_temporary_uploads','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','a3da484c-4c2c-48b9-b298-e9dbcb242241'),
	(56,NULL,'app','m170414_162429_rich_text_config_setting','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','5ad675cb-ac6c-4095-a790-697280a2968c'),
	(57,NULL,'app','m170523_190652_element_field_layout_ids','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','3bff08ec-cd00-452f-9a6d-fd239fdf961e'),
	(58,NULL,'app','m170612_000000_route_index_shuffle','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','aaf353e4-e184-4b2d-90f3-0cb2debad00f'),
	(59,NULL,'app','m170620_203910_no_disabled_plugins','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','243030fa-9231-4cc3-87a5-4a53c4d4c06e'),
	(60,NULL,'app','m170621_195237_format_plugin_handles','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','36baed2a-bacd-461b-b845-5045d3c475eb'),
	(61,NULL,'app','m170630_161028_deprecation_changes','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','b41d287c-83b7-4a40-bcf8-9ba46284162c'),
	(62,NULL,'app','m170703_181539_plugins_table_tweaks','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','d7af6376-0b93-46dc-a3d3-bf5ccb04d104'),
	(63,NULL,'app','m170704_134916_sites_tables','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','666a9a72-068b-43c9-9880-e1d404a85968'),
	(64,NULL,'app','m170706_183216_rename_sequences','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','4fe6e75f-68a0-4d82-8124-1ce6f785d618'),
	(65,NULL,'app','m170707_094758_delete_compiled_traits','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','4509be14-39f5-4afb-ae6e-b70a18702d1c'),
	(66,NULL,'app','m170707_131841_fix_db_routes','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','c37e3634-6d24-408f-ae90-89322dd56ef8'),
	(67,NULL,'app','m170731_190138_drop_asset_packagist','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','6aec70ab-c2f1-4a19-a02c-9351f32f55a7'),
	(68,NULL,'app','m170810_201318_create_queue_table','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','62000ccb-8984-466f-b1e1-a3acbf9ccd72'),
	(69,NULL,'app','m170816_133741_delete_compiled_behaviors','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','279fd55e-c84a-4646-9bd9-387e92fb70e7'),
	(70,NULL,'app','m170821_180624_deprecation_line_nullable','2017-09-08 18:35:51','2017-09-08 18:35:51','2017-09-08 18:35:51','a4b1d8e7-bb2f-48dc-9a12-ddafaa7766d2'),
	(71,NULL,'app','m170903_192801_longblob_for_queue_jobs','2017-09-19 19:11:36','2017-09-19 19:11:36','2017-09-19 19:11:36','f16d18ea-8138-475e-8bd0-a85b35e70da9'),
	(72,NULL,'app','m170914_204621_asset_cache_shuffle','2017-09-19 19:11:36','2017-09-19 19:11:36','2017-09-19 19:11:36','58d72620-3f51-491e-9e9c-08092fde7dfe'),
	(73,NULL,'app','m170809_223337_oauth_tokens_table','2017-11-24 11:44:11','2017-11-24 11:44:11','2017-11-24 11:44:11','744b27c3-651d-4fb8-971b-86b7117c9705'),
	(74,NULL,'app','m171107_000000_assign_group_permissions','2017-11-24 11:44:11','2017-11-24 11:44:11','2017-11-24 11:44:11','47e07ea5-8962-43af-ad35-c546db06eaa3'),
	(75,NULL,'app','m171011_214115_site_groups','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','12fbdb9f-5832-4ac6-9761-e2dbf119cc31'),
	(76,NULL,'app','m171012_151440_primary_site','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','9189f995-9159-41cc-8ad6-318c6a28cc7f'),
	(77,NULL,'app','m171013_142500_transform_interlace','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','a0df02fd-7581-44ea-beaa-81437203286f'),
	(78,NULL,'app','m171016_092553_drop_position_select','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','ddb8d3a5-110f-462a-b6dc-f63401b10152'),
	(79,NULL,'app','m171016_221244_less_strict_translation_method','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','2304d133-7a2b-46a2-8f57-355fbc5a7917'),
	(80,NULL,'app','m171117_000001_templatecache_index_tune','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','e8d4cf67-21eb-4206-a216-86ecf01a3724'),
	(81,NULL,'app','m171126_105927_disabled_plugins','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','956d76d1-5c03-419d-bbc2-bfac5ae7efb7'),
	(82,NULL,'app','m171130_214407_craftidtokens_table','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','0a54f06d-71ec-46ca-8eca-bb69910848a1'),
	(83,NULL,'app','m171202_004225_update_email_settings','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','f7eb8ac4-e383-4361-9ea4-eaf6beb4938b'),
	(84,NULL,'app','m171204_000001_templatecache_index_tune_deux','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','98ea5b0c-21bc-4a8c-b33f-c2ffee02166b'),
	(85,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','56deb6f2-2c57-4e31-a820-07d365a3855f'),
	(86,NULL,'app','m171210_142046_fix_db_routes','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','b9aeccc0-a4a8-4602-8e06-5cf03f17a768'),
	(87,NULL,'app','m171218_143135_longtext_query_column','2017-12-20 13:49:10','2017-12-20 13:49:10','2017-12-20 13:49:10','ed2651b2-a0ba-410b-adf0-d1dfc9bfa03b'),
	(88,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-01-03 08:51:37','2018-01-03 08:51:37','2018-01-03 08:51:37','adbeb7c4-40e2-4942-8570-85adf5204c22'),
	(90,4,'plugin','Install','2018-01-04 10:19:37','2018-01-04 10:19:37','2018-01-04 10:19:37','43965fc5-c0dc-449d-8950-880b1d6d6195'),
	(93,NULL,'app','m180113_153740_drop_users_archived_column','2018-01-17 09:04:24','2018-01-17 09:04:24','2018-01-17 09:04:24','654648a5-325b-4686-a022-066b0418a321'),
	(94,NULL,'app','m180122_213433_propagate_entries_setting','2018-01-29 11:05:25','2018-01-29 11:05:25','2018-01-29 11:05:25','320c031d-20ec-4503-870f-7700f6386494'),
	(95,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-01-29 11:05:25','2018-01-29 11:05:25','2018-01-29 11:05:25','b8d64a3d-d0db-4a75-bf5b-78afa5cd7cd5'),
	(96,NULL,'app','m180128_235202_set_tag_slugs','2018-02-09 17:53:48','2018-02-09 17:53:48','2018-02-09 17:53:48','aa377847-967c-43ae-a8a1-376c59bbe48e'),
	(97,NULL,'app','m180202_185551_fix_focal_points','2018-02-09 18:04:36','2018-02-09 18:04:36','2018-02-09 18:04:36','82c818ac-64f2-416d-95b1-ded4222031be'),
	(98,NULL,'app','m180217_172123_tiny_ints','2018-02-21 22:03:17','2018-02-21 22:03:17','2018-02-21 22:03:17','4e6debda-95d2-4d62-aeb2-6d1bd24a51ba');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') NOT NULL DEFAULT 'unknown',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`),
  KEY `plugins_enabled_idx` (`enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`, `enabled`)
VALUES
	(2,'element-api','2.5.2','1.0.0',NULL,'unknown',NULL,'2017-10-17 13:44:43','2017-10-17 13:44:43','2018-03-02 09:09:28','8f7f3aa0-254f-4870-953b-4e86077acde3',1),
	(4,'redactor','1.0.1','1.0.0',NULL,'unknown',NULL,'2018-01-04 10:19:37','2018-01-04 10:19:37','2018-03-02 09:09:28','ef7f378d-d08b-4dd0-9814-8e99ba495507',1);

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(2,'slug',0,1,' homepage '),
	(2,'title',0,1,' homepage '),
	(2,'field',1,1,''),
	(1,'username',0,1,' admin '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' johndoe gmail com '),
	(1,'slug',0,1,''),
	(5,'slug',0,1,' blog index '),
	(5,'title',0,1,' blog index '),
	(6,'slug',0,1,' hello world '),
	(6,'title',0,1,' hello world '),
	(6,'field',1,1,' lorem ipsum dolor sit amet consectetur adipisicing elit vero tempore reiciendis laudantium laborum quos nesciunt suscipit dolorem aperiam cumque sequi ullam nisi cum sed dolorum obcaecati iste totam minima nostrum magnam dolor vel consequuntur quae magnam molestias obcaecati laudantium tenetur facilis corporis distinctio deleniti ipsum delectus quidem dignissimos ad voluptatem ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `dateCreated`, `dateUpdated`, `uid`, `propagateEntries`)
VALUES
	(1,NULL,'Homepage','homepage','single',1,'2017-09-08 19:09:37','2017-09-08 19:09:37','540d7d7f-a6bb-4d10-a178-9296fdd989d5',1),
	(4,NULL,'Blog','blog','channel',1,'2017-09-08 20:06:37','2017-09-08 20:06:37','979a880c-a545-4399-8eaf-cd4462f41268',1),
	(5,NULL,'Blog Index','blogIndex','single',1,'2017-09-08 20:07:15','2017-09-08 20:07:15','b656e8d7-87a7-4700-93a7-6918015d7229',1);

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `enabledByDefault`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,1,'__home__','index','2017-09-08 19:09:37','2017-09-08 19:09:37','de1d4c72-2a84-4363-975c-0b29c9ef3758'),
	(4,4,1,1,1,'blog/{slug}','blog/_entry','2017-09-08 20:06:37','2017-09-08 20:06:37','4fbaf5b4-e877-4e44-baf2-59ca8003e137'),
	(5,5,1,1,1,'blog','blog/index','2017-09-08 20:07:15','2017-09-08 20:07:15','e7875c20-4b46-4f15-a1a2-bd13f067897f');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(8,1,'t83_10CzjpfemaEPtZlrwtXeSqR_WQ36e8vp1fxO9Nosrinnh1fjZOAvEHAQ4Jc4i3j6PNhfhG628BRh-2x6-cQamiuy9Nwru_E-','2017-12-20 13:49:22','2017-12-20 13:53:37','0e7d688d-878e-463c-a06c-99319f47c8a6'),
	(9,1,'LpmliM0kssN9PU8uQXbcuYzAihLbJa6PfGePFX99xxqHLXZcHwqukseExFOAE1kop0ibe10-tuZZBCh_4PjJS7yScCrKf7uJzZMc','2017-12-20 13:58:51','2017-12-20 14:06:28','82ed968c-657c-4e4d-bb5d-5277cbaad036'),
	(10,1,'DZYMVYJoUgfboPzpG_XISYUplnobG2IwdmoWXA8XsZrewvtEch3TMvyo28O0TS-GXIll0J7xuWJccv8pWII97mYUn4MWWGm43TmB','2018-01-03 08:51:44','2018-01-03 08:57:00','a39bb0e8-fd78-4aa3-b8fe-9341400b936b'),
	(11,1,'EB-IwjpeP_1Agk1esr4UoQXeurmbsG1pzxm-JQzy1Duz6DtoXEK99W4VzmSTEXdtdcikYhIDQIC2wcd8fVqgMdk1rc8v0Sf16rId','2018-01-04 10:19:21','2018-01-04 10:34:11','8fb7a151-76b8-4027-aae9-2b569e938805'),
	(12,1,'DFQJpZEQ-MWCjp41JYGfHBm9cRKF9MZV9oSv0l0PRSdM4UDWuXpycrVJ-theOqqEwgKxNS4XP9yHHFmKCHBeGZzYDWSbhDfHecKJ','2018-01-10 13:16:49','2018-01-10 13:17:18','5be38f7a-11e3-42ab-82e8-f36a7bfcfdc6'),
	(13,1,'mU2kBsyhgXh4Qn9-jP2ZOJiU-6XbpoUxuyAY1adIdLKz0SDhTghIuBcenquTRRpqHs36zyFCYBw1-xd4HQ2RKrUb_y3lVqNPGfh5','2018-01-11 12:45:53','2018-01-11 12:57:14','8803d656-1a00-4418-aff8-5ad9ae285c06'),
	(14,1,'ltGCCF7RrEugKVsKOFgBUOs6_eIyqNk1DxZweGBdjW2TqqFkpuPWGoNK-p_jiuX17N0odbg-geJEC7EgKqC3jLqx3hIYcizkPhue','2018-01-17 09:04:37','2018-01-17 09:15:46','daab918e-5f9c-4f79-894d-884a3048037e'),
	(15,1,'2fMzFaLkbMYJjFbGvjFCUTm4VC5uRfSphkiCKhrJMVkzW_EAfW1KWSO0hvHl0GQ8hIMxdd4GYH2bFiUVi8vKAipkxCgsnAqxu21T','2018-01-29 11:05:34','2018-01-29 11:10:43','55434133-45d1-4d1d-856d-bb5c84f30caa'),
	(16,1,'vGhH_rtAL04irGq4_W1yan9jrlombEV89BGXXgSkPmfMS3iERlxOskqAt9OnJbsXv2ZlOQVw4PTts-FhGx2yNRTRaacWZQHm7PMC','2018-02-09 18:04:48','2018-02-09 18:15:18','9b50bec4-ea33-4f18-88cb-2259cb6360ad'),
	(17,1,'eihQHAVj5GwOfq0mU3zdd5aDjNt6GLecw5lNkewzby5ZdcDL_pUEeo7jXOjn2jJKgsk_iTdFD963UjxmdUONyMAqnT4z-Ev3KlV6','2018-03-02 09:09:12','2018-03-02 09:09:35','600e9bbf-36a7-4f84-9bb1-8b5edc026938');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitegroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Default','2017-12-20 13:49:10','2017-12-20 14:01:49','a0059ff2-95fa-4b45-9b83-d33adaccc6e4');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`, `groupId`, `primary`)
VALUES
	(1,'Craft CMS Project Starter','default','en',1,'/',1,'2017-09-08 18:35:49','2018-02-21 22:03:54','aebac91c-fff6-4f09-b5d1-72694fe08a75',1,1);

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"philipp@rppld.co\",\"fromName\":\"Craft CMS Project Starter\",\"template\":null,\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Sendmail\",\"transportSettings\":null}','2017-09-08 18:35:51','2018-02-21 22:05:19','a94802d4-ee0d-46b2-ae23-364f81880113'),
	(3,'users','{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeId\":\"1\",\"photoSubpath\":\"\"}','2017-12-20 14:01:31','2017-12-20 14:01:31','ca305540-3c62-430d-9df1-216d8b8651d6');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en\",\"weekStartDay\":\"1\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `client` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `client`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'admin',NULL,'','','johndoe@gmail.com','$2y$13$OPD/lGFjmP/WU8mAwDUGIuocjmi7ODdRDI8p020gqmZ4JyG1C8.n.',1,0,0,0,0,'2018-03-02 09:09:12','::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2018-01-04 10:29:57','2017-09-08 18:35:51','2018-03-02 09:09:12','28a89b27-c02d-43df-abb8-d7c0537ff6bb');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Uploads','','2017-09-19 19:09:28','2017-09-19 19:09:28','771a72c3-6032-4455-a802-52958370ee18'),
	(2,NULL,NULL,'Temporary source',NULL,'2017-09-19 19:11:41','2017-09-19 19:11:41','c7499c2d-6c9a-4ebf-96f9-6fa7e1b1a6ad'),
	(3,2,NULL,'user_1','user_1/','2017-09-19 19:11:41','2017-09-19 19:11:41','d4ca1b9d-ff0e-4d89-b5f0-2e0e77575bc1');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,6,'Uploads','uploads','craft\\volumes\\Local',1,'http://craftcms-webpack-boilerplate.dev//uploads','{\"path\":\"/Users/philipp/Sites/unionhaus/web/uploads\"}',1,'2017-09-19 19:09:28','2017-09-19 19:09:28','62e59e02-40ad-4e3b-b574-4059ccb41e80');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` tinyint(3) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2017-09-08 18:35:53','2017-09-08 18:35:53','35026951-c3f3-4945-a13c-24af6327c2e3'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2017-09-08 18:35:53','2017-09-08 18:35:53','c8e9454d-976a-40dd-a37a-f707854940d1'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2017-09-08 18:35:53','2017-09-08 18:35:53','2286af31-aa37-45df-8d0f-365c0a56d6a2'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2017-09-08 18:35:54','2017-09-08 18:35:54','aa0457cc-737c-4916-a954-e6caeb2dc799');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
