# Purpose

Pull request screen of modern Bitbucket Server has redundant UI elements interfering a review process. This Google Chrome extension is aimed to remove (on demand) this unnecessary UI elements and increase the area of displayed code.

# How to use

1. Build
2. Install
3. Click on extension's button to modify the PR's view

# How to build

## Build `tar`-packed extension using Docker

To build `tar`-packed extension inside a Docker container run:
```
docker/docker-make tar
```

Requirements:
* POSIX-compatible environment with `bash`
* Docker

## Build `tar`-packed extension at your host environment

To build `tar`-packed extension at your host environment run:
```
make tar
```

Requirements:
* POSIX-compatible environment with common tools like `find` and `tar`
* GNU Make
* GNU Awk (`gawk`)
* Inkscape
