#!/usr/bin/env bash
set -euxo pipefail

OUTDIR="/tmp/flvoters/csv/$(basename $1)"
rm -rf $OUTDIR
mkdir -p $OUTDIR

# run the raw tab separated file through a python script that converts it to CSV and cleans up quoting
python tsv_to_csv.py < $1 >> $OUTDIR/all.csv

# split the file into chunks small enough to load without running out of memory
( cd $OUTDIR && split -l 32767 all.csv && rm all.csv )

# load each chunk
find $OUTDIR/ -type f -print0 | sort -z | while read -d $'\0' f
do 
  echo 'county_code,voter_id,name_last,name_suffix,name_first,name_middle,requested_public_records_exemption,residence_address_line_1,residence_address_line_2,residence_city,residence_state,residence_zipcode,mailing_address_line_1,mailing_address_line_2,mailing_address_line_3,mailing_city,mailing_state,mailing_zipcode,mailing_country,gender,race,birth_date,registration_date,party_affiliation,precinct,precinct_group,precinct_split,precinct_suffix,voter_status,congressional_district,house_district,senate_district,county_commission_district,school_board_district,daytime_area_code,daytime_phone_number,daytime_phone_extension,email_address' > $f.csv
  cat $f >> $f.csv
  ( cd flvoters; dolt table import --update-table  --file-type=csv --pk=voter_id voter_detail $f.csv )
  sleep 1
done

