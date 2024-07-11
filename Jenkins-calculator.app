pipeline{
    agent {
        label 'slave1'
    }
    tools {
        maven 'maven_3.9.8'
    }
        stages{
            stage('checkout'){
                steps{
                git branch: 'main', credentialsId: 'Git-Jenkins', url: 'https://github.com/SudheeshKumarSN/Jenkins-pipeline.git'
                }
            }
            stage('compile test and integration test'){
                steps{
                    sh ''' cd ./java_app
                    mvn  compile && mvn test && mvn integration-test
                    ''' 
                }
            }
            stage('Package'){
                steps{
                    sh 'cd ./java_app && ls -ltr'
                    sh ''' mvn clean package '''
                }
            }
        }
}   
