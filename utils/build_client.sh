#!/bin/bash

if [ -z $1 ]; then
	echo 'Need to specify platform'
	exit 1
fi

if [ $1 == "w" ]; then
	build_dir="Zotero_win32/"
elif [ $1 == "l" ]; then
	build_dir="Zotero_linux-x86_64/"
elif [ $1 == "m" ]; then
	build_dir="Zotero.app/"
else
	echo "Unknown platform"
	exit 1
fi

cd ~/zotero-selfhost/src/client/zotero-client
npm i && npm run build

cd ~/zotero-selfhost/src/client/zotero-standalone-build
rm -rf staging/
./fetch_xulrunner.sh -p $1 && ./fetch_pdftools && ./scripts/dir_build -p $1

cd staging/
rm -f ~/z.tar
tar cf ~/z.tar $build_dir
