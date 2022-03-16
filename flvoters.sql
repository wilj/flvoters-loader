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
  `name_last_search` varchar(30),
  `name_suffix_search` varchar(5),
  `name_first_search` varchar(30),
  `name_middle_search` varchar(30),
  `residence_address_line_1_search` varchar(50),
  `residence_address_line_2_search` varchar(40),
  `residence_city_search` varchar(40),
  `residence_state_search` varchar(2),
  `residence_zipcode_search` varchar(10),
  `mailing_address_line_1_search` varchar(40),
  `mailing_address_line_2_search` varchar(40),
  `mailing_address_line_3_search` varchar(40),
  `mailing_city_search` varchar(40),
  `mailing_state_search` varchar(2),
  `mailing_zipcode_search` varchar(12),
  `mailing_country_search` varchar(40),
  `birth_date_search` date,
  `registration_date_search` date,
  `email_address_search` varchar(100),
  PRIMARY KEY (`voter_id`),
  INDEX `county_code_i` (`county_code`),
  INDEX `name_last_search_i` (`name_last_search`),
  INDEX `name_suffix_search_i` (`name_suffix_search`),
  INDEX `name_first_search_i` (`name_first_search`),
  INDEX `name_middle_search_i` (`name_middle_search`),
  INDEX `residence_address_line_1_search_i` (`residence_address_line_1_search`),
  INDEX `residence_address_line_2_search_i` (`residence_address_line_2_search`),
  INDEX `residence_city_search_i` (`residence_city_search`),
  INDEX `residence_state_search_i` (`residence_state_search`),
  INDEX `residence_zipcode_search_i` (`residence_zipcode_search`),
  INDEX `mailing_address_line_1_search_i` (`mailing_address_line_1_search`),
  INDEX `mailing_address_line_2_search_i` (`mailing_address_line_2_search`),
  INDEX `mailing_address_line_3_search_i` (`mailing_address_line_3_search`),
  INDEX `mailing_city_search_i` (`mailing_city_search`),
  INDEX `mailing_state_search_i` (`mailing_state_search`),
  INDEX `mailing_zipcode_search_i` (`mailing_zipcode_search`),
  INDEX `mailing_country_search_i` (`mailing_country_search`),
  INDEX `birth_date_search_i` (`birth_date_search`),
  INDEX `registration_date_search_i` (`registration_date_search`),
  INDEX `email_address_search_i` (`email_address_search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop trigger if exists voter_detail_insert;

delimiter //
create trigger voter_detail_insert before insert on voter_detail for each row 
begin
  set new.name_last_search = lower(trim(coalesce(new.`name_last`, '')));
  set new.name_suffix_search = lower(trim(coalesce(new.`name_suffix`, '')));
  set new.name_first_search = lower(trim(coalesce(new.`name_first`, '')));
  set new.name_middle_search = lower(trim(coalesce(new.`name_middle`, '')));
  set new.residence_address_line_1_search = lower(trim(coalesce(new.`residence_address_line_1`, '')));
  set new.residence_address_line_2_search = lower(trim(coalesce(new.`residence_address_line_2`, '')));
  set new.residence_city_search = lower(trim(coalesce(new.`residence_city`, '')));
  set new.residence_state_search = lower(trim(coalesce(new.`residence_state`, '')));
  set new.residence_zipcode_search = lower(trim(coalesce(new.`residence_zipcode`, '')));
  set new.mailing_address_line_1_search = lower(trim(coalesce(new.`mailing_address_line_1`, '')));
  set new.mailing_address_line_2_search = lower(trim(coalesce(new.`mailing_address_line_2`, '')));
  set new.mailing_address_line_3_search = lower(trim(coalesce(new.`mailing_address_line_3`, '')));
  set new.mailing_city_search = lower(trim(coalesce(new.`mailing_city`, '')));
  set new.mailing_state_search = lower(trim(coalesce(new.`mailing_state`, '')));
  set new.mailing_zipcode_search = lower(trim(coalesce(new.`mailing_zipcode`, '')));
  set new.mailing_country_search = lower(trim(coalesce(new.`mailing_country`, '')));
  set new.birth_date_search = str_to_date(coalesce(new.`birth_date`, '12/31/9999'), '%m/%d/%Y');
  set new.registration_date_search = str_to_date(coalesce(new.`registration_date`, '12/31/9999'), '%m/%d/%Y');
  set new.email_address_search = lower(trim(coalesce(new.`email_address`, '')));
end;//
delimiter ;

drop trigger if exists voter_detail_update;

delimiter //
create trigger voter_detail_update before update on voter_detail for each row 
begin
  set new.name_last_search = lower(trim(coalesce(new.`name_last`, '')));
  set new.name_suffix_search = lower(trim(coalesce(new.`name_suffix`, '')));
  set new.name_first_search = lower(trim(coalesce(new.`name_first`, '')));
  set new.name_middle_search = lower(trim(coalesce(new.`name_middle`, '')));
  set new.residence_address_line_1_search = lower(trim(coalesce(new.`residence_address_line_1`, '')));
  set new.residence_address_line_2_search = lower(trim(coalesce(new.`residence_address_line_2`, '')));
  set new.residence_city_search = lower(trim(coalesce(new.`residence_city`, '')));
  set new.residence_state_search = lower(trim(coalesce(new.`residence_state`, '')));
  set new.residence_zipcode_search = lower(trim(coalesce(new.`residence_zipcode`, '')));
  set new.mailing_address_line_1_search = lower(trim(coalesce(new.`mailing_address_line_1`, '')));
  set new.mailing_address_line_2_search = lower(trim(coalesce(new.`mailing_address_line_2`, '')));
  set new.mailing_address_line_3_search = lower(trim(coalesce(new.`mailing_address_line_3`, '')));
  set new.mailing_city_search = lower(trim(coalesce(new.`mailing_city`, '')));
  set new.mailing_state_search = lower(trim(coalesce(new.`mailing_state`, '')));
  set new.mailing_zipcode_search = lower(trim(coalesce(new.`mailing_zipcode`, '')));
  set new.mailing_country_search = lower(trim(coalesce(new.`mailing_country`, '')));
  set new.birth_date_search = str_to_date(coalesce(new.`birth_date`, '12/31/9999'), '%m/%d/%Y');
  set new.registration_date_search = str_to_date(coalesce(new.`registration_date`, '12/31/9999'), '%m/%d/%Y');
  set new.email_address_search = lower(trim(coalesce(new.`email_address`, '')));
end;//
delimiter ;
