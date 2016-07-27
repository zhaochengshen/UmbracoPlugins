/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.28-log : Database - umbraco-cms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`umbraco-cms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `umbraco-cms`;

/*Table structure for table `cmscontent` */

DROP TABLE IF EXISTS `cmscontent`;

CREATE TABLE `cmscontent` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `nodeId` int(11) NOT NULL,
  `contentType` int(11) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `IX_cmsContent` (`nodeId`),
  KEY `contentType` (`contentType`),
  CONSTRAINT `cmscontent_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmscontent_ibfk_2` FOREIGN KEY (`contentType`) REFERENCES `cmscontenttype` (`nodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

/*Data for the table `cmscontent` */

LOCK TABLES `cmscontent` WRITE;

insert  into `cmscontent`(`pk`,`nodeId`,`contentType`) values (1,1047,1044),(2,1049,1033),(3,1053,1033),(4,1054,1033),(5,1055,1033),(6,1056,1031),(7,1057,1031),(8,1058,1033),(9,1059,1031),(10,1060,1032),(11,1061,1032),(12,1062,1032),(13,1063,1032),(14,1064,1032),(15,1065,1031),(16,1066,1033),(34,1107,1106),(35,1108,1105),(36,1109,1104),(37,1110,1105),(38,1111,1105),(39,1112,1104),(40,1115,1106),(41,1116,1104);

UNLOCK TABLES;

/*Table structure for table `cmscontenttype` */

DROP TABLE IF EXISTS `cmscontenttype`;

CREATE TABLE `cmscontenttype` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `nodeId` int(11) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) NOT NULL DEFAULT 'folder.png',
  `description` varchar(1500) DEFAULT NULL,
  `isContainer` tinyint(1) NOT NULL DEFAULT '0',
  `allowAtRoot` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk`),
  KEY `IX_cmsContentType` (`nodeId`),
  KEY `IX_cmsContentType_icon` (`icon`),
  CONSTRAINT `cmscontenttype_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8;

/*Data for the table `cmscontenttype` */

LOCK TABLES `cmscontenttype` WRITE;

insert  into `cmscontenttype`(`pk`,`nodeId`,`alias`,`icon`,`thumbnail`,`description`,`isContainer`,`allowAtRoot`) values (531,1044,'Member','icon-user','icon-user',NULL,0,0),(532,1031,'Folder','icon-folder','icon-folder',NULL,0,1),(533,1032,'Image','icon-picture','icon-picture',NULL,0,0),(534,1033,'File','icon-document','icon-document',NULL,0,0),(541,1104,'files','icon-camcorder','folder.png','',0,0),(542,1105,'folders','icon-folder','folder.png','',0,0),(543,1106,'home','icon-circus','folder.png','',0,1);

UNLOCK TABLES;

/*Table structure for table `cmscontenttype2contenttype` */

DROP TABLE IF EXISTS `cmscontenttype2contenttype`;

