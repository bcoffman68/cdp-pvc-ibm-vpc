# Ranger Atlas (Worldwide Bank)

## Demo overview

Demo overview can be found [here](https://community.hortonworks.com/articles/151939/hdp-securitygovernance-demo-kit.html) 

## Versions tested

Tested with:
- [x] CDP 7.1.4 / CM 7.1.4


## Fresh install of CDP Private Cloud Base + Worldwide demo
https://github.com/bcoffman68/cdp-pvc-ibm-vpc

- Pre-reqs:
  - Launch a single vanilla Centos/RHEL 7.x VM (e.g. on local VM or openstack or cloud provider of choice) 
  - The VM should not already have any Cloudera/Hortonworks components installed (e.g. do NOT run script on HDP sandbox)
  - The VM requires 16 vcpus and ~64 GB RAM once all services are running and you execute a query, so m4.4xlarge size is recommended
  
- Login as root
```
ssh root@<public_ip_address>
```

- Execute installation
```
yum install -y git 
#setup KDC 
curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm.sh | sudo -E sh
```

- This will run for about 1hr and install CDP-PvC 7.1.4 cluster with the Ranger/Atlas demo installed




## Login details 

- Access CM at :7180 as admin/admin
- Access Ranger at :6080. Ranger login is admin/BadPass#1
- Access Atlas at :31000. Atlas login is admin/BadPass#1
- Access Zeppelin at :8885. Zeppelin users logins are:
  - joe_analyst = BadPass#1
  - ivanna_eu_hr = BadPass#1
  - etl_user = BadPass#1
  - Access DAS at :30800



  ## Demo walkthrough
  
  - CDP walthrough available on Cloudera partner portal [here](https://my.cloudera.com/partner-portal/training/demo-center.html)
  - Older HDP walkthrough of demo steps available [here](https://community.hortonworks.com/articles/151939/hdp-securitygovernance-demo-kit.html)

  ## Other things to try
- Simulate users trying to randomly access Hive tables to generate more interesting audits
```
/tmp/masterclass/ranger-atlas/HortoniaMunichSetup/audit_simulator.sh
```

- Install Ranger Audits Banana dashboard to visuaize audits


  ## How does it work?
- The script basically:
  - uses [SingleNodeCDPCluster](https://github.com/fabiog1901/SingleNodeCDPCluster) to install CM and deploy CDP-DC cluster that includes Ranger/Atlas
  - uses Ranger APIs to import service defs, create tag repo and import policies for HDFS/Hive/Hbase/Kafka
  - import tags into Atlas
  - imports sample Hive data (which also creates HDFS/Hive entities in Atlas)
  - [uses Atlas APIs to associate tags with Hive/Kafka/Hbase/HDFS entities](https://community.hortonworks.com/articles/189615/atlas-how-to-automate-associating-tagsclassificati.html)
  - enables kerberos


 
