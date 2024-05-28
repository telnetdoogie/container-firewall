# container-firewall
My attempt at creating an iptables-controlled parent container for other containers to connect through.

If you're using a host that makes modifying host `iptables` entries challenging (like a NAS that has proprietary firewall inits)
You could use this for creating `iptables` rules for the firewall container, and then 'wrapping' your desired container in the firewall container

## An example would be:
Running a container that can access the respond to established connections, but cannot create new connections out to the LAN, for example.
