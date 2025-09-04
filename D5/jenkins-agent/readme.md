## Docker jenkins agent 
* Update the ip or port if required 
* update the secret key from the jenkins --> node --> details
```
docker run -d \
  --name jenkins-agent \
  -e JENKINS_URL="http://172.17.0.2:8080" \
  -e JENKINS_SECRET="26fbdef815356e5abd86ac0de61529a10344c6abe895ab6a127ee3ce2b18b788" \
  -e AGENT_NAME="agent" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-ubuntu-agent
```
