#!/bin/bash
# 功能：从~/.vnc/中获取VNC端口号，并重启VNC

myname=`whoami`
mypath=`cat /etc/passwd | grep $myname | awk -F ":" '{print $6}'`
filelist=`ls $mypath"/.vnc"`
for filename in $filelist; do
    part1=${filename##*:}
    #echo $part1
    part2=${part1%%.*}
    extension=${part1##*.}
    #echo $extension
    #echo $part2
    if [ `echo $part2 | tr -cd "[0-9]"` ] && [ $extension == "pid" ];then
        echo "************************"
        echo "重启端口号：$part2......"
        echo "************************"
        vncserver -kill :$part2
        # 请自行修改分辨率
        vncserver :${part2} -geometry 1920x1080
        exit
    fi
    #echo `echo $filename | grep 'log\>'`
done

echo "> ~/.vnc/目录下无端口号信息，请联系管理员处理！谢谢！！！"
echo ">  如果你知道自己的端口号，请自行手动启动。命令为："
echo ">      vncserver -kill :port"
echo ">      vncserver :port -geometry 1920x1080"
vncserver :1 -geometry 1920x1080
echo ">  已执行vncserver :1 -geometry 1920x1080"
