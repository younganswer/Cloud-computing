#!/bin/bash

set -e

TMP_FILE=$(mktemp).py

cat << EOF > $TMP_FILE
from locust import HttpUser, task

class HelloWorldUser(HttpUser):
    @task
    def hello_world(self):
        self.client.get("/suppliers")
EOF

locust -f $TMP_FILE