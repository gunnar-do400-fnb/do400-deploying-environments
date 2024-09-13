pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    environment {
        RHT_OCP4_DEV_USER = 'bgnffr'
        DEPLOYMENT_STAGE = 'shopping-cart-stage'
        DEPLOYMENT_PRODUCTION = 'shopping-cart-production'
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
                sh 'build/build-image.sh'
            }
        }
        stage('Deploy - Stage') {
            environment {
                APP_NAMESPACE = "${RHT_OCP4_DEV_USER}-shopping-cart-stage"
                QUAY = credentials('QUAY_TOKEN_GHILLING')
            }
            steps {
                sh """
                    oc set image deployment ${DEPLOYMENT_STAGE} \
                    shopping-cart-stage=quay.io/ghilling/do400-deploying-environments:build-${BUILD_NUMBER} \
                    -n ${APP_NAMESPACE} --record
                """
            }
        }
    }
}
