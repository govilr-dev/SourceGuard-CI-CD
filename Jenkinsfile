 pipeline {
      agent any
      environment {
           SG_CLIENT_ID = "2d190ec2-08e1-45ef-bfb0-6a9f8a301a3b"
           SG_SECRET_KEY = "38f49fb560904a1a9577c74033dfc7a1"
           registry = "https://registry.hub.docker.com"
       
           
        }
  stages {
          
         stage('Clone Github repository') {
            
    
           steps {
              
             checkout scm
           
             }
  
          }

          stage ('Build') {
              steps {
                  sh '''
               docker rmi govil/SG --force | true
            
               '''
              }
          }
    stage('SourceGuard SCA and SAST') {   
       steps {   
           parallel (
            SCA: {
               echo  'Dependency Check by SourceGuard'
            },
            SAST: {       
         script {      
              try {
         
                sh 'chmod +x sourceguard-cli' 

                sh './sourceguard-cli --src .'
           
               } catch (Exception e) {
    
                 echo "Request for Approval"  
                  }
              }
            }
           )
         }
    }  
           
          stage('Staging Setup') {
             
            steps {

              sh 'docker build -t govil/SG .'
              sh 'docker save govil/SG -o gr.tar'
              
             } 
           }
       stage('Staging Container Image Scan') {   
          steps {
            script {
               try {     
           
         
                    sh './sourceguard-cli --img gr.tar'
                    } catch (Exception e) {
    
                 echo "Image scanning is BLOCK and recommend not using the source code"  
                  }
                }
              }
            
            }
            
        
        
  } 
}
