## Epitest Docker

#### Requirements
____

You need to install `docker`, to build correctly epitest-docker image

#### Epitest-Docker
____

Just specify the tag you want to apply to the image on the build.sh :

``` bash
build.sh --tag latest
```

You can add an option to clean the cache before building the image :

``` bash
build.sh --tag latest -n
```

#### Deployment
____


##### Login into dockerhub

``` bash
docker login -u username
```

You'll be prompted for your password

##### Push docker image

**`epitest-docker`**
``` bash
docker push epitechcontent/epitest-docker:latest
```

Where `latest` is the tag of image you want to push, e.g. : latest, devel, coverage