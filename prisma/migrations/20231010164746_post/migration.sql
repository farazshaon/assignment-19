/*
  Warnings:

  - The primary key for the `post` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `description` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `post` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `post` table. The data in that column could be lost. The data in that column will be cast from `Int` to `UnsignedBigInt`.
  - You are about to alter the column `title` on the `post` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(75)`.
  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `password` on the `user` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `user` table. The data in that column could be lost. The data in that column will be cast from `Int` to `UnsignedBigInt`.
  - You are about to alter the column `email` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(50)`.
  - You are about to drop the `comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `employee` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `profile` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[authorId]` on the table `post` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[parentId]` on the table `post` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `authorId` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `content` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `metaTitle` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `parentId` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `published` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `slug` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `summary` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `intro` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `middleName` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mobile` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `passwordHash` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `profile` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `comment_post_id_fkey`;

-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `comment_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `post` DROP FOREIGN KEY `post_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `profile` DROP FOREIGN KEY `profile_user_id_fkey`;

-- DropIndex
DROP INDEX `user_email_key` ON `user`;

-- AlterTable
ALTER TABLE `post` DROP PRIMARY KEY,
    DROP COLUMN `description`,
    DROP COLUMN `user_id`,
    ADD COLUMN `authorId` BIGINT UNSIGNED NOT NULL,
    ADD COLUMN `content` TEXT NOT NULL,
    ADD COLUMN `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    ADD COLUMN `metaTitle` VARCHAR(100) NOT NULL,
    ADD COLUMN `parentId` BIGINT UNSIGNED NOT NULL,
    ADD COLUMN `published` BOOLEAN NOT NULL,
    ADD COLUMN `publishedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    ADD COLUMN `slug` VARCHAR(100) NOT NULL,
    ADD COLUMN `summary` TINYTEXT NOT NULL,
    ADD COLUMN `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `title` VARCHAR(75) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `password`,
    ADD COLUMN `firstName` VARCHAR(50) NOT NULL,
    ADD COLUMN `intro` TINYTEXT NOT NULL,
    ADD COLUMN `lastLogin` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    ADD COLUMN `lastName` VARCHAR(50) NOT NULL,
    ADD COLUMN `middleName` VARCHAR(50) NOT NULL,
    ADD COLUMN `mobile` VARCHAR(15) NOT NULL,
    ADD COLUMN `passwordHash` VARCHAR(32) NOT NULL,
    ADD COLUMN `profile` TEXT NOT NULL,
    ADD COLUMN `registerAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    MODIFY `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MODIFY `email` VARCHAR(50) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `comment`;

-- DropTable
DROP TABLE `employee`;

-- DropTable
DROP TABLE `profile`;

-- CreateTable
CREATE TABLE `post_comment` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `postId` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `published` BOOLEAN NOT NULL,
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `publishedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `context` TEXT NOT NULL,

    UNIQUE INDEX `post_comment_postId_key`(`postId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_category` (
    `postId` BIGINT UNSIGNED NOT NULL,
    `categoryId` BIGINT UNSIGNED NOT NULL,

    UNIQUE INDEX `post_category_postId_key`(`postId`),
    UNIQUE INDEX `post_category_categoryId_key`(`categoryId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `parentId` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(75) NOT NULL,
    `metaTitle` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,

    UNIQUE INDEX `category_parentId_key`(`parentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tag` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(75) NOT NULL,
    `metaTitle` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_tag` (
    `postId` BIGINT UNSIGNED NOT NULL,
    `tagId` BIGINT UNSIGNED NOT NULL,

    UNIQUE INDEX `post_tag_postId_key`(`postId`),
    UNIQUE INDEX `post_tag_tagId_key`(`tagId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_meta` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `postId` BIGINT UNSIGNED NOT NULL,
    `key` VARCHAR(50) NOT NULL,
    `content` TEXT NOT NULL,

    UNIQUE INDEX `post_meta_postId_key`(`postId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `post_authorId_key` ON `post`(`authorId`);

-- CreateIndex
CREATE UNIQUE INDEX `post_parentId_key` ON `post`(`parentId`);
