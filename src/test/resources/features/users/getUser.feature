Feature: Get user information

  Scenario: Get user by id

    Given url baseUrl + '/users/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response contains
    """
    {
      id: 1,
      username: '#string',
      email: '#string'
    }
    """