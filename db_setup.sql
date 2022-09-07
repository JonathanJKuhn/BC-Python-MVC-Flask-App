-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema burgers_schema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `burgers_schema` ;

-- -----------------------------------------------------
-- Schema burgers_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `burgers_schema` DEFAULT CHARACTER SET utf8 ;
USE `burgers_schema` ;

-- -----------------------------------------------------
-- Table `burgers_schema`.`restaurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `burgers_schema`.`restaurants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `burgers_schema`.`burgers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `burgers_schema`.`burgers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `bun` VARCHAR(255) NULL,
  `meat` VARCHAR(255) NULL,
  `calories` INT NULL,
  `restaurant_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_burgers_users_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_burgers_users`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `burgers_schema`.`restaurants` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `burgers_schema`.`toppings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `burgers_schema`.`toppings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `topping_name` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `burgers_schema`.`add_ons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `burgers_schema`.`add_ons` (
  `burger_id` INT NOT NULL,
  `topping_id` INT NOT NULL,
  PRIMARY KEY (`burger_id`, `topping_id`),
  INDEX `fk_burgers_has_toppings_toppings1_idx` (`topping_id` ASC) VISIBLE,
  INDEX `fk_burgers_has_toppings_burgers1_idx` (`burger_id` ASC) VISIBLE,
  CONSTRAINT `fk_burgers_has_toppings_burgers1`
    FOREIGN KEY (`burger_id`)
    REFERENCES `burgers_schema`.`burgers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_burgers_has_toppings_toppings1`
    FOREIGN KEY (`topping_id`)
    REFERENCES `burgers_schema`.`toppings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
