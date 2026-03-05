Feature: Authentication selecting user from TXT file

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  Scenario: Login selecting user dynamically

    Given url baseUrl + '/auth/login'

    * def targetUser = 'jperez'

    * def credentialsFile = read('classpath:config/credentials.txt')

    * def credentialLoader = read('classpath:utils/auth/credentialLoader.js')

    * def user = credentialLoader(credentialsFile, targetUser)

    * def username = user.username
    * def password = user.password

    * print 'Selected user:', username

    * def loginRequest = read('classpath:data/auth/loginRequest.json')

    And request loginRequest

    When method POST

    Then status 200

    * def authToken = response.token

    * print 'Generated token:', authToken