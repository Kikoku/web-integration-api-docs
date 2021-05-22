# Local Setup

We use a dockerized ruby environment to build and watch your local changes.

## Building your docker

Run the following command in this directory to set up the docker container

```docker build -t wiapi-doc .```

## Run your docker container 

Run the following command in this directory to build and watch the external document

```docker run --rm -v ${PWD%/*}/source:/slate/source -p 4567:4567 -it wiapi-doc external```

Run the following command in this directory to build and watch the internal document

```docker run --rm -v ${PWD%/*}/source:/slate/source -p 4567:4567 -it wiapi-doc internal```

## View the document in your local

The document would be available in [http://localhost:4567](http://localhost:4567). 

Once, you have  your docker container running.
