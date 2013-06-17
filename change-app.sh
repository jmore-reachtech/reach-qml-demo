source /etc/tslib.environment

REACH_VIEWER=./qml-viewer


if [ -d "$1" ]; then
       # delete the current content symlink
       rm content
       # create new content symlink
       ln -s $1 content
       # delete the current translate.txt symlink
       rm translate.txt
       #create new translate.txt symlink
       ln -s $1/translate.txt translate.txt
       #touch the translate.txt symlink
       touch -am $1/translate.txt
       # restart viewer
       /etc/init.d/qml-reset restart
       sleep 3
fi
