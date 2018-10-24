*** Variables ***
${http context localhost}=           localhost:8080
${http context variable}=            http
${header content json}=              application/json
    
${get client endpoint}=              /hotel-rest/webresources/client/
${put create client endpoint}=       /hotel-rest/webresources/client/

${response 200}                      200
${response 204}                      204 

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
        
    
Request Data From Specific Client    [Arguments]                                         ${client_id}
    Create Http Context              ${http context localhost}                           ${http context variable}
    Get                              ${get client endpoint}${client_id}
    ${body}=                         Get Response Body
    ${status}=                       Get Response Status        
    Should contain                   ${status}                                           ${response 200}
    
Create a New Client With Random Data
    Create Http Context              ${http context localhost}                           ${http context variable}            
    ${client_json}=                  Generate a Random Client        
    Set request Body                 ${client_json}
    Set Request Header               Content-Type                                        ${header content json}
    Post                             ${put create client endpoint}
    ${status}=                       Get Response Status        
    Should contain                   ${status}                                           ${response 204}