FROM postgres:latest

# ENV POSTGRES_HOST_AUTH_METHOD trust
# in the docker initialization, we do not build the data
ENV BUILD_EICU 0

ENV DBNAME eicu
ENV DBUSER eicu
ENV DBPASS eicu
ENV DBSCHEMA eicu_crd

RUN mkdir -p /eicu_data /eicu-code
RUN apt-get update -qq && apt-get -y --no-install-recommends install build-essential


COPY data/ /eicu_data

COPY postgres/ /eicu-code/
COPY docker/setup.sh /docker-entrypoint-initdb.d/
