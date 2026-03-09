Feature: Create post using mock

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  @mock
  Scenario: Create post

    Given url baseUrl + '/posts'

    And request
"""
{
 title: "new post",
 body: "testing mock "
}
"""

    When method POST

    Then status 201

    And match response.title == 'new post'