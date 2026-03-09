Feature: Create posts data driven

  Background:
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

 @test1
  Scenario Outline: Create post with Data Driven Test with logs

Given url baseUrl + '/posts'
And request { title: '<title>', body: '<body>', userId: <userId> }
When method POST
Then status 201

Examples:
| read('classpath:data/postData.json') |