##
# cayetanobv/gdal2
#
# This creates an Ubuntu derived base image that installs GDAL 2.
#

# Ubuntu 14.04 Trusty Tahyr
FROM ubuntu:trusty

MAINTAINER Cayetano Benavent <cayetano.benavent@geographica.gs>

# Ensure the package repository is up to date
RUN apt-get update -y

# Install basic dependencies
RUN apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    python-dev \
    python-numpy \
    libspatialite-dev \
    sqlite3 \
    wget \
    unzip

# Get the GDAL source
ADD ./getsources_gdal2.sh /tmp/
RUN sh /tmp/getsources_gdal2.sh

# Compile and install GDAL
ADD ./compileandinstall_gdal2.sh /tmp/
RUN sh /tmp/compileandinstall_gdal2.sh

# Output version and capabilities by default.
CMD gdalinfo --version && gdalinfo --formats && ogrinfo --formats