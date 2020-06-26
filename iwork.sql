/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.13 : Database - iwork
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`iwork` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `iwork`;

/*Table structure for table `i_tb_adjustsalary` */

DROP TABLE IF EXISTS `i_tb_adjustsalary`;

CREATE TABLE `i_tb_adjustsalary` (
  `as_uid` varchar(32) NOT NULL,
  `as_eid` varchar(32) DEFAULT NULL,
  `as_asDate` date DEFAULT NULL COMMENT '调薪日期',
  `as_beforeSalary` varchar(32) DEFAULT NULL COMMENT '调前薪资',
  `as_afterSalary` varchar(32) DEFAULT NULL COMMENT '调后薪资',
  `as_reason` varchar(255) DEFAULT NULL COMMENT '调薪原因',
  `as_remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`as_uid`),
  KEY `pid` (`as_eid`),
  KEY `fk_adjustsalary_ibfk_2` (`as_beforeSalary`),
  KEY `fk_adjustsalary_ibfk_3` (`as_afterSalary`),
  CONSTRAINT `fk_adjustsalary_ibfk_1` FOREIGN KEY (`as_eid`) REFERENCES `i_tb_user` (`u_uid`),
  CONSTRAINT `fk_adjustsalary_ibfk_2` FOREIGN KEY (`as_beforeSalary`) REFERENCES `i_tb_salary` (`s_uid`),
  CONSTRAINT `fk_adjustsalary_ibfk_3` FOREIGN KEY (`as_afterSalary`) REFERENCES `i_tb_salary` (`s_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_adjustsalary` */

/*Table structure for table `i_tb_appraise` */

DROP TABLE IF EXISTS `i_tb_appraise`;

CREATE TABLE `i_tb_appraise` (
  `a_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `a_eid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_appDate` date DEFAULT NULL COMMENT '考评日期',
  `a_appResult` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '考评结果',
  `a_appContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '考评内容',
  `a_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`a_uid`) USING BTREE,
  KEY `pid` (`a_eid`) USING BTREE,
  CONSTRAINT `fk_appraise_ibfk_1` FOREIGN KEY (`a_eid`) REFERENCES `i_tb_user` (`u_uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `i_tb_appraise` */

insert  into `i_tb_appraise`(`a_uid`,`a_eid`,`a_appDate`,`a_appResult`,`a_appContent`,`a_remark`) values ('001','001','2019-11-20','优秀','KPI','撸起袖子加油干');

/*Table structure for table `i_tb_check` */

DROP TABLE IF EXISTS `i_tb_check`;

CREATE TABLE `i_tb_check` (
  `c_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '签到UId',
  `c_userId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签到人',
  `c_siteposLat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签到所在纬度',
  `c_siteposLng` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签到所在精度',
  `c_date` datetime DEFAULT NULL COMMENT '签到日期',
  `c_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '签到类型',
  PRIMARY KEY (`c_uid`) USING BTREE,
  KEY `fk_check_1` (`c_userId`) USING BTREE,
  CONSTRAINT `fk_check_1` FOREIGN KEY (`c_userId`) REFERENCES `i_tb_user` (`u_uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `i_tb_check` */

insert  into `i_tb_check`(`c_uid`,`c_userId`,`c_siteposLat`,`c_siteposLng`,`c_date`,`c_type`) values ('001','001',NULL,NULL,'2019-11-20 14:50:01','迟到'),('002','002',NULL,NULL,'2019-11-21 14:50:34','出勤'),('174ba33fef064939bbddd487b655bf28',NULL,NULL,NULL,'2019-11-28 10:40:02',NULL),('6275abd3577a402ea33f8a9b466efb67',NULL,NULL,NULL,'2019-11-28 14:43:14',NULL);

/*Table structure for table `i_tb_checkrule` */

DROP TABLE IF EXISTS `i_tb_checkrule`;

CREATE TABLE `i_tb_checkrule` (
  `cr_uid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '签到规则id',
  `cr_siteposLat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规定所在纬度',
  `cr_siteposLng` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '规定所在精度',
  `cr_siteradius` float DEFAULT NULL COMMENT '规定签到半径',
  PRIMARY KEY (`cr_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `i_tb_checkrule` */

/*Table structure for table `i_tb_department` */

DROP TABLE IF EXISTS `i_tb_department`;

CREATE TABLE `i_tb_department` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT,
  `d_name` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `d_parentId` int(11) DEFAULT NULL COMMENT '上一级部门Id',
  `d_depPath` varchar(255) DEFAULT NULL COMMENT '部门所在位置',
  `d_enabled` tinyint(1) DEFAULT '1' COMMENT '启用位',
  `d_isParent` tinyint(1) DEFAULT '0' COMMENT '是否为父部门单位',
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_department` */

insert  into `i_tb_department`(`d_id`,`d_name`,`d_parentId`,`d_depPath`,`d_enabled`,`d_isParent`) values (1,'股东会',-1,'.1',1,1),(4,'董事会',1,'.1.4',1,1),(5,'总办',4,'.1.4.5',1,1),(8,'财务部',5,'.1.4.5.8',1,0),(78,'市场部',5,'.1.4.5.78',1,1),(81,'华北市场部',78,'.1.4.5.78.81',1,1),(82,'华南市场部',78,'.1.4.5.78.82',1,0),(85,'石家庄市场部',81,'.1.4.5.78.81.85',1,0),(86,'西北市场部',78,'.1.4.5.78.86',1,1),(87,'西安市场',86,'.1.4.5.78.86.87',1,1),(89,'莲湖区市场',87,'.1.4.5.78.86.87.89',1,0),(91,'技术部',5,'.1.4.5.91',1,0),(92,'运维部',5,'.1.4.5.92',1,0);

/*Table structure for table `i_tb_employee_state` */

DROP TABLE IF EXISTS `i_tb_employee_state`;

CREATE TABLE `i_tb_employee_state` (
  `es_employeeStateId` int(11) NOT NULL AUTO_INCREMENT,
  `es_employeeState` varchar(45) DEFAULT NULL,
  `es_remark` text,
  PRIMARY KEY (`es_employeeStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_employee_state` */

insert  into `i_tb_employee_state`(`es_employeeStateId`,`es_employeeState`,`es_remark`) values (1,'在职',NULL),(2,'离职',NULL),(3,'返聘',NULL),(4,'退休',NULL),(5,'留职查看',NULL),(6,'停薪留职',NULL),(7,'试用期',NULL),(8,'试用延长期',NULL);

/*Table structure for table `i_tb_employeeremove` */

DROP TABLE IF EXISTS `i_tb_employeeremove`;

CREATE TABLE `i_tb_employeeremove` (
  `er_uid` varchar(32) NOT NULL,
  `er_eid` varchar(32) DEFAULT NULL,
  `er_afterDepId` int(11) DEFAULT NULL COMMENT '调动后部门',
  `er_afterJobId` int(11) DEFAULT NULL COMMENT '调动后职位',
  `er_removeDate` date DEFAULT NULL COMMENT '调动日期',
  `er_reason` varchar(255) DEFAULT NULL COMMENT '调动原因',
  `er_remark` varchar(255) DEFAULT NULL,
  `er_beforeDepId` int(11) DEFAULT NULL COMMENT '调动前部门',
  `er_beforeJobId` int(11) DEFAULT NULL COMMENT '调动前职位',
  PRIMARY KEY (`er_uid`),
  KEY `pid` (`er_eid`),
  CONSTRAINT `fk_employeeremove_ibfk_1` FOREIGN KEY (`er_eid`) REFERENCES `i_tb_user` (`u_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_employeeremove` */

/*Table structure for table `i_tb_empsalary` */

DROP TABLE IF EXISTS `i_tb_empsalary`;

CREATE TABLE `i_tb_empsalary` (
  `es_uid` varchar(32) NOT NULL,
  `es_eid` varchar(32) DEFAULT NULL,
  `es_sid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`es_uid`),
  KEY `eid` (`es_eid`),
  KEY `empsalary_ibfk_2` (`es_sid`),
  CONSTRAINT `fk_empsalary_ibfk_1` FOREIGN KEY (`es_eid`) REFERENCES `i_tb_user` (`u_uid`),
  CONSTRAINT `fk_empsalary_ibfk_2` FOREIGN KEY (`es_sid`) REFERENCES `i_tb_salary` (`s_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_empsalary` */

insert  into `i_tb_empsalary`(`es_uid`,`es_eid`,`es_sid`) values ('10','005','9'),('11','006','13'),('12','007','13'),('13','002','13'),('14','008','10'),('15','009','10'),('16','010','13'),('6','004','10'),('7','003','9'),('e960996fffa842a18187f5b3126f15e7','001','10');

/*Table structure for table `i_tb_joblevel` */

DROP TABLE IF EXISTS `i_tb_joblevel`;

CREATE TABLE `i_tb_joblevel` (
  `j_uid` varchar(32) NOT NULL,
  `j_name` varchar(32) DEFAULT NULL COMMENT '职称名称',
  `j_titleLevel` enum('正高级','副高级','中级','初级','员级') DEFAULT NULL,
  `j_createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `j_enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`j_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_joblevel` */

insert  into `i_tb_joblevel`(`j_uid`,`j_name`,`j_titleLevel`,`j_createDate`,`j_enabled`) values ('2','副教授','副高级','2018-01-11 21:19:20',1),('3','助教','初级','2018-01-11 21:35:39',1),('4','讲师','中级','2018-01-11 22:42:12',1),('5','初级工程师','初级','2018-01-14 16:18:50',1),('6','中级工程师','中级','2018-01-14 16:19:00',1),('7','高级工程师','副高级','2018-01-14 16:19:14',1),('8','骨灰级工程师','正高级','2018-01-14 16:19:24',1),('9','教授','正高级','2018-01-11 21:19:14',1);

/*Table structure for table `i_tb_leave` */

DROP TABLE IF EXISTS `i_tb_leave`;

CREATE TABLE `i_tb_leave` (
  `l_leaveId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请假ID',
  `l_applyPerson` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请假人Id',
  `l_applyDate` date NOT NULL COMMENT '申请日期',
  `l_applyReason` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '申请原因',
  `l_leaveTypeId` int(11) DEFAULT NULL COMMENT '请假类型',
  `l_startTime` datetime DEFAULT NULL COMMENT '开始时间',
  `l_endTime` datetime DEFAULT NULL COMMENT '结束时间',
  `l_leaveTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '离开时间',
  `l_approveDate` date DEFAULT NULL COMMENT '审核日期',
  `l_approver` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核人',
  `l_approveResult` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '审核原因',
  `l_state` tinyint(2) DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`l_leaveId`) USING BTREE,
  KEY `fk_leave_leaveTypeId` (`l_leaveTypeId`) USING BTREE,
  KEY `fk_leave_applyPerson` (`l_applyPerson`) USING BTREE,
  KEY `fk_leave_approver` (`l_approver`) USING BTREE,
  CONSTRAINT `fk_leaveType` FOREIGN KEY (`l_leaveTypeId`) REFERENCES `i_tb_leavetype` (`lt_leaveTypeid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_leave_applyPerson` FOREIGN KEY (`l_applyPerson`) REFERENCES `i_tb_user` (`u_uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_leave_approver` FOREIGN KEY (`l_approver`) REFERENCES `i_tb_user` (`u_uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `i_tb_leave` */

insert  into `i_tb_leave`(`l_leaveId`,`l_applyPerson`,`l_applyDate`,`l_applyReason`,`l_leaveTypeId`,`l_startTime`,`l_endTime`,`l_leaveTime`,`l_approveDate`,`l_approver`,`l_approveResult`,`l_state`) values ('09acd98f00b043d8b49a65696d6b6ff7','001','2019-11-28','6荣以',2,'2019-11-12 00:00:00','2019-11-21 00:00:00',NULL,NULL,NULL,NULL,0),('1','001','2019-11-18','探亲',1,'2019-11-19 16:41:33','2019-11-21 16:41:41',NULL,NULL,'003',NULL,0),('2','002','2019-11-18','访友',2,'2019-11-20 16:41:47','2019-11-23 16:41:51',NULL,NULL,'002',NULL,0),('3','003','2019-11-06','跑路',3,'2019-11-09 14:18:46','2019-11-15 14:18:51',NULL,NULL,'005',NULL,1),('4','004','2019-11-23','结婚',1,'2019-11-20 16:41:57','2019-11-24 16:42:03',NULL,NULL,'005',NULL,2),('5','006','2019-11-23','生子',1,'2019-11-25 16:42:09','2019-11-28 16:42:15',NULL,NULL,'008',NULL,2),('5854c02079f741babf1f6c7f587cae76','001','2019-11-28','重複v時間發貨時間看',1,'2019-11-13 00:00:00','2019-11-13 00:00:00',NULL,NULL,NULL,NULL,0),('6','004','2019-11-06','跑路2',3,'2019-11-09 14:18:46','2019-11-15 14:18:51',NULL,NULL,'005',NULL,1),('889aa21195254f8f8a6d06feec528f04','001','2019-11-28','6784如同结果',2,'2019-11-27 00:00:00','2019-11-29 00:00:00',NULL,NULL,NULL,NULL,1);

/*Table structure for table `i_tb_leavetype` */

DROP TABLE IF EXISTS `i_tb_leavetype`;

CREATE TABLE `i_tb_leavetype` (
  `lt_leaveTypeid` int(11) NOT NULL AUTO_INCREMENT,
  `lt_leaveType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lt_leaveTypeid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_leavetype` */

insert  into `i_tb_leavetype`(`lt_leaveTypeid`,`lt_leaveType`) values (1,'请假'),(2,'调休'),(3,'出差');

/*Table structure for table `i_tb_menu` */

DROP TABLE IF EXISTS `i_tb_menu`;

CREATE TABLE `i_tb_menu` (
  `m_uid` varchar(32) NOT NULL COMMENT 'UUID',
  `m_url` varchar(64) DEFAULT NULL COMMENT '映射的url地址',
  `m_path` varchar(64) DEFAULT NULL COMMENT '请求路径',
  `m_component` varchar(64) DEFAULT NULL COMMENT '响应的组件',
  `m_name` varchar(64) DEFAULT NULL,
  `iconCls` varchar(64) DEFAULT NULL COMMENT '菜单图标',
  `m_keepAlive` tinyint(1) DEFAULT NULL,
  `m_requireAuth` tinyint(1) DEFAULT NULL,
  `m_parentId` varchar(32) DEFAULT NULL COMMENT '上一级资源UID',
  `m_enabled` tinyint(1) DEFAULT '1' COMMENT '可用性',
  PRIMARY KEY (`m_uid`),
  KEY `fk_menu` (`m_parentId`),
  CONSTRAINT `fk_menu` FOREIGN KEY (`m_parentId`) REFERENCES `i_tb_menu` (`m_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_menu` */

insert  into `i_tb_menu`(`m_uid`,`m_url`,`m_path`,`m_component`,`m_name`,`iconCls`,`m_keepAlive`,`m_requireAuth`,`m_parentId`,`m_enabled`) values ('1','/',NULL,NULL,'所有',NULL,NULL,NULL,NULL,1),('10','/personnel/Leave/**','/per/Leave','PerLeave','请假调休',NULL,NULL,1,'3',1),('11','/personnel/search/**','/per/search','PerSearch','考勤名单',NULL,NULL,1,'3',1),('12','/personnel/trip/**','/per/trip','PerTrip','出差管理',NULL,NULL,1,'3',1),('13','/personnel/evaluation/**','/per/evaluat','PerEvaluat','评优评先',NULL,NULL,1,'3',1),('14','/salary/sob/**','/sal/sob','SalSob','工资账套管理',NULL,NULL,1,'4',1),('15','/salary/sobcfg/**','/sal/sobcfg','SalSobCfg','员工账套设置',NULL,NULL,1,'4',1),('16','/salary/table/**','/sal/table','SalTable','工资表管理',NULL,NULL,1,'4',1),('19','/statistics/all/**','/sta/all','StaAll','综合信息统计',NULL,NULL,1,'5',1),('2','/','/home','Home','员工资料','fa fa-user-circle-o',NULL,1,'1',1),('21','/statistics/personnel/**','/sta/pers','StaPers','人事信息统计',NULL,NULL,1,'5',1),('22','/statistics/recored/**','/sta/record','StaRecord','人事记录统计',NULL,NULL,1,'5',1),('23','/system/basic/**','/sys/basic','SysBasic','基础信息设置',NULL,NULL,1,'6',1),('26','/system/hr/**','/sys/hr','SysHr','操作员管理',NULL,NULL,1,'6',1),('27','/user/attendance/**','/user/atten','UserAtten','考勤打卡',NULL,NULL,1,'29',1),('28','/user/info/**','/user/info','UserInfo','个人信息',NULL,NULL,1,'29',1),('29','/','/home','Home','个人中心','fa fa-user',NULL,1,'1',1),('3','/','/home','Home','考勤管理','fa fa-address-card-o',NULL,1,'1',1),('4','/','/home','Home','薪资管理','fa fa-money',NULL,1,'1',1),('5','/','/home','Home','统计管理','fa fa-bar-chart',NULL,1,'1',1),('6','/','/home','Home','系统管理','fa fa-windows',NULL,1,'1',1),('7','/employee/basic/**','/emp/basic','EmpBasic','基本资料',NULL,NULL,1,'2',1),('8','/user/empCalendar/**','/user/EmpCalendar','UserCalendar','个人日程',NULL,NULL,1,'29',0),('9','/statistics/permission/**','/sta/permission','StaPermiss','考勤模块统计',NULL,NULL,1,'5',1);

/*Table structure for table `i_tb_msgcontent` */

DROP TABLE IF EXISTS `i_tb_msgcontent`;

CREATE TABLE `i_tb_msgcontent` (
  `m_uid` varchar(32) NOT NULL COMMENT '消息UID',
  `m_title` varchar(64) DEFAULT NULL COMMENT '消息标题',
  `m_message` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `m_createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息发送时间',
  PRIMARY KEY (`m_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_msgcontent` */

insert  into `i_tb_msgcontent`(`m_uid`,`m_title`,`m_message`,`m_createDate`) values ('02cb4934644d42f68afda8e115771e1e','111','11111111111111111111','2019-11-28 18:22:37'),('14','2222222222','11111111111111111','2018-02-02 20:46:19'),('1423c16cd0c04e6bb0d6c6706a5b0cf9','88888','8888888','2019-11-28 18:25:17'),('15','22222222','3333333333333333333333','2018-02-02 21:45:57'),('16','通知标题1','通知内容1','2018-02-03 11:41:39'),('17','通知标题2','通知内容2','2018-02-03 11:52:37'),('18','通知标题3','通知内容3','2018-02-03 12:19:41'),('3eaed66655ff48ce81a89dbd2b53c333','王朝','马汉','2019-11-19 14:30:50'),('6c4c501c5cc1496f878f094d91a57d8d','111','1111111','2019-11-20 08:58:27'),('a7e7a318a0464427a28a6849aa50d251','天天','抽下','2019-11-25 15:09:44'),('aaae5ad7c0484c4da75f88b71a7d9c90','11111','111111','2019-11-19 13:20:51');

/*Table structure for table `i_tb_nation` */

DROP TABLE IF EXISTS `i_tb_nation`;

CREATE TABLE `i_tb_nation` (
  `n_id` int(11) NOT NULL AUTO_INCREMENT,
  `n_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_nation` */

insert  into `i_tb_nation`(`n_id`,`n_name`) values (1,'汉族'),(2,'蒙古族'),(3,'回族'),(4,'藏族'),(5,'维吾尔族'),(6,'苗族'),(7,'彝族'),(8,'壮族'),(9,'布依族'),(10,'朝鲜族'),(11,'满族'),(12,'侗族'),(13,'瑶族'),(14,'白族'),(15,'土家族'),(16,'哈尼族'),(17,'哈萨克族'),(18,'傣族'),(19,'黎族'),(20,'傈僳族'),(21,'佤族'),(22,'畲族'),(23,'高山族'),(24,'拉祜族'),(25,'水族'),(26,'东乡族'),(27,'纳西族'),(28,'景颇族'),(29,'柯尔克孜族'),(30,'土族'),(31,'达斡尔族'),(32,'仫佬族'),(33,'羌族'),(34,'布朗族'),(35,'撒拉族'),(36,'毛难族'),(37,'仡佬族'),(38,'锡伯族'),(39,'阿昌族'),(40,'普米族'),(41,'塔吉克族'),(42,'怒族'),(43,'乌孜别克族'),(44,'俄罗斯族'),(45,'鄂温克族'),(46,'崩龙族'),(47,'保安族'),(48,'裕固族'),(49,'京族'),(50,'塔塔尔族'),(51,'独龙族'),(52,'鄂伦春族'),(53,'赫哲族'),(54,'门巴族'),(55,'珞巴族'),(56,'基诺族');

/*Table structure for table `i_tb_oplog` */

DROP TABLE IF EXISTS `i_tb_oplog`;

CREATE TABLE `i_tb_oplog` (
  `o_uid` varchar(32) NOT NULL,
  `o_addDate` date DEFAULT NULL COMMENT '添加日期',
  `o_operate` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `o_userid` varchar(32) DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`o_uid`),
  KEY `fk_oplog_user` (`o_userid`),
  CONSTRAINT `fk_oplog_user` FOREIGN KEY (`o_userid`) REFERENCES `i_tb_user` (`u_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_oplog` */

/*Table structure for table `i_tb_politicsstatus` */

DROP TABLE IF EXISTS `i_tb_politicsstatus`;

CREATE TABLE `i_tb_politicsstatus` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_politicsstatus` */

insert  into `i_tb_politicsstatus`(`p_id`,`p_name`) values (1,'中共党员'),(2,'中共预备党员'),(3,'共青团员'),(4,'民革党员'),(5,'民盟盟员'),(6,'民建会员'),(7,'民进会员'),(8,'农工党党员'),(9,'致公党党员'),(10,'九三学社社员'),(11,'台盟盟员'),(12,'无党派民主人士'),(13,'普通公民');

/*Table structure for table `i_tb_position` */

DROP TABLE IF EXISTS `i_tb_position`;

CREATE TABLE `i_tb_position` (
  `p_uid` varchar(32) NOT NULL,
  `p_name` varchar(32) DEFAULT NULL COMMENT '职位',
  `p_createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `p_enabled` tinyint(1) DEFAULT '1' COMMENT '启用位',
  PRIMARY KEY (`p_uid`),
  UNIQUE KEY `p_name` (`p_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_position` */

insert  into `i_tb_position`(`p_uid`,`p_name`,`p_createDate`,`p_enabled`) values ('29','技术总监','2018-01-11 21:13:42',1),('30','运营总监','2018-01-11 21:13:48',1),('31','市场总监','2018-01-11 21:13:56',1),('32','总经理','2018-01-11 21:35:07',1),('33','研发工程师','2018-01-14 16:07:11',1),('34','运维工程师','2018-01-14 16:11:41',1);

/*Table structure for table `i_tb_role` */

DROP TABLE IF EXISTS `i_tb_role`;

CREATE TABLE `i_tb_role` (
  `r_uid` varchar(32) NOT NULL COMMENT '角色UUID',
  `r_name` varchar(64) DEFAULT NULL COMMENT '角色的英文称',
  `r_nameZh` varchar(64) DEFAULT NULL COMMENT '角色的中文名称',
  `r_description` varchar(255) DEFAULT NULL COMMENT '角色的描述',
  PRIMARY KEY (`r_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_role` */

insert  into `i_tb_role`(`r_uid`,`r_name`,`r_nameZh`,`r_description`) values ('0af7525ac0f741fea75ca2d51429fc38','test3','测试角色3',NULL),('1','ROLE_manager','部门经理','管理一个部门'),('13','ROLE_test2','测试角色2','描述'),('14','ROLE_test1','测试角色1','描述'),('2','ROLE_personnel','人事专员','管理人事调动'),('3','ROLE_recruiter','招聘主管','招聘员工'),('4','ROLE_train','培训主管','培训员工'),('5','ROLE_performance','薪酬绩效主管','发放工资'),('6','ROLE_admin','系统管理员','管理系统'),('7','ROLE_common','普通员工','万年码农'),('7f6fb3e6173b412e853dc92669206341','produPM','產品經理',NULL);

/*Table structure for table `i_tb_role_meau` */

DROP TABLE IF EXISTS `i_tb_role_meau`;

CREATE TABLE `i_tb_role_meau` (
  `r_m_uid` varchar(32) NOT NULL COMMENT 'UUID',
  `r_m_roleid` varchar(32) DEFAULT NULL COMMENT '角色UID',
  `r_m_meauid` varchar(32) DEFAULT NULL COMMENT '权限UID',
  PRIMARY KEY (`r_m_uid`),
  KEY `fk_role_meau_meau` (`r_m_meauid`),
  KEY `fk_role_meau_role` (`r_m_roleid`),
  CONSTRAINT `fk_role_meau_meau` FOREIGN KEY (`r_m_meauid`) REFERENCES `i_tb_menu` (`m_uid`),
  CONSTRAINT `fk_role_meau_role` FOREIGN KEY (`r_m_roleid`) REFERENCES `i_tb_role` (`r_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_role_meau` */

insert  into `i_tb_role_meau`(`r_m_uid`,`r_m_roleid`,`r_m_meauid`) values ('10fb992bd9b04f56aacbeb9dc6ce5633','6','13'),('1207fac6ab914056a2db0e4b341bc1d2','7','8'),('1280d15ae30741178efc7206329939b0','6','7'),('1577daae03db441491b009686cb8e5bf','6','26'),('17a15a1ce0c744e5a82039f7d174ab12','13','23'),('1d4f62e249e5436f94b61fd8b3a7dfac','2','10'),('2003d0113e364505882378d0aa88b198','5','23'),('205ffc5dbe7941d2a11b1645462e14e0','6','27'),('247','4','7'),('248','4','8'),('249','4','11'),('2994b1419522406cbd17fc8dc7784159','7f6fb3e6173b412e853dc92669206341','16'),('2fd8749d0be34827b192c78d340a3f51','1','14'),('3247f5ea70e143299b72610ccbe5881d','1','19'),('3402e5fcbd164497ab8a5d4c2a232034','1','15'),('4056502ac13f4281b7a3d321ae767d2d','7f6fb3e6173b412e853dc92669206341','15'),('4241b9e6aa0c4202aeb4d22dd2e57054','6','23'),('4259690601e34e15907ed28ddecb9537','2','23'),('46cf8dfce5a74afe9e6817f017c115d1','7f6fb3e6173b412e853dc92669206341','11'),('4710778dffb644af9b069ee802b43210','1','22'),('47e91f207165480ca2ae8d6d5831212a','6','19'),('4adef913cbee4f90aadc1cef3aa297f4','6','14'),('58296fc89b8c47648bcb20a53cc918c0','7f6fb3e6173b412e853dc92669206341','14'),('58d690711e344fd281cdce89b11e5db4','1','16'),('637c4fe45f2846728bbb3cf0626804b6','6','8'),('68e92bd0711b4fbaa6877bb812c661e8','7f6fb3e6173b412e853dc92669206341','27'),('6f56521b7fbd4fb8b903976af1305571','7','28'),('711f626bc24c4536ac11ce4a3dd00398','7','27'),('72d610262ad64f9cbb995cdc8283e410','13','26'),('7414cb391c974fb59f1e32c2a1765b07','6','11'),('792384823e87497ca2c7e52ffd942da8','6','21'),('792c51970d2d402890b48fb259dcc333','6','12'),('82562bd4ce6e4b7ba438997ba7d1c186','13','7'),('8bbc36b995164b4a8d9628000c82f794','6','22'),('8e23633e1edd444399dcb22df8cebf95','6','15'),('93731c294d3f4d3db75bb961a3559b53','1','26'),('9b98e30e2f8d4a7292f23f0b86c6e744','1','21'),('9fcf3c2b8566436aa97f82da8a9bf30c','6','9'),('a300e5b3d94c49e4b500dc9149a3c298','2','12'),('a3f623e2feda435d86327b32440a3a44','13','14'),('ab6b960eca614a229d18abed7c510013','1','10'),('b7d996dc148e4847a11ae8b622c14a2f','1','12'),('b83874e407c04a428f1554ab2f3fc2d8','1','28'),('c17563e989054a6eb4fcbe49b048ca2a','1','27'),('c4b68e21d53f4445bdf88466da6411c3','7f6fb3e6173b412e853dc92669206341','8'),('ccbc7eb4ae304334b4c8369ee1b21975','1','11'),('cd8e33441656439abb83f8db533153a2','7f6fb3e6173b412e853dc92669206341','10'),('d7686bc792c544819b48c522bb553576','1','7'),('d829fb71eb094b68997d3a761c125f37','2','8'),('e371411bf2cf4ab6ae91de0cf47b0d93','1','23'),('e4f66e257f024dd6a11d9175bd579eec','6','16'),('f020365f406a48b1a14460a1b29b69db','6','28'),('f1aba936cb894bdfab6da859d824ff68','6','10'),('f46944e9af0e483fa6b8ed925b781ec9','7f6fb3e6173b412e853dc92669206341','13'),('f5b3a2597b9e4a39a5ae08b9331acb8c','5','26'),('fa8a8dd1567d455abe21a7ef0400faa7','1','13'),('fb3db197a36b4a3d93840fbcde97bd09','2','7'),('fe89b7fe950e428da5a8191908563b1a','2','26');

/*Table structure for table `i_tb_salary` */

DROP TABLE IF EXISTS `i_tb_salary`;

CREATE TABLE `i_tb_salary` (
  `s_uid` varchar(32) NOT NULL COMMENT 'UUID',
  `basicSalary` int(11) DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) DEFAULT NULL COMMENT '午餐餐补',
  `trafficSalary` int(11) DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) DEFAULT NULL COMMENT '应发工资',
  `pensionBase` int(11) DEFAULT NULL COMMENT '养老金基数',
  `pensionPer` float DEFAULT NULL COMMENT '养老金比率',
  `createDate` timestamp NULL DEFAULT NULL COMMENT '启用时间',
  `medicalBase` int(11) DEFAULT NULL COMMENT '医疗基数',
  `medialPer` float DEFAULT NULL COMMENT '医疗保险比率',
  `accumulationFundBase` int(11) DEFAULT NULL COMMENT '公积金基数',
  `accumulationFundPer` float DEFAULT NULL COMMENT '公积金比率',
  `name` varchar(32) DEFAULT NULL COMMENT '工资名字',
  PRIMARY KEY (`s_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_salary` */

insert  into `i_tb_salary`(`s_uid`,`basicSalary`,`bonus`,`lunchSalary`,`trafficSalary`,`allSalary`,`pensionBase`,`pensionPer`,`createDate`,`medicalBase`,`medialPer`,`accumulationFundBase`,`accumulationFundPer`,`name`) values ('10',3000,2000,400,1000,0,2000,0.07,'2018-01-01 00:00:00',2000,0.07,2000,0.07,'人事部工资账套'),('13',10000,3000,500,500,NULL,4000,0.07,'2018-01-25 00:00:00',4000,0.07,4000,0.07,'运维部工资账套'),('9',9000,4000,800,500,NULL,2000,0.07,'2018-01-24 00:00:00',2000,0.07,2000,0.07,'市场部工资账套');

/*Table structure for table `i_tb_sysmsg` */

DROP TABLE IF EXISTS `i_tb_sysmsg`;

CREATE TABLE `i_tb_sysmsg` (
  `s_uid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'UUID',
  `s_msgid` varchar(32) DEFAULT NULL COMMENT '消息id',
  `s_type` tinyint(1) DEFAULT NULL COMMENT '消息的类型',
  `s_userid` varchar(32) DEFAULT NULL COMMENT '消息接收人',
  `s_state` int(11) DEFAULT NULL COMMENT '消息的状态',
  PRIMARY KEY (`s_uid`),
  KEY `fk_sysmsg_meau` (`s_msgid`),
  KEY `fk_sysmsg_role` (`s_userid`),
  CONSTRAINT `fk_sysmsg_meau` FOREIGN KEY (`s_msgid`) REFERENCES `i_tb_msgcontent` (`m_uid`),
  CONSTRAINT `fk_sysmsg_role` FOREIGN KEY (`s_userid`) REFERENCES `i_tb_user` (`u_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_sysmsg` */

insert  into `i_tb_sysmsg`(`s_uid`,`s_msgid`,`s_type`,`s_userid`,`s_state`) values (57,'14',0,'001',1),(58,'14',0,'002',1),(59,'14',0,'003',1),(60,'14',0,'004',0),(61,'14',0,'005',0),(62,'15',0,'001',1),(63,'15',0,'002',1),(64,'15',0,'003',1),(65,'15',0,'004',0),(66,'15',0,'005',0),(67,'16',0,'001',1),(68,'16',0,'002',1),(69,'16',0,'003',1),(70,'16',0,'004',0),(71,'16',0,'005',0),(72,'17',0,'001',1),(73,'17',0,'002',1),(74,'17',0,'003',1),(75,'17',0,'004',0),(76,'17',0,'005',0),(77,'18',0,'001',1),(78,'18',0,'002',0),(79,'18',0,'003',0),(80,'18',0,'004',0),(81,'18',0,'005',0),(82,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'001',1),(83,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'002',NULL),(84,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'003',NULL),(85,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'004',NULL),(86,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'005',NULL),(87,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'006',NULL),(88,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'007',NULL),(89,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'008',NULL),(90,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'009',NULL),(91,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'010',NULL),(92,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'011',NULL),(93,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'012',NULL),(94,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'013',NULL),(95,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'014',NULL),(96,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'015',NULL),(97,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'016',NULL),(98,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'017',NULL),(99,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'018',NULL),(100,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'019',NULL),(101,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'020',NULL),(102,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'021',NULL),(103,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'022',NULL),(104,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'023',NULL),(105,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'024',NULL),(106,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'025',NULL),(107,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'026',NULL),(108,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'027',NULL),(109,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'028',NULL),(110,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'029',NULL),(111,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'030',NULL),(112,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'031',NULL),(113,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'032',NULL),(114,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'033',NULL),(115,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'034',NULL),(116,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'035',NULL),(117,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'036',NULL),(118,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'037',NULL),(119,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'038',NULL),(120,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'039',NULL),(121,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'040',NULL),(122,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'041',NULL),(123,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'042',NULL),(124,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'043',NULL),(125,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'044',NULL),(126,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'045',NULL),(127,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'046',NULL),(128,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'047',NULL),(129,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'048',NULL),(130,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'049',NULL),(131,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'050',NULL),(132,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'051',NULL),(133,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'052',NULL),(134,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'053',NULL),(135,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'054',NULL),(136,'aaae5ad7c0484c4da75f88b71a7d9c90',NULL,'055',NULL),(137,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'001',1),(138,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'002',NULL),(139,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'003',NULL),(140,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'004',NULL),(141,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'005',NULL),(142,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'006',1),(143,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'007',NULL),(144,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'008',NULL),(145,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'009',NULL),(146,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'010',NULL),(147,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'011',NULL),(148,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'012',NULL),(149,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'013',NULL),(150,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'014',NULL),(151,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'015',NULL),(152,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'016',NULL),(153,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'017',NULL),(154,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'018',NULL),(155,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'019',NULL),(156,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'020',NULL),(157,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'021',NULL),(158,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'022',NULL),(159,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'023',NULL),(160,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'024',NULL),(161,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'025',NULL),(162,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'026',NULL),(163,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'027',NULL),(164,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'028',NULL),(165,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'029',NULL),(166,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'030',NULL),(167,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'031',NULL),(168,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'032',NULL),(169,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'033',NULL),(170,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'034',NULL),(171,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'035',NULL),(172,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'036',NULL),(173,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'037',NULL),(174,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'038',NULL),(175,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'039',NULL),(176,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'040',NULL),(177,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'041',NULL),(178,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'042',NULL),(179,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'043',NULL),(180,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'044',NULL),(181,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'045',NULL),(182,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'046',NULL),(183,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'047',NULL),(184,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'048',NULL),(185,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'049',NULL),(186,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'050',NULL),(187,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'051',NULL),(188,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'052',NULL),(189,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'053',NULL),(190,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'054',NULL),(191,'3eaed66655ff48ce81a89dbd2b53c333',NULL,'055',NULL),(192,'6c4c501c5cc1496f878f094d91a57d8d',NULL,'001',1),(193,'6c4c501c5cc1496f878f094d91a57d8d',NULL,'002',NULL),(194,'6c4c501c5cc1496f878f094d91a57d8d',NULL,'003',NULL),(195,'6c4c501c5cc1496f878f094d91a57d8d',NULL,'004',NULL),(196,'6c4c501c5cc1496f878f094d91a57d8d',NULL,'005',NULL),(197,'a7e7a318a0464427a28a6849aa50d251',NULL,'001',1),(198,'a7e7a318a0464427a28a6849aa50d251',NULL,'002',NULL),(199,'a7e7a318a0464427a28a6849aa50d251',NULL,'003',NULL),(200,'a7e7a318a0464427a28a6849aa50d251',NULL,'004',NULL),(201,'a7e7a318a0464427a28a6849aa50d251',NULL,'005',NULL),(202,'a7e7a318a0464427a28a6849aa50d251',NULL,'207dfbbb126745e4b1e5e8fb08714ab7',NULL),(203,'a7e7a318a0464427a28a6849aa50d251',NULL,'22345a0989ed4afb9cbb2ca56e0dca5d',NULL),(204,'a7e7a318a0464427a28a6849aa50d251',NULL,'314be6447bb94312a70504c0b4e4c224',1),(205,'a7e7a318a0464427a28a6849aa50d251',NULL,'460161a4ad4a47a8b4cd55563608b48d',NULL),(206,'a7e7a318a0464427a28a6849aa50d251',NULL,'765e1a3d37294bee97c67fb1b263928e',NULL),(207,'02cb4934644d42f68afda8e115771e1e',NULL,'001',NULL),(208,'02cb4934644d42f68afda8e115771e1e',NULL,'002',1),(209,'02cb4934644d42f68afda8e115771e1e',NULL,'003',NULL),(210,'02cb4934644d42f68afda8e115771e1e',NULL,'004',NULL),(211,'02cb4934644d42f68afda8e115771e1e',NULL,'005',NULL),(212,'02cb4934644d42f68afda8e115771e1e',NULL,'22345a0989ed4afb9cbb2ca56e0dca5d',NULL),(213,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'001',NULL),(214,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'002',NULL),(215,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'003',NULL),(216,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'004',NULL),(217,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'005',NULL),(218,'1423c16cd0c04e6bb0d6c6706a5b0cf9',NULL,'22345a0989ed4afb9cbb2ca56e0dca5d',NULL);

/*Table structure for table `i_tb_user` */

DROP TABLE IF EXISTS `i_tb_user`;

CREATE TABLE `i_tb_user` (
  `u_uid` varchar(32) NOT NULL COMMENT '用户UUID',
  `u_real_name` varchar(32) DEFAULT NULL COMMENT '用户真实姓名',
  `u_nickname` varchar(32) DEFAULT NULL COMMENT '用户昵称',
  `u_password` varchar(32) DEFAULT NULL COMMENT '用户密码',
  `u_gender` char(4) DEFAULT NULL COMMENT '用户性别',
  `u_birthday` date DEFAULT NULL COMMENT '出生日期',
  `u_wedlock` enum('已婚','未婚','离异') DEFAULT NULL COMMENT '婚姻状况',
  `u_nationId` int(11) DEFAULT NULL COMMENT '民族',
  `u_nativePlace` varchar(20) DEFAULT NULL COMMENT '籍贯',
  `u_politicId` int(11) DEFAULT NULL COMMENT '政治面貌UId',
  `u_departmentId` int(11) DEFAULT NULL COMMENT '部门Id',
  `u_joblevelId` varchar(32) DEFAULT NULL COMMENT '职称Id',
  `u_posId` varchar(32) DEFAULT NULL COMMENT '职位Id',
  `u_engageForm` varchar(8) DEFAULT NULL COMMENT '聘用形式',
  `u_specialty` varchar(32) DEFAULT NULL COMMENT '从事专业',
  `u_tiptopDegree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') DEFAULT NULL COMMENT '最高学历',
  `u_school` varchar(32) DEFAULT NULL COMMENT '毕业院校',
  `u_beginDate` date DEFAULT NULL COMMENT '入职时间',
  `u_workId` char(8) DEFAULT NULL COMMENT '工号',
  `u_contractTerm` double DEFAULT NULL COMMENT '合同期限',
  `u_beginContract` date DEFAULT NULL COMMENT '合同起始日期',
  `u_endContract` date DEFAULT NULL COMMENT '合同终止日期',
  `u_conversionTime` date DEFAULT NULL COMMENT '转正日期',
  `u_notWorkDate` date DEFAULT NULL COMMENT '离职日期',
  `u_workAge` int(11) DEFAULT NULL COMMENT '工龄',
  `u_phone` char(11) DEFAULT NULL COMMENT '联系电话',
  `u_mail` varchar(255) DEFAULT NULL COMMENT '用户邮箱',
  `u_idcard` varchar(125) DEFAULT NULL COMMENT '用户身份证号',
  `u_address` varchar(255) DEFAULT NULL COMMENT '用户地址',
  `u_state` int(11) DEFAULT '1' COMMENT '员工的状态',
  `u_userface` varchar(250) DEFAULT NULL COMMENT '用户个人主页',
  `u_remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `u_employeeState` int(11) DEFAULT '1' COMMENT '公司职员当前的状态',
  PRIMARY KEY (`u_uid`),
  KEY `user_ibfk_1` (`u_departmentId`),
  KEY `user_ibfk_2` (`u_joblevelId`),
  KEY `user_ibfk_3` (`u_posId`),
  KEY `user_ibfk_4` (`u_nationId`),
  KEY `user_ibfk_5` (`u_politicId`),
  KEY `user_ibfk_6` (`u_state`),
  KEY `user_ibfk_7` (`u_employeeState`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`u_departmentId`) REFERENCES `i_tb_department` (`d_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`u_joblevelId`) REFERENCES `i_tb_joblevel` (`j_uid`),
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`u_posId`) REFERENCES `i_tb_position` (`p_uid`),
  CONSTRAINT `user_ibfk_4` FOREIGN KEY (`u_nationId`) REFERENCES `i_tb_nation` (`n_id`),
  CONSTRAINT `user_ibfk_5` FOREIGN KEY (`u_politicId`) REFERENCES `i_tb_politicsstatus` (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_user` */

insert  into `i_tb_user`(`u_uid`,`u_real_name`,`u_nickname`,`u_password`,`u_gender`,`u_birthday`,`u_wedlock`,`u_nationId`,`u_nativePlace`,`u_politicId`,`u_departmentId`,`u_joblevelId`,`u_posId`,`u_engageForm`,`u_specialty`,`u_tiptopDegree`,`u_school`,`u_beginDate`,`u_workId`,`u_contractTerm`,`u_beginContract`,`u_endContract`,`u_conversionTime`,`u_notWorkDate`,`u_workAge`,`u_phone`,`u_mail`,`u_idcard`,`u_address`,`u_state`,`u_userface`,`u_remark`,`u_employeeState`) values ('001','张六','zhangsan','9521d1d68a53a70a2d32a16359c6a3cc','男','1998-10-29','未婚',2,'江西',1,4,'2','29','劳动合同','软件开发','本科','南昌航空大学','2019-10-31','0001',0,'2019-11-24','2019-11-24','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('002','李四','lisi','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'海南',2,4,'3','29','劳务合同','通信工程','本科','武汉大学','2019-10-31','0002',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('003','陈静','chenjing','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',2,'河南',3,8,'4','29','劳动合同','电子工程','本科','西北大学','2019-10-31','0003',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('004','姚森','yaosen','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'陕西',1,78,'5','29','劳务合同','软件开发','本科','深圳大学','2019-10-31','0004',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('005','云星','yunxing','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','离异',1,'广东',3,81,'6','29','劳动合同','市场营销','本科','西安电子科技大学','2019-10-31','0005',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('006','赵琳浩','zhaolinhao','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',3,'福建',4,1,'2','29','劳务合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0006',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('007','鹿存亮','lucunliang','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'上海',1,85,'3','29','劳动合同','市场营销','本科','清华大学','2019-10-31','0007',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('008','贾旭明','jiaxuming','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'江苏',1,86,'4','29','劳务合同','通信工程','本科','南昌大学','2019-10-31','0008',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('009','张黎明','zhangliming','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'湖南',6,87,'5','29','劳动合同','电子工程','本科','江西农业大学','2019-10-31','0009',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('010','薛磊','xuelei','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',4,'北京',6,89,'6','29','劳务合同','通信工程','本科','华东交通大学','2019-10-31','0010',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('011','张洁','zhangjie','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',1,'安徽',7,91,'7','29','劳动合同','电子工程','本科','江西师范大学','2019-10-31','0011',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('012','张三1','zhangsan1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'江西',1,92,'8','29','劳务合同','软件开发','本科','南昌航空大学','2019-10-31','0012',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('013','李四1','lisi1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',5,'海南',8,8,'9','29','劳动合同','通信工程','本科','武汉大学','2019-10-31','0013',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('014','陈静1','chenjing1','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',1,'河南',10,78,'6','29','劳务合同','电子工程','本科','西北大学','2019-10-31','0014',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('015','姚森1','yaosen1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'陕西',13,81,'2','29','劳动合同','软件开发','本科','深圳大学','2019-10-31','0015',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('016','云星1','yunxing1','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','离异',1,'广东',13,82,'3','29','劳务合同','市场营销','本科','西安电子科技大学','2019-10-31','0016',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('017','赵琳浩1','zhaolinhao1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',3,'福建',13,85,'4','29','劳动合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0017',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('018','鹿存亮1','lucunliang1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'上海',13,86,'5','29','劳务合同','市场营销','本科','清华大学','2019-10-31','0018',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('019','贾旭明1','jiaxuming1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'江苏',13,8,'6','29','劳动合同','通信工程','本科','南昌大学','2019-10-31','0019',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('020','张黎明1','zhangliming1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'湖南',1,78,'2','29','劳务合同','电子工程','本科','江西农业大学','2019-10-31','0020',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('021','薛磊1','xuelei1','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'北京',2,81,'3','29','劳动合同','通信工程','本科','华东交通大学','2019-10-31','0021',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('022','张洁1','zhangjie1','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',4,'安徽',3,82,'4','29','劳务合同','电子工程','本科','江西师范大学','2019-10-31','0022',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('023','张三2','zhangsan2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'江西',1,85,'5','29','劳动合同','软件开发','本科','南昌航空大学','2019-10-31','0023',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('024','李四2','lisi2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',25,'海南',3,86,'6','29','劳务合同','通信工程','本科','武汉大学','2019-10-31','0024',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('025','陈静2','chenjing2','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',1,'河南',4,87,'7','29','劳动合同','电子工程','本科','西北大学','2019-10-31','0025',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('026','姚森2','yaosen2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'陕西',5,89,'8','29','劳务合同','软件开发','本科','深圳大学','2019-10-31','0026',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('027','云星2','yunxing2','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','离异',1,'广东',1,8,'2','29','劳动合同','市场营销','本科','西安电子科技大学','2019-10-31','0027',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('028','赵琳浩2','zhaolinhao2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'福建',6,78,'3','29','劳务合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0028',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('029','鹿存亮2','lucunliang2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'上海',6,81,'4','29','劳动合同','市场营销','本科','清华大学','2019-10-31','0029',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('030','贾旭明2','jiaxuming2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',25,'江苏',7,82,'5','29','劳务合同','通信工程','本科','南昌大学','2019-10-31','0030',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('031','张黎明2','zhangliming2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'湖南',1,85,'2','29','劳动合同','电子工程','本科','江西农业大学','2019-10-31','0031',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('032','薛磊2','xuelei2','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'北京',8,86,'3','29','劳务合同','通信工程','本科','华东交通大学','2019-10-31','0032',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('033','张洁2','zhangjie2','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',36,'安徽',10,87,'4','29','劳动合同','电子工程','本科','江西师范大学','2019-10-31','0033',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('034','张三3','zhangsan3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'江西',13,8,'5','29','劳务合同','软件开发','本科','南昌航空大学','2019-10-31','0034',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('035','李四3','lisi3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'海南',13,78,'6','29','劳动合同','通信工程','本科','武汉大学','2019-10-31','0035',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('036','陈静3','chenjing3','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',2,'河南',13,81,'2','29','劳务合同','电子工程','本科','西北大学','2019-10-31','0036',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('037','姚森3','yaosen3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'陕西',13,82,'3','29','劳动合同','软件开发','本科','深圳大学','2019-10-31','0037',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('038','云星3','yunxing3','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','离异',1,'广东',13,85,'4','29','劳务合同','市场营销','本科','西安电子科技大学','2019-10-31','0038',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('039','赵琳浩3','zhaolinhao3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',3,'福建',1,86,'5','29','劳动合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0039',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('040','鹿存亮3','lucunliang3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'上海',2,87,'6','29','劳务合同','市场营销','本科','清华大学','2019-10-31','0040',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('041','贾旭明3','jiaxuming3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'江苏',3,89,'7','29','劳动合同','通信工程','本科','南昌大学','2019-10-31','0041',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('042','张黎明3','zhangliming3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'湖南',1,8,'2','29','劳务合同','电子工程','本科','江西农业大学','2019-10-31','0042',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('043','薛磊3','xuelei3','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',4,'北京',3,78,'3','29','劳动合同','通信工程','本科','华东交通大学','2019-10-31','0043',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('044','张洁3','zhangjie3','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',1,'安徽',4,81,'4','29','劳务合同','电子工程','本科','江西师范大学','2019-10-31','0044',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('045','张三4','zhangsan4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'江西',5,82,'5','29','劳动合同','软件开发','本科','南昌航空大学','2019-10-31','0045',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('046','李四4','lisi4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',5,'海南',1,85,'6','29','劳务合同','通信工程','本科','武汉大学','2019-10-31','0046',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('047','陈静4','chenjing4','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',1,'河南',6,86,'2','29','劳动合同','电子工程','本科','西北大学','2019-10-31','0047',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('048','姚森4','yaosen4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','未婚',1,'陕西',6,87,'3','29','劳务合同','软件开发','本科','深圳大学','2019-10-31','0048',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('049','云星4','yunxing4','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','离异',1,'广东',7,89,'4','29','劳动合同','市场营销','本科','西安电子科技大学','2019-10-31','0049',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('050','赵琳浩4','zhaolinhao4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',3,'福建',1,91,'5','29','劳务合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0050',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('051','鹿存亮4','lucunliang4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'上海',8,92,'2','29','劳动合同','市场营销','本科','清华大学','2019-10-31','0051',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('052','贾旭明4','jiaxuming4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'江苏',10,8,'3','29','劳务合同','通信工程','本科','南昌大学','2019-10-31','0052',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('053','张黎明4','zhangliming4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'湖南',13,78,'4','29','劳动合同','电子工程','本科','江西农业大学','2019-10-31','0053',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('054','薛磊4','xuelei4','9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',1,'北京',13,81,'5','29','劳务合同','通信工程','本科','华东交通大学','2019-10-31','0054',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com','370481199804061516','祖安省德玛西亚区',1,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('055','张洁4','zhangjie4','9521d1d68a53a70a2d32a16359c6a3cc','女','2019-10-31','未婚',4,'安徽',13,82,'2','29','劳动合同','电子工程','本科','江西师范大学','2019-10-31','0055',3,'2018-09-01','2021-09-01','2019-10-31','2019-10-31',5,'15797897170','2697431730@qq.com',NULL,NULL,0,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('207dfbbb126745e4b1e5e8fb08714ab7','张雨婷',NULL,NULL,'男','2019-10-31','已婚',1,'湖南',6,87,'3','29','劳动合同','电子工程','本科','江西农业大学','2019-10-31','0062',36,'2018-09-01','2021-09-01',NULL,NULL,NULL,'15797897170','3267311931@qq.com','370481199804061511','祖安省德玛西亚区',0,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1),('22345a0989ed4afb9cbb2ca56e0dca5d','王慎瑜',NULL,NULL,'男','2019-10-30','未婚',2,'山东',2,78,'4','31','劳动合同','软件','初中','南昌航空大学','2019-11-20','0056',0,'2019-11-10','2019-11-25','2019-11-13',NULL,NULL,'15797897170','1337116052@qq.com','370481199804061517','山东',1,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1227368255,1458372865&fm=26&gp=0.jpg',NULL,1),('314be6447bb94312a70504c0b4e4c224','袁湾',NULL,'9521d1d68a53a70a2d32a16359c6a3cc','男','2019-10-31','已婚',3,'福建',4,1,'5','29','劳务合同','市场营销','本科','哈尔滨工业大学','2019-10-31','0059',36,'2018-09-01','2021-09-01',NULL,NULL,NULL,'15797897170','562464454@qq.com','370481199804061511','祖安省德玛西亚区',0,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2890461139,704805775&fm=26&gp=0.jpg',NULL,1),('460161a4ad4a47a8b4cd55563608b48d','谷伟帅',NULL,NULL,'男','2019-10-31','已婚',1,'上海',1,85,'6','29','劳动合同','市场营销','本科','清华大学','2019-10-31','0060',36,'2018-09-01','2021-09-01',NULL,NULL,NULL,'15797897170','425044630@qq.com','370481199804061511','祖安省德玛西亚区',0,'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1938482571,2420691429&fm=26&gp=0.jpg',NULL,1),('765e1a3d37294bee97c67fb1b263928e','易青青',NULL,NULL,'男','2019-10-31','已婚',1,'江苏',1,86,'7','29','劳务合同','通信工程','本科','南昌大学','2019-10-31','0061',36,'2018-09-01','2021-09-01',NULL,NULL,NULL,'15797897170','3275838145@qq.com','370481199804061511','祖安省德玛西亚区',0,'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2098901558,128917449&fm=26&gp=0.jpg',NULL,1);

/*Table structure for table `i_tb_user_role` */

DROP TABLE IF EXISTS `i_tb_user_role`;

CREATE TABLE `i_tb_user_role` (
  `u_r_uid` varchar(32) NOT NULL COMMENT 'UUID',
  `u_r_userid` varchar(32) DEFAULT NULL COMMENT '用户UUID',
  `u_r_roleid` varchar(32) DEFAULT NULL COMMENT '角色UUID',
  `u_r_rtime` varchar(32) DEFAULT NULL COMMENT '授予时间',
  PRIMARY KEY (`u_r_uid`),
  KEY `fk_user_role_user` (`u_r_userid`),
  KEY `fk_user_role_role` (`u_r_roleid`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`u_r_roleid`) REFERENCES `i_tb_role` (`r_uid`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`u_r_userid`) REFERENCES `i_tb_user` (`u_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `i_tb_user_role` */

insert  into `i_tb_user_role`(`u_r_uid`,`u_r_userid`,`u_r_roleid`,`u_r_rtime`) values ('11','008','1','2011-05-20'),('12','045','5','2011-05-20'),('13','044','5','2011-05-20'),('14','023','5','2011-05-20'),('15','022','2','2011-05-20'),('16','032','2','2011-05-20'),('18','005','3','2011-08-20'),('19','015','3','2011-08-20'),('19d94cb8963d4103804350144526a7ed','003','6',NULL),('20','021','3','2011-10-20'),('22','030','6','2011-05-20'),('238a52ef8f2d4ca9a0749ad6359196f7','004','6',NULL),('31095f8a825441d0a04f1e9d08cbeb82','002','2',NULL),('33','011','4','2011-05-20'),('34','033','4','2011-09-20'),('35','035','4','2011-09-20'),('36','006','7','2011-09-20'),('37','007','7','2011-09-20'),('38','008','7','2019-09-20'),('39','009','7','2019-09-20'),('40','010','7','2019-09-20'),('41','011','7','2019-09-20'),('42','012','7','2019-09-20'),('43','013','7','2019-09-20'),('44','014','7','2019-09-20'),('45','015','7','2019-09-20'),('46','016','7','2019-09-20'),('47','017','7','2019-09-20'),('49','018','7','2019-09-20'),('50','019','7','2019-09-20'),('51','020','7','2019-09-20'),('52','021','7','2019-09-20'),('53','022','7','2019-09-20'),('54','023','7','2019-09-20'),('55','024','7','2019-09-20'),('56','025','7','2019-09-20'),('57','026','7','2019-09-20'),('58','027','7','2019-09-20'),('59','028','7','2019-09-20'),('60','029','7','2019-09-20'),('61','030','7','2019-09-20'),('62','031','7','2019-09-20'),('63','032','7','2019-09-20'),('64','033','7','2019-09-20'),('65','034','7','2019-09-20'),('66','035','7','2019-09-20'),('67','036','7','2019-09-20'),('68','037','7','2019-09-20'),('69','038','7','2019-09-20'),('70','039','7','2019-09-20'),('71','040','7','2019-09-20'),('73','041','7','2019-09-20'),('74','042','7','2019-09-20'),('75','043','7','2019-09-20'),('76','044','7','2019-09-20'),('77','045','7','2019-09-20'),('78','046','7','2019-09-20'),('79','047','7','2019-09-20'),('80','048','7','2019-09-20'),('81','049','7','2019-09-20'),('82','050','7','2019-09-20'),('83','051','7','2019-09-20'),('84','052','7','2019-09-20'),('85','053','7','2019-09-20'),('86','054','7','2019-09-20'),('87','055','7','2019-09-20'),('88','001','6','2019-09-20'),('8ac57cc13f4b485ba99f8be7b9508180','314be6447bb94312a70504c0b4e4c224','7f6fb3e6173b412e853dc92669206341',NULL),('a0938bf8435e4daea4fd5d5b1eceeaab','002','6',NULL),('c5e497d11b3e4d2ea5f00778b50d6542','22345a0989ed4afb9cbb2ca56e0dca5d','6',NULL);

/* Procedure structure for procedure `addDep` */

/*!50003 DROP PROCEDURE IF EXISTS  `addDep` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
    declare did int;
    declare pDepPath varchar(64);
    insert into i_tb_department set d_name=depName,d_parentId=parentId,d_enabled=enabled;
    select row_count() into result;
    select last_insert_id() into did;
    set result2=did;
    select d_depPath into pDepPath from i_tb_department where d_id=parentId;
    update i_tb_department set d_depPath=concat(pDepPath,'.',did) where d_id=did;
    update i_tb_department set d_isParent=true where d_id=parentId;
  end */$$
DELIMITER ;

/* Procedure structure for procedure `deleteDep` */

/*!50003 DROP PROCEDURE IF EXISTS  `deleteDep` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
    declare ecount int;
    declare pid int;
    declare pcount int;
    select count(*) into ecount from i_tb_user where u_departmentId=did;
    if ecount>0 then set result=-1;
    else
      select d_parentId into pid from d_department where d_id=did;
      delete from d_department where d_id=did and d_isParent=false;
      select row_count() into result;
      select count(*) into pcount from d_department where d_parentId=pid;
      if pcount=0 then update d_department set d_isParent=false where d_id=pid;
      end if;
    end if;
  end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
