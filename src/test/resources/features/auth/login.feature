Feature: Login reusable

  Scenario: login user

    Given url baseUrl + '/auth/login'

    And request
    """
    {
      username: '#(username)',
      password: '#(password)'
    }
    """

    When method POST
    Then status 200

    * def token = response.token
    * print 'Generated token for', username, ':', token