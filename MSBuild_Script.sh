#!/bin/bash
#exec > log
#files=/home/vladdden/Documents/Gitea2/*

files=`pwd`/* 
for f in $files
do
	echo $f
	foldername=$(basename "$f")
	filename="${f}/${foldername}.sln"
	if [ $foldername != "NuGet.Config" ] && [ $foldername != "_builds" ] && [ $foldername != "code.sh" ] && [ $foldername != "Release" ];
		then
		echo -e '\n\n'
		if [ -e $filename ]
		then
			echo $foldername
			echo $filename
			msbuild "$filename" /p:OutputPath=`pwd`/Release >> build_log
			echo -e '\n\n\n\n' >> build_log
		else 
			if [ -e $f/*.sln ]
			then
				echo $filename
				msbuild "$filename" >> build_log /p:OutputPath=`pwd`/Release
				echo -e '\n\n\n\n' >> build_log
			else
				echo "-----------------------------------------------------------------------------------------"
				echo "Файла $filename НЕ СУЩЕСТВУЕТ !!!!"
				echo "-----------------------------------------------------------------------------------------"
			fi
		fi
	fi
done
