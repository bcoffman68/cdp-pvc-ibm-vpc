#Installs CDP-Private Cloud Base single node plus Worldwide bank demo on IBM Cloud
#Pre-reqs:
# - OS:      CentOS 7 or RHEL 7
# - vCPUs:   16
# - Memory:  64 GB RAM
# - Boot:   100 GB 3000 MaxIOPs
# - fdisk -l
# - lsblk
# - cat /etc/centos-release

#Run by:
#curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm.sh | sudo -E sh

#!/bin/bash
host=$(hostname)
IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
mv /etc/hosts /etc/hosts.bak
echo "127.0.0.1  localhost  localhost.localdomain" > /etc/hosts
echo "${IP} ${host}.ibm.com ${host}" >> /etc/hosts
echo "updated hosts file:"
cat /etc/hosts
echo "hostname is $(hostname -f)"
echo "disabling SELinux for this boot.."
setenforce 0
sestatus


#on Redhat, extra steps needed
if [ $(rpm --query centos-release | grep "not installed" | wc -l) == 1 ]; then
  #if RH, here are the RH repos and commands for adding RH epel and python-pip packages:
  subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"  --enable "rhel-ha-for-rhel-*-server-rpms"
  yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum install -y python-pip

  #rest of the workshop vm install commands RH or centos:
  #install tools
  yum install -y java-1.8.0-openjdk-devel vim wget curl git bind-utils chrony
else
  yum install -y git chrony
fi


echo "installing CDP-Private Cloud Base..."
git clone https://github.com/fabiog1901/SingleNodeCDPCluster.git

echo "Setting up cluster without CDSW..."
cd SingleNodeCDPCluster
./setup.sh gcp templates/base.json


