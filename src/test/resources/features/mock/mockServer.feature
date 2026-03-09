Feature: Advanced Mock Server

  Background:

    * configure cors = true

# base de datos en memoria
    * def posts = read('classpath:mock-data/posts.json')

# Get method
  Scenario: pathMatches('/posts') && methodIs('get')

    * def response = posts
    * def responseStatus = 200

# Get method with Id
  Scenario: pathMatches('/posts/{id}') && methodIs('get')

    * def id = pathParams.id
    * def post = karate.filter(posts, function(x){ return x.id == id })[0]

    * if (!post) karate.abort()

    * def response = post
    * def responseStatus = 200

# Post method
  Scenario: pathMatches('/posts') && methodIs('post')

    * def newPost = request

    * def newId = posts.length + 1

    * set newPost.id = newId

    * eval posts.push(newPost)

    * def response = newPost
    * def responseStatus = 201

# Put method
  Scenario: pathMatches('/posts/{id}') && methodIs('put')

    * def id = parseInt(pathParams.id)
    * def updated = request

    * def index = posts.findIndex(x => x.id == id)

    * if (index == -1) karate.abort()

    * set updated.id = id
    * eval posts[index] = updated

    * def response = updated
    * def responseStatus = 200

  # DELETE by index
  Scenario: pathMatches('/posts/index/{index}') && methodIs('delete')

    * def index = parseInt(pathParams.index)

    * if (index < 0 || index >= posts.length) karate.abort()

    * eval posts.splice(index,1)

    * def response =
    """
    {
      message: "deleted by index"
    }
    """

    * def responseStatus = 200


# DELETE by id
  Scenario: pathMatches('/posts/{id}') && methodIs('delete')

    * def id = parseInt(pathParams.id)

    * def index = posts.findIndex(function(x){ return x.id == id })

    * eval
    """
    if(index > -1){
        posts.splice(index,1);
    }
    """

    * def response =
    """
    index > -1 ?
    { message: 'Post deleted successfully' } :
    { message: 'Post not found' }
    """

    * def responseStatus = index > -1 ? 200 : 404


#  Errors

  Scenario: pathMatches('/error')

    * def response =
"""
{
  message: "Internal server error"
}
"""

    * def responseStatus = 500


  # Delays (Latencia)

  Scenario: pathMatches('/slow') && methodIs('get')

    * def delay = requestParams.delay ? parseInt(requestParams.delay) : 3000

    * def responseDelay = delay

    * def response =
"""
{
  message: "slow response"
}
"""

    * def responseStatus = 200