Feature: Contract validation for Post API

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

  Scenario: Validate contract of GET post

    Given url baseUrl + '/posts/1'

    When method GET

    Then status 200

    And match response == read('classpath:models/postSchema.json')