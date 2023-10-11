pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-central-1'
    }

    stages {
        stage('Clone clamav_role and playbook.yml') {
            steps {
                dir('/var/lib/jenkins/clamAV') {
                    script {
                    // Перевіряємо, чи існує папка 'repo', і видаляємо її, якщо так
                    if (fileExists('repo')) {
                        sh 'rm -rf repo'
                    }
                    }
                    // Клонуємо лише папку clamav_role та файл playbook.yml
                    sh '''
                        git clone --depth 1 --branch main https://github.com/alehhillka/project_remember.git repo
                        cp -r repo/clamav_role .
                        cp repo/playbook.yml .
                        cp repo/aws_ec2.yml .
                        rm -rf repo
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    def sshKey = credentials('aws') // Отримуємо SSH ключ із Jenkins credentials

                    // Задаємо SSH ключ для з'єднання з EC2
                    withCredentials([sshUserPrivateKey(credentialsId: 'aws', keyFileVariable: 'SSH_KEY', passphraseVariable: '', usernameVariable: 'EC2_USER')]) {
                        // Вимкнути перевірку ключів хостів для Ansible
                        sh 'export ANSIBLE_HOST_KEY_CHECKING=False'

                        // Запускаємо Ansible playbook
                        sh '''
                            ansible-playbook /var/lib/jenkins/clamAV/playbook.yml -i /var/lib/jenkins/clamAV/aws_ec2.yml --private-key $SSH_KEY --user $EC2_USER
                        '''
                    }
                }
            }
        }
    }
}