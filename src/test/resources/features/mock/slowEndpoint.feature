Feature: Validate slow endpoint performance

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    * def responses = read('classpath:test-data/responses/mockResponses.json')

  @mock
  Scenario: Validate slow endpoint latency

    * def start = java.lang.System.currentTimeMillis()

    Given url baseUrl + '/slow'
    When method GET
    Then status 200

    * def end = java.lang.System.currentTimeMillis()
    * def elapsed = end - start

    * print 'Measured elapsed time:', elapsed

    * assert elapsed >= 3000
