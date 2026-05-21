```
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=localhost                                                                                                               

netsh interface portproxy add v4tov4 listenport=8080 listenaddress=LAN_IP connectport=8080 connectaddress=<Linux address>
                   

ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'  

netsh interface portproxy show all
```

> As admin

`netsh interface portproxy reset`
