## Powershell NETSH commands

TODO: document use cases develop split blah.

Expose llama-server WEBUI port to your LAN
```
# run as admin
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=localhost                                                                                                               
```


Expose Hermes port to your LAN
```
# run as admin
netsh interface portproxy add v4tov4 listenport=8082 listenaddress=0.0.0.0 connectport=8082 connectaddress=localhost                                                                                                               
```


Expose HONCHO chat port to your LAN
```
# run as admin
netsh interface portproxy add v4tov4 listenport=8083 listenaddress=0.0.0.0 connectport=8083 connectaddress=localhost                                                                                                               
```



```
# Don't remember it this one is also needed (Probably not)
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=LAN_IP connectport=8080 connectaddress=<Linux address>
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=192.168.1.140 connectport=8080 connectaddress=172.20.48.1
```


```
# Expose  Hermes & Honcho ports to LAN
New-NetFirewallRule -DisplayName "Allow HONCHO-CHAT" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8083
New-NetFirewallRule -DisplayName "Allow HONCHO-MEM" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8083
New-NetFirewallRule -DisplayName "Allow HERMES" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8081
```                   


```
ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'  

netsh interface portproxy show all
```

> As admin

`netsh interface portproxy reset`

## Powershell CUDA commands

Download CUDA toolkit here:  `https://developer.nvidia.com/cuda-downloads`

**Which CUDA you have**
```
nvcc --version
```

**Which CUDA your GPUs support**
```
nvidia-smi

```
