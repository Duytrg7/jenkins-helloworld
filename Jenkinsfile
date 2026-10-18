podTemplate(yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
          secretName: dockercred
          items:
          - key: .dockerconfigjson
            path: config.json
''') {
    node(POD_LABEL) {
        stage('Get the project') {
            checkout scm
        }
        stage('Test') {
            sh 'test -f Dockerfile && test -f index.html && echo "files OK"'
        }
        stage('Build & push image') {
            container('kaniko') {
                sh '''
                    /kaniko/executor --context `pwd` \
                      --destination crzuy7007/jenkins-helloworld:$BUILD_ID \
                      --destination crzuy7007/jenkins-helloworld:latest
                '''
            }
        }
    }
}
