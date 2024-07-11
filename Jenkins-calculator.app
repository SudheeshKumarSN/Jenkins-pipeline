pipeline{
    agent {
        label 'slave1'
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
                    sh ''' mvn clean package '''
                }
            }
        }
}   
