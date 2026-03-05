Feature: Create post using model

  Scenario: Create post simple with model

    * def payload =
"""
{
  title: 'Karate Framework',
  body: 'Automation testing',
  userId: 1
}
"""

    * def model = read('classpath:models/postModel.json')
    * def requestBody = karate.merge(model, payload)

    Given url baseUrl + '/posts'
    And request requestBody
    When method POST
    Then status 201
    And match response.title == 'Karate Framework'


