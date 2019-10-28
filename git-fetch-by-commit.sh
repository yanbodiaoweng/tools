#!/bin/bash 
# fetch git repo to some commit

read -p "git repo url:" url
read -p "commit ID:" commitID
read -p "clone to directory" dir
if [ "$dir" == "" ];then
    echo "use default directory:" $(pwd)
elif [ ! -d "$dir" ];then
    echo $dir "not exist, create target directory"
    mkdir $dir
fi

folder_dot_git=${url##*\/}
folder=${folder_dot_git%%.*}
# rm exist git folder
if [ -d $folder ];then
    echo "folder exist, remove it:" $folder
    rm -rf $folder
fi

git clone --depth 1 $url $dir
if [ "$dir" != "" ];then
    cd $dir
fi
cd $folder
echo "===>" $(pwd)

i=1
until git show $commitID > /dev/null
do
    i=$((i+1))
    git fetch --depth=$i
done
echo "=======successful======="
