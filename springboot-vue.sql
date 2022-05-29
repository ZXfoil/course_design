/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : springboot-vue

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 29/05/2022 10:13:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '书名',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '出版日期',
  `lend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否出借',
  `borrower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '借书人',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '你', 5.00, '我', '2022-05-11 00:00:00', '出借中', '他', 'http://localhost:9090/files/4dc674b6aac94c5893eeb76e6b86cca6');
INSERT INTO `book` VALUES (2, '椰羊', 5.00, '王小美', '2021-05-01 00:00:00', '出借中', '我', 'http://localhost:9090/files/edf5983630cd4850a7f1c75248f75b23');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (2, '震惊', '<p>zhenjing</p>', '椰羊', '2022-05-28 00:00:00');
INSERT INTO `news` VALUES (3, 'asdf', '<p>asdf</p>', 'asdf', '2022-05-28 16:01:28');
INSERT INTO `news` VALUES (4, '我不想报pat', '<p>pat题目不行，没有用</p>', 'zxfoil', '2022-05-28 19:34:01');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '住址',
  `role` int NULL DEFAULT NULL COMMENT '角色，1为管理员，2为用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'qwer', NULL, 'qwer', 123, '不愿透露', 'asdf', 1);
INSERT INTO `user` VALUES (2, 'asdf', 'asdf', 'asdf', 1243, '男', 'asdf', 1);
INSERT INTO `user` VALUES (3, 'zxb', '123456', 'zxfoil', 20, '男', '127.0.0.0', 1);
INSERT INTO `user` VALUES (4, 'a', '123456', 'a', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (5, 'b', '123456', 'b', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (6, 'c', '123456', 'c', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (7, 'd', '123456', 'd', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (8, 'e', '123456', 'e', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (9, 'f', '123456', 'f', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (10, 'g', '123456', 'g', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (11, 'h', '123456', 'h', NULL, NULL, NULL, 2);
INSERT INTO `user` VALUES (13, 'toolman', 'jsws', NULL, NULL, NULL, NULL, 2);

SET FOREIGN_KEY_CHECKS = 1;
