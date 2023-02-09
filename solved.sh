#!/bin/sh
# This makes it so I can use !(toExclude)
shopt -s extglob
directory=$1
newDir=$2
sRange=$3
eRange=$(printf "%02d" $4)
# From Desktop we are cd to where our folders are held. This is specifically so we can use auto complete in the bash terminal. This could be streamlined more
# Change this to what ever path you need to to make it into your 01-Class-Content folder
cd fullstack-live/01-Class-Content
# Just saving a suffix so we can append this to whichever week content we are using
suffix='01-Activities/'
# makes an array of directorys where ever there is a space its a new line
list=($($(echo ls) | tr ' ' "\n"))
# iterate over the directory
for dirNum in ${list[@]}
do
# if the directory has a subdir that matches which subdir you want to go into go into it
if [[ "$dirNum" == *$(printf "%02d" $directory)* ]]; then
Path=$dirNum"/"$suffix
cd $Path
mkdir $newDir
dirList=($($(echo ls) | tr ' ' "\n"))
for inputToMatch in $(seq -w $sRange $eRange)
do
# for how ever many indecies in our director
for fileInDir in ${dirList[@]}
do
# check if our array matches the names of dirs in the main dir ie. 03 matches 03-Stu_Traverse-That-Dom
if [[ "$fileInDir" == *"$inputToMatch"* ]]; then
# if conditional is met, make a new directory inside our new folder example week4Day1
mkdir $newDir/$fileInDir
# copy everything that matches so 03 and 03S_T-T-D into a new Dir EXCLUDING Solved since we don't want the students having the solved activities
eval cp -r $fileInDir/!(Solved) $newDir/$fileInDir
# end the if statement
fi
# end the nested loop
done
# end the main loop
done
fi
done
7z a $newDir".zip" $newDir
echo 'All Folders and Files excluding Solved have been copied into' $newDir
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
read wait