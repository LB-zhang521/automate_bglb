###
 # @Author: bglb
 # @Email: bglb@qq.com
 # @Date: 2021-12-10 21:35:43
 # @LastEditTime: 2021-12-10 21:35:55
 # @Description: build_version
### 
#!/bin/bash

# 版本增加函数 
increment_versiovn ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 ));
  do
       len=${#part[CNTR]}
       new=$((part[CNTR]+carry))
       [ ${#new} -gt $len ] && carry=1 || carry=0
       [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo "${new// /.}"
}
# 判断 当前所在分支
#!/bin/bash
if branch=$(git symbolic-ref --short -q HEAD)
then
	if [ "$branch" = "master" ]
	then
		echo master branch is not allow build version
	else
		# read old version
       		version=$(cat ./version)

        	# clear version
        	cat /dev/null > ./version

        	# write new version
        	echo $(increment_versiovn $version) > ./version

        	# replace file's "\r" to ""
        	sed -i "s/$/\r/g" ./version

        	git add ./version
        	git commit ./version -m "update version: $(increment_versiovn $version)"
        	git push
        	echo "build version and push successfully form $branch"
	fi
fi
