# Single Node CDP PVC-Base Cluster
This script automatically sets up a CDP PVC-Base (aka CDP Data Center) Trial cluster on the public cloud on an IBM Cloud Virtual Server Instance with the services preconfigured in a template file. It supports both clusters with or without kerberos.

This cluster is meant to be used for demos, experimenting, training, and workshops so it is only one node and does not have TLS enabled.

## Instructions

Below are instructions for creating the cluster with or without CDSW service. CDSW requires some extra resources (more powerful instance, and a secondary disk for the docker device).

### Provisioning Cluster without WWBank Demo
```
Virtual Server Instance Configuration:
Size:             8 vCPU | 64 GB Ram | 16 Gbps
Image:            CentOS 7.x - Minimal Install (amd64)
Boot Storage:     100 GB | 3000 Max IOPS | 46.88 MiBps
```
### Provisioning Cluster with WWBank Demo
```
Virtual Server Instance Configuration:
Size:             8 vCPU | 64 GB Ram | 16 Gbps
Image:            CentOS 7.x - Minimal Install (amd64)
Boot Storage:     100 GB | 3000 Max IOPS | 46.88 MiBps
Block Storage:    100 GB | 3000 Max IOPS | 46.88 MiBps
```

### SSH into the Server
```
ssh root@<public_ip>
```

### Execute Installation without WWBank Demo
```
curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm.sh | sudo -E sh
```

Continue to the 'Use' section below


### Execute Installation with WWBank Demo
Setup Block storage as ext4 which is used for /kudu

Display the partitions and file system type
```
fdisk -1
```

Create a new partition on the Block storage (most likely vdd)
```
fdisk /dev/vdd
```

Create a new directory for kudu
```
mkdir /kudu
```

Format the Block storage with ext4 (most likely vdd)
```
mkfs -t ext4 /dev/vdd
```

Mount the kudu directory to the Block storage
```
mount /dev/vdd /kudu
```

Verify the Block storage /vdd is now available with ext4 with a mountpoint of /kudu
```
lsblk -fs
```

### Execute Installation Script
```
curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm_wwbank.sh | sudo -E sh
```

====================================================
## Use
Wait until the script finishes, check for any error.

Once the script returns, you can open Cloudera Manager at [http://\<public-IP\>:7180](http://<public-IP>:7180)

