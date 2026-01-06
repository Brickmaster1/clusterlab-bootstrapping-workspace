# Getting Started
## Reqiurements
- #### A Linux machine of some form.
- #### Docker (as well as Docker Compose), refer to the [official installation documentation](https://docs.docker.com/engine/install/).
- #### KVM/QEMU
  
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

