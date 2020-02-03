
# [v0.12 - v0.12.1]

- Clean-up after package Alpine & yarn package installations
- Use `COPY ` Dockerfile syntax instead of `ADD `
- Add Docker image layer caching to build
- Allow slack notification step to fail with overall build success

# [v0.11.1 - v0.12]

- NGINX base image version 1.17

# [v0.11.0 - v0.11.1]

- Upgrade node to v10.x.x
- Simplify how we combine nginx and node
- Fix: send nginx output to container output

# [v0.10.0 - v0.10.1]

- Update node version to latest 9.x.x by forcing rebuild
- Trigger CI build

# v0.9.2

Added utilities for use in all deployments
- bash
- jq
- dotenv-to-json 
- dynamic-env 

# v0.9.1

Reinstate build process through Drone CI/CD
