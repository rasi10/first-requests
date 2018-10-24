*** Settings ***
Library                                            HttpLibrary.HTTP
Library                                            String

Resource                                           client-operations.robot


*** Test cases***
Test case 1 - Requesting data of a specific client
   Request Data From Specific Client               1
      
    
Test case 2 - Create a new client
    Create a New Client With Random Data  
    