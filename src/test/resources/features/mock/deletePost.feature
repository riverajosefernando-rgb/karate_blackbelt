Feature: Delete post by index

  @mock
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

    And match response.message == '#string'

    And match response ==
"""
{
 message: "Post deleted successfully"
}
"""

 @mock
  Scenario: Delete non existing post

    Given url baseUrl + '/posts/999'
    When method DELETE
    Then status 404
    And match response ==
"""
{
  message: "Post not found"
}
"""