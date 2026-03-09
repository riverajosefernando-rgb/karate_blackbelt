Feature: Get posts

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    * def postSchema = read('classpath:models/postSchemaMock.json')

  @mock
  Scenario: Get all posts

    Given url baseUrl + '/posts'

    When method GET

    Then status 200

    And match response == '#[]'

    And print 'Total posts:', response.length

    And match each response == postSchema



  @mock
  Scenario: Get post by id

    * def postId = 3

    Given url baseUrl + '/posts/' + postId

    When method GET

    Then status 200

    And match response.id == postId

    And print 'Post response:', response