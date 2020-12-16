#!/bin/bash

files=`pwd`/* 
for f in $files
do
	foldername=$(basename "$f")
	filename="${f}/${foldername}.sln"
	if [ $foldername != "NuGet.Config" ] && [ $foldername != "_builds" ] && [ $foldername != "code.sh" ] && [ $foldername != "Builds" ];
		then
		echo -e '\n\n'
		if [ -e $filename ]
		then
			echo $foldername
			echo $filename
			msbuild "$filename" /p:OutputPath=`pwd`/Builds >> build_log
			echo -e '\n\n\n\n' >> build_log
		else 
			if [ -e $f/*.sln ]
			then
				filename=`find $f -name "*.sln"`
				echo $foldername
				echo $filename
				msbuild "$filename" >> build_log /p:OutputPath=`pwd`/Builds
				echo -e '\n\n\n\n' >> build_log
			else
				echo "-----------------------------------------------------------------------------------------"
				echo "Файла $filename НЕ СУЩЕСТВУЕТ !!!!"
				echo "-----------------------------------------------------------------------------------------"
			fi
		fi
	fi
done


