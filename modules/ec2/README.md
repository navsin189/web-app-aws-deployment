## Amazon Elastic Compute Cloud

EC2 service provide virtual machines to run your applications. For now, the backend, haproxy and rsyslog are provisioned.

### Haproxy

HAProxy, which stands for High Availability Proxy, is a widely used TCP and HTTP-based proxy server that runs on Linux, Solaris, and FreeBSD. It is used to load balance applications by distributing requests between multiple servers, and to ensure that applications are highly available for users.

### Rsyslog

Rsyslog is a rocket-fast system for log processing. It offers high-performance, great security features and a modular design. While it started as a regular syslogd, rsyslog has evolved into a kind of swiss army knife of logging, being able to

- accept inputs from a wide variety of sources,
- transform them,
- and output the results to diverse destinations.

### Haproxy with Rsyslog

By default on many O.S., HAProxy is not configured to write its log output to a file so rsyslog is used for logging. [Click here for quick tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-haproxy-logging-with-rsyslog-on-centos-8-quickstart).
