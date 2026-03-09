Feature: Authentication selecting user from TXT file

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    # cargar archivo de credenciales
    * def credentialsFile = karate.readAsString('classpath:config/credentials.txt')

    # cargar utility correctamente
    * def credentialLoader = call read('classpath:utils/auth/credentialLoader.js')


  Scenario: Login selecting user dynamically from single user

    Given url baseUrl + '/auth/login'

    * def targetUser = 'jperez'

    # obtener usuario dinámicamente
    * def user = credentialLoader.getCredentials(credentialsFile, targetUser)

    * def username = user.username
    * def password = user.password

    * print 'Selected user:', username

    * def loginRequest = read('classpath:data/auth/loginRequest.json')

    And request loginRequest
    When method POST
    Then status 200

    * def authToken = response.token
    * print 'Generated token:', authToken


  Scenario Outline: Login using users from TXT multiple users

    Given url baseUrl + '/auth/login'

    * def targetUser = '<user>'

    # obtener usuario dinámicamente
    * def user = credentialLoader.getCredentials(credentialsFile, targetUser)

    * def username = user.username
    * def password = user.password

    * print 'Selected user:', username

    * def loginRequest = read('classpath:data/auth/loginRequest.json')

    And request loginRequest
    When method POST
    Then status 200

    * def authToken = response.token
    * print 'Generated token:', authToken

    Examples:
      | user  |
      | maria |