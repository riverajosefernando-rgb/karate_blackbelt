Feature: Get authentication token basic

  Scenario: Login basic

    Given url baseUrl + '/auth/login'

    And request
"""
{
 username: "admin",
 password: "password"
}
"""

    When method POST

    Then status 200

    * def authToken = response.token