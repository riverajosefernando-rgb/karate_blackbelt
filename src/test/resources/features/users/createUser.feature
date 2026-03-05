Feature: Create user reusable

  Scenario: Create user

    Given url baseUrl + '/users'
    And request userData
    When method POST
    Then status 201

    * def createdUser = response