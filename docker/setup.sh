#!/bin/bash

echo 'CREATING EICU ... '

# this flag allows us to initialize the docker repo without building the data
if [ $BUILD_EICU -eq 1 ]
then
echo "running create eicu user"

cd /eicu-code
make initialize
make eicu-gz datadir=/eicu_data/

# pg_ctl stop
# # su - postgres -c "/usr/lib/postgresql/12/bin/pg_ctl -D \"$PGDATA\" stop"
#
# pg_ctl -D "$PGDATA" \
# 	-o "-c listen_addresses='' -c checkpoint_timeout=600" \
# 	-w start
#
# # su - postgres -c "/usr/lib/postgresql/12/bin/pg_ctl -D \"$PGDATA\" -o \"-c listen_addresses='' -c checkpoint_timeout=600\" -w restart"
#
#
# psql <<- EOSQL
#     CREATE USER EICU WITH PASSWORD '$EICU_PASSWORD';
#     CREATE DATABASE EICU OWNER EICU;
#     \c eicu;
#     CREATE SCHEMA  eicu_crd;
# 		ALTER SCHEMA  eicu_crd OWNER TO eicuuser;
# EOSQL
#
# # check for the admissions to set the extension
# if [ -e "/eicu_data/patient.csv.gz" ]; then
#   COMPRESSED=1
#   EXT='.csv.gz'
# elif [ -e "/eicu_data/patient.csv" ]; then
#   COMPRESSED=0
#   EXT='.csv'
# else
#   echo "Unable to find a EICU data file (ADMISSIONS) in /eicu_data"
#   echo "Did you map a local directory using `docker run -v /path/to/eicu/data:/eicu_data` ?"
#   exit 1
# fi
#
# # check for all the tables, exit if we are missing any
# ALLTABLES='admissionDrug carePlanCareProvider diagnosis medication pastHistory treatment  admissionDx carePlanEOL hospital  microLab  patient vitalAperiodic.csv.gz allergy carePlanGeneral infusionDrug note physicalExam vitalPeriodic apacheApsVar carePlanGoal intakeOutput nurseAssessment respiratoryCare apachePatientResult carePlanInfectiousDisease lab nurseCare respiratoryCharting apachePredVar customLab nurseCharting'
#
# for TBL in $ALLTABLES; do
#   if [ ! -e "/eicu_data/${TBL^^}$EXT" ];
#   then
#     echo "Unable to find ${TBL^^}$EXT in /eicu_data"
#     exit 1
#   fi
#   echo "Found all tables in /eicu_data - beginning import from $EXT files."
# done
#
# # # checks passed - begin building the database
# # if [ ${PG_MAJOR:0:1} -eq 1 ]; then
# # echo "$0: running postgres_create_tables_pg10.sql"
# # psql "dbname=eicu user='$POSTGRES_USER' options=--search_path= eicu_crd" < /eicu-code/postgres_create_tables_pg10.sql
# # else
# # echo "$0: running postgres_create_tables_pg.sql"
# # psql "dbname=eicu user='$POSTGRES_USER' options=--search_path= eicu_crd" < /eicu-code/postgres_create_tables_pg.sql
# #
# # fi
#
# DBSTRING="dbname=${DBNAME} user=${DBUSER} options=--search_path=${DBSCHEMA}"
#
# psql "${DBSTRING}" -v ON_ERROR_STOP=1 < /eicu-code/postgres_create_tables.sql
#
# psql "${DBSTRING}" -a -v ON_ERROR_STOP=1 -v datadir=/eicu_data -f /eicu-code/postgres_load_data.sql
#
# psql "${DBSTRING}" -v ON_ERROR_STOP=1 -f /eicu-code/postgres_add_indexes.sql
#
# psql "${DBSTRING}" -v ON_ERROR_STOP=1 -f /eicu-code/postgres_checks.sql
#
fi
echo 'Done!'
