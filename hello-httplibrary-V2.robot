*** Settings ***
Library                            HttpLibrary.HTTP
Library                            String


*** keywords ***
Generate a Random Client
    ${id}=                           Set Variable                   100
    ${name}=                         Generate random String         10                  [LOWER]
    ${createDate}=                   Set Variable                   1473633063279
    ${email}=                        Catenate                       SEPARATOR=          ${name}        @email.com
    ${socialSecurityNumber}=         Generate Random String         9                   [NUMBERS]
    ${gender}=                       Generate Random String         1                   MF
    ${dictionary}=                   Create Dictionary  id=${id}    name=${name}  
                                     ...  createDate=${createDate}  email=${email}      gender=${gender}   
                                     ...  socialSecurityNumber=${socialSecurityNumber}
    ${client_json}=                  Stringify Json                 ${dictionary}
    [return]                         ${client_json}


*** Test cases***
Test case 1 - Requesting data of client with id 1
    Create Http Context           localhost:8080                      http
    Get                           /hotel-rest/webresources/client/1
    ${body}=                      Get Response Body
    ${status}=                    Get Response Status        
    Should contain                ${status}                           200
    
      
    
Test case 2 - Create a new client
    Create Http Context           localhost:8080                      http
    ${client_json}=               Generate a Random Client        
    #log to console                ${client_json}
    Set request Body              ${client_json}
    Set Request Header            Content-Type                        application/json
    #Set Request Header            Accept                              */*
    
    Post                          /hotel-rest/webresources/client/
    ${status}=                    Get Response Status        
    Should contain                ${status}                           204
    
    