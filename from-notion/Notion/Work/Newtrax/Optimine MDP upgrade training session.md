---

---
Responsible: Jeff

Material:

- [https://newtrax.atlassian.net/wiki/spaces/SP/pages/5210046730/How+to+Upgrade+OptiMine+MDP+with+a+BSX](https://newtrax.atlassian.net/wiki/spaces/SP/pages/5210046730/How+to+Upgrade+OptiMine+MDP+with+a+BSX)
- [https://newtrax.atlassian.net/wiki/spaces/SP/pages/5671518234/OptiMine+MDP+command-line+cheat+sheet](https://newtrax.atlassian.net/wiki/spaces/SP/pages/5671518234/OptiMine+MDP+command-line+cheat+sheet)

### Filename auto-completion

- Filenames can be auto-completed by typing a few characters, and pressing the tab key
    - If the filename is not fully completed after a single tab key press, press tab again to see all possible options
    - Type some unique characters and press tab again to continue auto-completion

### Session management

- whoami display current user name
- su become root user (password required)
    - regular user prompt ends with a $
    - root user prompt ends with a #
- exit exit a session

### File management

- ls -alh view all files with human-readable size
- cd <dir> change directory
    - cd .. move up a directory
    - cd change to home directory
- rm <file> remove a file
- rm -rf <dir> remove a directory
- mv <file> <dir> move a file to a directory
- cp <file> <dir> copy a file to a directory
- chmod +x <file> make a file executable
- ./<file> execute an executable file

### System management

- df -h / view total and available disk space
- free -mh view total and available RAM
- lscpu view CPU information, including count
- ifconfig eth0 view networking information
- cat /etc/resolv.conf view DNS servers
- rc-status view system services health
    - k3s service is particularly important
    - restart count is in parenthesis
- tail -f /var/log/k3s.log display k3s logs

### OptiMine MDP monitoring

- k9s start a monitoring session
    - If no output appears, press 0 to use all filter
- Into **deveployment** view, press 's' to scale service.
- home, end, page up and page down keys can be used to quickly navigate views and logs
- ? show contextual help
- :pod switch to pod view
    - shift+p sort by namespace
    - shift+c sort by CPU
    - shift+m sort by memory
    - enter on a pod to view containers
    - enter on a container to view logs
        - 0 follow latest logs
        - / search for text
        - s toggle autoscroll
        - t toggle timestamps
- :dp switch to deployments view
    - shift+r sort by “ready”
        - Blue 0/0 means deployment was manually scaled down
        - Orange 0/0 means deployment is down due to errors
    - enter on deployment to view pods

### Database operations

- List all databases, ordered by largest size
    - kubectl exec timescaledb-0 --namespace=postgres --container timescaledb -- psql -qc 'SELECT database_name, pg_size_pretty(size) FROM (SELECT pg_database.datname AS "database_name", pg_database_size(pg_database.datname) AS size FROM pg_database ORDER by size DESC) X;'
- Generate a system-configuration-server backup
    - kubectl exec timescaledb-0 --namespace=postgres --container timescaledb -- pg_dump -Fc -d system_configuration_server -n public > syscon.custom