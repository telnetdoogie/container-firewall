# container-firewall
My attempt at creating an iptables-controlled parent container for other containers to connect through.

If you're using a host that makes modifying host `iptables` entries challenging (like a NAS that has proprietary firewall inits)
You could use this for creating `iptables` rules for the firewall container, and then 'wrapping' your desired container in the firewall container

## An example would be:
Running a container that can access the respond to established connections, but cannot create new connections out to the LAN, for example.

## Want to give it a try?
```console
git clone https://github.com/telnetdoogie/container-firewall.git
cd container-firewall
```
Edit the `entrypoint.sh` file to have iptables rules you need / want

Run `docker-compose build` 

Edit the `docker-compose.yml` to specify the container you want to put 'behind' the firewall rules

`docker-compose up -d && docker-compose logs`

Each time you change the iptables settings, you'll need to re-run `docker-compose build` and `docker-compose up -d && docker-compose logs` to update the container.

I used dozzle as my example, but perhaps using a better container to do testing with would be easier (perhaps a basic alpine image where you can open a shell and test network)

