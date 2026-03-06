Feature: Update post

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  @mock4
  Scenario: Update post

    Given url baseUrl + '/posts/1'

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