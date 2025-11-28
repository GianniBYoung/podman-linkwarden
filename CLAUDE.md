# Context
this is a Podman container for LinkWarden, a self-hosted password manager.
It uses podman and quadlets to create a hardened deployment using chainguard images.

# Building the Container for testing
`podman build -f linkwarden-wolfi.ContainerFile -t linkwarden-wolfi`

# Building the Container for Production
This will use the `linkwarden-wofli.build` quadlet to build the container
