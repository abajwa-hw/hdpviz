#### An Ambari Stack for HDP Visualizer for component services
Ambari stack for easily installing and managing HDP component services Visualizer on HDP cluster

- Download HDP 2.2 sandbox VM image (Sandbox_HDP_2.2_VMware.ova) from [Hortonworks website](http://hortonworks.com/products/hortonworks-sandbox/)
- Import Sandbox_HDP_2.2_VMware.ova into VMWare and set the VM memory size to 8GB
- Now start the VM
- After it boots up, find the IP address of the VM and add an entry into your machines hosts file e.g.
```
192.168.191.241 sandbox.hortonworks.com sandbox    
```
- Connect to the VM via SSH (password hadoop), correct the /etc/hosts entry and start Ambari server
```
ssh root@sandbox.hortonworks.com
```

- Edit /etc/hosts on sandbox and change localhost entry to point to IP address instead of 127.0.0.1 e.g. 
```
127.0.0.1               localhost.localdomain
192.168.191.142 sandbox.hortonworks.com sandbox ambari.hortonworks.com localhost
```
- Start Ambari service
```
/root/start_ambari.sh
```
- Install Maven
```
mkdir /usr/share/maven
cd /usr/share/maven
wget http://mirrors.koehn.com/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz
tar xvzf apache-maven-3.2.5-bin.tar.gz
ln -s /usr/share/maven/apache-maven-3.2.5/ /usr/share/maven/latest
echo 'M2_HOME=/usr/share/maven/latest' >> ~/.bashrc
echo 'M2=$M2_HOME/bin' >> ~/.bashrc
echo 'PATH=$PATH:$M2' >> ~/.bashrc
export M2_HOME=/usr/share/maven/latest
export M2=$M2_HOME/bin
export PATH=$PATH:$M2
```

- To deploy the stack and view, run below
```
cd /root
git clone https://github.com/abajwa-hw/hdpviz.git 

cp -R /root/hdpviz/hdpviz_stack /var/lib/ambari-server/resources/stacks/HDP/2.2/services/

IP=$(ifconfig eth0|awk '/inet addr/ {split ($2,A,":"); print A[2]}')
sed -i "s/sandbox.hortonworks.com/$IP/g" /root/hdpviz/hdpviz-view/src/main/resources/index.html

cd /root/hdpviz/hdpviz-view
mvn clean package
cp target/*.jar /var/lib/ambari-server/resources/views

sudo service ambari restart
```
- Then you can click on 'Add Service' from the 'Actions' dropdown menu in the bottom left of the Ambari dashboard:

On bottom left -> Actions -> Add service -> check HDPVIZ server -> Next -> Next -> Next -> Deploy
![Image](../master/screenshots/screenshot-vnc-config.png?raw=true)

- On successful deployment you will see the HDPVIZ service as part of Ambari stack and will be able to start/stop the service from here:
![Image](../master/screenshots/screenshot-vnc-stack.png?raw=true)

- When you've completed the install process, HDPVIZ will appear in Ambari 
![Image](../master/screenshots/screenshot-freeipa-stack.png?raw=true)

- You can see the parameters you configured under 'Configs' tab
![Image](../master/screenshots/screenshot-freeipa-stack-config.png?raw=true)

- To remove the HDPVIZ service: 
  - Stop the service via Ambari
  - Delete the service
  
    ```
    curl -u admin:admin -i -H 'X-Requested-By: ambari' -X DELETE http://sandbox.hortonworks.com:8080/api/v1/clusters/Sandbox/services/HDPVIZ
    ```
  - Remove artifacts 
  
    ```
    /var/lib/ambari-server/resources/stacks/HDP/2.2/services/hdpviz-stack/remove.sh
    ```


#### Open view

- Open the view from Ambari and browse HDFS

- Or open a separate browser tab to the IP of the VM:
http://192.168.191.142:9001/





