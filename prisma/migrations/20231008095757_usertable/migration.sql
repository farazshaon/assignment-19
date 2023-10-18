/*
  Warnings:

  - You are about to drop the column `post_id` on the `post` table. All the data in the column will be lost.
  - You are about to drop the column `text` on the `post` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `profile` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `description` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `title` to the `post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `profile` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `post` DROP COLUMN `post_id`,
    DROP COLUMN `text`,
    ADD COLUMN `description` LONGTEXT NOT NULL,
    ADD COLUMN `title` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `profile` ADD COLUMN `user_id` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `comment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(191) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `post_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `profile_user_id_key` ON `profile`(`user_id`);

-- AddForeignKey
ALTER TABLE `profile` ADD CONSTRAINT `profile_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `post` ADD CONSTRAINT `post_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comment` ADD CONSTRAINT `comment_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comment` ADD CONSTRAINT `comment_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
