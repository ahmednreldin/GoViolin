# GoViolin

### Generate go.mod go.sum
Generate go.mod
```
go mod init github.com/Rosalita/GoViolin
```
Generate go.sum
```
go mod tidy 
```
## Build image
```
docker build -t ${image-name} . 
```
## Run 
```
docker run -p ${host-port}:${port-exposed-in-dockerfile} -d image-name
```

## Access Application
```
localhost:host-port
```
