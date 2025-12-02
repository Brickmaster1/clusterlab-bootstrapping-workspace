# Getting Started
## Reqiurements
- #### A Linux machine of some form.
- #### Docker (as well as Docker Compose), refer to the [official installation documentation](https://docs.docker.com/engine/install/).
- #### Sysbox
  you can follow installation instructions at the Sysbox [documentation](https://github.com/nestybox/sysbox/blob/master/docs/user-guide/install-package.md#installing-sysbox).

  It's also available as an AUR package for Arch users as `sysbox-ce`

  Once installed make sure that you start the service with
  ```bash
  sudo systemctl enable --now sysbox
  ```

## Running
#### First run the `setup.sh` script.  
  ```bash
  $ ./setup.sh
  ```

  This will download the `compose.yaml` from Coder's repository and replace the UID to access the Docker daemon and workspaces using Docker with your current UID.

  Run this as the user you would be starting your other Docker projects with, make sure they are part of the `docker` group.

#### Now you can run the Docker Compose project.
  ```bash
  $ docker compose up -d
  ```

