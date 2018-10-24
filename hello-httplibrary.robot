*** Settings ***
Library                            HttpLibrary.HTTP


*** Test cases***
Test case 1 - Requesting data of client with id 1
    Create Http Context           localhost:8080                      http
    Get                           /hotel-rest/webresources/client/1
    ${body}=                      Get Response Body
    ${status}=                    Get Response Status        
    Should contain                ${status}                           200
    
      
    
Test case 2 - Create a new client
    Create Http Context           localhost:8080                      http
    ${client_dictionary}=         Create Dictionary                   id=100    
                                  ...  name=name                      createDate=1212121212  
                                  ...  email=namea@email.com          gender=M  
                                  ...  socialSecurityNumber=1a212
    
    ${client_json}=               Stringify Json                      ${client_dictionary}                              
    Set request Body              ${client_json}
    Set Request Header            Content-Type                        application/json
    #Set Request Header            Accept                              */*
    
    Post                          /hotel-rest/webresources/client/
    ${status}=                    Get Response Status        
    Should contain                ${status}                           204
    
    