CREATE TABLE `cmscontenttype2contenttype` (
  `parentContentTypeId` int(11) NOT NULL,
  `childContentTypeId` int(11) NOT NULL,
  PRIMARY KEY (`parentContentTypeId`,`childContentTypeId`),
  KEY `childContentTypeId` (`childContentTypeId`),
  CONSTRAINT `cmscontenttype2contenttype_ibfk_1` FOREIGN KEY (`parentContentTypeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmscontenttype2contenttype_ibfk_2` FOREIGN KEY (`childContentTypeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmscontenttype2contenttype` */

LOCK TABLES `cmscontenttype2contenttype` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmscontenttypeallowedcontenttype` */

DROP TABLE IF EXISTS `cmscontenttypeallowedcontenttype`;

CREATE TABLE `cmscontenttypeallowedcontenttype` (
  `Id` int(11) NOT NULL,
  `AllowedId` int(11) NOT NULL,
  `SortOrder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`,`AllowedId`),
  KEY `AllowedId` (`AllowedId`),
  CONSTRAINT `cmscontenttypeallowedcontenttype_ibfk_1` FOREIGN KEY (`Id`) REFERENCES `cmscontenttype` (`nodeId`),
  CONSTRAINT `cmscontenttypeallowedcontenttype_ibfk_2` FOREIGN KEY (`AllowedId`) REFERENCES `cmscontenttype` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmscontenttypeallowedcontenttype` */

LOCK TABLES `cmscontenttypeallowedcontenttype` WRITE;

insert  into `cmscontenttypeallowedcontenttype`(`Id`,`AllowedId`,`SortOrder`) values (1031,1031,0),(1031,1032,0),(1031,1033,0),(1105,1104,0),(1105,1105,1),(1106,1104,0),(1106,1105,1);

UNLOCK TABLES;

/*Table structure for table `cmscontentversion` */

DROP TABLE IF EXISTS `cmscontentversion`;

CREATE TABLE `cmscontentversion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ContentId` int(11) NOT NULL,
  `VersionId` char(36) NOT NULL,
  `VersionDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IX_cmsContentVersion_ContentId` (`ContentId`),
  KEY `IX_cmsContentVersion_VersionId` (`VersionId`),
  CONSTRAINT `cmscontentversion_ibfk_1` FOREIGN KEY (`ContentId`) REFERENCES `cmscontent` (`nodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

/*Data for the table `cmscontentversion` */

LOCK TABLES `cmscontentversion` WRITE;

insert  into `cmscontentversion`(`id`,`ContentId`,`VersionId`,`VersionDate`) values (1,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d','2016-06-13 17:40:58'),(2,1049,'328c5f75-d506-4777-85a1-75fa2d7279ea','2016-06-29 13:41:06'),(3,1053,'7e07a126-7189-4aa7-9cfc-8a558ef675bd','2016-06-29 13:38:29'),(4,1054,'a6e66185-418f-4fd8-8580-7da20eecffdd','2016-06-29 13:38:54'),(5,1055,'e6da32d9-e922-4381-9ceb-b5b7040021d9','2016-06-29 13:50:07'),(6,1056,'a5fffdab-2e84-40fd-8b8d-665a2d1f529d','2016-06-29 13:48:26'),(7,1057,'f541bdc8-73d6-42b0-9f61-77cc1d1a6fe3','2016-06-29 13:48:26'),(8,1058,'49cd0139-c4e6-49e8-8160-9a3e35cb0eef','2016-06-29 13:48:26'),(9,1059,'716908aa-a352-499d-973a-434dc22eee2d','2016-06-29 13:48:26'),(10,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba','2016-06-29 13:48:26'),(11,1061,'295684cd-2ee2-4b15-863f-001b869f713a','2016-06-29 13:48:26'),(12,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5','2016-06-29 13:48:26'),(13,1063,'7fac755e-036e-4002-8154-4e258f3bef74','2016-06-29 13:48:26'),(14,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3','2016-06-29 13:48:26'),(15,1065,'55ade4ac-b710-4923-a0b8-a865e3b676fa','2016-06-29 13:48:26'),(16,1066,'fb88ba80-f814-4612-b097-38b809736c10','2016-06-29 13:48:26'),(67,1107,'dff42db0-61d4-4447-9fc6-102e6108c44e','2016-06-30 10:56:20'),(68,1108,'83e39217-06c5-4c9d-b978-2728a7f748fa','2016-06-30 10:59:22'),(69,1109,'25ea5f87-63ca-4c5f-b6c3-26659e728e4d','2016-06-30 10:59:28'),(70,1110,'927a846f-26b8-41d7-bba3-0c75ebde0a8b','2016-06-30 10:59:36'),(71,1111,'2f6152a4-62b9-4f34-9be7-be1bb60c2cd7','2016-06-30 10:59:42'),(72,1107,'8c6c041c-4c6e-4a1a-aebf-6ceece50e136','2016-06-30 14:40:17'),(73,1108,'0ae758a0-4498-48fc-8721-08a72dfe9686','2016-06-30 14:40:17'),(74,1109,'138d3018-3513-4e57-85e1-7d34abf89837','2016-06-30 14:40:17'),(75,1110,'7036cd92-51a3-4bcc-8ee7-ffde6fb49bf5','2016-06-30 14:40:18'),(76,1111,'e90349cc-33a6-4344-b6ef-97b44ec96d22','2016-06-30 14:40:18'),(77,1112,'20f79f03-5836-4319-9568-2d3350554504','2016-07-12 16:46:18'),(78,1109,'9b732db8-9c92-4d4a-a3ae-3e99698f6250','2016-07-14 14:02:32'),(79,1107,'45585f8c-1c01-4aff-99ec-b84da4468653','2016-07-14 14:03:43'),(80,1108,'c9ab3b9b-f5ba-45f6-bf07-482e151245c1','2016-07-14 14:03:47'),(81,1109,'6c5ed68d-d81e-4a2e-b587-7052339c31ce','2016-07-14 14:03:50'),(82,1110,'0c713dcc-a834-420d-a2b5-850f3cdffd7d','2016-07-14 14:03:53'),(83,1112,'e2a73924-529d-4de7-bf4f-551f7462ba3e','2016-07-14 14:03:56'),(84,1111,'832c38bc-7c6b-4a68-ae42-9ffeac627f7a','2016-07-14 14:04:00'),(85,1107,'f19a5f13-b477-4190-aac9-853cd6d3b066','2016-07-14 14:04:03'),(86,1108,'3efac298-2842-4623-a32e-5f4e45dfda4f','2016-07-14 14:04:03'),(87,1109,'6091839e-efa2-4cb7-af1e-e56e59e0a67c','2016-07-14 14:04:03'),(88,1110,'4f1762ea-7949-4381-8c4b-4b36f0573cdb','2016-07-14 14:04:03'),(89,1112,'33b2dd7f-639c-4451-a177-accd4b7a118b','2016-07-14 14:04:04'),(90,1111,'5e7e6ec4-23a5-4523-96f8-1e56a21e3326','2016-07-14 14:04:04'),(91,1107,'5aabca95-0fd3-407f-a77d-743a76386cbd','2016-07-14 14:04:05'),(92,1115,'b65e338f-6d24-40eb-a027-2229a87630fe','2016-07-14 14:04:32'),(93,1116,'1e56729f-d563-4983-a214-ec1948e546b8','2016-07-14 14:05:01');

UNLOCK TABLES;

/*Table structure for table `cmscontentxml` */

DROP TABLE IF EXISTS `cmscontentxml`;

CREATE TABLE `cmscontentxml` (
  `nodeId` int(11) NOT NULL,
  `xml` longtext NOT NULL,
  PRIMARY KEY (`nodeId`),
  CONSTRAINT `cmscontentxml_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `cmscontent` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmscontentxml` */

LOCK TABLES `cmscontentxml` WRITE;

insert  into `cmscontentxml`(`nodeId`,`xml`) values (1047,'<Member id=\"1047\" key=\"62c86a6e-337f-44cb-bbd1-7538ad8f0d95\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-06T10:31:36\" updateDate=\"2016-06-13T17:40:57\" nodeName=\"VIP_1\" urlName=\"vip_1\" path=\"-1,1047\" isDoc=\"\" nodeType=\"1044\" nodeTypeAlias=\"Member\" loginName=\"admin\" email=\"admin@qq.com\" icon=\"icon-user\" />'),(1053,'<File id=\"1053\" key=\"67a05626-fc0e-408c-a987-0db38c703269\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"1\" createDate=\"2016-06-29T13:38:28\" updateDate=\"2016-06-29T13:38:28\" nodeName=\"产品路线20150628.xlsx\" urlName=\"产品路线20150628xlsx\" path=\"-1,1053\" isDoc=\"\" nodeType=\"1033\" writerName=\"zcs\" writerID=\"0\" version=\"7e07a126-7189-4aa7-9cfc-8a558ef675bd\" template=\"0\" nodeTypeAlias=\"File\"><umbracoFile><![CDATA[/media/1001/产品路线20150628.xlsx]]></umbracoFile><umbracoBytes><![CDATA[119961]]></umbracoBytes><umbracoExtension><![CDATA[xlsx]]></umbracoExtension></File>'),(1054,'<File id=\"1054\" key=\"f15f245b-4a52-42c9-89ca-b771fd5dae8c\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"2\" createDate=\"2016-06-29T13:38:53\" updateDate=\"2016-06-29T13:38:53\" nodeName=\"crebas.sql\" urlName=\"crebassql\" path=\"-1,1054\" isDoc=\"\" nodeType=\"1033\" writerName=\"zcs\" writerID=\"0\" version=\"a6e66185-418f-4fd8-8580-7da20eecffdd\" template=\"0\" nodeTypeAlias=\"File\"><umbracoFile><![CDATA[/media/1002/crebas.sql]]></umbracoFile><umbracoBytes><![CDATA[5061]]></umbracoBytes><umbracoExtension><![CDATA[sql]]></umbracoExtension></File>'),(1115,'<home id=\"1115\" key=\"286bf910-1455-41e2-888d-dc05a4fbc8a5\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-07-14T14:04:32\" updateDate=\"2016-07-14T14:04:32\" nodeName=\"文件管理\" urlName=\"文件管理\" path=\"-1,1115\" isDoc=\"\" nodeType=\"1106\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1094\" nodeTypeAlias=\"home\" />'),(1116,'<files id=\"1116\" key=\"ff3a0e5b-75d3-4f9a-bd23-a42cc39d9ad7\" parentID=\"1115\" level=\"2\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-07-14T14:05:00\" updateDate=\"2016-07-14T14:05:00\" nodeName=\"12\" urlName=\"12\" path=\"-1,1115,1116\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\"><fileURL><![CDATA[1053]]></fileURL><fileName><![CDATA[12]]></fileName></files>');

UNLOCK TABLES;

/*Table structure for table `cmsdatatype` */

DROP TABLE IF EXISTS `cmsdatatype`;

CREATE TABLE `cmsdatatype` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `nodeId` int(11) NOT NULL,
  `propertyEditorAlias` varchar(255) NOT NULL,
  `dbType` varchar(50) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `IX_cmsDataType_nodeId` (`nodeId`),
  CONSTRAINT `cmsdatatype_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

/*Data for the table `cmsdatatype` */

LOCK TABLES `cmsdatatype` WRITE;

insert  into `cmsdatatype`(`pk`,`nodeId`,`propertyEditorAlias`,`dbType`) values (-28,-97,'Umbraco.ListView','Nvarchar'),(-27,-96,'Umbraco.ListView','Nvarchar'),(-26,-95,'Umbraco.ListView','Nvarchar'),(1,-49,'Umbraco.TrueFalse','Integer'),(2,-51,'Umbraco.Integer','Integer'),(3,-87,'Umbraco.TinyMCEv3','Ntext'),(4,-88,'Umbraco.Textbox','Nvarchar'),(5,-89,'Umbraco.TextboxMultiple','Ntext'),(6,-90,'Umbraco.UploadField','Nvarchar'),(7,-92,'Umbraco.NoEdit','Nvarchar'),(8,-36,'Umbraco.DateTime','Date'),(9,-37,'Umbraco.ColorPickerAlias','Nvarchar'),(11,-39,'Umbraco.DropDownMultiple','Nvarchar'),(12,-40,'Umbraco.RadioButtonList','Nvarchar'),(13,-41,'Umbraco.Date','Date'),(14,-42,'Umbraco.DropDown','Integer'),(15,-43,'Umbraco.CheckBoxList','Nvarchar'),(16,1034,'Umbraco.ContentPickerAlias','Integer'),(17,1035,'Umbraco.MediaPicker','Integer'),(18,1036,'Umbraco.MemberPicker','Integer'),(21,1040,'Umbraco.RelatedLinks','Ntext'),(22,1041,'Umbraco.Tags','Ntext'),(24,1043,'Umbraco.ImageCropper','Ntext'),(25,1045,'Umbraco.MultipleMediaPicker','Nvarchar'),(26,1048,'Umbraco.NoEdit','Ntext'),(27,1050,'Umbraco.Date','Date'),(28,1067,'Umbraco.Textbox','Nvarchar'),(29,1069,'Umbraco.Textbox','Nvarchar'),(30,1070,'Umbraco.Textbox','Nvarchar'),(31,1073,'Umbraco.Textbox','Nvarchar'),(32,1076,'Umbraco.Textbox','Nvarchar'),(33,1077,'Umbraco.UploadField','Nvarchar'),(34,1090,'Umbraco.Textbox','Nvarchar'),(35,1093,'Umbraco.Textbox','Nvarchar'),(36,1113,'Umbraco.MultipleMediaPicker','Nvarchar'),(37,1114,'Umbraco.MultipleMediaPicker','Nvarchar');

UNLOCK TABLES;

/*Table structure for table `cmsdatatypeprevalues` */

DROP TABLE IF EXISTS `cmsdatatypeprevalues`;

CREATE TABLE `cmsdatatypeprevalues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datatypeNodeId` int(11) NOT NULL,
  `value` longtext,
  `sortorder` int(11) NOT NULL,
  `alias` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datatypeNodeId` (`datatypeNodeId`),
  CONSTRAINT `cmsdatatypeprevalues_ibfk_1` FOREIGN KEY (`datatypeNodeId`) REFERENCES `cmsdatatype` (`nodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `cmsdatatypeprevalues` */

LOCK TABLES `cmsdatatypeprevalues` WRITE;

insert  into `cmsdatatypeprevalues`(`id`,`datatypeNodeId`,`value`,`sortorder`,`alias`) values (-9,-96,'[{\"alias\":\"sortOrder\",\"isSystem\":1, \"header\": \"Sort order\"},{\"alias\":\"updateDate\",\"header\":\"Last edited\",\"isSystem\":1},{\"alias\":\"owner\",\"header\":\"Updated by\",\"isSystem\":1}]',5,'includeProperties'),(-8,-96,'[{\"name\": \"Grid\",\"path\": \"views/propertyeditors/listview/layouts/grid/grid.html\", \"icon\": \"icon-thumbnails-small\", \"isSystem\": 1, \"selected\": true},{\"name\": \"List\",\"path\": \"views/propertyeditors/listview/layouts/list/list.html\",\"icon\": \"icon-list\", \"isSystem\": 1,\"selected\": true}]',4,'layouts'),(-7,-96,'desc',3,'orderDirection'),(-6,-96,'VersionDate',2,'orderBy'),(-5,-96,'100',1,'pageSize'),(-4,-97,'[{\"alias\":\"email\",\"isSystem\":1},{\"alias\":\"username\",\"isSystem\":1},{\"alias\":\"updateDate\",\"header\":\"Last edited\",\"isSystem\":1}]',4,'includeProperties'),(-3,-97,'asc',3,'orderDirection'),(-2,-97,'Name',2,'orderBy'),(-1,-97,'10',1,'pageSize'),(3,-87,',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|',0,''),(4,1041,'default',0,'group'),(5,1045,'1',0,'multiPicker'),(6,1050,'YYYY-MM-DD',1,'format'),(7,1077,'',1,'thumbs'),(8,1113,NULL,1,'multiPicker'),(9,1113,NULL,2,'onlyImages'),(10,1113,'',3,'startNodeId'),(11,1114,NULL,1,'multiPicker'),(12,1114,NULL,2,'onlyImages'),(13,1114,'',3,'startNodeId');

UNLOCK TABLES;

/*Table structure for table `cmsdictionary` */

DROP TABLE IF EXISTS `cmsdictionary`;

CREATE TABLE `cmsdictionary` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `id` char(36) NOT NULL,
  `parent` char(36) DEFAULT NULL,
  `key` varchar(1000) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `IX_cmsDictionary_id` (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `cmsdictionary_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `cmsdictionary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsdictionary` */

LOCK TABLES `cmsdictionary` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmsdocument` */

DROP TABLE IF EXISTS `cmsdocument`;

CREATE TABLE `cmsdocument` (
  `nodeId` int(11) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `documentUser` int(11) NOT NULL,
  `versionId` char(36) NOT NULL,
  `text` varchar(255) NOT NULL,
  `releaseDate` timestamp NULL DEFAULT NULL,
  `expireDate` timestamp NULL DEFAULT NULL,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `templateId` int(11) DEFAULT NULL,
  `newest` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`versionId`),
  KEY `IX_cmsDocument` (`nodeId`,`versionId`),
  KEY `IX_cmsDocument_published` (`published`),
  KEY `IX_cmsDocument_newest` (`newest`),
  KEY `templateId` (`templateId`),
  CONSTRAINT `cmsdocument_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `cmscontent` (`nodeId`),
  CONSTRAINT `cmsdocument_ibfk_2` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmsdocument_ibfk_3` FOREIGN KEY (`templateId`) REFERENCES `cmstemplate` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsdocument` */

LOCK TABLES `cmsdocument` WRITE;

insert  into `cmsdocument`(`nodeId`,`published`,`documentUser`,`versionId`,`text`,`releaseDate`,`expireDate`,`updateDate`,`templateId`,`newest`) values (1108,0,0,'0ae758a0-4498-48fc-8721-08a72dfe9686','test',NULL,NULL,'2016-06-30 14:40:17',1091,0),(1110,0,0,'0c713dcc-a834-420d-a2b5-850f3cdffd7d','test2',NULL,NULL,'2016-07-14 14:03:53',1091,0),(1109,0,0,'138d3018-3513-4e57-85e1-7d34abf89837','test',NULL,NULL,'2016-06-30 14:40:17',1078,0),(1116,1,0,'1e56729f-d563-4983-a214-ec1948e546b8','12',NULL,NULL,'2016-07-14 14:05:01',1078,1),(1112,0,0,'20f79f03-5836-4319-9568-2d3350554504','12',NULL,NULL,'2016-07-12 16:46:18',1078,0),(1109,0,0,'25ea5f87-63ca-4c5f-b6c3-26659e728e4d','test',NULL,NULL,'2016-06-30 10:59:28',1078,0),(1111,0,0,'2f6152a4-62b9-4f34-9be7-be1bb60c2cd7','test3',NULL,NULL,'2016-06-30 10:59:42',1091,0),(1112,0,0,'33b2dd7f-639c-4451-a177-accd4b7a118b','12',NULL,NULL,'2016-07-14 14:04:04',1078,1),(1108,0,0,'3efac298-2842-4623-a32e-5f4e45dfda4f','test',NULL,NULL,'2016-07-14 14:04:03',1091,1),(1107,0,0,'45585f8c-1c01-4aff-99ec-b84da4468653','FileManage',NULL,NULL,'2016-07-14 14:03:43',1094,0),(1110,0,0,'4f1762ea-7949-4381-8c4b-4b36f0573cdb','test2',NULL,NULL,'2016-07-14 14:04:03',1091,1),(1107,0,0,'5aabca95-0fd3-407f-a77d-743a76386cbd','FileManage',NULL,NULL,'2016-07-14 14:04:05',1094,1),(1111,0,0,'5e7e6ec4-23a5-4523-96f8-1e56a21e3326','test3',NULL,NULL,'2016-07-14 14:04:04',1091,1),(1109,0,0,'6091839e-efa2-4cb7-af1e-e56e59e0a67c','test',NULL,NULL,'2016-07-14 14:04:03',1078,1),(1109,0,0,'6c5ed68d-d81e-4a2e-b587-7052339c31ce','test',NULL,NULL,'2016-07-14 14:03:50',1078,0),(1110,0,0,'7036cd92-51a3-4bcc-8ee7-ffde6fb49bf5','test2',NULL,NULL,'2016-06-30 14:40:18',1091,0),(1111,0,0,'832c38bc-7c6b-4a68-ae42-9ffeac627f7a','test3',NULL,NULL,'2016-07-14 14:04:00',1091,0),(1108,0,0,'83e39217-06c5-4c9d-b978-2728a7f748fa','test',NULL,NULL,'2016-06-30 10:59:22',1091,0),(1107,0,0,'8c6c041c-4c6e-4a1a-aebf-6ceece50e136','FileManage',NULL,NULL,'2016-06-30 14:40:17',1094,0),(1110,0,0,'927a846f-26b8-41d7-bba3-0c75ebde0a8b','test2',NULL,NULL,'2016-06-30 10:59:36',1091,0),(1109,0,0,'9b732db8-9c92-4d4a-a3ae-3e99698f6250','test',NULL,NULL,'2016-07-14 14:02:32',1078,0),(1115,1,0,'b65e338f-6d24-40eb-a027-2229a87630fe','文件管理',NULL,NULL,'2016-07-14 14:04:32',1094,1),(1108,0,0,'c9ab3b9b-f5ba-45f6-bf07-482e151245c1','test',NULL,NULL,'2016-07-14 14:03:47',1091,0),(1107,0,0,'dff42db0-61d4-4447-9fc6-102e6108c44e','FileManage',NULL,NULL,'2016-06-30 10:56:20',1094,0),(1112,0,0,'e2a73924-529d-4de7-bf4f-551f7462ba3e','12',NULL,NULL,'2016-07-14 14:03:56',1078,0),(1111,0,0,'e90349cc-33a6-4344-b6ef-97b44ec96d22','test3',NULL,NULL,'2016-06-30 14:40:18',1091,0),(1107,0,0,'f19a5f13-b477-4190-aac9-853cd6d3b066','FileManage',NULL,NULL,'2016-07-14 14:04:03',1094,0);

UNLOCK TABLES;

/*Table structure for table `cmsdocumenttype` */

DROP TABLE IF EXISTS `cmsdocumenttype`;

CREATE TABLE `cmsdocumenttype` (
  `contentTypeNodeId` int(11) NOT NULL,
  `templateNodeId` int(11) NOT NULL,
  `IsDefault` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`contentTypeNodeId`,`templateNodeId`),
  KEY `templateNodeId` (`templateNodeId`),
  CONSTRAINT `cmsdocumenttype_ibfk_1` FOREIGN KEY (`contentTypeNodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmsdocumenttype_ibfk_2` FOREIGN KEY (`contentTypeNodeId`) REFERENCES `cmscontenttype` (`nodeId`),
  CONSTRAINT `cmsdocumenttype_ibfk_3` FOREIGN KEY (`templateNodeId`) REFERENCES `cmstemplate` (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsdocumenttype` */

LOCK TABLES `cmsdocumenttype` WRITE;

insert  into `cmsdocumenttype`(`contentTypeNodeId`,`templateNodeId`,`IsDefault`) values (1104,1078,1),(1105,1091,1),(1106,1094,1);

UNLOCK TABLES;

/*Table structure for table `cmslanguagetext` */

DROP TABLE IF EXISTS `cmslanguagetext`;

CREATE TABLE `cmslanguagetext` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `languageId` int(11) NOT NULL,
  `UniqueId` char(36) NOT NULL,
  `value` varchar(1000) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `languageId` (`languageId`),
  KEY `UniqueId` (`UniqueId`),
  CONSTRAINT `cmslanguagetext_ibfk_1` FOREIGN KEY (`languageId`) REFERENCES `umbracolanguage` (`id`),
  CONSTRAINT `cmslanguagetext_ibfk_2` FOREIGN KEY (`UniqueId`) REFERENCES `cmsdictionary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmslanguagetext` */

LOCK TABLES `cmslanguagetext` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmsmacro` */

DROP TABLE IF EXISTS `cmsmacro`;

CREATE TABLE `cmsmacro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `macroUseInEditor` tinyint(1) NOT NULL DEFAULT '0',
  `macroRefreshRate` int(11) NOT NULL DEFAULT '0',
  `macroAlias` varchar(255) NOT NULL,
  `macroName` varchar(255) DEFAULT NULL,
  `macroScriptType` varchar(255) DEFAULT NULL,
  `macroScriptAssembly` varchar(255) DEFAULT NULL,
  `macroXSLT` varchar(255) DEFAULT NULL,
  `macroCacheByPage` tinyint(1) NOT NULL DEFAULT '1',
  `macroCachePersonalized` tinyint(1) NOT NULL DEFAULT '0',
  `macroDontRender` tinyint(1) NOT NULL DEFAULT '0',
  `macroPython` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsMacroPropertyAlias` (`macroAlias`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `cmsmacro` */

LOCK TABLES `cmsmacro` WRITE;

insert  into `cmsmacro`(`id`,`macroUseInEditor`,`macroRefreshRate`,`macroAlias`,`macroName`,`macroScriptType`,`macroScriptAssembly`,`macroXSLT`,`macroCacheByPage`,`macroCachePersonalized`,`macroDontRender`,`macroPython`) values (1,0,0,'Locator','Locator','~//usercontrols/Locator.ascx','','',0,0,0,NULL);

UNLOCK TABLES;

/*Table structure for table `cmsmacroproperty` */

DROP TABLE IF EXISTS `cmsmacroproperty`;

CREATE TABLE `cmsmacroproperty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `editorAlias` varchar(255) NOT NULL,
  `macro` int(11) NOT NULL,
  `macroPropertySortOrder` int(11) NOT NULL DEFAULT '0',
  `macroPropertyAlias` varchar(50) NOT NULL,
  `macroPropertyName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsMacroProperty_Alias` (`macro`,`macroPropertyAlias`),
  CONSTRAINT `cmsmacroproperty_ibfk_1` FOREIGN KEY (`macro`) REFERENCES `cmsmacro` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `cmsmacroproperty` */

LOCK TABLES `cmsmacroproperty` WRITE;

insert  into `cmsmacroproperty`(`id`,`editorAlias`,`macro`,`macroPropertySortOrder`,`macroPropertyAlias`,`macroPropertyName`) values (1,'Umbraco.Textbox',1,0,'XPath','X Path'),(2,'Umbraco.Textbox',1,0,'LocationAlias','Location Alias'),(3,'Umbraco.TrueFalse',1,0,'UseAddress','Use Address'),(4,'Umbraco.Textbox',1,0,'AddressAliases','Address Aliases'),(5,'Umbraco.Textbox',1,0,'ResultsXslt','Results Xslt'),(6,'Umbraco.Textbox',1,0,'AddressExtra','Address Extra'),(7,'Umbraco.TrueFalse',1,0,'UnitInKm','Unit In Km'),(8,'Umbraco.Textbox',1,0,'MultipleResultsCaption','Multiple Results Caption');

UNLOCK TABLES;

/*Table structure for table `cmsmember` */

DROP TABLE IF EXISTS `cmsmember`;

CREATE TABLE `cmsmember` (
  `nodeId` int(11) NOT NULL,
  `Email` varchar(1000) NOT NULL DEFAULT '''',
  `LoginName` varchar(1000) NOT NULL DEFAULT '''',
  `Password` varchar(1000) NOT NULL DEFAULT '''',
  PRIMARY KEY (`nodeId`),
  CONSTRAINT `cmsmember_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `cmscontent` (`nodeId`),
  CONSTRAINT `cmsmember_ibfk_2` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsmember` */

LOCK TABLES `cmsmember` WRITE;

insert  into `cmsmember`(`nodeId`,`Email`,`LoginName`,`Password`) values (1047,'admin@qq.com','admin','g9S/tWhV7WUoCqMdf+WN7WbvexI=');

UNLOCK TABLES;

/*Table structure for table `cmsmember2membergroup` */

DROP TABLE IF EXISTS `cmsmember2membergroup`;

CREATE TABLE `cmsmember2membergroup` (
  `Member` int(11) NOT NULL,
  `MemberGroup` int(11) NOT NULL,
  PRIMARY KEY (`Member`,`MemberGroup`),
  KEY `MemberGroup` (`MemberGroup`),
  CONSTRAINT `cmsmember2membergroup_ibfk_1` FOREIGN KEY (`Member`) REFERENCES `cmsmember` (`nodeId`),
  CONSTRAINT `cmsmember2membergroup_ibfk_2` FOREIGN KEY (`MemberGroup`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsmember2membergroup` */

LOCK TABLES `cmsmember2membergroup` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmsmembertype` */

DROP TABLE IF EXISTS `cmsmembertype`;

CREATE TABLE `cmsmembertype` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `NodeId` int(11) NOT NULL,
  `propertytypeId` int(11) NOT NULL,
  `memberCanEdit` tinyint(1) NOT NULL DEFAULT '0',
  `viewOnProfile` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk`),
  KEY `NodeId` (`NodeId`),
  CONSTRAINT `cmsmembertype_ibfk_1` FOREIGN KEY (`NodeId`) REFERENCES `cmscontenttype` (`nodeId`),
  CONSTRAINT `cmsmembertype_ibfk_2` FOREIGN KEY (`NodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `cmsmembertype` */

LOCK TABLES `cmsmembertype` WRITE;

insert  into `cmsmembertype`(`pk`,`NodeId`,`propertytypeId`,`memberCanEdit`,`viewOnProfile`) values (1,1044,35,0,0),(2,1044,36,0,0),(3,1044,28,0,0),(4,1044,29,0,0),(5,1044,30,0,0),(6,1044,31,0,0),(7,1044,32,0,0),(8,1044,33,0,0),(9,1044,34,0,0);

UNLOCK TABLES;

/*Table structure for table `cmspreviewxml` */

DROP TABLE IF EXISTS `cmspreviewxml`;

CREATE TABLE `cmspreviewxml` (
  `nodeId` int(11) NOT NULL,
  `versionId` char(36) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `xml` longtext NOT NULL,
  PRIMARY KEY (`nodeId`,`versionId`),
  KEY `versionId` (`versionId`),
  CONSTRAINT `cmspreviewxml_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `cmscontent` (`nodeId`),
  CONSTRAINT `cmspreviewxml_ibfk_2` FOREIGN KEY (`versionId`) REFERENCES `cmscontentversion` (`VersionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmspreviewxml` */

LOCK TABLES `cmspreviewxml` WRITE;

insert  into `cmspreviewxml`(`nodeId`,`versionId`,`timestamp`,`xml`) values (1107,'8c6c041c-4c6e-4a1a-aebf-6ceece50e136','2016-06-30 14:40:17','<home id=\"1107\" key=\"d61b0ede-2d7d-40de-9b60-6c3f0d43ff5b\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:56:20\" updateDate=\"2016-06-30T14:40:16\" nodeName=\"FileManage\" urlName=\"filemanage\" path=\"-1,1107\" isDoc=\"\" nodeType=\"1106\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1094\" nodeTypeAlias=\"home\"><siteName><![CDATA[文件管理]]></siteName></home>'),(1107,'dff42db0-61d4-4447-9fc6-102e6108c44e','2016-06-30 10:56:20','<home id=\"1107\" key=\"d61b0ede-2d7d-40de-9b60-6c3f0d43ff5b\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:56:19\" updateDate=\"2016-06-30T10:56:19\" nodeName=\"FileManage\" urlName=\"filemanage\" path=\"-1,1107\" isDoc=\"\" nodeType=\"1106\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1094\" nodeTypeAlias=\"home\"><siteName><![CDATA[文件管理]]></siteName></home>'),(1108,'0ae758a0-4498-48fc-8721-08a72dfe9686','2016-06-30 14:40:17','<folders id=\"1108\" key=\"a7e57c16-a47b-4738-8cf0-967b6944eee4\" parentID=\"1107\" level=\"2\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:22\" updateDate=\"2016-06-30T14:40:17\" nodeName=\"test\" urlName=\"test\" path=\"-1,1107,1108\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\"><folderName><![CDATA[test]]></folderName></folders>'),(1108,'83e39217-06c5-4c9d-b978-2728a7f748fa','2016-06-30 10:59:22','<folders id=\"1108\" key=\"a7e57c16-a47b-4738-8cf0-967b6944eee4\" parentID=\"1107\" level=\"2\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:22\" updateDate=\"2016-06-30T10:59:22\" nodeName=\"test\" urlName=\"test\" path=\"-1,1107,1108\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\"><folderName><![CDATA[test]]></folderName></folders>'),(1109,'138d3018-3513-4e57-85e1-7d34abf89837','2016-06-30 14:40:18','<files id=\"1109\" key=\"ee481acd-855e-46d2-a2a1-8280ef236543\" parentID=\"1108\" level=\"3\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:28\" updateDate=\"2016-06-30T14:40:17\" nodeName=\"test\" urlName=\"test\" path=\"-1,1107,1108,1109\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\" />'),(1109,'25ea5f87-63ca-4c5f-b6c3-26659e728e4d','2016-06-30 10:59:29','<files id=\"1109\" key=\"ee481acd-855e-46d2-a2a1-8280ef236543\" parentID=\"1108\" level=\"3\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:28\" updateDate=\"2016-06-30T10:59:28\" nodeName=\"test\" urlName=\"test\" path=\"-1,1107,1108,1109\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\" />'),(1109,'9b732db8-9c92-4d4a-a3ae-3e99698f6250','2016-07-14 14:02:32','<files id=\"1109\" key=\"ee481acd-855e-46d2-a2a1-8280ef236543\" parentID=\"1108\" level=\"3\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:28\" updateDate=\"2016-07-14T14:02:31\" nodeName=\"test\" urlName=\"test\" path=\"-1,1107,1108,1109\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\"><fileURL><![CDATA[/media/1017/new-text-document.txt]]></fileURL><fileName><![CDATA[1212]]></fileName></files>'),(1110,'7036cd92-51a3-4bcc-8ee7-ffde6fb49bf5','2016-06-30 14:40:18','<folders id=\"1110\" key=\"2255b168-a0fd-440b-8bf9-74dc1ed7b853\" parentID=\"1108\" level=\"3\" creatorID=\"0\" sortOrder=\"1\" createDate=\"2016-06-30T10:59:36\" updateDate=\"2016-06-30T14:40:17\" nodeName=\"test2\" urlName=\"test2\" path=\"-1,1107,1108,1110\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\" />'),(1110,'927a846f-26b8-41d7-bba3-0c75ebde0a8b','2016-06-30 10:59:36','<folders id=\"1110\" key=\"2255b168-a0fd-440b-8bf9-74dc1ed7b853\" parentID=\"1108\" level=\"3\" creatorID=\"0\" sortOrder=\"1\" createDate=\"2016-06-30T10:59:35\" updateDate=\"2016-06-30T10:59:35\" nodeName=\"test2\" urlName=\"test2\" path=\"-1,1107,1108,1110\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\" />'),(1111,'2f6152a4-62b9-4f34-9be7-be1bb60c2cd7','2016-06-30 10:59:42','<folders id=\"1111\" key=\"ef45d5c2-fa4b-4214-ab9a-086c1f20e72f\" parentID=\"1110\" level=\"4\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:42\" updateDate=\"2016-06-30T10:59:42\" nodeName=\"test3\" urlName=\"test3\" path=\"-1,1107,1108,1110,1111\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\" />'),(1111,'e90349cc-33a6-4344-b6ef-97b44ec96d22','2016-06-30 14:40:18','<folders id=\"1111\" key=\"ef45d5c2-fa4b-4214-ab9a-086c1f20e72f\" parentID=\"1110\" level=\"4\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-06-30T10:59:42\" updateDate=\"2016-06-30T14:40:17\" nodeName=\"test3\" urlName=\"test3\" path=\"-1,1107,1108,1110,1111\" isDoc=\"\" nodeType=\"1105\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1091\" nodeTypeAlias=\"folders\" />'),(1112,'20f79f03-5836-4319-9568-2d3350554504','2016-07-12 16:46:18','<files id=\"1112\" key=\"965c981a-0f07-469f-a867-9488287f64cc\" parentID=\"1110\" level=\"4\" creatorID=\"0\" sortOrder=\"1\" createDate=\"2016-07-12T16:46:17\" updateDate=\"2016-07-12T16:46:17\" nodeName=\"12\" urlName=\"12\" path=\"-1,1107,1108,1110,1112\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\"><fileName><![CDATA[1212]]></fileName><fileURL><![CDATA[/media/1016/bg.jpg]]></fileURL></files>'),(1115,'b65e338f-6d24-40eb-a027-2229a87630fe','2016-07-14 14:04:33','<home id=\"1115\" key=\"286bf910-1455-41e2-888d-dc05a4fbc8a5\" parentID=\"-1\" level=\"1\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-07-14T14:04:32\" updateDate=\"2016-07-14T14:04:32\" nodeName=\"文件管理\" urlName=\"文件管理\" path=\"-1,1115\" isDoc=\"\" nodeType=\"1106\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1094\" nodeTypeAlias=\"home\" />'),(1116,'1e56729f-d563-4983-a214-ec1948e546b8','2016-07-14 14:05:01','<files id=\"1116\" key=\"ff3a0e5b-75d3-4f9a-bd23-a42cc39d9ad7\" parentID=\"1115\" level=\"2\" creatorID=\"0\" sortOrder=\"0\" createDate=\"2016-07-14T14:05:00\" updateDate=\"2016-07-14T14:05:00\" nodeName=\"12\" urlName=\"12\" path=\"-1,1115,1116\" isDoc=\"\" nodeType=\"1104\" creatorName=\"zcs\" writerName=\"zcs\" writerID=\"0\" template=\"1078\" nodeTypeAlias=\"files\"><fileURL><![CDATA[1053]]></fileURL><fileName><![CDATA[12]]></fileName></files>');

UNLOCK TABLES;

/*Table structure for table `cmspropertydata` */

DROP TABLE IF EXISTS `cmspropertydata`;

CREATE TABLE `cmspropertydata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contentNodeId` int(11) NOT NULL,
  `versionId` char(36) DEFAULT NULL,
  `propertytypeid` int(11) NOT NULL,
  `dataInt` int(11) DEFAULT NULL,
  `dataDecimal` decimal(38,6) DEFAULT NULL,
  `dataDate` timestamp NULL DEFAULT NULL,
  `dataNvarchar` varchar(500) DEFAULT NULL,
  `dataNtext` longtext,
  PRIMARY KEY (`id`),
  KEY `IX_cmsPropertyData` (`id`),
  KEY `IX_cmsPropertyData_1` (`contentNodeId`),
  KEY `IX_cmsPropertyData_2` (`versionId`),
  KEY `IX_cmsPropertyData_3` (`propertytypeid`),
  CONSTRAINT `cmspropertydata_ibfk_1` FOREIGN KEY (`contentNodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmspropertydata_ibfk_2` FOREIGN KEY (`propertytypeid`) REFERENCES `cmspropertytype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

/*Data for the table `cmspropertydata` */

LOCK TABLES `cmspropertydata` WRITE;

insert  into `cmspropertydata`(`id`,`contentNodeId`,`versionId`,`propertytypeid`,`dataInt`,`dataDecimal`,`dataDate`,`dataNvarchar`,`dataNtext`) values (1,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',35,NULL,NULL,NULL,NULL,NULL),(2,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',36,NULL,NULL,NULL,NULL,NULL),(3,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',32,NULL,NULL,NULL,NULL,NULL),(4,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',30,1,NULL,NULL,NULL,NULL),(5,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',28,NULL,NULL,NULL,NULL,'11'),(6,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',33,NULL,NULL,'2016-06-06 10:31:36',NULL,NULL),(7,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',31,0,NULL,NULL,NULL,NULL),(8,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',29,NULL,NULL,NULL,NULL,NULL),(9,1047,'44e97c9a-c6a5-4d44-acfb-0074417e0b9d',34,NULL,NULL,'2016-06-06 10:31:36',NULL,NULL),(10,1049,'328c5f75-d506-4777-85a1-75fa2d7279ea',25,NULL,NULL,NULL,'docx',NULL),(11,1049,'328c5f75-d506-4777-85a1-75fa2d7279ea',24,NULL,NULL,NULL,'/media/1001/中国梦德育课修改613.docx',NULL),(12,1049,'328c5f75-d506-4777-85a1-75fa2d7279ea',26,NULL,NULL,NULL,'128978',NULL),(13,1053,'7e07a126-7189-4aa7-9cfc-8a558ef675bd',24,NULL,NULL,NULL,'/media/1001/产品路线20150628.xlsx',NULL),(14,1053,'7e07a126-7189-4aa7-9cfc-8a558ef675bd',26,NULL,NULL,NULL,'119961',NULL),(15,1053,'7e07a126-7189-4aa7-9cfc-8a558ef675bd',25,NULL,NULL,NULL,'xlsx',NULL),(16,1054,'a6e66185-418f-4fd8-8580-7da20eecffdd',24,NULL,NULL,NULL,'/media/1002/crebas.sql',NULL),(17,1054,'a6e66185-418f-4fd8-8580-7da20eecffdd',26,NULL,NULL,NULL,'5061',NULL),(18,1054,'a6e66185-418f-4fd8-8580-7da20eecffdd',25,NULL,NULL,NULL,'sql',NULL),(19,1055,'e6da32d9-e922-4381-9ceb-b5b7040021d9',24,NULL,NULL,NULL,'/media/1003/正式平台账号密码.txt',NULL),(20,1055,'e6da32d9-e922-4381-9ceb-b5b7040021d9',26,NULL,NULL,NULL,'1654',NULL),(21,1055,'e6da32d9-e922-4381-9ceb-b5b7040021d9',25,NULL,NULL,NULL,'txt',NULL),(22,1056,'a5fffdab-2e84-40fd-8b8d-665a2d1f529d',27,NULL,NULL,NULL,NULL,NULL),(23,1057,'f541bdc8-73d6-42b0-9f61-77cc1d1a6fe3',27,NULL,NULL,NULL,NULL,NULL),(24,1058,'49cd0139-c4e6-49e8-8160-9a3e35cb0eef',24,NULL,NULL,NULL,'/media/1004/base.css',NULL),(25,1058,'49cd0139-c4e6-49e8-8160-9a3e35cb0eef',26,NULL,NULL,NULL,'6428',NULL),(26,1058,'49cd0139-c4e6-49e8-8160-9a3e35cb0eef',25,NULL,NULL,NULL,'css',NULL),(27,1059,'716908aa-a352-499d-973a-434dc22eee2d',27,NULL,NULL,NULL,NULL,NULL),(28,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba',9,NULL,NULL,NULL,'65844',NULL),(29,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba',6,NULL,NULL,NULL,NULL,'{src: \'/media/1005/banner.jpg\', crops: []}'),(30,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba',8,NULL,NULL,NULL,'268',NULL),(31,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba',10,NULL,NULL,NULL,'jpg',NULL),(32,1060,'b0cd1c93-6903-4e36-bcb9-488e7fcb3bba',7,NULL,NULL,NULL,'1200',NULL),(33,1061,'295684cd-2ee2-4b15-863f-001b869f713a',9,NULL,NULL,NULL,'1696',NULL),(34,1061,'295684cd-2ee2-4b15-863f-001b869f713a',6,NULL,NULL,NULL,NULL,'{src: \'/media/1006/banner_bg.jpg\', crops: []}'),(35,1061,'295684cd-2ee2-4b15-863f-001b869f713a',8,NULL,NULL,NULL,'268',NULL),(36,1061,'295684cd-2ee2-4b15-863f-001b869f713a',10,NULL,NULL,NULL,'jpg',NULL),(37,1061,'295684cd-2ee2-4b15-863f-001b869f713a',7,NULL,NULL,NULL,'12',NULL),(38,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5',9,NULL,NULL,NULL,'686',NULL),(39,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5',6,NULL,NULL,NULL,NULL,'{src: \'/media/1007/foot.jpg\', crops: []}'),(40,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5',8,NULL,NULL,NULL,'52',NULL),(41,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5',10,NULL,NULL,NULL,'jpg',NULL),(42,1062,'f1b0da4c-122a-467b-b4c0-0f220dbb12b5',7,NULL,NULL,NULL,'11',NULL),(43,1063,'7fac755e-036e-4002-8154-4e258f3bef74',9,NULL,NULL,NULL,'5690',NULL),(44,1063,'7fac755e-036e-4002-8154-4e258f3bef74',6,NULL,NULL,NULL,NULL,'{src: \'/media/1008/txl.jpg\', crops: []}'),(45,1063,'7fac755e-036e-4002-8154-4e258f3bef74',8,NULL,NULL,NULL,'175',NULL),(46,1063,'7fac755e-036e-4002-8154-4e258f3bef74',10,NULL,NULL,NULL,'jpg',NULL),(47,1063,'7fac755e-036e-4002-8154-4e258f3bef74',7,NULL,NULL,NULL,'60',NULL),(48,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3',9,NULL,NULL,NULL,'2650',NULL),(49,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3',6,NULL,NULL,NULL,NULL,'{src: \'/media/1009/yin.jpg\', crops: []}'),(50,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3',8,NULL,NULL,NULL,'38',NULL),(51,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3',10,NULL,NULL,NULL,'jpg',NULL),(52,1064,'ef0aafd7-a7b1-4315-a056-84f2b36c5dc3',7,NULL,NULL,NULL,'50',NULL),(53,1065,'55ade4ac-b710-4923-a0b8-a865e3b676fa',27,NULL,NULL,NULL,NULL,NULL),(54,1066,'fb88ba80-f814-4612-b097-38b809736c10',24,NULL,NULL,NULL,'/media/1010/modernizr.js',NULL),(55,1066,'fb88ba80-f814-4612-b097-38b809736c10',26,NULL,NULL,NULL,'28463',NULL),(56,1066,'fb88ba80-f814-4612-b097-38b809736c10',25,NULL,NULL,NULL,'js',NULL),(122,1107,'dff42db0-61d4-4447-9fc6-102e6108c44e',47,NULL,NULL,NULL,'文件管理',NULL),(123,1108,'83e39217-06c5-4c9d-b978-2728a7f748fa',46,NULL,NULL,NULL,'test',NULL),(124,1109,'25ea5f87-63ca-4c5f-b6c3-26659e728e4d',44,NULL,NULL,NULL,'',NULL),(125,1109,'25ea5f87-63ca-4c5f-b6c3-26659e728e4d',45,NULL,NULL,NULL,NULL,NULL),(126,1110,'927a846f-26b8-41d7-bba3-0c75ebde0a8b',46,NULL,NULL,NULL,NULL,NULL),(127,1111,'2f6152a4-62b9-4f34-9be7-be1bb60c2cd7',46,NULL,NULL,NULL,NULL,NULL),(128,1107,'8c6c041c-4c6e-4a1a-aebf-6ceece50e136',47,NULL,NULL,NULL,'文件管理',NULL),(129,1108,'0ae758a0-4498-48fc-8721-08a72dfe9686',46,NULL,NULL,NULL,'test',NULL),(130,1109,'138d3018-3513-4e57-85e1-7d34abf89837',44,NULL,NULL,NULL,NULL,NULL),(131,1109,'138d3018-3513-4e57-85e1-7d34abf89837',45,NULL,NULL,NULL,NULL,NULL),(132,1110,'7036cd92-51a3-4bcc-8ee7-ffde6fb49bf5',46,NULL,NULL,NULL,NULL,NULL),(133,1111,'e90349cc-33a6-4344-b6ef-97b44ec96d22',46,NULL,NULL,NULL,NULL,NULL),(134,1112,'20f79f03-5836-4319-9568-2d3350554504',45,NULL,NULL,NULL,'1212',NULL),(135,1112,'20f79f03-5836-4319-9568-2d3350554504',44,NULL,NULL,NULL,'/media/1016/bg.jpg',NULL),(136,1109,'9b732db8-9c92-4d4a-a3ae-3e99698f6250',44,NULL,NULL,NULL,'/media/1017/new-text-document.txt',NULL),(137,1109,'9b732db8-9c92-4d4a-a3ae-3e99698f6250',45,NULL,NULL,NULL,'1212',NULL),(138,1107,'45585f8c-1c01-4aff-99ec-b84da4468653',47,NULL,NULL,NULL,'文件管理',NULL),(139,1108,'c9ab3b9b-f5ba-45f6-bf07-482e151245c1',46,NULL,NULL,NULL,'test',NULL),(140,1109,'6c5ed68d-d81e-4a2e-b587-7052339c31ce',45,NULL,NULL,NULL,'1212',NULL),(141,1109,'6c5ed68d-d81e-4a2e-b587-7052339c31ce',44,NULL,NULL,NULL,'/media/1017/new-text-document.txt',NULL),(142,1110,'0c713dcc-a834-420d-a2b5-850f3cdffd7d',46,NULL,NULL,NULL,NULL,NULL),(143,1112,'e2a73924-529d-4de7-bf4f-551f7462ba3e',45,NULL,NULL,NULL,'1212',NULL),(144,1112,'e2a73924-529d-4de7-bf4f-551f7462ba3e',44,NULL,NULL,NULL,'/media/1016/bg.jpg',NULL),(145,1111,'832c38bc-7c6b-4a68-ae42-9ffeac627f7a',46,NULL,NULL,NULL,NULL,NULL),(146,1107,'f19a5f13-b477-4190-aac9-853cd6d3b066',47,NULL,NULL,NULL,'文件管理',NULL),(147,1108,'3efac298-2842-4623-a32e-5f4e45dfda4f',46,NULL,NULL,NULL,'test',NULL),(148,1109,'6091839e-efa2-4cb7-af1e-e56e59e0a67c',45,NULL,NULL,NULL,'1212',NULL),(149,1109,'6091839e-efa2-4cb7-af1e-e56e59e0a67c',44,NULL,NULL,NULL,'/media/1017/new-text-document.txt',NULL),(150,1110,'4f1762ea-7949-4381-8c4b-4b36f0573cdb',46,NULL,NULL,NULL,NULL,NULL),(151,1112,'33b2dd7f-639c-4451-a177-accd4b7a118b',45,NULL,NULL,NULL,'1212',NULL),(152,1112,'33b2dd7f-639c-4451-a177-accd4b7a118b',44,NULL,NULL,NULL,'/media/1016/bg.jpg',NULL),(153,1111,'5e7e6ec4-23a5-4523-96f8-1e56a21e3326',46,NULL,NULL,NULL,NULL,NULL),(154,1107,'5aabca95-0fd3-407f-a77d-743a76386cbd',47,NULL,NULL,NULL,'文件管理',NULL),(155,1115,'b65e338f-6d24-40eb-a027-2229a87630fe',47,NULL,NULL,NULL,NULL,NULL),(156,1116,'1e56729f-d563-4983-a214-ec1948e546b8',44,NULL,NULL,NULL,'1053',NULL),(157,1116,'1e56729f-d563-4983-a214-ec1948e546b8',45,NULL,NULL,NULL,'12',NULL);

UNLOCK TABLES;

/*Table structure for table `cmspropertytype` */

DROP TABLE IF EXISTS `cmspropertytype`;

CREATE TABLE `cmspropertytype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataTypeId` int(11) NOT NULL,
  `contentTypeId` int(11) NOT NULL,
  `propertyTypeGroupId` int(11) DEFAULT NULL,
  `Alias` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `sortOrder` int(11) NOT NULL DEFAULT '0',
  `mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `validationRegExp` varchar(255) DEFAULT NULL,
  `Description` varchar(2000) DEFAULT NULL,
  `UniqueID` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsPropertyTypeUniqueID` (`UniqueID`),
  KEY `dataTypeId` (`dataTypeId`),
  KEY `contentTypeId` (`contentTypeId`),
  KEY `propertyTypeGroupId` (`propertyTypeGroupId`),
  CONSTRAINT `cmspropertytype_ibfk_1` FOREIGN KEY (`dataTypeId`) REFERENCES `cmsdatatype` (`nodeId`),
  CONSTRAINT `cmspropertytype_ibfk_2` FOREIGN KEY (`contentTypeId`) REFERENCES `cmscontenttype` (`nodeId`),
  CONSTRAINT `cmspropertytype_ibfk_3` FOREIGN KEY (`propertyTypeGroupId`) REFERENCES `cmspropertytypegroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/*Data for the table `cmspropertytype` */

LOCK TABLES `cmspropertytype` WRITE;

insert  into `cmspropertytype`(`id`,`dataTypeId`,`contentTypeId`,`propertyTypeGroupId`,`Alias`,`Name`,`sortOrder`,`mandatory`,`validationRegExp`,`Description`,`UniqueID`) values (6,1043,1032,3,'umbracoFile','Upload image',0,0,NULL,NULL,'00000006-0000-0000-0000-000000000000'),(7,-92,1032,3,'umbracoWidth','Width',0,0,NULL,NULL,'00000007-0000-0000-0000-000000000000'),(8,-92,1032,3,'umbracoHeight','Height',0,0,NULL,NULL,'00000008-0000-0000-0000-000000000000'),(9,-92,1032,3,'umbracoBytes','Size',0,0,NULL,NULL,'00000009-0000-0000-0000-000000000000'),(10,-92,1032,3,'umbracoExtension','Type',0,0,NULL,NULL,'0000000a-0000-0000-0000-000000000000'),(24,-90,1033,4,'umbracoFile','Upload file',0,0,NULL,NULL,'00000018-0000-0000-0000-000000000000'),(25,-92,1033,4,'umbracoExtension','Type',0,0,NULL,NULL,'00000019-0000-0000-0000-000000000000'),(26,-92,1033,4,'umbracoBytes','Size',0,0,NULL,NULL,'0000001a-0000-0000-0000-000000000000'),(27,-96,1031,5,'contents','Contents:',0,0,NULL,NULL,'0000001b-0000-0000-0000-000000000000'),(28,-89,1044,11,'umbracoMemberComments','Comments',0,0,NULL,NULL,'0111d441-d618-4a4b-8627-2888c1475f34'),(29,-92,1044,11,'umbracoMemberFailedPasswordAttempts','Failed Password Attempts',1,0,NULL,NULL,'b03e484d-dad4-4e0c-83d3-e04a33521a12'),(30,-49,1044,11,'umbracoMemberApproved','Is Approved',2,0,NULL,NULL,'1fbe4d93-027b-4477-935d-1e5fbfd3c671'),(31,-49,1044,11,'umbracoMemberLockedOut','Is Locked Out',3,0,NULL,NULL,'fc06fb51-1f34-4076-b118-bba24d5e5491'),(32,-92,1044,11,'umbracoMemberLastLockoutDate','Last Lockout Date',4,0,NULL,NULL,'d3794654-496b-4ffc-8dee-2efa9a72d17a'),(33,-92,1044,11,'umbracoMemberLastLogin','Last Login Date',5,0,NULL,NULL,'3556ee94-bd7b-4292-bfa3-eed2161cbcdf'),(34,-92,1044,11,'umbracoMemberLastPasswordChangeDate','Last Password Change Date',6,0,NULL,NULL,'07ed163f-3be6-4633-8e92-a954814a75f2'),(35,-92,1044,NULL,'umbracoMemberPasswordRetrievalAnswer','Password Answer',0,0,NULL,NULL,'05d17b73-6283-4706-8387-bab428c8391f'),(36,-92,1044,NULL,'umbracoMemberPasswordRetrievalQuestion','Password Question',1,0,NULL,NULL,'266d0fe1-dfe4-4921-b384-cd79351bd188'),(44,1114,1104,18,'fileURL','FileURL',1,0,NULL,NULL,'50cb21e0-5e2c-40a6-bbdd-8aa516c82884'),(45,1076,1104,18,'fileName','FileName',0,0,NULL,NULL,'301d1291-3211-4327-a30f-e785e0365127'),(46,1090,1105,19,'folderName','FolderName',0,0,NULL,NULL,'f9f3ef9f-33ad-47bd-9693-9c50702b6575'),(47,1093,1106,20,'siteName','SiteName',0,0,NULL,NULL,'932ba971-b6d2-4203-b83a-0b2ad52b6cc6');

UNLOCK TABLES;

/*Table structure for table `cmspropertytypegroup` */

DROP TABLE IF EXISTS `cmspropertytypegroup`;

CREATE TABLE `cmspropertytypegroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contenttypeNodeId` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `sortorder` int(11) NOT NULL,
  `uniqueID` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsPropertyTypeGroupUniqueID` (`uniqueID`),
  KEY `contenttypeNodeId` (`contenttypeNodeId`),
  CONSTRAINT `cmspropertytypegroup_ibfk_1` FOREIGN KEY (`contenttypeNodeId`) REFERENCES `cmscontenttype` (`nodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `cmspropertytypegroup` */

LOCK TABLES `cmspropertytypegroup` WRITE;

insert  into `cmspropertytypegroup`(`id`,`contenttypeNodeId`,`text`,`sortorder`,`uniqueID`) values (3,1032,'Image',1,'79ed4d07-254a-42cf-8fa9-ebe1c116a596'),(4,1033,'File',1,'50899f9c-023a-4466-b623-aba9049885fe'),(5,1031,'Contents',1,'79995fa2-63ee-453c-a29b-2e66f324cdbe'),(11,1044,'Membership',1,'cf033149-c2b4-420e-9ca1-f45682de1532'),(18,1104,'FileInfo',0,'ef9e3e04-a096-4797-a693-301d100ba118'),(19,1105,'FolderInfo',0,'dc528387-2073-4c1c-8e56-91b78ec0b7fb'),(20,1106,'WebSite',0,'2acb11dd-76c3-4d46-ac23-8507129f76c8');

UNLOCK TABLES;

/*Table structure for table `cmsstylesheet` */

DROP TABLE IF EXISTS `cmsstylesheet`;

CREATE TABLE `cmsstylesheet` (
  `nodeId` int(11) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `content` longtext,
  PRIMARY KEY (`nodeId`),
  CONSTRAINT `cmsstylesheet_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsstylesheet` */

LOCK TABLES `cmsstylesheet` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmsstylesheetproperty` */

DROP TABLE IF EXISTS `cmsstylesheetproperty`;

CREATE TABLE `cmsstylesheetproperty` (
  `nodeId` int(11) NOT NULL,
  `stylesheetPropertyEditor` tinyint(1) DEFAULT NULL,
  `stylesheetPropertyAlias` varchar(50) DEFAULT NULL,
  `stylesheetPropertyValue` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`nodeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmsstylesheetproperty` */

LOCK TABLES `cmsstylesheetproperty` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmstagrelationship` */

DROP TABLE IF EXISTS `cmstagrelationship`;

CREATE TABLE `cmstagrelationship` (
  `nodeId` int(11) NOT NULL,
  `tagId` int(11) NOT NULL,
  `propertyTypeId` int(11) NOT NULL,
  PRIMARY KEY (`nodeId`,`propertyTypeId`,`tagId`),
  KEY `tagId` (`tagId`),
  KEY `propertyTypeId` (`propertyTypeId`),
  CONSTRAINT `cmstagrelationship_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `cmscontent` (`nodeId`),
  CONSTRAINT `cmstagrelationship_ibfk_2` FOREIGN KEY (`tagId`) REFERENCES `cmstags` (`id`),
  CONSTRAINT `cmstagrelationship_ibfk_3` FOREIGN KEY (`propertyTypeId`) REFERENCES `cmspropertytype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmstagrelationship` */

LOCK TABLES `cmstagrelationship` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmstags` */

DROP TABLE IF EXISTS `cmstags`;

CREATE TABLE `cmstags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(200) DEFAULT NULL,
  `ParentId` int(11) DEFAULT NULL,
  `group` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsTags` (`tag`,`group`),
  KEY `ParentId` (`ParentId`),
  CONSTRAINT `cmstags_ibfk_1` FOREIGN KEY (`ParentId`) REFERENCES `cmstags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmstags` */

LOCK TABLES `cmstags` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmstask` */

DROP TABLE IF EXISTS `cmstask`;

CREATE TABLE `cmstask` (
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskTypeId` int(11) NOT NULL,
  `nodeId` int(11) NOT NULL,
  `parentUserId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `DateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taskTypeId` (`taskTypeId`),
  KEY `nodeId` (`nodeId`),
  KEY `parentUserId` (`parentUserId`),
  KEY `userId` (`userId`),
  CONSTRAINT `cmstask_ibfk_1` FOREIGN KEY (`taskTypeId`) REFERENCES `cmstasktype` (`id`),
  CONSTRAINT `cmstask_ibfk_2` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `cmstask_ibfk_3` FOREIGN KEY (`parentUserId`) REFERENCES `umbracouser` (`id`),
  CONSTRAINT `cmstask_ibfk_4` FOREIGN KEY (`userId`) REFERENCES `umbracouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmstask` */

LOCK TABLES `cmstask` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmstasktype` */

DROP TABLE IF EXISTS `cmstasktype`;

CREATE TABLE `cmstasktype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_cmsTaskType_alias` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `cmstasktype` */

LOCK TABLES `cmstasktype` WRITE;

insert  into `cmstasktype`(`id`,`alias`) values (1,'toTranslate');

UNLOCK TABLES;

/*Table structure for table `cmstemplate` */

DROP TABLE IF EXISTS `cmstemplate`;

CREATE TABLE `cmstemplate` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `nodeId` int(11) NOT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `design` longtext NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `IX_cmsTemplate_nodeId` (`nodeId`),
  CONSTRAINT `cmstemplate_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `cmstemplate` */

LOCK TABLES `cmstemplate` WRITE;

insert  into `cmstemplate`(`pk`,`nodeId`,`alias`,`design`) values (1,1051,'test1','@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.Test1>\r\n@using ContentModels = Umbraco.Web.PublishedContentModels;\r\n@{\r\n	Layout = null;\r\n}'),(2,1071,'FirstLevel','@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.FirstLevel>\r\n@using ContentModels = Umbraco.Web.PublishedContentModels;\r\n@{\r\n	Layout = null;\r\n}'),(3,1074,'SecondLevel','@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.SecondLevel>\r\n@using ContentModels = Umbraco.Web.PublishedContentModels;\r\n@{\r\n	Layout = null;\r\n}'),(4,1078,'Files','@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.Files>\r\n@using ContentModels = Umbraco.Web.PublishedContentModels;\r\n@{\r\n	Layout = null;\r\n}'),(5,1091,'Folders','@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.Folders>\r\n@using ContentModels = Umbraco.Web.PublishedContentModels;\r\n@{\r\n	Layout = null;\r\n}'),(6,1094,'Home','<div>\n	\ntest\n	</div>');

UNLOCK TABLES;

/*Table structure for table `cmumbracotools_permanentredirects` */

DROP TABLE IF EXISTS `cmumbracotools_permanentredirects`;

CREATE TABLE `cmumbracotools_permanentredirects` (
  `PermanentRedirectID` int(11) NOT NULL AUTO_INCREMENT,
  `OriginalURL` varchar(255) NOT NULL,
  `RedirectURL` varchar(255) NOT NULL,
  `Notes` varchar(255) NOT NULL,
  PRIMARY KEY (`PermanentRedirectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmumbracotools_permanentredirects` */

LOCK TABLES `cmumbracotools_permanentredirects` WRITE;

UNLOCK TABLES;

/*Table structure for table `cmumbracotools_settings` */

DROP TABLE IF EXISTS `cmumbracotools_settings`;

CREATE TABLE `cmumbracotools_settings` (
  `SettingID` int(11) NOT NULL AUTO_INCREMENT,
  `Application` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Value` longtext NOT NULL,
  PRIMARY KEY (`SettingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cmumbracotools_settings` */

LOCK TABLES `cmumbracotools_settings` WRITE;

UNLOCK TABLES;

/*Table structure for table `files` */

DROP TABLE IF EXISTS `files`;

CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(200) NOT NULL COMMENT '文件[夹]名称',
  `FileType` varchar(200) NOT NULL COMMENT '文件类型：0文件夹 1文件',
  `ParentID` int(11) NOT NULL COMMENT '父节点ID',
  `FilePath` varchar(200) DEFAULT NULL COMMENT '文件路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `files` */

LOCK TABLES `files` WRITE;

insert  into `files`(`id`,`fileName`,`FileType`,`ParentID`,`FilePath`) values (1,'文件管理系统','0',-1,NULL),(2,'ExtendMenu安装执行一次','1',1,NULL),(3,'ExtendMenu安装执行一次','1',1,NULL),(4,'ExtendMenu安装执行一次','1',1,NULL),(5,'DTP App Pool Refresh安装执行一次','1',1,NULL),(6,'DTP App Pool Refresh安装执行一次','1',1,NULL),(7,'DTP App Pool Refresh安装执行一次','1',1,NULL),(8,'ExtendMenu安装执行一次','1',1,NULL),(9,'ExtendMenu安装执行一次','1',1,NULL),(10,'ExtendMenu安装执行一次','1',1,NULL),(11,'ExtendMenu卸载执行一次','1',1,NULL);

UNLOCK TABLES;

/*Table structure for table `umbracoaccess` */

DROP TABLE IF EXISTS `umbracoaccess`;

CREATE TABLE `umbracoaccess` (
  `id` char(36) NOT NULL,
  `nodeId` int(11) NOT NULL,
  `loginNodeId` int(11) NOT NULL,
  `noAccessNodeId` int(11) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoAccess_nodeId` (`nodeId`),
  KEY `loginNodeId` (`loginNodeId`),
  KEY `noAccessNodeId` (`noAccessNodeId`),
  CONSTRAINT `umbracoaccess_ibfk_1` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `umbracoaccess_ibfk_2` FOREIGN KEY (`loginNodeId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `umbracoaccess_ibfk_3` FOREIGN KEY (`noAccessNodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracoaccess` */

LOCK TABLES `umbracoaccess` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracoaccessrule` */

DROP TABLE IF EXISTS `umbracoaccessrule`;

CREATE TABLE `umbracoaccessrule` (
  `id` char(36) NOT NULL,
  `accessId` char(36) NOT NULL,
  `ruleValue` varchar(255) NOT NULL,
  `ruleType` varchar(255) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoAccessRule` (`ruleValue`,`ruleType`,`accessId`),
  KEY `accessId` (`accessId`),
  CONSTRAINT `umbracoaccessrule_ibfk_1` FOREIGN KEY (`accessId`) REFERENCES `umbracoaccess` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracoaccessrule` */

LOCK TABLES `umbracoaccessrule` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracocacheinstruction` */

DROP TABLE IF EXISTS `umbracocacheinstruction`;

CREATE TABLE `umbracocacheinstruction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utcStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `jsonInstruction` longtext NOT NULL,
  `originated` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8;

/*Data for the table `umbracocacheinstruction` */

LOCK TABLES `umbracocacheinstruction` WRITE;

insert  into `umbracocacheinstruction`(`id`,`utcStamp`,`jsonInstruction`,`originated`) values (150,'2016-07-20 08:30:29','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D23] D6979A3908114549972E37C4FB18D848'),(151,'2016-07-20 08:32:18','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D32] 02AA1D0805D841DF9E50408467B329F9'),(152,'2016-07-20 08:35:44','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D42] 4E479EB11B4F426E8C2E8684BD8DBC01'),(153,'2016-07-20 08:37:21','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D51] 7D5AB97189154D109874AB833631D323'),(154,'2016-07-20 08:39:13','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D61] 48F9C4D5A36A4C06A3CD667C1851E5D1'),(155,'2016-07-20 08:56:52','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D69] 9984540FE3DC4F1C877A447EE4E4DB15'),(156,'2016-07-20 09:45:28','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D80] B7A4D0AC340049EE94F24C5769B514E8'),(157,'2016-07-20 09:48:25','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9292/D87] 7B4CF6BCDFA44F7AA00A80650D51AECD'),(158,'2016-07-20 09:58:53','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P3584/D6] 872A015A2519428AAE9D925528948A90'),(159,'2016-07-20 10:03:30','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P3584/D15] BF383B79A1F44476AD2E3D9FE84E1199'),(160,'2016-07-20 10:07:12','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P3584/D23] 853DC3F5E02047E6B2D5323B2241E50A'),(161,'2016-07-20 10:07:57','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P3584/D29] 8A276A487F0D4667A68D6002207B9EAA'),(162,'2016-07-20 10:41:20','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P3584/D37] 2BDF3C41E5234EE09F3F9F9FED49EB35'),(163,'2016-07-21 02:24:25','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P2168/D17] AA97CA219EF34265BCB3A0C12F21603B'),(164,'2016-07-21 02:28:21','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P2168/D24] BB64459FAE0440D0BC57774BF86C483F'),(165,'2016-07-21 02:59:20','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P8572/D6] D8C212D5397C4FD39ED21EF541318D90'),(166,'2016-07-21 03:34:28','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9652/D7] 9F58579C858C40C49D7C01F035A1FF1E'),(167,'2016-07-21 03:42:34','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9652/D16] 9D579CAF38F94F30A713698126DF2BEF'),(168,'2016-07-21 03:46:15','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P9652/D23] 92B1726EDC1A4F05BCB77DA793E82F56'),(169,'2016-07-21 08:00:15','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/49/ROOT [P13112/D80] 6D2E6E9FAAA7404CB85013D51D1D71FE'),(170,'2016-07-21 10:16:25','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/1/ROOT [P6364/D5] 85844D1815A74405AEDC9005926EBCFB'),(171,'2016-07-21 10:22:13','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/1/ROOT [P6364/D14] DAA130892DBA44E8AC4F0EE93861A463'),(172,'2016-07-21 10:25:11','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/1/ROOT [P6364/D22] 88FC5FF945B34AC193CB414EE745A59C'),(173,'2016-07-21 10:51:36','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/63/ROOT [P3516/D5] FA23656C7E414B64A7AD822649562754'),(174,'2016-07-21 10:57:22','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/63/ROOT [P6964/D5] 6C6FD56182C54105BBA546D7AEDE5893'),(175,'2016-07-21 10:58:02','[{\"RefreshType\":0,\"RefresherId\":\"27ab3022-3dfa-47b6-9119-5945bc88fd66\",\"GuidId\":\"00000000-0000-0000-0000-000000000000\",\"IntId\":0,\"JsonIds\":null,\"JsonPayload\":null}]','ST-PC//LM/W3SVC/63/ROOT [P6964/D11] 88E5B45B120B45639BB58724281BBC75');

UNLOCK TABLES;

/*Table structure for table `umbracodeploychecksum` */

DROP TABLE IF EXISTS `umbracodeploychecksum`;

CREATE TABLE `umbracodeploychecksum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityType` varchar(32) NOT NULL,
  `entityGuid` char(36) DEFAULT NULL,
  `entityPath` varchar(256) DEFAULT NULL,
  `localChecksum` varchar(32) NOT NULL,
  `compositeChecksum` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracodeploychecksum` */

LOCK TABLES `umbracodeploychecksum` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracodeploydependency` */

DROP TABLE IF EXISTS `umbracodeploydependency`;

CREATE TABLE `umbracodeploydependency` (
  `sourceId` int(11) NOT NULL,
  `targetId` int(11) NOT NULL,
  `mode` int(11) NOT NULL,
  PRIMARY KEY (`sourceId`,`targetId`),
  KEY `targetId` (`targetId`),
  CONSTRAINT `umbracodeploydependency_ibfk_1` FOREIGN KEY (`sourceId`) REFERENCES `umbracodeploychecksum` (`id`),
  CONSTRAINT `umbracodeploydependency_ibfk_2` FOREIGN KEY (`targetId`) REFERENCES `umbracodeploychecksum` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracodeploydependency` */

LOCK TABLES `umbracodeploydependency` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracodomains` */

DROP TABLE IF EXISTS `umbracodomains`;

CREATE TABLE `umbracodomains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domainDefaultLanguage` int(11) DEFAULT NULL,
  `domainRootStructureID` int(11) DEFAULT NULL,
  `domainName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domainRootStructureID` (`domainRootStructureID`),
  CONSTRAINT `umbracodomains_ibfk_1` FOREIGN KEY (`domainRootStructureID`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracodomains` */

LOCK TABLES `umbracodomains` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracoexternallogin` */

DROP TABLE IF EXISTS `umbracoexternallogin`;

CREATE TABLE `umbracoexternallogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `loginProvider` varchar(4000) NOT NULL,
  `providerKey` varchar(4000) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracoexternallogin` */

LOCK TABLES `umbracoexternallogin` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracolanguage` */

DROP TABLE IF EXISTS `umbracolanguage`;

CREATE TABLE `umbracolanguage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `languageISOCode` varchar(10) DEFAULT NULL,
  `languageCultureName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoLanguage_languageISOCode` (`languageISOCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `umbracolanguage` */

LOCK TABLES `umbracolanguage` WRITE;

insert  into `umbracolanguage`(`id`,`languageISOCode`,`languageCultureName`) values (1,'en-US','en-US');

UNLOCK TABLES;

/*Table structure for table `umbracolog` */

DROP TABLE IF EXISTS `umbracolog`;

CREATE TABLE `umbracolog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `NodeId` int(11) NOT NULL,
  `Datestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logHeader` varchar(50) NOT NULL,
  `logComment` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoLog` (`NodeId`)
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8;

/*Data for the table `umbracolog` */

LOCK TABLES `umbracolog` WRITE;

insert  into `umbracolog`(`id`,`userId`,`NodeId`,`Datestamp`,`logHeader`,`logComment`) values (1,0,-1,'2016-06-06 10:07:03','PackagerInstall','Package \'Hebrew Search\' installed. Package guid: '),(2,0,-1,'2016-06-06 10:07:12','Save','Save ContentTypes performed by user'),(3,0,-1,'2016-06-06 10:13:41','PackagerUninstall','Package \'Hebrew Search\' uninstalled. Package guid: '),(4,0,-1,'2016-06-06 10:14:11','PackagerUninstall','Package \'\' uninstalled. Package guid: '),(5,0,-1,'2016-06-06 10:20:30','PackagerInstall','Package \'UmbracoSocialPluginAdapters\' installed. Package guid: '),(6,0,-1,'2016-06-06 10:20:38','Save','Save ContentTypes performed by user'),(7,0,-1,'2016-06-06 10:21:23','PackagerUninstall','Package \'UmbracoSocialPluginAdapters\' uninstalled. Package guid: '),(8,0,-1,'2016-06-06 10:28:22','PackagerInstall','Package \'AsposeMemberExportToWord\' installed. Package guid: '),(9,0,-1,'2016-06-06 10:28:24','Save','Save ContentTypes performed by user'),(10,0,-1,'2016-06-06 10:33:12','PackagerUninstall','Package \'AsposeMemberExportToWord\' uninstalled. Package guid: '),(11,0,-1,'2016-06-06 10:33:45','PackagerInstall','Package \'AsposeMemberExportToWord\' installed. Package guid: '),(12,0,-1,'2016-06-06 10:33:48','Save','Save ContentTypes performed by user'),(13,0,-1,'2016-06-06 10:40:57','PackagerUninstall','Package \'AsposeMemberExportToWord\' uninstalled. Package guid: '),(14,0,-1,'2016-06-06 10:42:18','PackagerInstall','Package 5005e2c2-819d-41c5-bbd8-2eab27d66024 fetched from 65194810-1f85-11dd-bd0b-0800200c9a66'),(15,0,-1,'2016-06-06 10:42:47','PackagerInstall','Package \'Locator\' installed. Package guid: 5005e2c2-819d-41c5-bbd8-2eab27d66024'),(16,0,-1,'2016-06-06 10:42:56','Save','Save DataTypeDefinition performed by user'),(17,0,-1,'2016-06-06 10:42:56','Save','Save DataTypeDefinition performed by user'),(18,0,-1,'2016-06-06 10:42:56','Save','Save Macro performed by user'),(19,0,-1,'2016-06-06 10:42:57','Save','Save Macro performed by user'),(20,0,-1,'2016-06-06 10:42:57','Save','Save ContentTypes performed by user'),(21,0,-1,'2016-06-06 17:05:05','PackagerInstall','Package \'ExtendMenu\' installed. Package guid: '),(22,0,-1,'2016-06-06 17:05:14','Save','Save ContentTypes performed by user'),(23,0,-1,'2016-06-08 10:33:06','Save','Save Template performed by user'),(24,0,-1,'2016-06-08 10:33:08','Save','Save ContentTypes performed by user'),(25,0,-1,'2016-06-08 10:33:09','Save','Save ContentTypes performed by user'),(26,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(27,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(28,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(29,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(30,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(31,0,-1,'2016-06-08 10:33:09','Save','Save Stylesheet performed by user'),(32,0,-1,'2016-06-08 10:33:10','Save','Bulk Save content performed by user'),(33,0,-1,'2016-06-08 17:20:33','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(34,0,-1,'2016-06-08 17:20:42','Save','Save ContentTypes performed by user'),(35,0,1049,'2016-06-08 17:28:56','Delete','Delete Template performed by user'),(36,0,1057,'2016-06-08 17:28:56','Delete','Delete Content performed by user'),(37,0,-1,'2016-06-08 17:28:56','Delete','Delete Content of Type 1053 performed by user'),(38,0,1053,'2016-06-08 17:28:57','Delete','Delete ContentType performed by user'),(39,0,1058,'2016-06-08 17:28:58','Delete','Trashed content with Id: \'1058\' related to original parent content with Id: \'1054\''),(40,0,1058,'2016-06-08 17:28:58','Move','Move Content to Recycle Bin performed by user'),(41,0,1055,'2016-06-08 17:28:58','Delete','Trashed content with Id: \'1055\' related to original parent content with Id: \'1054\''),(42,0,1055,'2016-06-08 17:28:58','Move','Move Content to Recycle Bin performed by user'),(43,0,1056,'2016-06-08 17:28:58','Delete','Trashed content with Id: \'1056\' related to original parent content with Id: \'1054\''),(44,0,1056,'2016-06-08 17:28:58','Move','Move Content to Recycle Bin performed by user'),(45,0,1054,'2016-06-08 17:28:58','Delete','Delete Content performed by user'),(46,0,-1,'2016-06-08 17:28:59','Delete','Delete Content of Type 1052 performed by user'),(47,0,1052,'2016-06-08 17:28:59','Delete','Delete ContentType performed by user'),(48,0,1055,'2016-06-08 17:28:59','Delete','Delete Content performed by user'),(49,0,1056,'2016-06-08 17:28:59','Delete','Delete Content performed by user'),(50,0,-1,'2016-06-08 17:28:59','Delete','Delete Content of Type 1051 performed by user'),(51,0,1051,'2016-06-08 17:29:00','Delete','Delete ContentType performed by user'),(52,0,1058,'2016-06-08 17:29:00','Delete','Delete Content performed by user'),(53,0,-1,'2016-06-08 17:29:00','Delete','Delete Content of Type 1050 performed by user'),(54,0,1050,'2016-06-08 17:29:00','Delete','Delete ContentType performed by user'),(55,0,-1,'2016-06-08 17:29:00','PackagerUninstall','Package \'OverflowStarterKit\' uninstalled. Package guid: 0b0101f7-9394-48f3-a581-dd3f18480265'),(56,0,-1,'2016-06-08 17:29:18','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(57,0,-1,'2016-06-08 17:31:02','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(58,0,-1,'2016-06-08 17:31:04','Save','Save ContentTypes performed by user'),(59,0,-1,'2016-06-08 18:05:12','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(60,0,-1,'2016-06-08 18:05:55','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(61,0,-1,'2016-06-08 18:06:04','Save','Save ContentTypes performed by user'),(62,0,-1,'2016-06-08 18:09:56','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(63,0,-1,'2016-06-08 18:10:36','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(64,0,-1,'2016-06-08 18:10:45','Save','Save ContentTypes performed by user'),(65,0,0,'2016-06-13 17:37:28','New','Media \'中国梦德育课修改6.13.docx\' was created'),(66,0,1049,'2016-06-13 17:37:29','Save','Save Media performed by user'),(67,0,-1,'2016-06-13 17:38:08','Save','Save Script performed by user'),(68,0,-1,'2016-06-15 10:49:52','PackagerInstall','Package \'Solis Search\' installed. Package guid: '),(69,0,-1,'2016-06-15 10:50:05','Save','Save ContentTypes performed by user'),(70,0,1050,'2016-06-27 14:20:27','Save','Save DataTypeDefinition performed by user'),(71,0,1051,'2016-06-27 14:20:55','Save','Save Template performed by user'),(72,0,1052,'2016-06-27 14:20:56','Save','Save ContentType performed by user'),(73,0,0,'2016-06-27 14:21:02','New','Content \'\' was created'),(74,0,1053,'2016-06-27 15:52:33','UnPublish','UnPublish performed by user'),(75,0,1053,'2016-06-27 15:52:34','Delete','Trashed content with Id: \'1053\' related to original parent content with Id: \'-1\''),(76,0,1053,'2016-06-27 15:52:34','Move','Move Content to Recycle Bin performed by user'),(77,0,1053,'2016-06-27 15:52:35','Delete','Delete Content performed by user'),(78,0,0,'2016-06-28 14:34:40','New','Content \'\' was created'),(79,0,-1,'2016-06-28 17:08:43','PackagerInstall','Package \'Custom Login Page\' installed. Package guid: '),(80,0,-1,'2016-06-28 17:08:45','Save','Save ContentTypes performed by user'),(81,0,-1,'2016-06-28 17:25:52','PackagerUninstall','Package \'Custom Login Page\' uninstalled. Package guid: '),(82,0,0,'2016-06-29 13:38:28','New','Media \'产品路线20150628.xlsx\' was created'),(83,0,1053,'2016-06-29 13:38:29','Save','Save Media performed by user'),(84,0,0,'2016-06-29 13:38:53','New','Media \'crebas.sql\' was created'),(85,0,1054,'2016-06-29 13:38:54','Save','Save Media performed by user'),(86,0,0,'2016-06-29 13:38:58','New','Media \'正式平台账号密码.txt\' was created'),(87,0,1055,'2016-06-29 13:38:58','Save','Save Media performed by user'),(88,0,0,'2016-06-29 13:39:04','New','Media \'MySite\' was created'),(89,0,1056,'2016-06-29 13:39:05','Save','Save Media performed by user'),(90,0,0,'2016-06-29 13:39:05','New','Media \'css\' was created'),(91,0,1057,'2016-06-29 13:39:05','Save','Save Media performed by user'),(92,0,0,'2016-06-29 13:39:06','New','Media \'base.css\' was created'),(93,0,1058,'2016-06-29 13:39:06','Save','Save Media performed by user'),(94,0,0,'2016-06-29 13:39:06','New','Media \'images\' was created'),(95,0,1059,'2016-06-29 13:39:06','Save','Save Media performed by user'),(96,0,0,'2016-06-29 13:39:06','New','Media \'banner.jpg\' was created'),(97,0,1060,'2016-06-29 13:39:07','Save','Save Media performed by user'),(98,0,0,'2016-06-29 13:39:07','New','Media \'banner_bg.jpg\' was created'),(99,0,1061,'2016-06-29 13:39:07','Save','Save Media performed by user'),(100,0,0,'2016-06-29 13:39:07','New','Media \'foot.jpg\' was created'),(101,0,1062,'2016-06-29 13:39:07','Save','Save Media performed by user'),(102,0,0,'2016-06-29 13:39:08','New','Media \'txl.jpg\' was created'),(103,0,1063,'2016-06-29 13:39:08','Save','Save Media performed by user'),(104,0,0,'2016-06-29 13:39:08','New','Media \'yin.jpg\' was created'),(105,0,1064,'2016-06-29 13:39:08','Save','Save Media performed by user'),(106,0,0,'2016-06-29 13:39:08','New','Media \'js\' was created'),(107,0,1065,'2016-06-29 13:39:08','Save','Save Media performed by user'),(108,0,0,'2016-06-29 13:39:08','New','Media \'modernizr.js\' was created'),(109,0,1066,'2016-06-29 13:39:08','Save','Save Media performed by user'),(110,0,1049,'2016-06-29 13:41:06','Move','Move Media to Recycle Bin performed by user'),(111,0,1056,'2016-06-29 13:48:26','Move','Move Media to Recycle Bin performed by user'),(112,0,1055,'2016-06-29 13:50:07','Move','Move Media to Recycle Bin performed by user'),(113,0,-1,'2016-06-29 13:51:51','Delete','Delete Content of Type 1052 performed by user'),(114,0,1052,'2016-06-29 13:51:52','Delete','Delete ContentType performed by user'),(115,0,1067,'2016-06-29 14:57:49','Save','Save DataTypeDefinition performed by user'),(116,0,1069,'2016-06-29 14:59:39','Save','Save DataTypeDefinition performed by user'),(117,0,1070,'2016-06-29 15:00:07','Save','Save DataTypeDefinition performed by user'),(118,0,1071,'2016-06-29 15:00:10','Save','Save Template performed by user'),(119,0,1072,'2016-06-29 15:00:10','Save','Save ContentType performed by user'),(120,0,1073,'2016-06-29 15:01:35','Save','Save DataTypeDefinition performed by user'),(121,0,1074,'2016-06-29 15:01:49','Save','Save Template performed by user'),(122,0,1075,'2016-06-29 15:01:49','Save','Save ContentType performed by user'),(123,0,1072,'2016-06-29 15:02:24','Save','Save ContentType performed by user'),(124,0,1076,'2016-06-29 15:03:05','Save','Save DataTypeDefinition performed by user'),(125,0,1077,'2016-06-29 15:03:21','Save','Save DataTypeDefinition performed by user'),(126,0,1078,'2016-06-29 15:03:43','Save','Save Template performed by user'),(127,0,1079,'2016-06-29 15:03:44','Save','Save ContentType performed by user'),(128,0,0,'2016-06-29 15:03:53','New','Content \'\' was created'),(129,0,1072,'2016-06-29 15:04:11','Save','Save ContentType performed by user'),(130,0,1072,'2016-06-29 15:04:19','Save','Save ContentType performed by user'),(131,0,0,'2016-06-29 15:04:24','New','Content \'\' was created'),(132,0,0,'2016-06-29 15:04:39','New','Content \'\' was created'),(133,0,0,'2016-06-29 15:05:39','New','Content \'\' was created'),(134,0,0,'2016-06-29 15:06:04','New','Content \'\' was created'),(135,0,0,'2016-06-29 15:09:41','New','Content \'\' was created'),(136,0,0,'2016-06-29 15:10:30','New','Content \'\' was created'),(137,0,0,'2016-06-29 15:10:45','New','Content \'\' was created'),(138,0,1082,'2016-06-29 15:10:59','Save','Save Content performed by user'),(139,0,1082,'2016-06-29 15:11:06','Save','Save Content performed by user'),(140,0,0,'2016-06-29 15:11:45','New','Content \'\' was created'),(141,0,1083,'2016-06-29 15:12:04','Save','Save Content performed by user'),(142,0,-1,'2016-06-29 15:12:21','Delete','Delete Content of Type 1075 performed by user'),(143,0,1075,'2016-06-29 15:12:21','Delete','Delete ContentType performed by user'),(144,0,1079,'2016-06-29 15:14:22','Save','Save ContentType performed by user'),(145,0,1079,'2016-06-29 15:15:57','Save','Save ContentType performed by user'),(146,0,1072,'2016-06-29 15:16:20','Save','Save ContentType performed by user'),(147,0,0,'2016-06-29 15:18:24','New','Content \'\' was created'),(148,0,1084,'2016-06-29 15:18:32','Save','Save Content performed by user'),(149,0,1080,'2016-06-29 15:19:11','Save','Save Content performed by user'),(150,0,0,'2016-06-29 15:19:45','New','Content \'\' was created'),(151,0,0,'2016-06-29 15:19:45','New','Content \'\' was created'),(152,0,1085,'2016-06-29 15:19:51','Save','Save Content performed by user'),(153,0,1072,'2016-06-29 15:20:17','Save','Save ContentType performed by user'),(154,0,1072,'2016-06-29 15:20:20','Save','Save ContentType performed by user'),(155,0,0,'2016-06-29 15:20:54','New','Content \'\' was created'),(156,0,1086,'2016-06-29 15:21:04','Publish','Save and Publish performed by user'),(157,0,0,'2016-06-29 15:21:12','New','Content \'\' was created'),(158,0,1087,'2016-06-29 15:21:43','Save','Save Content performed by user'),(159,0,0,'2016-06-29 15:21:52','New','Content \'\' was created'),(160,0,1088,'2016-06-29 15:22:03','Save','Save Content performed by user'),(161,0,0,'2016-06-29 15:22:07','New','Content \'\' was created'),(162,0,1089,'2016-06-29 15:22:14','Save','Save Content performed by user'),(163,0,1080,'2016-06-29 15:22:36','UnPublish','UnPublish performed by user'),(164,0,1081,'2016-06-29 15:22:39','UnPublish','UnPublish performed by user'),(165,0,1080,'2016-06-29 15:22:40','Delete','Trashed content with Id: \'1080\' related to original parent content with Id: \'-1\''),(166,0,1085,'2016-06-29 15:22:40','Delete','Trashed content with Id: \'1085\' related to original parent content with Id: \'1080\''),(167,0,1084,'2016-06-29 15:22:40','Delete','Trashed content with Id: \'1084\' related to original parent content with Id: \'1080\''),(168,0,1083,'2016-06-29 15:22:40','Delete','Trashed content with Id: \'1083\' related to original parent content with Id: \'1080\''),(169,0,1082,'2016-06-29 15:22:40','Delete','Trashed content with Id: \'1082\' related to original parent content with Id: \'1080\''),(170,0,1081,'2016-06-29 15:22:41','Delete','Trashed content with Id: \'1081\' related to original parent content with Id: \'1080\''),(171,0,1086,'2016-06-29 15:22:41','Delete','Trashed content with Id: \'1086\' related to original parent content with Id: \'1082\''),(172,0,1088,'2016-06-29 15:22:41','Delete','Trashed content with Id: \'1088\' related to original parent content with Id: \'1086\''),(173,0,1087,'2016-06-29 15:22:41','Delete','Trashed content with Id: \'1087\' related to original parent content with Id: \'1086\''),(174,0,1089,'2016-06-29 15:22:41','Delete','Trashed content with Id: \'1089\' related to original parent content with Id: \'1088\''),(175,0,1080,'2016-06-29 15:22:41','Move','Move Content to Recycle Bin performed by user'),(176,0,1085,'2016-06-29 15:22:41','Delete','Delete Content performed by user'),(177,0,1084,'2016-06-29 15:22:41','Delete','Delete Content performed by user'),(178,0,1083,'2016-06-29 15:22:42','Delete','Delete Content performed by user'),(179,0,1089,'2016-06-29 15:22:42','Delete','Delete Content performed by user'),(180,0,1088,'2016-06-29 15:22:42','Delete','Delete Content performed by user'),(181,0,1087,'2016-06-29 15:22:43','Delete','Delete Content performed by user'),(182,0,1086,'2016-06-29 15:22:43','Delete','Delete Content performed by user'),(183,0,1082,'2016-06-29 15:22:43','Delete','Delete Content performed by user'),(184,0,1081,'2016-06-29 15:22:43','Delete','Delete Content performed by user'),(185,0,1080,'2016-06-29 15:22:44','Delete','Delete Content performed by user'),(186,0,-1,'2016-06-29 15:23:02','Delete','Delete Content of Type 1072 performed by user'),(187,0,1072,'2016-06-29 15:23:03','Delete','Delete ContentType performed by user'),(188,0,1090,'2016-06-29 15:24:13','Save','Save DataTypeDefinition performed by user'),(189,0,1091,'2016-06-29 15:24:34','Save','Save Template performed by user'),(190,0,1092,'2016-06-29 15:24:34','Save','Save ContentType performed by user'),(191,0,1079,'2016-06-29 15:25:13','Save','Save ContentType performed by user'),(192,0,1093,'2016-06-29 15:26:12','Save','Save DataTypeDefinition performed by user'),(193,0,1094,'2016-06-29 15:26:14','Save','Save Template performed by user'),(194,0,1095,'2016-06-29 15:26:14','Save','Save ContentType performed by user'),(195,0,0,'2016-06-29 15:26:21','New','Content \'\' was created'),(196,0,1096,'2016-06-29 15:26:32','Save','Save Content performed by user'),(197,0,1095,'2016-06-29 15:27:02','Save','Save ContentType performed by user'),(198,0,1092,'2016-06-29 15:27:15','Save','Save ContentType performed by user'),(199,0,1095,'2016-06-29 15:27:44','Save','Save ContentType performed by user'),(200,0,0,'2016-06-29 15:27:54','New','Content \'\' was created'),(201,0,1097,'2016-06-29 15:28:11','Save','Save Content performed by user'),(202,0,0,'2016-06-29 15:28:14','New','Content \'\' was created'),(203,0,1098,'2016-06-29 15:28:28','Save','Save Content performed by user'),(204,0,0,'2016-06-29 15:28:31','New','Content \'\' was created'),(205,0,1099,'2016-06-29 15:28:37','Save','Save Content performed by user'),(206,0,0,'2016-06-29 15:28:40','New','Content \'\' was created'),(207,0,1100,'2016-06-29 15:28:49','Save','Save Content performed by user'),(208,0,0,'2016-06-29 15:28:53','New','Content \'\' was created'),(209,0,1101,'2016-06-29 15:29:09','Save','Save Content performed by user'),(210,0,0,'2016-06-29 15:29:15','New','Content \'\' was created'),(211,0,1102,'2016-06-29 15:29:33','Save','Save Content performed by user'),(212,0,1096,'2016-06-30 10:49:18','Publish','Publish with Children performed by user'),(213,0,1094,'2016-06-30 10:49:59','Save','Save Template performed by user'),(214,0,0,'2016-06-30 10:54:45','New','Content \'\' was created'),(215,0,1096,'2016-06-30 10:54:59','UnPublish','UnPublish performed by user'),(216,0,1097,'2016-06-30 10:54:59','UnPublish','UnPublish performed by user'),(217,0,1098,'2016-06-30 10:54:59','UnPublish','UnPublish performed by user'),(218,0,1099,'2016-06-30 10:55:00','UnPublish','UnPublish performed by user'),(219,0,1102,'2016-06-30 10:55:00','UnPublish','UnPublish performed by user'),(220,0,1100,'2016-06-30 10:55:00','UnPublish','UnPublish performed by user'),(221,0,1101,'2016-06-30 10:55:00','UnPublish','UnPublish performed by user'),(222,0,1096,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1096\' related to original parent content with Id: \'-1\''),(223,0,1097,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1097\' related to original parent content with Id: \'1096\''),(224,0,1098,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1098\' related to original parent content with Id: \'1096\''),(225,0,1099,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1099\' related to original parent content with Id: \'1098\''),(226,0,1102,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1102\' related to original parent content with Id: \'1098\''),(227,0,1100,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1100\' related to original parent content with Id: \'1099\''),(228,0,1101,'2016-06-30 10:55:01','Delete','Trashed content with Id: \'1101\' related to original parent content with Id: \'1100\''),(229,0,1096,'2016-06-30 10:55:02','Move','Move Content to Recycle Bin performed by user'),(230,0,1102,'2016-06-30 10:55:20','Delete','Delete Content performed by user'),(231,0,1097,'2016-06-30 10:55:20','Delete','Delete Content performed by user'),(232,0,-1,'2016-06-30 10:55:20','Delete','Delete Content of Type 1079 performed by user'),(233,0,1079,'2016-06-30 10:55:20','Delete','Delete ContentType performed by user'),(234,0,1101,'2016-06-30 10:55:25','Delete','Delete Content performed by user'),(235,0,1100,'2016-06-30 10:55:25','Delete','Delete Content performed by user'),(236,0,1099,'2016-06-30 10:55:26','Delete','Delete Content performed by user'),(237,0,1098,'2016-06-30 10:55:26','Delete','Delete Content performed by user'),(238,0,-1,'2016-06-30 10:55:26','Delete','Delete Content of Type 1092 performed by user'),(239,0,1092,'2016-06-30 10:55:26','Delete','Delete ContentType performed by user'),(240,0,1096,'2016-06-30 10:55:30','Delete','Delete Content performed by user'),(241,0,-1,'2016-06-30 10:55:30','Delete','Delete Content of Type 1095 performed by user'),(242,0,1095,'2016-06-30 10:55:31','Delete','Delete ContentType performed by user'),(243,0,-1,'2016-06-30 10:56:16','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(244,0,-1,'2016-06-30 10:56:19','Save','Save ContentTypes performed by user'),(245,0,-1,'2016-06-30 10:56:20','Save','Save ContentTypes performed by user'),(246,0,-1,'2016-06-30 10:56:20','Save','Bulk Save content performed by user'),(247,0,0,'2016-06-30 10:56:45','New','Content \'\' was created'),(248,0,0,'2016-06-30 10:56:47','New','Content \'\' was created'),(249,0,0,'2016-06-30 10:56:49','New','Content \'\' was created'),(250,0,0,'2016-06-30 10:56:51','New','Content \'\' was created'),(251,0,0,'2016-06-30 10:59:14','New','Content \'\' was created'),(252,0,1108,'2016-06-30 10:59:23','Save','Save Content performed by user'),(253,0,0,'2016-06-30 10:59:26','New','Content \'\' was created'),(254,0,1109,'2016-06-30 10:59:29','Save','Save Content performed by user'),(255,0,0,'2016-06-30 10:59:32','New','Content \'\' was created'),(256,0,1110,'2016-06-30 10:59:36','Save','Save Content performed by user'),(257,0,0,'2016-06-30 10:59:39','New','Content \'\' was created'),(258,0,1111,'2016-06-30 10:59:42','Save','Save Content performed by user'),(259,0,1107,'2016-06-30 14:40:18','Publish','Publish with Children performed by user'),(260,0,1094,'2016-06-30 14:40:32','Save','Save Template performed by user'),(261,0,0,'2016-07-12 16:46:04','New','Content \'\' was created'),(262,0,0,'2016-07-14 13:33:35','New','Content \'\' was created'),(263,0,1113,'2016-07-14 14:03:23','Save','Save DataTypeDefinition performed by user'),(264,0,1104,'2016-07-14 14:03:25','Save','Save ContentType performed by user'),(265,0,1107,'2016-07-14 14:03:47','UnPublish','UnPublish performed by user'),(266,0,1108,'2016-07-14 14:03:50','UnPublish','UnPublish performed by user'),(267,0,1109,'2016-07-14 14:03:53','UnPublish','UnPublish performed by user'),(268,0,1110,'2016-07-14 14:03:56','UnPublish','UnPublish performed by user'),(269,0,1112,'2016-07-14 14:04:00','UnPublish','UnPublish performed by user'),(270,0,1111,'2016-07-14 14:04:03','UnPublish','UnPublish performed by user'),(271,0,1107,'2016-07-14 14:04:04','Delete','Trashed content with Id: \'1107\' related to original parent content with Id: \'-1\''),(272,0,1108,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1108\' related to original parent content with Id: \'1107\''),(273,0,1109,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1109\' related to original parent content with Id: \'1108\''),(274,0,1110,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1110\' related to original parent content with Id: \'1108\''),(275,0,1112,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1112\' related to original parent content with Id: \'1110\''),(276,0,1111,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1111\' related to original parent content with Id: \'1110\''),(277,0,1107,'2016-07-14 14:04:05','Move','Move Content to Recycle Bin performed by user'),(278,0,1107,'2016-07-14 14:04:05','Delete','Trashed content with Id: \'1107\' related to original parent content with Id: \'-1\''),(279,0,1107,'2016-07-14 14:04:06','Move','Move Content to Recycle Bin performed by user'),(280,0,1114,'2016-07-14 14:04:18','Save','Save DataTypeDefinition performed by user'),(281,0,1104,'2016-07-14 14:04:20','Save','Save ContentType performed by user'),(282,0,0,'2016-07-14 14:04:25','New','Content \'\' was created'),(283,0,0,'2016-07-14 14:04:43','New','Content \'\' was created'),(284,0,0,'2016-07-14 14:04:47','New','Content \'\' was created'),(285,0,-1,'2016-07-14 14:40:01','PackagerInstall','Package \'CM Umbraco Tools\' installed. Package guid: '),(286,0,-1,'2016-07-14 14:40:23','Save','Save ContentTypes performed by user'),(287,0,-1,'2016-07-14 14:46:34','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(288,0,-1,'2016-07-14 14:46:48','Save','Save ContentTypes performed by user'),(289,0,-1,'2016-07-14 14:47:54','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(290,0,-1,'2016-07-14 14:48:51','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(291,0,-1,'2016-07-14 14:49:03','Save','Save ContentTypes performed by user'),(292,0,-1,'2016-07-14 16:16:08','PackagerInstall','Package \'AsposeMemberExportToWord\' installed. Package guid: '),(293,0,-1,'2016-07-14 16:16:21','Save','Save ContentTypes performed by user'),(294,0,-1,'2016-07-14 17:10:26','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(295,0,-1,'2016-07-14 17:10:35','Save','Save ContentTypes performed by user'),(296,0,-1,'2016-07-15 09:30:12','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(297,0,-1,'2016-07-15 09:31:19','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(298,0,-1,'2016-07-15 09:31:32','Save','Save ContentTypes performed by user'),(299,0,-1,'2016-07-15 09:35:41','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(300,0,-1,'2016-07-15 09:36:07','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(301,0,-1,'2016-07-15 09:36:19','Save','Save ContentTypes performed by user'),(302,0,-1,'2016-07-15 09:38:09','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(303,0,-1,'2016-07-15 09:43:20','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(304,0,-1,'2016-07-15 09:43:32','Save','Save ContentTypes performed by user'),(305,0,-1,'2016-07-15 09:56:00','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(306,0,-1,'2016-07-15 09:56:53','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(307,0,-1,'2016-07-15 09:57:06','Save','Save ContentTypes performed by user'),(308,0,-1,'2016-07-20 14:51:37','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(309,0,-1,'2016-07-20 16:30:19','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(310,0,-1,'2016-07-20 16:30:29','Save','Save ContentTypes performed by user'),(311,0,-1,'2016-07-20 16:31:30','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(312,0,-1,'2016-07-20 16:32:07','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(313,0,-1,'2016-07-20 16:32:17','Save','Save ContentTypes performed by user'),(314,0,-1,'2016-07-20 16:34:44','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(315,0,-1,'2016-07-20 16:35:34','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(316,0,-1,'2016-07-20 16:35:44','Save','Save ContentTypes performed by user'),(317,0,-1,'2016-07-20 16:36:36','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(318,0,-1,'2016-07-20 16:37:10','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(319,0,-1,'2016-07-20 16:37:21','Save','Save ContentTypes performed by user'),(320,0,-1,'2016-07-20 16:37:56','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(321,0,-1,'2016-07-20 16:39:03','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(322,0,-1,'2016-07-20 16:39:12','Save','Save ContentTypes performed by user'),(323,0,-1,'2016-07-20 16:56:42','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(324,0,-1,'2016-07-20 16:56:52','Save','Save ContentTypes performed by user'),(325,0,-1,'2016-07-20 16:57:27','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(326,0,-1,'2016-07-20 17:41:51','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(327,0,-1,'2016-07-20 17:45:17','PackagerInstall','Package \'PluginsUmbracoMemberExportToWord\' installed. Package guid: '),(328,0,-1,'2016-07-20 17:45:28','Save','Save ContentTypes performed by user'),(329,0,-1,'2016-07-20 17:46:04','PackagerUninstall','Package \'PluginsUmbracoMemberExportToWord\' uninstalled. Package guid: '),(330,0,-1,'2016-07-20 17:48:15','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(331,0,-1,'2016-07-20 17:48:25','Save','Save ContentTypes performed by user'),(332,0,-1,'2016-07-20 17:48:50','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(333,0,-1,'2016-07-20 17:50:42','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(334,0,-1,'2016-07-20 17:58:15','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(335,0,-1,'2016-07-20 17:58:43','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(336,0,-1,'2016-07-20 17:58:53','Save','Save ContentTypes performed by user'),(337,0,-1,'2016-07-20 18:00:51','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(338,0,-1,'2016-07-20 18:03:20','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(339,0,-1,'2016-07-20 18:03:30','Save','Save ContentTypes performed by user'),(340,0,-1,'2016-07-20 18:04:50','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(341,0,-1,'2016-07-20 18:07:01','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(342,0,-1,'2016-07-20 18:07:12','Save','Save ContentTypes performed by user'),(343,0,-1,'2016-07-20 18:07:46','PackagerInstall','Package \'ExtendMenu\' installed. Package guid: '),(344,0,-1,'2016-07-20 18:07:56','Save','Save ContentTypes performed by user'),(345,0,-1,'2016-07-20 18:08:28','PackagerUninstall','Package \'ExtendMenu\' uninstalled. Package guid: '),(346,0,-1,'2016-07-20 18:09:04','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(347,0,-1,'2016-07-20 18:40:45','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(348,0,-1,'2016-07-20 18:41:10','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(349,0,-1,'2016-07-20 18:41:19','Save','Save ContentTypes performed by user'),(350,0,-1,'2016-07-21 09:58:47','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(351,0,-1,'2016-07-21 09:59:14','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(352,0,-1,'2016-07-21 10:20:40','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(353,0,-1,'2016-07-21 10:21:03','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(354,0,-1,'2016-07-21 10:23:52','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(355,0,-1,'2016-07-21 10:24:15','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(356,0,-1,'2016-07-21 10:24:25','Save','Save ContentTypes performed by user'),(357,0,-1,'2016-07-21 10:27:35','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(358,0,-1,'2016-07-21 10:28:10','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(359,0,-1,'2016-07-21 10:28:20','Save','Save ContentTypes performed by user'),(360,0,-1,'2016-07-21 10:28:47','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(361,0,-1,'2016-07-21 10:59:07','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(362,0,-1,'2016-07-21 10:59:19','Save','Save ContentTypes performed by user'),(363,0,-1,'2016-07-21 11:24:32','PackagerUninstall','Package \'DTP App Pool Refresh\' uninstalled. Package guid: '),(364,0,-1,'2016-07-21 11:34:17','PackagerInstall','Package \'AsposeMemberExportToWord\' installed. Package guid: '),(365,0,-1,'2016-07-21 11:34:27','Save','Save ContentTypes performed by user'),(366,0,-1,'2016-07-21 11:42:03','PackagerUninstall','Package \'AsposeMemberExportToWord\' uninstalled. Package guid: '),(367,0,-1,'2016-07-21 11:42:24','PackagerInstall','Package \'ExtendMenu\' installed. Package guid: '),(368,0,-1,'2016-07-21 11:42:34','Save','Save ContentTypes performed by user'),(369,0,-1,'2016-07-21 11:45:29','PackagerUninstall','Package \'ExtendMenu\' uninstalled. Package guid: '),(370,0,-1,'2016-07-21 11:46:04','PackagerInstall','Package \'Our.Umbraco.BootEasy\' installed. Package guid: '),(371,0,-1,'2016-07-21 11:46:14','Save','Save ContentTypes performed by user'),(372,0,-1,'2016-07-21 16:00:04','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(373,0,-1,'2016-07-21 16:00:14','Save','Save ContentTypes performed by user'),(374,0,-1,'2016-07-21 18:16:09','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(375,0,-1,'2016-07-21 18:16:24','Save','Save ContentTypes performed by user'),(376,0,-1,'2016-07-21 18:19:00','PackagerUninstall','Package \'AsposeMemberExportToWord\' uninstalled. Package guid: '),(377,0,-1,'2016-07-21 18:20:13','PackagerUninstall','Package \'CM Umbraco Tools\' uninstalled. Package guid: '),(378,0,-1,'2016-07-21 18:21:21','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(379,0,-1,'2016-07-21 18:22:00','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(380,0,-1,'2016-07-21 18:22:13','Save','Save ContentTypes performed by user'),(381,0,-1,'2016-07-21 18:24:25','PackagerUninstall','Package \'FileManage\' uninstalled. Package guid: '),(382,0,-1,'2016-07-21 18:24:59','PackagerInstall','Package \'FileManage\' installed. Package guid: '),(383,0,-1,'2016-07-21 18:25:11','Save','Save ContentTypes performed by user'),(384,0,-1,'2016-07-21 18:51:08','PackagerInstall','Package \'ExtendMenu\' installed. Package guid: '),(385,0,-1,'2016-07-21 18:51:33','Save','Save ContentTypes performed by user'),(386,0,-1,'2016-07-21 18:52:55','PackagerUninstall','Package \'ExtendMenu\' uninstalled. Package guid: '),(387,0,-1,'2016-07-21 18:57:11','PackagerInstall','Package \'ExtendMenu\' installed. Package guid: '),(388,0,-1,'2016-07-21 18:57:21','Save','Save ContentTypes performed by user'),(389,0,-1,'2016-07-21 18:57:52','PackagerInstall','Package \'DTP App Pool Refresh\' installed. Package guid: '),(390,0,-1,'2016-07-21 18:58:01','Save','Save ContentTypes performed by user'),(391,0,-1,'2016-07-21 18:59:04','PackagerUninstall','Package \'ExtendMenu\' uninstalled. Package guid: ');

UNLOCK TABLES;

/*Table structure for table `umbracomigration` */

DROP TABLE IF EXISTS `umbracomigration`;

CREATE TABLE `umbracomigration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `version` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoMigration` (`name`,`version`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `umbracomigration` */

LOCK TABLES `umbracomigration` WRITE;

insert  into `umbracomigration`(`id`,`name`,`createDate`,`version`) values (1,'Umbraco','2016-06-06 09:29:05','7.4.3');

UNLOCK TABLES;

/*Table structure for table `umbraconode` */

DROP TABLE IF EXISTS `umbraconode`;

CREATE TABLE `umbraconode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trashed` tinyint(1) NOT NULL DEFAULT '0',
  `parentID` int(11) NOT NULL,
  `nodeUser` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL,
  `path` varchar(150) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  `uniqueID` char(36) NOT NULL,
  `text` varchar(255) DEFAULT NULL,
  `nodeObjectType` char(36) DEFAULT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoNodeTrashed` (`trashed`),
  KEY `IX_umbracoNodeParentId` (`parentID`),
  KEY `IX_umbracoNodeUniqueID` (`uniqueID`),
  KEY `IX_umbracoNodeObjectType` (`nodeObjectType`),
  CONSTRAINT `umbraconode_ibfk_1` FOREIGN KEY (`parentID`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1117 DEFAULT CHARSET=utf8;

/*Data for the table `umbraconode` */

LOCK TABLES `umbraconode` WRITE;

insert  into `umbraconode`(`id`,`trashed`,`parentID`,`nodeUser`,`level`,`path`,`sortOrder`,`uniqueID`,`text`,`nodeObjectType`,`createDate`) values (-97,0,-1,0,1,'-1,-97',2,'aa2c52a0-ce87-4e65-a47c-7df09358585d','List View - Members','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-96,0,-1,0,1,'-1,-96',2,'3a0156c4-3b8c-4803-bdc1-6871faa83fff','List View - Media','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-95,0,-1,0,1,'-1,-95',2,'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4','List View - Content','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-92,0,-1,0,1,'-1,-92',35,'f0bc4bfb-b499-40d6-ba86-058885a5178c','Label','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-90,0,-1,0,1,'-1,-90',34,'84c6b441-31df-4ffe-b67e-67d5bc3ae65a','Upload','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-89,0,-1,0,1,'-1,-89',33,'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3','Textarea','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-88,0,-1,0,1,'-1,-88',32,'0cc0eba1-9960-42c9-bf9b-60e150b429ae','Textstring','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-87,0,-1,0,1,'-1,-87',4,'ca90c950-0aff-4e72-b976-a30b1ac57dad','Richtext editor','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-51,0,-1,0,1,'-1,-51',2,'2e6d3631-066e-44b8-aec4-96f09099b2b5','Numeric','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-49,0,-1,0,1,'-1,-49',2,'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49','True/false','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-43,0,-1,0,1,'-1,-43',2,'fbaf13a8-4036-41f2-93a3-974f678c312a','Checkbox list','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-42,0,-1,0,1,'-1,-42',2,'0b6a45e7-44ba-430d-9da5-4e46060b9e03','Dropdown','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-41,0,-1,0,1,'-1,-41',2,'5046194e-4237-453c-a547-15db3a07c4e1','Date Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:29'),(-40,0,-1,0,1,'-1,-40',2,'bb5f57c9-ce2b-4bb9-b697-4caca783a805','Radiobox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-39,0,-1,0,1,'-1,-39',2,'f38f0ac7-1d27-439c-9f3f-089cd8825a53','Dropdown multiple','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-37,0,-1,0,1,'-1,-37',2,'0225af17-b302-49cb-9176-b9f35cab9c17','Approved Color','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-36,0,-1,0,1,'-1,-36',2,'e4d66c0f-b935-4200-81f0-025f7256b89a','Date Picker with time','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:30'),(-21,0,-1,0,0,'-1,-21',0,'bf7c7cbc-952f-4518-97a2-69e9c7b33842','Recycle Bin','cf3d8e34-1c1c-41e9-ae56-878b57b32113','2016-06-06 09:26:29'),(-20,0,-1,0,0,'-1,-20',0,'0f582a79-1e41-4cf0-bfa0-76340651891a','Recycle Bin','01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8','2016-06-06 09:26:29'),(-1,0,-1,0,0,'-1',0,'916724a5-173d-4619-b97e-b9de133dd6f5','SYSTEM DATA: umbraco master root','ea7d8624-4cfe-4578-a871-24aa946bf34d','2016-06-06 09:26:28'),(1031,0,-1,0,1,'-1,1031',2,'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d','Folder','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2016-06-06 09:26:31'),(1032,0,-1,0,1,'-1,1032',2,'cc07b313-0843-4aa8-bbda-871c8da728c8','Image','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2016-06-06 09:26:31'),(1033,0,-1,0,1,'-1,1033',2,'4c52d8ab-54e6-40cd-999c-7a5f24903e4d','File','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2016-06-06 09:26:31'),(1034,0,-1,0,1,'-1,1034',2,'a6857c73-d6e9-480c-b6e6-f15f6ad11125','Content Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1035,0,-1,0,1,'-1,1035',2,'93929b9a-93a2-4e2a-b239-d99334440a59','Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1036,0,-1,0,1,'-1,1036',2,'2b24165f-9782-4aa3-b459-1de4a4d21f60','Member Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1040,0,-1,0,1,'-1,1040',2,'21e798da-e06e-4eda-a511-ed257f78d4fa','Related Links','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1041,0,-1,0,1,'-1,1041',2,'b6b73142-b9c1-4bf8-a16d-e1c23320b549','Tags','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1043,0,-1,0,1,'-1,1043',2,'1df9f033-e6d4-451f-b8d2-e0cbc50a836f','Image Cropper','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1044,0,-1,0,1,'-1,1044',1,'d59be02f-1df9-4228-aa1e-01917d806cda','VIP','9b5416fb-e72f-45a9-a07b-5a9a2709ce43','2016-06-06 09:26:31'),(1045,0,-1,0,1,'-1,1045',2,'7e3962cc-ce20-4ffc-b661-5897a894ba7e','Multiple Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 09:26:31'),(1046,0,-1,0,0,'-1,1046',0,'5f7195a0-32b1-4ce8-b519-3548b56827cd','特别关注1','366e63b9-880f-4e13-a61c-98069b029728','2016-06-06 10:30:30'),(1047,0,-1,0,1,'-1,1047',0,'62c86a6e-337f-44cb-bbd1-7538ad8f0d95','VIP_1','39eb0f98-b348-42a1-8662-e7eb18487560','2016-06-06 10:31:36'),(1048,0,-1,0,1,'-1,1048',24,'9839f0d6-abf7-4387-b9fd-af4918c830fe','Locator','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-06 10:42:56'),(1049,1,-21,0,1,'-1,-21,1049',1,'1bc3112d-5676-4d3e-bef3-26cf422ebd0e','中国梦德育课修改6.13.docx','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-13 17:37:28'),(1050,0,-1,0,1,'-1,1050',25,'34a2f284-fd89-4de4-87c6-930f71113a47','test1 - Date','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-27 14:20:27'),(1051,0,-1,NULL,1,'-1,1051',0,'b9f94418-c88e-40b9-8fde-cab47b580bdb','test1','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-27 14:20:55'),(1053,0,-1,0,1,'-1,1053',1,'67a05626-fc0e-408c-a987-0db38c703269','产品路线20150628.xlsx','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:38:29'),(1054,0,-1,0,1,'-1,1054',2,'f15f245b-4a52-42c9-89ca-b771fd5dae8c','crebas.sql','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:38:54'),(1055,1,-21,0,1,'-1,-21,1055',3,'d13fbf8d-0ef0-46c0-96f4-46666c2e14ed','正式平台账号密码.txt','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:38:58'),(1056,1,-21,0,1,'-1,-21,1056',2,'ddbb2ded-75c1-4e46-af9b-f09d34b11212','MySite','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:05'),(1057,1,1056,0,2,'-1,-21,1056,1057',3,'bd65fd86-0f31-4279-acb9-2705ad4f3254','css','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:05'),(1058,1,1057,0,3,'-1,-21,1056,1057,1058',1,'8476fcbf-83ae-4dda-8997-68d760e9e878','base.css','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:06'),(1059,1,1056,0,2,'-1,-21,1056,1059',4,'d42fdc7c-3846-4095-937b-aa97a67069f7','images','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:06'),(1060,1,1059,0,3,'-1,-21,1056,1059,1060',5,'57e0c552-d480-4464-8cb5-241c0ddb6bd0','banner.jpg','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:07'),(1061,1,1059,0,3,'-1,-21,1056,1059,1061',6,'a34fb579-de06-404b-b45c-4ca02c924d48','banner_bg.jpg','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:07'),(1062,1,1059,0,3,'-1,-21,1056,1059,1062',7,'a51a3f6e-28f2-49ca-a9a3-ee6fb29096c5','foot.jpg','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:07'),(1063,1,1059,0,3,'-1,-21,1056,1059,1063',8,'84878759-899f-4f22-83e4-f80716097aaf','txl.jpg','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:08'),(1064,1,1059,0,3,'-1,-21,1056,1059,1064',9,'f7e27377-c1a2-47dc-a54f-223b7497dc9f','yin.jpg','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:08'),(1065,1,1056,0,2,'-1,-21,1056,1065',5,'d93d6c61-8750-4a66-a02d-7a9b45314b14','js','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:08'),(1066,1,1065,0,3,'-1,-21,1056,1065,1066',1,'082349ce-b502-49fe-a82f-0e98eb86e71e','modernizr.js','b796f64c-1f99-4ffb-b886-4bf4bc011a9c','2016-06-29 13:39:08'),(1067,0,-1,0,1,'-1,1067',26,'62469aeb-4d00-4e58-95d0-f4d2cf17cccd','一级目录 - FirstlevelName - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 14:57:48'),(1069,0,-1,0,1,'-1,1069',27,'845f6dee-018c-42ec-9558-780070095ad9','FirstLevelName','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 14:59:39'),(1070,0,-1,0,1,'-1,1070',28,'ba8d92d4-1eda-45f7-9f8c-0cd965e1b9c0','FirstLevel - FirstLevelName - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:00:07'),(1071,0,-1,NULL,1,'-1,1071',0,'ad9fe064-5375-4607-8598-e6645e54ade2','FirstLevel','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-29 15:00:10'),(1073,0,-1,0,1,'-1,1073',29,'c8235f95-e0c4-4cdd-a1a3-35c41bad1fb3','SecondLevel - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:01:35'),(1074,0,-1,NULL,1,'-1,1074',0,'5ade27f7-44b8-42dc-a732-09b22fd1109a','SecondLevel','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-29 15:01:49'),(1076,0,-1,0,1,'-1,1076',30,'4cf265ec-aafd-40f9-8a42-5507547cd4c6','File - FileName - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:03:05'),(1077,0,-1,0,1,'-1,1077',31,'7192a7cb-5cb6-451f-9e61-c8882e90e06b','File - FileURL - File upload','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:03:21'),(1078,0,-1,NULL,1,'-1,1078',0,'68643522-815a-4804-9b1d-3add5f2547ef','Files','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-29 15:03:43'),(1090,0,-1,0,1,'-1,1090',32,'0b2ce682-24cb-48e2-8288-255f49600e1c','Folder - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:24:13'),(1091,0,-1,NULL,1,'-1,1091',0,'be2cbcd2-0516-4709-b3ca-ac6dd3ba07ed','Folders','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-29 15:24:34'),(1093,0,-1,0,1,'-1,1093',33,'0846f1c4-a500-4eb9-9b96-677ba00dc162','Home - SiteName - Textbox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-06-29 15:26:12'),(1094,0,-1,NULL,1,'-1,1094',0,'2877560d-7443-41d7-b2d7-6e77fac32475','Home','6fbde604-4178-42ce-a10b-8a2600a2f07d','2016-06-29 15:26:14'),(1103,0,-1,0,1,'-1,1103',0,'f2fe38b6-ad34-458e-b501-86c6a4767405','文件管理系统','2f7a2769-6b0b-4468-90dd-af42d64f7f16','2016-06-30 10:56:19'),(1104,0,1103,0,2,'-1,1103,1104',4,'1562a405-647d-4a7b-b595-5008d5d7dc6a','Files','a2cb7800-f571-4787-9638-bc48539a0efb','2016-06-30 10:56:19'),(1105,0,1103,0,2,'-1,1103,1105',1,'d8fb8bd0-e3f3-4b74-af5c-ebae4b9232de','Folders','a2cb7800-f571-4787-9638-bc48539a0efb','2016-06-30 10:56:19'),(1106,0,1103,0,2,'-1,1103,1106',2,'50f3884a-0fa2-4ca6-8405-135f3564ddeb','Home','a2cb7800-f571-4787-9638-bc48539a0efb','2016-06-30 10:56:19'),(1107,1,-20,0,1,'-1,-20,1107',2,'d61b0ede-2d7d-40de-9b60-6c3f0d43ff5b','文件管理','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-06-30 10:56:20'),(1108,1,1107,0,2,'-1,-20,1107,1108',1,'a7e57c16-a47b-4738-8cf0-967b6944eee4','test','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-06-30 10:59:22'),(1109,1,1108,0,3,'-1,-20,1107,1108,1109',2,'ee481acd-855e-46d2-a2a1-8280ef236543','test','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-06-30 10:59:28'),(1110,1,1108,0,3,'-1,-20,1107,1108,1110',3,'2255b168-a0fd-440b-8bf9-74dc1ed7b853','test2','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-06-30 10:59:36'),(1111,1,1110,0,4,'-1,-20,1107,1108,1110,1111',3,'ef45d5c2-fa4b-4214-ab9a-086c1f20e72f','test3','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-06-30 10:59:42'),(1112,1,1110,0,4,'-1,-20,1107,1108,1110,1112',2,'965c981a-0f07-469f-a867-9488287f64cc','12','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-07-12 16:46:18'),(1113,0,-1,0,1,'-1,1113',34,'50225aed-9e2c-4e8a-aa5f-444d92f76499','Files - FileURL - Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-07-14 14:03:23'),(1114,0,-1,0,1,'-1,1114',35,'e8ccaeae-2a69-4c52-89e7-2bcdd2c0b00f','Files - FileURL - Media Picker (1)','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2016-07-14 14:04:18'),(1115,0,-1,0,1,'-1,1115',0,'286bf910-1455-41e2-888d-dc05a4fbc8a5','文件管理','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-07-14 14:04:32'),(1116,0,1115,0,2,'-1,1115,1116',0,'ff3a0e5b-75d3-4f9a-bd23-a42cc39d9ad7','12','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2016-07-14 14:05:01');

UNLOCK TABLES;

/*Table structure for table `umbracorelation` */

DROP TABLE IF EXISTS `umbracorelation`;

CREATE TABLE `umbracorelation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `childId` int(11) NOT NULL,
  `relType` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  KEY `childId` (`childId`),
  KEY `relType` (`relType`),
  CONSTRAINT `umbracorelation_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `umbracorelation_ibfk_2` FOREIGN KEY (`childId`) REFERENCES `umbraconode` (`id`),
  CONSTRAINT `umbracorelation_ibfk_3` FOREIGN KEY (`relType`) REFERENCES `umbracorelationtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `umbracorelation` */

LOCK TABLES `umbracorelation` WRITE;

insert  into `umbracorelation`(`id`,`parentId`,`childId`,`relType`,`datetime`,`comment`) values (1,-1,1107,2,'2016-07-14 14:04:04',''),(2,1107,1108,2,'2016-07-14 14:04:04',''),(3,1108,1109,2,'2016-07-14 14:04:05',''),(4,1108,1110,2,'2016-07-14 14:04:05',''),(5,1110,1112,2,'2016-07-14 14:04:05',''),(6,1110,1111,2,'2016-07-14 14:04:05',''),(7,-1,1107,2,'2016-07-14 14:04:05','');

UNLOCK TABLES;

/*Table structure for table `umbracorelationtype` */

DROP TABLE IF EXISTS `umbracorelationtype`;

CREATE TABLE `umbracorelationtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dual` tinyint(1) NOT NULL,
  `parentObjectType` char(36) NOT NULL,
  `childObjectType` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `alias` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `umbracorelationtype` */

LOCK TABLES `umbracorelationtype` WRITE;

insert  into `umbracorelationtype`(`id`,`dual`,`parentObjectType`,`childObjectType`,`name`,`alias`) values (1,1,'c66ba18e-eaf3-4cff-8a22-41b16d66a972','c66ba18e-eaf3-4cff-8a22-41b16d66a972','Relate Document On Copy','relateDocumentOnCopy'),(2,0,'c66ba18e-eaf3-4cff-8a22-41b16d66a972','c66ba18e-eaf3-4cff-8a22-41b16d66a972','Relate Parent Document On Delete','relateParentDocumentOnDelete');

UNLOCK TABLES;

/*Table structure for table `umbracoserver` */

DROP TABLE IF EXISTS `umbracoserver`;

CREATE TABLE `umbracoserver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(500) NOT NULL,
  `computerName` varchar(255) NOT NULL,
  `registeredDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastNotifiedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `isActive` tinyint(1) NOT NULL,
  `isMaster` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_computerName` (`computerName`),
  KEY `IX_umbracoServer_isActive` (`isActive`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `umbracoserver` */

LOCK TABLES `umbracoserver` WRITE;

insert  into `umbracoserver`(`id`,`address`,`computerName`,`registeredDate`,`lastNotifiedDate`,`isActive`,`isMaster`) values (1,'http://localhost:8001/umbraco','ST-PC//LM/W3SVC/1/ROOT','2016-07-14 14:58:43','2016-07-21 19:00:56',1,1),(2,'http://localhost:28915/umbraco','ST-PC//LM/W3SVC/51/ROOT','2016-07-14 15:00:13','2016-07-20 15:06:41',0,0),(3,'http://localhost:25316/umbraco','ST-PC//LM/W3SVC/49/ROOT','2016-07-20 13:32:58','2016-07-21 17:43:18',0,0),(4,'http://localhost:10004/umbraco','ST-PC//LM/W3SVC/63/ROOT','2016-07-21 17:52:48','2016-07-21 19:01:25',1,0);

UNLOCK TABLES;

/*Table structure for table `umbracouser` */

DROP TABLE IF EXISTS `umbracouser`;

CREATE TABLE `umbracouser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userDisabled` tinyint(1) NOT NULL DEFAULT '0',
  `userNoConsole` tinyint(1) NOT NULL DEFAULT '0',
  `userType` int(11) NOT NULL,
  `startStructureID` int(11) NOT NULL,
  `startMediaID` int(11) DEFAULT NULL,
  `userName` varchar(255) NOT NULL,
  `userLogin` varchar(125) NOT NULL,
  `userPassword` varchar(500) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  `userLanguage` varchar(10) DEFAULT NULL,
  `securityStampToken` varchar(255) DEFAULT NULL,
  `failedLoginAttempts` int(11) DEFAULT NULL,
  `lastLockoutDate` timestamp NULL DEFAULT NULL,
  `lastPasswordChangeDate` timestamp NULL DEFAULT NULL,
  `lastLoginDate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_umbracoUser_userLogin` (`userLogin`),
  KEY `userType` (`userType`),
  CONSTRAINT `umbracouser_ibfk_1` FOREIGN KEY (`userType`) REFERENCES `umbracousertype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracouser` */

LOCK TABLES `umbracouser` WRITE;

insert  into `umbracouser`(`id`,`userDisabled`,`userNoConsole`,`userType`,`startStructureID`,`startMediaID`,`userName`,`userLogin`,`userPassword`,`userEmail`,`userLanguage`,`securityStampToken`,`failedLoginAttempts`,`lastLockoutDate`,`lastPasswordChangeDate`,`lastLoginDate`) values (0,0,0,1,-1,-1,'zcs','zcs','g9S/tWhV7WUoCqMdf+WN7WbvexI=','zcs@sina.cn','zh-CN','f2483664-be48-47d6-8b34-f76192f2e4bd',0,NULL,'2016-06-06 09:30:17','2016-07-21 18:49:22');

UNLOCK TABLES;

/*Table structure for table `umbracouser2app` */

DROP TABLE IF EXISTS `umbracouser2app`;

CREATE TABLE `umbracouser2app` (
  `user` int(11) NOT NULL,
  `app` varchar(50) NOT NULL,
  PRIMARY KEY (`user`,`app`),
  CONSTRAINT `umbracouser2app_ibfk_1` FOREIGN KEY (`user`) REFERENCES `umbracouser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracouser2app` */

LOCK TABLES `umbracouser2app` WRITE;

insert  into `umbracouser2app`(`user`,`app`) values (0,'CMUmbracoTools'),(0,'content'),(0,'developer'),(0,'FileManage'),(0,'forms'),(0,'media'),(0,'member'),(0,'settings'),(0,'translation'),(0,'users');

UNLOCK TABLES;

/*Table structure for table `umbracouser2nodenotify` */

DROP TABLE IF EXISTS `umbracouser2nodenotify`;

CREATE TABLE `umbracouser2nodenotify` (
  `userId` int(11) NOT NULL,
  `nodeId` int(11) NOT NULL,
  `action` char(1) NOT NULL,
  PRIMARY KEY (`userId`,`nodeId`,`action`),
  KEY `nodeId` (`nodeId`),
  CONSTRAINT `umbracouser2nodenotify_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `umbracouser` (`id`),
  CONSTRAINT `umbracouser2nodenotify_ibfk_2` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracouser2nodenotify` */

LOCK TABLES `umbracouser2nodenotify` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracouser2nodepermission` */

DROP TABLE IF EXISTS `umbracouser2nodepermission`;

CREATE TABLE `umbracouser2nodepermission` (
  `userId` int(11) NOT NULL,
  `nodeId` int(11) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`,`nodeId`,`permission`),
  KEY `nodeId` (`nodeId`),
  CONSTRAINT `umbracouser2nodepermission_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `umbracouser` (`id`),
  CONSTRAINT `umbracouser2nodepermission_ibfk_2` FOREIGN KEY (`nodeId`) REFERENCES `umbraconode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `umbracouser2nodepermission` */

LOCK TABLES `umbracouser2nodepermission` WRITE;

UNLOCK TABLES;

/*Table structure for table `umbracousertype` */

DROP TABLE IF EXISTS `umbracousertype`;

CREATE TABLE `umbracousertype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userTypeAlias` varchar(50) DEFAULT NULL,
  `userTypeName` varchar(255) NOT NULL,
  `userTypeDefaultPermissions` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `umbracousertype` */

LOCK TABLES `umbracousertype` WRITE;

insert  into `umbracousertype`(`id`,`userTypeAlias`,`userTypeName`,`userTypeDefaultPermissions`) values (1,'admin','Administrators','CADMOSKTPIURZ:5F7'),(2,'writer','Writer','CADMOSKTPIURZ:5F7'),(3,'editor','Editor','CADMOSKTPIURZ:5F7'),(4,'translator','Translator','CADMOSKTPIURZ:5F7'),(5,'test','AA','CADMOSKTPIURZ:5F7');

UNLOCK TABLES;

/* Function  structure for function  `queryChildrenFile` */

/*!50003 DROP FUNCTION IF EXISTS `queryChildrenFile` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `queryChildrenFile`(fileID INT) RETURNS varchar(4000) CHARSET utf8
BEGIN
    
   DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);
SET sTemp = '&';
SET sTempChd = CAST(fileID AS CHAR);
WHILE sTempChd IS NOT NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT GROUP_CONCAT(id) INTO sTempChd FROM files WHERE FIND_IN_SET(parentId,sTempChd)>0;
END WHILE;
RETURN sTemp;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
