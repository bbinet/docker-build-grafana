docker-build-grafana
====================

This container is used to build deb and rpm packages for Grafana 2.


Build
-----

To create the image `bbinet/build-grafana`, execute the following command in
the `docker-build-grafana` folder:

    docker build -t bbinet/build-grafana .

You can now push the new image to the public registry:
    
    docker push bbinet/build-grafana


Run
---

Then, when you'll actually build deb and rpm packages for Grafana 2, the
build-grafana container will assume that Grafana source code is available in
the `/go/src/github.com/grafana/grafana` directory, so make sure it is
available to docker as a volume.

For example:

    $ docker pull bbinet/build-grafana

    $ docker run --rm --name build-grafana \
        -v /path/to/grafana/source:/go/src/github.com/grafana/grafana \
        bbinet/build-grafana
