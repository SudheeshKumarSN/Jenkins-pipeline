pipeline {
    agent {
        label 'slave1'
    }
    tools {
        maven 'maven_3.9.8'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Git-Jenkins', url: 'https://github.com/SudheeshKumarSN/Jenkins-pipeline.git'
            }
        }
        stage('Compile, Test, and Package') {
            steps {
                sh '''
                    cd ./java_app && ls -ltr
                    mvn compile
                    mvn test
                    mvn package
                '''
            }
        }
        stage('Tomcat Deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat', url: 'http://13.233.75.146:8080', path: '')],
                       contextPath: '/java_app',
                       war: 'java_app/target/calculator.war'
            }
        }
    }
}
