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
    stage('SourceGuard Code Scan') {   
       steps {   
                   
         script {      
              try {
         
               
            
                sh 'chmod +x sourceguard-cli' 

                sh './sourceguard-cli --src .'
           
               } catch (Exception e) {
    
                 echo "Request for Approval"  
                  }
              }
            }
         }
           
           
          stage('Docker image Build and scan prep') {
             
            steps {

              sh 'docker build -t dhouari/sg .'
              sh 'docker save dhouari/sg -o sg.tar'
              
             } 
           }
       stage('SourceGuard Container Image Scan') {   
          steps {
            script {
               try {     
           
         
                    sh './sourceguard-cli --img sg.tar'
                    } catch (Exception e) {
    
                 echo "Image scanning is BLOCK and recommend not using the source code"  
                  }
                }
              }
            
            }
            
        
        
  } 
}
