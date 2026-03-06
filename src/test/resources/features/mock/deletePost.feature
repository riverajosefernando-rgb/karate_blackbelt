Feature: Delete post by index

  @mock5
  Scenario: Delete index 0

    Given url baseUrl + '/posts/index/0'

    When method DELETE

    Then status 200

    And match response ==
"""
{
 message: "deleted by index"
}
"""

@mock
  Scenario: Delete id 2

    Given url baseUrl + '/posts/2'

    When method DELETE

    Then status 200

    And match response ==
"""
{
 message: "Post deleted successfully"
}
"""