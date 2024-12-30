# Locust

Locust is an open-source load testing tool that allows you to define user behavior with Python code and simulate millions of concurrent users. It is designed to be easy to use and highly scalable, making it an ideal choice for performance testing web applications and APIs.

## Getting started

You can install Locust using docker:

```bash
$ docker build -t locust .
```

## Running container

```bash
$ docker run -p 8089:8089 locust
```

## Accessing Locust

You can access Locust by visiting [http://localhost:8089](http://localhost:8089) in your web browser.
