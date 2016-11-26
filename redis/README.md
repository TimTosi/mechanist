# Redis Docker

## Overview

These files are intended to provide a ready-to-use [redis](https://redis.io/)
environment based on Docker.

The Dockerfile aims to be generic, easily extensible and used according to the
user's will such as a redis master, a redis [slave](https://redis.io/topics/replication)
or a redis [sentinel](https://redis.io/topics/sentinel).

## Quickstart

Let's start by building the Docker Image:

![Redis-Build](../assets/gifs/redis/redis-build.gif)

From here you got a new shiny Docker Image of a redis server you can play with:

![Redis-Test](../assets/gifs/redis/redis-test.gif)

## Dockerfile

The Docker Image you just created is based on [Alpine](https://alpinelinux.org/)
distribution and its total size is 23.82 MB.

This is lightweight and that works, though I would not use it in production as
it is because of my special needs. That is why you can override the redis
configuration in command line without specifying a redis configuration file that
would force you to create the Docker Image again.

Let's say you would like to change the port the redis server listens to:

![Redis-Override](../assets/gifs/redis/redis-override.gif)

Nevertheless, you would have to specify TONS of arguments in command line, and
that is not really practical.

That is why you should directly use the Compose file instead.

## Compose File

The present Compose file sets up a basic redis cluster composed of six services:
* one redis master
* two redis slaves
* three redis sentinels

```
    +-------------------+    +-------------------+    +-------------------+
    |                   |    |                   |    |                   |
    | redis-sentinel-01 |    | redis-sentinel-02 |    | redis-sentinel-03 |
    |                   |    |                   |    |                   |
    +-------------------+    +-------------------+    +-------------------+
              |                        |                         |
              |                +----------------+                |
              +--------------->|                |<---------------+
                             +>|    redis-01    |<+
                             | |                | |
                             | +----------------+ |
                             |                    |
                    +----------------+    +----------------+
                    |                |    |                |
                    |    redis-02    |    |    redis-03    |
                    |                |    |                |
                    +----------------+    +----------------+
```

But you can use it as you want in adding or updating provided services by
editing this very file.

Using this Compose file is as easy as:

![Redis-Compose](../assets/gifs/redis/redis-compose.gif)

## Not Good Enough ?

If you encouter any issue by using what is provided here, please
[let me know](https://github.com/TimTosi/mechanist/issues) ! 
Help me to improve by sending your thoughts to timothee.tosi@gmail.com !
