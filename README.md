Quadlets for creating a simple and hardened Linkwarden pod intended to be ran as an unprivileged podman user with optional ai tagging component.

This configuration will restart on failure, start at boot, and automatically pull the latest image on restart

# Usage
This assumes that your host UUID is 1000. If it is different make sure to update references accordingly.

## 1. Set Podman Secrets With Your Creds
`echo '< database url >' | podman secret create linkwarden_pg_db_url -`

`echo '< database password >' | podman secret create linkwarden_pg_password -`

`echo '< nextauth url >' | podman secret create linkwarden_pg_nextauth_url -`

`echo '< nextauth secret >' | podman secret create linkwarden_pg_nextauth_secret -`

### Example
```
echo 'postgresql://postgres:<yourpassword>@localhost:5432/linkwarden' | podman secret create linkwarden_pg_db_url -
echo '<yourpassword>' | podman secret create linkwarden_pg_nextauth_secret -
echo 'http://localhost:3000/api/v1/auth' | podman secret create linkwarden_pg_nextauth_url -
echo '<yourpassword>' | podman secret create linkwarden_pg_password -
```

## 2. Update the Persistent Storage Paths in `linkwarden.pod`
Make sure these paths exist! Podman *will not* create these for you

## 3. Copy Quadlets
`mkdir -p $XDG_CONFIG_HOME/containers/systemd`

- Copy both `.container` files and the `.pod` file to `$XDG_CONFIG_HOME/containers/systemd`
  - `cp *container *pod $XDG_CONFIG_HOME/containers/systemd`

- Make systemd aware of the new files
  - `systemctl --user daemon-reload`

## 4. Start the Service

`systemctl --user start linkwarden`

## 5. OPTIONAL: Start the AI Tagging Service

- Start up the pod, configure ollama and the model you want to use
  - `systemctl --user start linkwarden-pod`
- Refer to the ollama documentation for configuration details
  - https://ollama.com/docs/getting-started/installation
- Refer to the Linkwarden documentation for enabling AI tagging
  - https://docs.linkwarden.app/self-hosting/ai-worker

# Other Controls
`systemctl --user stop linkwarden-pod` will stop all containers

# References
- https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html
- https://docs.linkwarden.app/self-hosting/installation

# Contributing
- File issues
- Ask questions
- Submit PRs
- Suggest features
