-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema whereismyhome
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema whereismyhome
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `whereismyhome` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `whereismyhome` ;

-- -----------------------------------------------------
-- Table `whereismyhome`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`member` (
  `id` VARCHAR(20) NOT NULL,
  `pw` VARCHAR(20) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `comment` VARCHAR(20) NOT NULL DEFAULT 'Hello',
  `level` VARCHAR(20) NOT NULL,
  `register_time` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `whereismyhome`.`board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`board` (
  `article_no` INT NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(100) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`article_no`),
  INDEX `fk_board_member1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_board_member1`
    FOREIGN KEY (`id`)
    REFERENCES `whereismyhome`.`member` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `whereismyhome`.`dongcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`dongcode` (
  `dongCode` VARCHAR(10) NOT NULL,
  `sidoName` VARCHAR(30) NULL DEFAULT NULL,
  `gugunName` VARCHAR(30) NULL DEFAULT NULL,
  `dongName` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`dongCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `whereismyhome`.`bookmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`bookmark` (
  `id` VARCHAR(20) NOT NULL,
  `dongCode` VARCHAR(10) NOT NULL,
  `register_time` DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (`id`, `dongCode`),
  INDEX `fk_member_has_dongcode_dongcode1_idx` (`dongCode` ASC) VISIBLE,
  INDEX `fk_member_has_dongcode_member1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_member_has_dongcode_dongcode1`
    FOREIGN KEY (`dongCode`)
    REFERENCES `whereismyhome`.`dongcode` (`dongCode`),
  CONSTRAINT `fk_member_has_dongcode_member1`
    FOREIGN KEY (`id`)
    REFERENCES `whereismyhome`.`member` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `whereismyhome`.`houseinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`houseinfo` (
  `aptCode` BIGINT NOT NULL,
  `buildYear` INT NULL DEFAULT NULL,
  `roadName` VARCHAR(40) NULL DEFAULT NULL,
  `roadNameBonbun` VARCHAR(5) NULL DEFAULT NULL,
  `roadNameBubun` VARCHAR(5) NULL DEFAULT NULL,
  `roadNameSeq` VARCHAR(2) NULL DEFAULT NULL,
  `roadNameBasementCode` VARCHAR(1) NULL DEFAULT NULL,
  `roadNameCode` VARCHAR(7) NULL DEFAULT NULL,
  `dong` VARCHAR(40) NULL DEFAULT NULL,
  `bonbun` VARCHAR(4) NULL DEFAULT NULL,
  `bubun` VARCHAR(4) NULL DEFAULT NULL,
  `sigunguCode` VARCHAR(5) NULL DEFAULT NULL,
  `eubmyundongCode` VARCHAR(5) NULL DEFAULT NULL,
  `dongCode` VARCHAR(10) NULL DEFAULT NULL,
  `landCode` VARCHAR(1) NULL DEFAULT NULL,
  `apartmentName` VARCHAR(40) NULL DEFAULT NULL,
  `jibun` VARCHAR(10) NULL DEFAULT NULL,
  `lng` VARCHAR(30) NULL DEFAULT NULL,
  `lat` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`aptCode`),
  UNIQUE INDEX `UNIQUE` (`buildYear` ASC, `apartmentName` ASC, `jibun` ASC, `sigunguCode` ASC, `eubmyundongCode` ASC) INVISIBLE,
  INDEX `houseinfo_dongCode_dongcode_dongCode_fk_idx` (`dongCode` ASC) INVISIBLE,
  CONSTRAINT `houseinfo_dongCode_dongcode_dongCode_fk`
    FOREIGN KEY (`dongCode`)
    REFERENCES `whereismyhome`.`dongcode` (`dongCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `whereismyhome`.`housedeal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `whereismyhome`.`housedeal` (
  `no` BIGINT NOT NULL,
  `dealAmount` VARCHAR(20) NULL DEFAULT NULL,
  `dealYear` INT NULL DEFAULT NULL,
  `dealMonth` INT NULL DEFAULT NULL,
  `dealDay` INT NULL DEFAULT NULL,
  `area` VARCHAR(20) NULL DEFAULT NULL,
  `floor` VARCHAR(4) NULL DEFAULT NULL,
  `cancelDealType` VARCHAR(1) NULL DEFAULT NULL,
  `aptCode` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`no`),
  INDEX `housedeal_aptCode_houseinfo_aptCode_fk_idx` (`aptCode` ASC) VISIBLE,
  CONSTRAINT `housedeal_aptCode_houseinfo_aptCode_fk`
    FOREIGN KEY (`aptCode`)
    REFERENCES `whereismyhome`.`houseinfo` (`aptCode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into `whereismyhome`.`member`
values('admin','ssafy','admin@ssafy.com','Hello','admin');