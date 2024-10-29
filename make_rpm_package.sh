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
/usr/share/satdump
/usr/lib64/satdump/plugins
/usr/bin/satdump
/usr/bin/satdump-ui
/usr/bin/satdump_sdr_server
/usr/lib64/libsatdump_core.so
/usr/lib64/libsatdump_interface.so
/usr/share/applications/satdump.desktop
EOF

# Copying files
echo Copy files
make install DESTDIR=~/rpmbuild/BUILDROOT/satdump-1.2.2$BUILD_NO-1.x86_64/
rm -rf /root/rpmbuild/BUILDROOT/satdump-1.2.2$BUILD_NO-1.x86_64/usr/include/

# Create package
echo Create package
cd ~/rpmbuild/SPECS
rpmbuild -ba satdump.spec
