#!/bin/sh

VERSION=$(grep '^VERSION' BtBatStat.py | sed -e "s/[A-Za-z=\s\ \']//g")
cat > setup.py << EOF
from setuptools import setup

DATAFILES = ['icons', 'BtBatStat.icns']
setup(
    app=["BtBatStat.py"],
    data_files=DATAFILES,
    options=dict(py2app=dict(
        plist=dict(
            LSUIElement=True,
            CFBundleShortVersionString="$VERSION",
            CFBundleVersion="$VERSION",
            CFBundleIconFile="BtBatStat.icns",
            CFBundleIdentifier="org.vandalon.btbatstat",
            NSHumanReadableCopyright="Joris Vandalon",
        ),
    )),
    setup_requires=["py2app"],
)
EOF
