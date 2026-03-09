Feature: Validate error endpoint

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    * def responses = read('classpath:test-data/responses/mockResponses.json')

  @mock
  Scenario: Validate internal server error

    Given url baseUrl + '/error'

    When method GET

    Then status 500

    And match response == responses.errorResponse