## Docker jenkins agent 

```
docker run -d --name jenkins-agent -v /var/run/docker.sock:/var/run/docker.sock vishwacloudlab/jenkins-agent:v4 
```
NoTe: -- Login to the jenkins-agent as root
```
docker exec -it -u root jenkins-agent /bin/bash
```

run the commands mentioned on the agent for example
```
curl -sO http://172.17.0.2:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://172.17.0.2:8080/ -secret 26fbdef815356e5abd86ac0de61529a10344c6abe895ab6a127ee3ce2b18b788 -name agent -webSocket -workDir "/home/jenkins/agent"  &
```
* Change the secret value

# this is Experimental -- Beta

* Update the ip or port if required 
* update the secret key from the jenkins --> node --> details
* update the agent_name for multiple agents to be added 
```
docker run -d \
  --name jenkins-agent \
  -e JENKINS_URL="http://172.17.0.2:8080" \
  -e JENKINS_SECRET="26fbdef815356e5abd86ac0de61529a10344c6abe895ab6a127ee3ce2b18b788" \
  -e AGENT_NAME="agent" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  vishwacloudlab/jenkins-agent:v4
```


```
docker run -d \
  --name jenkins-agent \
  -e JENKINS_URL="http://172.17.0.2:8080" \
  -e JENKINS_SECRET="26fbdef815356e5abd86ac0de61529a10344c6abe895ab6a127ee3ce2b18b788" \
  -e AGENT_NAME="agent" \
  -e DOCKER_HOST="tcp://host.docker.internal:2375" \
  vishwacloudlab/jenkins-agent:v5
```
