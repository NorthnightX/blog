/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : blog-blog

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 06/02/2024 21:56:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '博客编号',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '博客标题',
  `blogger` int NOT NULL COMMENT '创建人',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '博客封面',
  `click_count` int NULL DEFAULT 0 COMMENT '点击阅读量',
  `comment` int NULL DEFAULT NULL COMMENT '评论数量',
  `like_count` int NULL DEFAULT NULL COMMENT '喜欢',
  `stamp_count` int NULL DEFAULT NULL COMMENT '踩，反对,不喜欢',
  `collect_count` int NULL DEFAULT NULL COMMENT '收藏数量',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '博客内容',
  `type_id` int NULL DEFAULT NULL COMMENT '博客所属分类',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态（1：正常 2：停用）',
  `deleted` tinyint NOT NULL DEFAULT 1 COMMENT '逻辑删除 1（true）未删除， 0（false）已删除',
  `is_public` int NULL DEFAULT NULL COMMENT '是否公开，1：是，2：否',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for t_collect_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_collect_blog`;
CREATE TABLE `t_collect_blog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `blog_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `modify_time` datetime NULL DEFAULT NULL,
  `deleted` int NULL DEFAULT NULL COMMENT '1没删：2删了',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_like_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_like_blog`;
CREATE TABLE `t_like_blog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `is_like` int NULL DEFAULT NULL COMMENT '1:喜欢，2：反对',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
