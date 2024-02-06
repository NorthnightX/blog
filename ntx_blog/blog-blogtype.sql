/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : blog-blogtype

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 06/02/2024 21:56:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog_type
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_type`;
CREATE TABLE `t_blog_type`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '博客分类编号',
  `blogger` int NULL DEFAULT NULL COMMENT '创建人',
  `name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '博客分类名称',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态（1：正常 2：停用）',
  `deleted` tinyint NOT NULL DEFAULT 1 COMMENT '逻辑删除 1（true）未删除， 0（false）已删除',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_public` int NULL DEFAULT NULL COMMENT '是否公开，1公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
