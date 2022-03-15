DROP TABLE IF EXISTS `voter_detail`;
CREATE TABLE `voter_detail` (
  `county_code` varchar(3) NOT NULL,
  `voter_id` varchar(10) NOT NULL,
  `name_last` varchar(30),
  `name_suffix` varchar(5),
  `name_first` varchar(30),
  `name_middle` varchar(30),
  `requested_public_records_exemption` varchar(1),
  `residence_address_line_1` varchar(50),
  `residence_address_line_2` varchar(40),
  `residence_city` varchar(40),
  `residence_state` varchar(2),
  `residence_zipcode` varchar(10),
  `mailing_address_line_1` varchar(40),
  `mailing_address_line_2` varchar(40),
  `mailing_address_line_3` varchar(40),
  `mailing_city` varchar(40),
  `mailing_state` varchar(2),
  `mailing_zipcode` varchar(12),
  `mailing_country` varchar(40),
  `gender` varchar(1),
  `race` varchar(1),
  `birth_date` varchar(10),
  `registration_date` varchar(10),
  `party_affiliation` varchar(3),
  `precinct` varchar(6),
  `precinct_group` varchar(3),
  `precinct_split` varchar(6),
  `precinct_suffix` varchar(3),
  `voter_status` varchar(3),
  `congressional_district` varchar(3),
  `house_district` varchar(3),
  `senate_district` varchar(3),
  `county_commission_district` varchar(3),
  `school_board_district` varchar(2),
  `daytime_area_code` varchar(3),
  `daytime_phone_number` varchar(7),
  `daytime_phone_extension` varchar(4),
  `email_address` varchar(100),
  PRIMARY KEY (`voter_id`),
  INDEX `county_code_i` (`county_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `voter_detail_search`;
CREATE TABLE `voter_detail_search` (
  `voter_id` varchar(10) NOT NULL,
  `name_last` varchar(30),
  `name_suffix` varchar(5),
  `name_first` varchar(30),
  `name_middle` varchar(30),
  `residence_address_line_1` varchar(50),
  `residence_address_line_2` varchar(40),
  `residence_city` varchar(40),
  `residence_state` varchar(2),
  `residence_zipcode` varchar(10),
  `mailing_address_line_1` varchar(40),
  `mailing_address_line_2` varchar(40),
  `mailing_address_line_3` varchar(40),
  `mailing_city` varchar(40),
  `mailing_state` varchar(2),
  `mailing_zipcode` varchar(12),
  `mailing_country` varchar(40),
  `birth_date` date,
  `registration_date` date,
  `email_address` varchar(100),
  PRIMARY KEY (`voter_id`),
  INDEX `name_last_i` (`name_last`),
  INDEX `name_suffix_i` (`name_suffix`),
  INDEX `name_first_i` (`name_first`),
  INDEX `name_middle_i` (`name_middle`),
  INDEX `residence_address_line_1_i` (`residence_address_line_1`),
  INDEX `residence_address_line_2_i` (`residence_address_line_2`),
  INDEX `residence_city_i` (`residence_city`),
  INDEX `residence_state_i` (`residence_state`),
  INDEX `residence_zipcode_i` (`residence_zipcode`),
  INDEX `mailing_address_line_1_i` (`mailing_address_line_1`),
  INDEX `mailing_address_line_2_i` (`mailing_address_line_2`),
  INDEX `mailing_address_line_3_i` (`mailing_address_line_3`),
  INDEX `mailing_city_i` (`mailing_city`),
  INDEX `mailing_state_i` (`mailing_state`),
  INDEX `mailing_zipcode_i` (`mailing_zipcode`),
  INDEX `mailing_country_i` (`mailing_country`),
  INDEX `birth_date_i` (`birth_date`),
  INDEX `registration_date_i` (`registration_date`),
  INDEX `email_address_i` (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop trigger if exists voter_detail_insert;
create trigger voter_detail_insert before insert on voter_detail for each row insert into voter_detail_search (
  `voter_id`,
  `name_last`,
  `name_suffix`,
  `name_first`,
  `name_middle`,
  `residence_address_line_1`,
  `residence_address_line_2`,
  `residence_city`,
  `residence_state`,
  `residence_zipcode`,
  `mailing_address_line_1`,
  `mailing_address_line_2`,
  `mailing_address_line_3`,
  `mailing_city`,
  `mailing_state`,
  `mailing_zipcode`,
  `mailing_country`,
  `birth_date`,
  `registration_date`,
  `email_address`
) values (
  new.`voter_id`,
  lower(trim(coalesce(new.`name_last`, ''))),
  lower(trim(coalesce(new.`name_suffix`, ''))),
  lower(trim(coalesce(new.`name_first`, ''))),
  lower(trim(coalesce(new.`name_middle`, ''))),
  lower(trim(coalesce(new.`residence_address_line_1`, ''))),
  lower(trim(coalesce(new.`residence_address_line_2`, ''))),
  lower(trim(coalesce(new.`residence_city`, ''))),
  lower(trim(coalesce(new.`residence_state`, ''))),
  lower(trim(coalesce(new.`residence_zipcode`, ''))),
  lower(trim(coalesce(new.`mailing_address_line_1`, ''))),
  lower(trim(coalesce(new.`mailing_address_line_2`, ''))),
  lower(trim(coalesce(new.`mailing_address_line_3`, ''))),
  lower(trim(coalesce(new.`mailing_city`, ''))),
  lower(trim(coalesce(new.`mailing_state`, ''))),
  lower(trim(coalesce(new.`mailing_zipcode`, ''))),
  lower(trim(coalesce(new.`mailing_country`, ''))),
  str_to_date(coalesce(new.`birth_date`, '12/31/9999'), '%m/%d/%Y'),
  str_to_date(coalesce(new.`registration_date`, '12/31/9999'), '%m/%d/%Y'),
  lower(trim(coalesce(new.`email_address`, '')))
);

drop trigger if exists voter_detail_update;
create trigger voter_detail_update before update on voter_detail for each row update voter_detail_search set
  `name_last` = lower(trim(coalesce(new.`name_last`, ''))),
  `name_suffix` = lower(trim(coalesce(new.`name_suffix`, ''))),
  `name_first` = lower(trim(coalesce(new.`name_first`, ''))),
  `name_middle` = lower(trim(coalesce(new.`name_middle`, ''))),
  `residence_address_line_1` = lower(trim(coalesce(new.`residence_address_line_1`, ''))),
  `residence_address_line_2` = lower(trim(coalesce(new.`residence_address_line_2`, ''))),
  `residence_city` = lower(trim(coalesce(new.`residence_city`, ''))),
  `residence_state` = lower(trim(coalesce(new.`residence_state`, ''))),
  `residence_zipcode` = lower(trim(coalesce(new.`residence_zipcode`, ''))),
  `mailing_address_line_1` = lower(trim(coalesce(new.`mailing_address_line_1`, ''))),
  `mailing_address_line_2` = lower(trim(coalesce(new.`mailing_address_line_2`, ''))),
  `mailing_address_line_3` = lower(trim(coalesce(new.`mailing_address_line_3`, ''))),
  `mailing_city` = lower(trim(coalesce(new.`mailing_city`, ''))),
  `mailing_state` = lower(trim(coalesce(new.`mailing_state`, ''))),
  `mailing_zipcode` = lower(trim(coalesce(new.`mailing_zipcode`, ''))),
  `mailing_country` = lower(trim(coalesce(new.`mailing_country`, ''))),
  `birth_date` = str_to_date(coalesce(new.`birth_date`, '12/31/9999'), '%m/%d/%Y'),
  `registration_date` = str_to_date(coalesce(new.`registration_date`, '12/31/9999'), '%m/%d/%Y'),
  `email_address` = lower(trim(coalesce(new.`email_address`, '')))
 where `voter_id` = new.`voter_id`;
