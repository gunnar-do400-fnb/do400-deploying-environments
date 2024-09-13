#!/bin/bash

set -euo pipefail

./mvnw package -DskipTests \
                -Dquarkus.container-image.push=true \
                -Dquarkus.container-image.build=true \
                -Dquarkus.container-image.username=$QUAY_USR \
                -Dquarkus.container-image.password=$QUAY_PSW
