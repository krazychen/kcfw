--
-- Definition of table `iim_chat_history`
--

DROP TABLE IF EXISTS `iim_chat_history`;
CREATE TABLE `iim_chat_history` (
  `id` varchar(64) NOT NULL,
  `userid1` varchar(64) default NULL,
  `userid2` varchar(64) default NULL,
  `msg` varchar(1024) character set utf8 default NULL,
  `status` varchar(45) default NULL,
  `create_date` datetime default NULL,
  `type` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `iim_chat_history`
--

/*!40000 ALTER TABLE `iim_chat_history` DISABLE KEYS */;
INSERT INTO `iim_chat_history` (`id`,`userid1`,`userid2`,`msg`,`status`,`create_date`,`type`) VALUES 
 ('081d0675a82b4315b3f77084c2ee5f52','c897bb6d3068478aab72cd1f60a69c78_msg_admin','zw','sssf','1','2016-08-14 18:10:45','group'),
 ('0c0c6f70344444f89bb2aa7d69825e02','c897bb6d3068478aab72cd1f60a69c78_msg_admin','zw','sss','1','2016-08-14 18:11:50','group'),
 ('10ab30d1d85e47de894a9ebd7177be5a','d7b0feb87a8c44acbe4a17d2aefa86a5_msg_admin','zw','999','1','2016-08-14 09:40:53','group'),
 ('11860c08433445c1a178464598712478','admin','zw','sqsqsqsqsq','1','2016-08-11 23:59:25',NULL),
 ('15f4aaf8545343ceb07d6c65a184d794','admin','zw','444','1','2016-08-11 23:54:49',NULL),
 ('19d245654cde4c2fb9f8b93a5325cf83','admin','zw','ww','1','2016-08-12 00:06:43',NULL),
 ('1d82f2ddb9944a598e0ca7ec1d05d678','admin','zw','111','1','2016-08-11 23:55:21',NULL),
 ('1f5a1281df7a49b09f7fb600d0545f3a','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','333','1','2016-08-11 23:56:54','group'),
 ('20707960c8bd4ef2a55bf9edf7b9c3f5','admin','zw','44','1','2016-08-11 23:54:56',NULL),
 ('2078e087319c4f00a1fe0e4938018136','admin','zw','333','1','2016-08-12 00:13:09','friend'),
 ('26f79867aece473bb9f770a15b210c70','71752068e6284b358283a1aee8c5dbec_msg_zw','admin','123','1','2016-08-11 23:56:25','group'),
 ('312976896ba84da3b4ec458c1335eacc','admin','zw','sqsqsqsqsqsq','1','2016-08-11 23:59:15',NULL),
 ('34ef66f157054ebea024c39ef1a8e3f7','admin','zw','3333','1','2016-08-11 23:54:24',NULL),
 ('38105ff5856e4e32b0e7fbdf9a0d50a0','admin','zw','rrr','1','2016-08-11 23:54:33',NULL),
 ('385017f5c1354ecc94ee79d745ea694b','d7b0feb87a8c44acbe4a17d2aefa86a5_msg_admin','zw','3333','1','2016-08-12 00:04:34','group'),
 ('3b8c9ba4e1b84174be3760bc93f57ef1','admin','zw','111','1','2016-08-11 23:57:02',NULL),
 ('3bed638001cc4880a4ab4536ffc19315','c897bb6d3068478aab72cd1f60a69c78_msg_fbb','zw','www','1','2016-08-14 18:11:42','group'),
 ('52778787c5b846da88b5b56e3435faed','admin','zw','111','1','2016-08-11 23:57:10',NULL),
 ('52cb6f5c97744501b6a9f55970c61ffe','admin','zw','eeee','1','2016-08-11 23:54:26',NULL),
 ('5bd5106dd6404ae199e595c8df77ed2b','admin','zw','sss','1','2016-08-11 23:57:51',NULL),
 ('690fdf7823f04c85bfe99ffca6b85a5c','d7b0feb87a8c44acbe4a17d2aefa86a5_msg_admin','zw','dddd','1','2016-08-12 00:06:48','group'),
 ('692cafb9794a4a2aa0a351fc9a4ec2fb','admin','zw','2222','1','2016-08-11 23:57:04',NULL),
 ('6b3693f22a5f4c8aa50a5a28d147212e','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','2222','1','2016-08-12 00:00:08','group'),
 ('72a5a411c6be45fca3bb33d5ac9801e8','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','3333','1','2016-08-11 23:56:37','group'),
 ('748d8767eab34ddda6c9ecf02a1a6dea','d7b0feb87a8c44acbe4a17d2aefa86a5_msg_admin','zw','eee','1','2016-08-12 00:13:16','group'),
 ('7838514c568f44fc9043f2e6ffe22abd','admin','zw','ssss','1','2016-08-11 23:54:09',NULL),
 ('7a90b0bea89b45dda85cbd6356b0984f','admin','zw','333','1','2016-08-11 23:54:46',NULL),
 ('7dcc6f49f4fd4093b2827a1954f9aa6a','admin','zw','asd','1','2016-08-11 23:58:00',NULL),
 ('84950e8f465345f788494cf9da543d3e','admin','zw','wwww','1','2016-08-12 00:05:37',NULL),
 ('8cc8c64e33ba4d1cbd154d412bdd625c','admin','zw','sqsqsqsq','1','2016-08-11 23:59:27',NULL),
 ('934d667f3bdd401db722eafd31a7c9f2','c897bb6d3068478aab72cd1f60a69c78_msg_admin','zw','333','1','2016-08-14 18:12:20','group'),
 ('943f8122dc3743f89ebefc70743d5e21','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','2222','1','2016-08-11 23:59:59','group'),
 ('9f4fab1bb19f407a88749aae1bffef30','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','333','1','2016-08-11 23:56:31','group'),
 ('9fecc106d5874d66b759c7d32464c6a0','admin','fbb','face[疑问] ','1','2016-08-14 09:40:36','friend'),
 ('a07dcb1ea3c844b4bb193c84d36e7246','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','222','1','2016-08-11 23:57:13','group'),
 ('a0f4de897fd34803953bb007c793756c','admin','zw','eeee','1','2016-08-12 00:13:11','friend'),
 ('a728ff498e6740079c35bd74c3380831','admin','zw','aqsqsqsqsq','1','2016-08-11 23:59:12',NULL),
 ('aef04b1974734fa087182e356d8397a5','admin','zw','test','1','2016-08-11 23:58:28',NULL),
 ('b070baffc6cd40d6a80a1247825ee235','admin','zw','sss','1','2016-08-12 00:05:23',NULL),
 ('b0edd27f24144ecfbb6677dbd0604f6e','admin','zw','wwww','1','2016-08-11 23:59:55',NULL),
 ('c50c3aefc4e64021be1765a0ead518f5','d7b0feb87a8c44acbe4a17d2aefa86a5_msg_admin','zw','4444','1','2016-08-12 00:04:36','group'),
 ('c8c12a2e86dd4e05a6a495923b9bea21','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','333','1','2016-08-11 23:56:51','group'),
 ('dd28edb75243440cb74a259a19294576','71752068e6284b358283a1aee8c5dbec_msg_admin','zw','1111','1','2016-08-11 23:56:58','group'),
 ('e5a98af3ee104e4bb2a8d224c505f4eb','c897bb6d3068478aab72cd1f60a69c78_msg_zw','fbb','23232','1','2016-08-14 18:10:37','group'),
 ('ec1be463a1b14ce7b58ac26328c7580c','admin','admin','ssss','1','2016-08-12 00:05:19',NULL);
/*!40000 ALTER TABLE `iim_chat_history` ENABLE KEYS */;


--
-- Definition of table `iim_mail`
--

DROP TABLE IF EXISTS `iim_mail`;
CREATE TABLE `iim_mail` (
  `id` varchar(64) NOT NULL,
  `title` varchar(128) default NULL COMMENT '标题',
  `overview` varchar(128) default NULL COMMENT '内容概要',
  `content` longblob COMMENT '内容',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件';

--
-- Dumping data for table `iim_mail`
--

/*!40000 ALTER TABLE `iim_mail` DISABLE KEYS */;
INSERT INTO `iim_mail` (`id`,`title`,`overview`,`content`) VALUES 
 ('df9d5b7631d94fbfaa6d6b0849220e6b','te','ss',0x7373);
/*!40000 ALTER TABLE `iim_mail` ENABLE KEYS */;


--
-- Definition of table `iim_mail_box`
--

DROP TABLE IF EXISTS `iim_mail_box`;
CREATE TABLE `iim_mail_box` (
  `id` varchar(64) NOT NULL,
  `readstatus` varchar(45) default NULL COMMENT '状态 0 未读 1 已读',
  `senderId` varchar(64) default NULL COMMENT '发件人',
  `receiverId` varchar(6400) default NULL COMMENT '收件人',
  `sendtime` datetime default NULL COMMENT '发送时间',
  `mailid` varchar(64) default NULL COMMENT '邮件外键',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收件箱';

--
-- Dumping data for table `iim_mail_box`
--

/*!40000 ALTER TABLE `iim_mail_box` DISABLE KEYS */;
INSERT INTO `iim_mail_box` (`id`,`readstatus`,`senderId`,`receiverId`,`sendtime`,`mailid`) VALUES 
 ('0530c561300b49e2bf6bc0128650d5a5','1','1','1','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('0cac5379e5634cc1ba22a4e56b11b412','0','1','0fb8ebbff20a46029596806aa077d3c2','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('7d31c46caa2d40ad856a96187f4fca14','1','1','f7cc1c7e6f494818adffe1de5f2282fb','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('feda277b87c54835929cbaa6aad02845','0','1','7374fe91d19a4b739ae649334c0cc273','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b');
/*!40000 ALTER TABLE `iim_mail_box` ENABLE KEYS */;


--
-- Definition of table `iim_mail_compose`
--

DROP TABLE IF EXISTS `iim_mail_compose`;
CREATE TABLE `iim_mail_compose` (
  `id` varchar(64) NOT NULL,
  `status` varchar(45) default NULL COMMENT '状态 0 草稿 1 已发送',
  `readstatus` varchar(45) default NULL COMMENT '状态 0 未读 1 已读',
  `senderId` varchar(64) default NULL COMMENT '发送者',
  `receiverId` varchar(6400) default NULL COMMENT '接收者',
  `sendtime` datetime default NULL COMMENT '发送时间',
  `mailId` varchar(64) default NULL COMMENT '邮件id',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发件箱 草稿箱';

--
-- Dumping data for table `iim_mail_compose`
--

/*!40000 ALTER TABLE `iim_mail_compose` DISABLE KEYS */;
INSERT INTO `iim_mail_compose` (`id`,`status`,`readstatus`,`senderId`,`receiverId`,`sendtime`,`mailId`) VALUES 
 ('23c6c211d9984846974568eca25c189f','1',NULL,'1','7374fe91d19a4b739ae649334c0cc273','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('3653fec3ca2943fa87e569d1efeaffd5','1',NULL,'1','1','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('4730d32825bf4e7cb361b9c853b9c9c2','1',NULL,'1','f7cc1c7e6f494818adffe1de5f2282fb','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b'),
 ('bb5d8bfec54540f482d5dc7b11c256a6','1',NULL,'1','0fb8ebbff20a46029596806aa077d3c2','2016-06-19 00:16:50','df9d5b7631d94fbfaa6d6b0849220e6b');
/*!40000 ALTER TABLE `iim_mail_compose` ENABLE KEYS */;
