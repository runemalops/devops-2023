### Run the docker_testing.sh script (recommended)
```bash
./docker_testing.sh
```

### Test Docker
Log into node 1 and test to make sure docker is working.
```bash
docker run hello-world
```

### Test docker-compose app
```bash
docker-compose up
```

### Troubleshooting
Sometimes if you made a mistake in one of the files, you made have to re-do the image build with docker-compose build
```bash
docker-compose build
```

### Testing
```bash
curl node1:5000
```
