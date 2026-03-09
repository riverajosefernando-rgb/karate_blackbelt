Feature: Update post

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  @mock
  Scenario: Update post

    Given url baseUrl + '/posts/3'

    And request
"""
{
 title: "updated title",
 body: "updated body"
}
"""

    When method PUT

    Then status 200

    And match response.title == 'updated title'