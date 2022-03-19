#!/usr/bin/env bash
set -euxo pipefail

# calculate chunk size based on available memory
ROWS_PER_GB=4096
GB_AVAILABLE=$(free --giga | head -n2 | head -n2 | tail -n1 | awk '{ print $NF }')
ROWS_PER_CHUNK=$(echo "$ROWS_PER_GB * $GB_AVAILABLE" | bc)

(cd flvoters/ && dolt sql - < ../flvoters.sql)

TMP=/tmp/flvoters/detail
rm -rf $TMP
mkdir -p $TMP
unzip $(find $1 -iname "*voterdetail.zip" | head -n1) -d $TMP


# load each file
find $TMP -type f -print0 | sort -z | while read -d $'\0' f
do 
  echo "Loading $f"
  OUTDIR="/tmp/flvoters/csv/$(basename $f)"
  rm -rf $OUTDIR
  mkdir -p $OUTDIR

  # run the raw tab separated file through a python script that converts it to CSV and cleans up quoting
  python tsv_to_csv.py < $f >> $OUTDIR/all.csv


  # split the file into chunks small enough to load without running out of memory
  ( cd $OUTDIR && split -l $ROWS_PER_CHUNK all.csv && rm all.csv )

  # load each chunk
  find $OUTDIR/ -type f -print0 | sort -z | while read -d $'\0' f
  do 
    echo 'county_code,voter_id,name_last,name_suffix,name_first,name_middle,requested_public_records_exemption,residence_address_line_1,residence_address_line_2,residence_city,residence_state,residence_zipcode,mailing_address_line_1,mailing_address_line_2,mailing_address_line_3,mailing_city,mailing_state,mailing_zipcode,mailing_country,gender,race,birth_date,registration_date,party_affiliation,precinct,precinct_group,precinct_split,precinct_suffix,voter_status,congressional_district,house_district,senate_district,county_commission_district,school_board_district,daytime_area_code,daytime_phone_number,daytime_phone_extension,email_address' > $f.csv
    cat $f >> $f.csv
    ( cd flvoters; time dolt table import --update-table  --file-type=csv --pk=voter_id voter_detail $f.csv && time dolt gc)
  done

  ( cd flvoters; time dolt sql -q 'select count(*) from voter_detail' )


done
