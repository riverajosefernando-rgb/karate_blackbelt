Feature: Get authentication token

  Scenario: Login advanced

    Given url baseUrl + '/auth/login'

# leer archivo de credenciales
    * def credentials = read('classpath:config/credentials.txt')

# convertir texto a variables
    * def username = credentials.split('\n')[0].split('=')[1]
    * def password = credentials.split('\n')[1].split('=')[1]

# leer request externo
    * def loginRequest = read('classpath:data/auth/loginRequest.json')

    And request loginRequest

    When method POST

    Then status 200

    * def authToken = response.token