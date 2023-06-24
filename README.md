# GoViolin

### Generate go.mod go.sum
go mod init github.com/Rosalita/GoViolin
go mod tidy // Then go mod tidy to generate go.sum

## Build image
docker build -t image-name . 

## Run 
docker run -p host-port:port-exposed-in-dockerfile -d image-name

## Access Application
localhost:<host-port>
