Quadlets for creating a simple Linkwarden pod intended to be ran as an unprivileged podman user.

This configuration will restart on failure, start at boot, and automatically pull the latest image on restart

# Usage
This assumes that your host UUID is 1000. If it is different make sure to update references accordingly.

## Set Podman Secrets With Your Creds
`echo "< database url >" | podman secret create linkwarden_pg_db_url -`

`echo "< database password >" | podman secret create linkwarden_pg_password -`

`echo "< nextauth url >" | podman secret create linkwarden_pg_nextauth_url -`

`echo "< nextauth secret >" | podman secret create linkwarden_pg_nextauth_secret -`

## Copy Quadlets
Copy both `.container` files and the `.pod` file to `$HOME/.config/containers/systemd`

Make systemd aware of the new files `systemctl daemon-reload`

## Start the service

`systemctl --user start linkwarden`

# References
https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html

# Contributing
- File issues
- Ask questions
- submit PRs
- Suggest features
