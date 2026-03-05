Feature: Authentication Provider

  Scenario: Select authentication source

    * def sourceType = source
    * def targetUser = user

# definir qué feature usar
    * def authFeature =
"""
function(sourceType){
  if(sourceType == 'json') return 'classpath:features/auth/getTokenFromJson.feature';
  if(sourceType == 'txt') return 'classpath:features/auth/getTokenFromTxt.feature';
  if(sourceType == 'fake') return 'classpath:features/auth/getTokenFake.feature';
  throw 'Invalid auth source: ' + sourceType;
}
"""

# obtener ruta del feature
    * def featurePath = authFeature(sourceType)

# ejecutar feature seleccionado
    * def tokenResponse = call read(featurePath) { user: '#(targetUser)' }

# extraer token
    * def authToken = tokenResponse.authToken

    * print 'Auth source:', sourceType
    * print 'Generated token:', authToken