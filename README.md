# OpenModelica and PyFMI
Docker image with PyFMI and OpenModelica

FMU files generated for linux can be used with PyFMI.

Build on your own:

```sh
$ cd omfmi
$ docker build -t omfmi .
```

Or just pull from docker hub:

```sh
$ docker pull phygitalism/omfmi:1.0
```


Run in docker:

```sh
$ docker run --rm -it -v "$(pwd)":/omfmi phygitalism/omfmi:1.0
```