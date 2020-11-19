# cdp-pvc-ibm-vpc
Install CDP Private Cloud Base on an IBM Cloud Virtual Server Instance either with Kerberos and WWBank Demo or without


# Install CDP Private Cloud Base
================================


## Virtual Server Setup
-----------------------

  ```
Virtual Server Instance Configuration:
Size:             8 vCPU | 64 GB Ram | 16 Gbps
Image:            CentOS 7.x - Minimal Install (amd64)
Boot Storage:     100 GB | 3000 Max IOPS | 46.88 MiBps
*Block Storage:   100 GB | 3000 Max IOPS | 46.88 MiBps
  ```
*Block Storage is only needed for kudu


### SSH into the Server
----------------------

  ```
ssh root@<public_ip>
  ```

### Execute Standard Installation
---------------------------------

  ```
curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm.sh | sudo -E sh
  ```


### External Block Preparation
------------------------------

Make sure that ext4 or xfs is used for /kudu e.g.

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

### Execute WWBank Installation
-------------------------------

  ```
curl -sSL https://raw.githubusercontent.com/bcoffman68/cdp-pvc-ibm-vpc/setup_ibm_wwbank.sh | sudo -E sh
  ```
