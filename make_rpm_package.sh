#!/bin/sh

# Create directory structure
echo Create directory structure
mkdir ~/rpmbuild
mkdir ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
mkdir ~/rpmbuild/BUILDROOT/satdump-1.2.2$BUILD_NO-1.x86_64/

# Create package info
cat <<EOF >> ~/rpmbuild/SPECS/satdump.spec
%global __requires_exclude libhackrf.so.0|libportaudio.so.2|librtlsdr.so.0|libsdrplay_api.so.3

Name:       satdump
Version:    1.2.2$BUILD_NO
Release:    1
Summary:    SatDump
Recommends: libhackrf.so.0()(64bit), libportaudio.so.2()(64bit), librtlsdr.so.0()(64bit), libsdrplay_api.so.3()(64bit)
License:    GPLv3+

%description
A generic satellite data processing software.

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

%files
*
EOF

# Copying files
echo Copy files
cd $1
make install DESTDIR=~/rpmbuild/BUILDROOT/satdump-1.2.2$BUILD_NO-1.x86_64/

# Create package
echo Create package
cd ~/rpmbuild/SPECS
rpmbuild -ba satdump.spec
