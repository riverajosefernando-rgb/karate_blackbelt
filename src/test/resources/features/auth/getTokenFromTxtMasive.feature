Feature: Authentication using users loaded dynamically from TXT

  Background:

    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    # leer archivo de credenciales
    * def credentialsFile = karate.readAsString('classpath:config/credentials.txt')

    # cargar utility
    * def credentialLoader = call read('classpath:utils/auth/credentialLoader.js')

    # obtener todos los usuarios
    * def users = credentialLoader.getAllUsers(credentialsFile)

    * print 'Users loaded:', users


  @test
  Scenario: Login for all users dynamically

    * def loginFunction =
    """
    function(user){

        karate.log('Testing user:', user.username)

        karate.call('classpath:features/auth/login.feature',
        {
            username: user.username,
            password: user.password
        })

    }
    """

    * karate.forEach(users, loginFunction)