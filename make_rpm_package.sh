#!/bin/sh

# Create directory structure
echo Create directory structure
rpmdev-setuptree

# Copying files
echo Copy files
make install DESTDIR=~/satdump-build/

# Create package info
cat <<EOF >> ~/rpmbuild/SPECS/satdump.spec
%global __requires_exclude libhackrf.so.0|libportaudio.so.2|librtlsdr.so.0|libsdrplay_api.so.3

Name:       satdump
Version:    1.2.2
Release:    $BUILD_NO
Summary:    SatDump
Recommends: libhackrf.so.0()(64bit), libportaudio.so.2()(64bit), librtlsdr.so.0()(64bit), libsdrplay_api.so.3()(64bit)
License:    GPLv3+

%description
A generic satellite data processing software.

%build
mv ~/satdump-build/* .

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

%files
/usr/share/satdump
/usr/lib64/satdump/plugins
/usr/bin/satdump
/usr/bin/satdump-ui
/usr/bin/satdump_sdr_server
/usr/lib64/libsatdump_core.so
/usr/lib64/libsatdump_interface.so
/usr/share/applications/satdump.desktop
EOF

# Create package
echo Create package
rpmbuild -ba ~/rpmbuild/SPECS/satdump.spec