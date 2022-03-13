#!/bin/bash
# python3 env manager
# python3 虚拟环境管理

# 默认家目录/PythonEnv 为虚拟环境根目录
action=$1
defaltAction=(create remove list use)
envName=$2
tempPyEnvPath=$PythonEnvRoot/$envName

Usage() {
    cat <<EOF

Usage:
    pyenv action [envName]

        * create envName -- 在 $PythonEnvRoot/{envName} 目录下 创建python虚拟环境
                         
        * remove envName -- 删除某个虚拟环境
       
        * use envName -- 返回激活某个虚拟环境的shell命令


        * list -- 显示所有虚拟环境
    
    \$(pyenv use envName) -- 使用某个虚拟环境

     deactivate -- 退出某个虚拟环境

    pyenv -h      (显示帮助)

EOF
    exit 1
}

checkParams() {
    case $action in
    create)
        # 判断是否输入 envName
        if test -z $envName; then
            echo "虚拟环境名称不能为空"
            exit
        fi

        # 判断 envName 是否包含 $PythonEnvRoot
        if [[ $envName =~ "/" ]]; then
            echo "虚拟环境名称不能包含 '/' "
            exit
        fi
        if [ -d $tempPyEnvPath ]; then
            echo "虚拟环境 $envName 已经存在！请先删除！"
            exit
        fi
        create
        ;;

    remove)
        remove
        ;;

    list)
        list
        ;;
    use)
        if test -z $envName; then
            echo "虚拟环境名称不能为空"
            exit
        fi
        if [ ! -d $tempPyEnvPath ]; then
            echo "虚拟环境 $tempPyEnvPath 不存在"
        else
            use
        fi
        ;;

    -h)
        Usage
        ;;
    *)
        Usage
        ;;
    esac
}

# 创建 env 环境
create() {
    echo "$envName 虚拟环境开始创建......"
    if [ ! -d $PythonEnvRoot ]; then
        mkdir $PythonEnvRoot
    fi
    # python3 -m venv $tempPyEnvPath
    if [ $? != 0 ]; then
        echo "创建虚拟环境 $envName 失败!"
        exit
    else
        echo "创建虚拟环境 $envName 成功!"
    fi
}

remove() {
    if [ ! -d $tempPyEnvPath ]; then
        echo "虚拟环境 $envName 不存在"
    else
        rm -rf $tempPyEnvPath
        echo "删除虚拟环境 $envName 成功"
    fi
}

list() {
    #  ls -F | grep '/$'
    echo "虚拟环境根目录: $PythonEnvRoot"
    for line in $(ls -F $PythonEnvRoot | grep '/$'); do
        echo "* (${line:0:${#str}-1}) -- $PythonEnvRoot/$line"
    done
}

use() {
    echo "source $tempPyEnvPath/bin/activate"
}
checkParams
