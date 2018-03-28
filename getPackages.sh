#!/bin/sh

url_prefix=http://archive.debian.org/debian/dists
for rel in bo buzz etch hamm lenny potato rex sarge slink squeeze woody
do
	for grp in main contrib non-free
	do
		echo -n "downloading ${url_prefix}/${rel}/${grp}/binary-i386/Packages.gz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/binary-i386/Packages.gz > ${rel}_${grp}_Packages.gz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Packages.gz
			echo not found
		else
			echo ok
		fi
	done
done

url_prefix=http://ftp.debian.org/debian/dists
for rel in wheezy
do
	for grp in main contrib non-free
	do
		echo -n "downloading ${url_prefix}/${rel}/${grp}/binary-i386/Packages.xz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/binary-i386/Packages.gz > ${rel}_${grp}_Packages.gz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Packages.gz
			echo not found
		else
			echo ok
		fi
	done
done



url_prefix=http://ftp.debian.org/debian/dists
for rel in buster jessie sid stretch
do
	for grp in main contrib non-free
	do
		echo -n "downloading ${url_prefix}/${rel}/${grp}/binary-i386/Packages.xz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/binary-i386/Packages.xz > ${rel}_${grp}_Packages.xz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Packages.xz
			echo not found
		else
			echo ok
		fi
	done
done


