/*
  Warnings:

  - You are about to drop the column `parentId` on the `category` table. All the data in the column will be lost.
  - You are about to drop the column `intro` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `passwordHash` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `profile` on the `user` table. All the data in the column will be lost.
  - You are about to drop the `post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `post_category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `post_comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `post_meta` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `post_tag` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tag` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `admin` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX `category_parentId_key` ON `category`;

-- AlterTable
ALTER TABLE `category` DROP COLUMN `parentId`,
    ADD COLUMN `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    ADD COLUMN `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    MODIFY `title` VARCHAR(100) NOT NULL,
    MODIFY `content` VARCHAR(100) NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `intro`,
    DROP COLUMN `passwordHash`,
    DROP COLUMN `profile`,
    ADD COLUMN `admin` BOOLEAN NOT NULL,
    ADD COLUMN `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    ADD COLUMN `password` VARCHAR(100) NOT NULL,
    ADD COLUMN `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    MODIFY `email` VARCHAR(100) NOT NULL,
    MODIFY `firstName` VARCHAR(100) NOT NULL,
    MODIFY `lastName` VARCHAR(100) NOT NULL,
    MODIFY `middleName` VARCHAR(100) NOT NULL,
    MODIFY `mobile` VARCHAR(100) NOT NULL;

-- DropTable
DROP TABLE `post`;

-- DropTable
DROP TABLE `post_category`;

-- DropTable
DROP TABLE `post_comment`;

-- DropTable
DROP TABLE `post_meta`;

-- DropTable
DROP TABLE `post_tag`;

-- DropTable
DROP TABLE `tag`;

-- CreateTable
CREATE TABLE `order` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `token` VARCHAR(100) NOT NULL,
    `subTotal` INTEGER NOT NULL,
    `itemDscount` INTEGER NOT NULL,
    `tax` INTEGER NOT NULL,
    `discount` INTEGER NOT NULL,
    `grandTotal` INTEGER NOT NULL,
    `firstName` VARCHAR(100) NOT NULL,
    `middleName` VARCHAR(100) NOT NULL,
    `lastName` VARCHAR(100) NOT NULL,
    `mobile` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `country` VARCHAR(100) NOT NULL,
    `usertid` BIGINT UNSIGNED NOT NULL,
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `metatitle` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL,
    `summary` VARCHAR(100) NOT NULL,
    `price` INTEGER NOT NULL,
    `discount` INTEGER NOT NULL,
    `usertid` BIGINT UNSIGNED NOT NULL,
    `publishedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `startAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `endAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_meta` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `key` VARCHAR(100) NOT NULL,
    `content` VARCHAR(100) NOT NULL,
    `productid` BIGINT UNSIGNED NOT NULL,
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_review` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `productid` BIGINT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `rating` VARCHAR(100) NOT NULL,
    `content` VARCHAR(100) NOT NULL,
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cart` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(75) NOT NULL,
    `sessionid` VARCHAR(100) NOT NULL,
    `token` VARCHAR(100) NOT NULL,
    `status` VARCHAR(100) NOT NULL,
    `firstName` VARCHAR(100) NOT NULL,
    `middleName` VARCHAR(100) NOT NULL,
    `lastName` VARCHAR(100) NOT NULL,
    `mobile` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `city` VARCHAR(100) NOT NULL,
    `country` VARCHAR(100) NOT NULL,
    `usertid` BIGINT UNSIGNED NOT NULL,
    `createAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updateAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_usertid_fkey` FOREIGN KEY (`usertid`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_usertid_fkey` FOREIGN KEY (`usertid`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_meta` ADD CONSTRAINT `product_meta_productid_fkey` FOREIGN KEY (`productid`) REFERENCES `product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_review` ADD CONSTRAINT `product_review_productid_fkey` FOREIGN KEY (`productid`) REFERENCES `product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `cart` ADD CONSTRAINT `cart_usertid_fkey` FOREIGN KEY (`usertid`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
