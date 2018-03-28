#!/bin/sh

url_prefix=http://archive.debian.org/debian/dists
for rel in bo buzz etch hamm lenny potato rex sarge slink squeeze woody
do
	for grp in main contrib non-free
	do
		echo -n "downloading ${url_prefix}/${rel}/${grp}/source/Sources.gz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/source/Sources.gz > ${rel}_${grp}_Sources.gz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Sources.gz
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
		echo -n "downloading ${url_prefix}/${rel}/${grp}/source/Sources.gz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/source/Sources.gz > ${rel}_${grp}_Sources.gz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Sources.gz
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
		echo -n "downloading ${url_prefix}/${rel}/${grp}/source/Sources.xz..."
		curl -f -s ${url_prefix}/${rel}/${grp}/source/Sources.xz > ${rel}_${grp}_Sources.xz
		if test $? != 0
		then
			rm -f ${rel}_${grp}_Sources.xz
			echo not found
		else
			echo ok
		fi
	done
done


