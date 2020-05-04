-- MySQL Script generated by MySQL Workbench
-- Mon May  4 15:05:08 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vueling
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `vueling` ;

-- -----------------------------------------------------
-- Schema vueling
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vueling` DEFAULT CHARACTER SET utf8 ;
USE `vueling` ;

-- -----------------------------------------------------
-- Table `vueling`.`avions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vueling`.`avions` ;

CREATE TABLE IF NOT EXISTS `vueling`.`avions` (
  `idavions` INT UNSIGNED NOT NULL,
  `model` VARCHAR(10) NOT NULL,
  `capacitat` TINYINT(4) NOT NULL,
  PRIMARY KEY (`idavions`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vueling`.`seients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vueling`.`seients` ;

CREATE TABLE IF NOT EXISTS `vueling`.`seients` (
  `idseients` INT NOT NULL,
  `idavions` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idseients`),
  INDEX `idavions_idx` (`idavions` ASC) VISIBLE,
  CONSTRAINT `idavions`
    FOREIGN KEY (`idavions`)
    REFERENCES `vueling`.`avions` (`idavions`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `vueling`;

DELIMITER $$

USE `vueling`$$
DROP TRIGGER IF EXISTS `vueling`.`seients_BEFORE_INSERT` $$
USE `vueling`$$
CREATE DEFINER = CURRENT_USER TRIGGER `vueling`.`seients_BEFORE_INSERT` BEFORE INSERT ON `seients` FOR EACH ROW
BEGIN
if (SELECT capacitat FROM avions WHERE idavions = new.idavions) <= (select count(*) from seients where idavions = new.idavions) THEN
		signal sqlstate '45000' set message_text = 'Aquest avió ja està ple';
    end if;
END$$


DELIMITER ;
