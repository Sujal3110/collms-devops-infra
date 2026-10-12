pipeline {
    agent any

    stages {
        stage('Show repo files') {
            steps {
                sh 'ls -la'
            }
        }
        stage('Check tools') {
            steps {
                sh 'git --version'
                sh 'java -version'
            }
        }
    }
}