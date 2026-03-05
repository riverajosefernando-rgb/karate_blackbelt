Feature: Get posts

  Scenario: Get post by id

    Given url baseUrl + '/posts/1'
    When method GET
    Then status 200
    And match response.id == 1


  Scenario Outline: Get post by id multiple

    Given url baseUrl + '/posts/<id>'
    When method GET
    Then status 200
    And match response.id == <id>

    Examples:
      | id |
      | 1 |
      | 2 |
      | 3 |