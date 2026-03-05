Feature: Authentication selecting user from JSON

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  Scenario: Login selecting user dynamically

    Given url baseUrl + '/auth/login'

# usuario a usar
    * def targetUser = 'maria'

# leer archivo JSON
    * def credentials = read('classpath:config/credentials.json')

# cargar selector
    * def userSelector = read('classpath:utils/userSelector.js')

# seleccionar usuario
    * def user = userSelector(credentials, targetUser)

    * def username = user.username
    * def password = user.password

    * print 'Selected user:', username
    * print 'User role:', user.role

# cargar request
    * def loginRequest = read('classpath:data/auth/loginRequest.json')

    And request loginRequest

    When method POST

    Then status 200

    * def authToken = response.token

    * print 'Generated token:', authToken