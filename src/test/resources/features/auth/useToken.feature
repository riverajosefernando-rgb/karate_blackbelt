Feature: Get posts using AuthProvider

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

# Obtener token usando AuthProvider
    * def auth = callonce read('classpath:features/auth/authProvider.feature') { source: 'fake', user: 'jperez' }

# extraer token
    * def authToken = auth.authToken

    * print 'AUTH TOKEN:', authToken


  @black
  Scenario: Get posts with authentication

    Given url baseUrl + '/posts'

    And header Authorization = 'Bearer ' + authToken

    When method GET

    Then status 200

    And match response == '#[]'

    * print 'Response size:', response.length