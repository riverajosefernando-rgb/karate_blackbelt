Feature: Validate response delay

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    * def responses = read('classpath:test-data/responses/mockResponses.json')


  @mock
  Scenario: Validate slow endpoint takes at least 3 seconds

    Given url baseUrl + '/slow'

    When method GET

    Then status 200

    And match response == responses.slowResponse

    * assert responseTime >= 3000