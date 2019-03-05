#!/bin/bash

#  address 文件记录需要验证ip地址，一行一个
#  /home/ec2-user/pass.sh 脚本用来验证当前用户(ec2-user)的密码验证，echo后写需要验证的密码
#  密码验证通过后，会输出/tmp目录下文件列表

for ip in `cat address`
   do
      echo "################# testing $ip ##############"
	  ssh-keyscan -t rsa $ip >> ~/.ssh/known_hosts 2>&1
	  echo  'ls -a /tmp/' | setsid env SSH_ASKPASS='/home/ec2-user/pass.sh' DISPLAY='none:0' ssh ec2-user@"$ip" 2>&1
	  if [[ "$?" == 0 ]]
	     then
		    echo "################# $ip test is success #################"
			echo ""
		else
		    echo "################# $ip test is  failed #################"
			echo ""
		fi
done
	  
