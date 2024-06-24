-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `role` ENUM('Student', 'Instructor', 'Admin') NOT NULL DEFAULT 'Student',
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `id_UNIQUE` (`userid` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`assignments` (
  `assignmentID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT(255) NOT NULL,
  `duedate` DATETIME NULL DEFAULT current_timestamp,
  PRIMARY KEY (`assignmentID`),
  UNIQUE INDEX `assignmentID_UNIQUE` (`assignmentID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`courses` (
  `courseid` INT NOT NULL AUTO_INCREMENT,
  `courseName` VARCHAR(100) NOT NULL,
  `instructorID` INT NOT NULL,
  `users_userid` INT NOT NULL,
  `assignments_assignmentID` INT NOT NULL,
  PRIMARY KEY (`courseid`, `users_userid`, `assignments_assignmentID`),
  UNIQUE INDEX `courseid_UNIQUE` (`courseid` ASC) VISIBLE,
  UNIQUE INDEX `instructorID_UNIQUE` (`instructorID` ASC) VISIBLE,
  INDEX `fk_courses_users_idx` (`users_userid` ASC) VISIBLE,
  INDEX `fk_courses_assignments1_idx` (`assignments_assignmentID` ASC) VISIBLE,
  CONSTRAINT `fk_courses_users`
    FOREIGN KEY (`users_userid`)
    REFERENCES `mydb`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_assignments1`
    FOREIGN KEY (`assignments_assignmentID`)
    REFERENCES `mydb`.`assignments` (`assignmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
