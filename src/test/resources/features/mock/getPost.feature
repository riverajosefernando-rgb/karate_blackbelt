Feature: Get posts

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    * def postSchema = read('classpath:models/postSchemaMock.json')

  @mock1
  Scenario: Get all posts

    Given url baseUrl + '/posts'

    When method GET

    Then status 200

    And match response == '#[]'

    And print 'Total posts:', response.length

    And match each response == postSchema



  @mock2
  Scenario: Get post by id

    * def postId = 1

    Given url baseUrl + '/posts/' + postId

    When method GET

    Then status 200

    And match response.id == postId

    And print 'Post response:', response