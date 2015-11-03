#!/bin/bash 

attribute_dir="/var/chef/cookbooks/dhcp_mod/attributes/default.rb" 

function prep_attrib {
  sed -i.bak '/\]$/d' $attribute_dir 
  sed -i.bak 's/\}.$/\},/g' $attribute_dir  
}

breaker="*****************************************************************************"


function fail_status { 
      echo "$breaker"
      echo "$2"
      echo "Here is the entry I have for $1:"
      echo "If you wish to use $1 , please remove all of the following manually from $attribute_dir "
      echo "$breaker"
      cat $attribute_dir | $3 $1 
      exit
   
}

function check_existing_host { 
  cat $attribute_dir | grep $1 1> /dev/null 
  if [ $? -eq "0" ] ; 
    then 
      fail_status $1 "I was unable to add $1, it appears that there is already and instance of $1." "grep -A 4"
  fi
}

function check_ip { 
  if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    echo "thanks" 1> /dev/null 
  else 
    echo ""
    echo "$2" 
    echo "Ex.. 10.177.75.10"
    echo ""
    exit
  fi
}

function check_existing_mac { 
  echo $1 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' 1> /dev/null 
  if [ $? -ne "0" ]; then 
    echo ""
    echo "please provide a valid mac address, $1 is not going to work"
    echo ""
    exit
  fi
  cat $attribute_dir | grep $1 1> /dev/null 
  if [ $? -eq "0" ] ; 
    then 
      fail_status $1  "The mac address you are trying to use $1, is already in use" "grep -A 3 -B 1"
  fi
}

function check_existing_pxe_ip { 
  check_ip $1  "please provide a properly formatted ip address for your pxe ip" 
  cat $attribute_dir | grep $1 1> /dev/null 
  if [ $? -eq "0" ] ; 
    then 
      fail_status $1  "The pxe ip you are trying to use $1, is already in use" "grep -A 2 -B 2"
  fi
}

function check_existing_static_ip { 
  check_ip $1  "Please provide a properly formatted ip address for your static ip" 
  cat $attribute_dir | grep $1 1> /dev/null 
  if [ $? -eq "0" ] ; 
    then 
      fail_status $1 "The static ip you are trying to use $1, is already in use" "grep -A 1 -B 3"
  fi
}

function add_host { 
  check_existing_host $1   
  check_existing_mac $2 
  check_existing_pxe_ip $3
  check_existing_static_ip $4
  prep_attrib 
  echo " 
  { 'hostname' =>  '$1', 
    'mac' => '$2', 
    'ip_address' => '$3',
    'perm_address' => '$4'
  } 
]" >> $attribute_dir 
  echo "please run chef-solo for entry to take effect"
}

#echo "please pass args as hostname mac ip" 

if [ "$#" -ne 4 ]; then 
  echo "*************************************"
  echo "Please pass args as hostname mac pxe_ip static_ip."
  echo "*************************************"
  echo "ex.. $0 net01 00:25:B5:02:B0:00 10.177.75.64 10.177.3.221" 
  exit 
fi 


add_host $1 $2 $3 $4 

