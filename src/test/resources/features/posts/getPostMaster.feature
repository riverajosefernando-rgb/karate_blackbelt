Feature: Get posts using global auth token

Background:

* configure logPrettyRequest = true
* configure logPrettyResponse = true

  @black
  Scenario: Get posts with global auth token

Given url baseUrl + '/posts'

And header Authorization = 'Bearer ' + authToken

When method GET

Then status 200

And match response == '#[]'

* print 'Posts returned:', response.length