-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nutrdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nutrdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nutrdb` DEFAULT CHARACTER SET utf8 ;
USE `nutrdb` ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Years`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Years` (
  `Y_ID` INT NOT NULL,
  `Year_Descr` INT NOT NULL,
  `FiveYSpan` INT NULL,
  `Decade` INT NULL,
  PRIMARY KEY (`Y_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nutrdb`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Countries` (
  `C_ID` INT NOT NULL,
  `C_CodeName` VARCHAR(45) NOT NULL,
  `C_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`C_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nutrdb`.`HDI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`HDI` (
  `HDI_Score` FLOAT NULL,
  `Y_ID_HDI` INT NOT NULL,
  `C_ID_HDI` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_HDI`,`C_ID_HDI`),
  CONSTRAINT `HDI_FK_Y_ID` FOREIGN KEY (`Y_ID_HDI`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `HDI_FK_C_ID` FOREIGN KEY (`C_ID_HDI`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `HDI_FK_Y_ID` ON `nutrdb`.`HDI` (`Y_ID_HDI` ASC) ;
CREATE INDEX `HDI_FK_C_ID` ON `nutrdb`.`HDI` (`C_ID_HDI` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Hapiscore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Hapiscore` (
  `WHR` FLOAT NULL,
  `Y_ID_HS` INT NOT NULL,
  `C_ID_HS` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_HS`,`C_ID_HS`),
  CONSTRAINT `HS_FK_Y_ID` FOREIGN KEY (`Y_ID_HS`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `HS_FK_C_ID` FOREIGN KEY (`C_ID_HS`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `HS_FK_Y_ID` ON `nutrdb`.`Hapiscore` (`Y_ID_HS` ASC) ;
CREATE INDEX `HS_FK_C_ID` ON `nutrdb`.`Hapiscore` (`C_ID_HS` ASC) ;


-- -----------------------------------------------------
-- Table `nutrdb`.`GDP_total_yearly_growth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`GDP` (
  `Total_Yearly_Growth` FLOAT NULL,
  `Y_ID_GDP` INT NOT NULL,
  `C_ID_GDP` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_GDP`,`C_ID_GDP`),
  CONSTRAINT `GDP_FK_Y_ID` FOREIGN KEY (`Y_ID_GDP`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GDP_FK_C_ID` FOREIGN KEY (`C_ID_GDP`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `GDP_FK_Y_ID` ON `nutrdb`.`GDP` (`Y_ID_GDP` ASC) ;
CREATE INDEX `GDP_FK_C_ID` ON `nutrdb`.`GDP` (`C_ID_GDP` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Child_Mortality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Child_Mortality` (
  `Child_Mortality_Percentage_U5` FLOAT NULL,
  `Y_ID_ChM` INT NOT NULL,
  `C_ID_ChM` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_ChM`,`C_ID_ChM`),
  CONSTRAINT `ChM_FK_Y_ID` FOREIGN KEY (`Y_ID_ChM`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ChM_FK_C_ID` FOREIGN KEY (`C_ID_ChM`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `ChM_FK_Y_ID` ON `nutrdb`.`Child_Mortality` (`Y_ID_ChM` ASC) ;
CREATE INDEX `ChM_FK_C_ID` ON `nutrdb`.`Child_Mortality` (`C_ID_ChM` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Kcal_Per_Person_Day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Kcal` (
  `Per_person_daily` INT NULL,
  `Y_ID_KCal` INT NOT NULL,
  `C_ID_KCal` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_KCal`,`C_ID_KCal`),
  CONSTRAINT `KCal_FK_Y_ID` FOREIGN KEY (`Y_ID_KCal`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `KCal_FK_C_ID` FOREIGN KEY (`C_ID_KCal`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `KCal_FK_Y_ID` ON `nutrdb`.`KCal` (`Y_ID_KCal` ASC) ;
CREATE INDEX `KCal_FK_C_ID` ON `nutrdb`.`KCal` (`C_ID_KCal` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Malnutrition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Malnutrition` (
  `Weight_For_Age_Percent_U5` FLOAT NULL,
  `Y_ID_MalNutr` INT NOT NULL,
  `C_ID_MalNutr` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_MalNutr`,`C_ID_MalNutr`),
  CONSTRAINT `MalNutr_FK_Y_ID` FOREIGN KEY (`Y_ID_MalNutr`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MalNutr_FK_C_ID` FOREIGN KEY (`C_ID_MalNutr`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `MalNutr_FK_Y_ID` ON `nutrdb`.`Malnutrition` (`Y_ID_MalNutr` ASC) ;
CREATE INDEX `MalNutr_FK_C_ID` ON `nutrdb`.`Malnutrition` (`C_ID_MalNutr` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Prevalence_Anemia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Anemia` (
  `Prevalence_Percentage_U5` FLOAT NULL,
  `Y_ID_Anm` INT NOT NULL,
  `C_ID_Anm` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_Anm`,`C_ID_Anm`),
  CONSTRAINT `Anm_FK_Y_ID` FOREIGN KEY (`Y_ID_Anm`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Anm_FK_C_ID` FOREIGN KEY (`C_ID_Anm`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `Anm_FK_Y_ID` ON `nutrdb`.`Anemia` (`Y_ID_Anm` ASC) ;
CREATE INDEX `Anm_FK_C_ID` ON `nutrdb`.`Anemia` (`C_ID_Anm` ASC) ;


-- -----------------------------------------------------
-- Table `nutrdb`.`Undernourishment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Undernourishment` (
  `Prevalence_Percentage_Populationt` FLOAT NULL,
  `Y_ID_UNour` INT NOT NULL,
  `C_ID_UNour` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_UNour`,`C_ID_UNour`),
  CONSTRAINT `UNour_FK_Y_ID` FOREIGN KEY (`Y_ID_UNour`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UNour_FK_C_ID` FOREIGN KEY (`C_ID_UNour`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `UNour_FK_Y_ID` ON `nutrdb`.`Undernourishment` (`Y_ID_UNour` ASC) ;
CREATE INDEX `UNour_FK_C_ID` ON `nutrdb`.`Undernourishment` (`C_ID_UNour` ASC) ;


-- -----------------------------------------------------
-- Table `nutrdb`.`Overweight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Overweight` (
  `Prevalence_Percentage_U5` FLOAT NULL,
  `Y_ID_OW` INT NOT NULL,
  `C_ID_OW` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_OW`,`C_ID_OW`),
  CONSTRAINT `OW_FK_Y_ID` FOREIGN KEY (`Y_ID_OW`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OW_FK_C_ID` FOREIGN KEY (`C_ID_OW`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `OW_FK_Y_ID` ON `nutrdb`.`Overweight` (`Y_ID_OW` ASC) ;
CREATE INDEX `OW_FK_C_ID` ON `nutrdb`.`Overweight` (`C_ID_OW` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Severe_Wasting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Severe_Wasting` (
  `Prevalence_Percentage_U5` FLOAT NULL,
  `Y_ID_SW` INT NOT NULL,
  `C_ID_SW` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_SW`,`C_ID_SW`),
  CONSTRAINT `SW_FK_Y_ID` FOREIGN KEY (`Y_ID_SW`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SW_FK_C_ID` FOREIGN KEY (`C_ID_SW`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `SW_FK_Y_ID` ON `nutrdb`.`Severe_Wasting` (`Y_ID_SW` ASC) ;
CREATE INDEX `SW_FK_C_ID` ON `nutrdb`.`Severe_Wasting` (`C_ID_SW` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Stunting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Stunting` (
  `Prevalence_Percentage_U5` FLOAT NULL,
  `Y_ID_Stunt` INT NOT NULL,
  `C_ID_Stunt` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_Stunt`,`C_ID_Stunt`),
  CONSTRAINT `Stunt_FK_Y_ID` FOREIGN KEY (`Y_ID_Stunt`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Stunt_FK_C_ID` FOREIGN KEY (`C_ID_Stunt`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `Stunt_FK_Y_ID` ON `nutrdb`.`Stunting` (`Y_ID_Stunt` ASC) ;
CREATE INDEX `Stunt_FK_C_ID` ON `nutrdb`.`Stunting` (`C_ID_Stunt` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Underweight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Underweight` (
  `Prevalence_Percentage_U5` FLOAT NULL,
  `Y_ID_UW` INT NOT NULL,
  `C_ID_UW` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_UW`,`C_ID_UW`),
  CONSTRAINT `UW_FK_Y_ID` FOREIGN KEY (`Y_ID_UW`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UW_FK_C_ID` FOREIGN KEY (`C_ID_UW`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `UW_FK_Y_ID` ON `nutrdb`.`Underweight` (`Y_ID_UW` ASC) ;
CREATE INDEX `UW_FK_C_ID` ON `nutrdb`.`Underweight` (`C_ID_UW` ASC) ;

-- -----------------------------------------------------
-- Table `nutrdb`.`Sugar_Per_Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`Sugar_Consumption` (
  `Grams_Per_Person_Daily` INT NULL,
  `Y_ID_SC` INT NOT NULL,
  `C_ID_SC` INT NOT NULL,
  PRIMARY KEY  (`Y_ID_SC`,`C_ID_SC`),
  CONSTRAINT `SC_FK_Y_ID` FOREIGN KEY (`Y_ID_SC`) REFERENCES `years` (`Y_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SC_FK_C_ID` FOREIGN KEY (`C_ID_SC`) REFERENCES `countries` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX `SC_FK_Y_ID` ON `nutrdb`.`Sugar_Consumption` (`Y_ID_SC` ASC) ;
CREATE INDEX `SC_FK_C_ID` ON `nutrdb`.`Sugar_Consumption` (`C_ID_SC` ASC) ;


USE `nutrdb` ;

-- -----------------------------------------------------
-- Placeholder table for view `nutrdb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nutrdb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `nutrdb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nutrdb`.`view1`;
USE `nutrdb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
