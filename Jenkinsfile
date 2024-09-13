pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    stages {
        stage('Tests') {
            steps {
                sh './mvnw clean test'
            }
        }
        stage('Package') {
            steps {
                sh '''
                    ./mvnw package -DskipTests \
                    -Dquarkus.package.type=uber-jar
                '''
                archiveArtifacts 'target/*.jar'
            }
        }
        stage('Build and Push Image') {
            environment { QUAY = credentials('QUAY_TOKEN_GHILLING')}
            steps {
                sh '''
                ./mvnw package -DskipTests \
                -Dquarkus.container-image.push=true \
                -Dquarkus.container-image.build=true \
                -Dquarkus.container-image.username=$QUAY_USR \
                -Dquarkus.container-image.password=$QUAY_PSW
                '''
            }
        }
    }
}
