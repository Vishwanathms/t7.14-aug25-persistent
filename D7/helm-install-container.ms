## install helm on jenkins container 

```

# Exec into Jenkins container
docker exec -it -u root jenkins /bin/bash

# Install dependencies
apt-get update && apt-get install -y curl apt-transport-https gnupg

# Download Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify
helm version


```