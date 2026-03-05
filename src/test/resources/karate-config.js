function fn() {

  var env = karate.env;
  if (!env) {
    env = 'dev';
  }

  karate.log('Environment:', env);

  var config = {
    baseUrl: 'https://jsonplaceholder.typicode.com'
  };

  // configuración por ambiente
  if (env == 'qa') {
    config.baseUrl = 'https://qa-api.mycompany.com';
  }

  if (env == 'prod') {
    config.baseUrl = 'https://api.mycompany.com';
  }

  // tipo de autenticación
  config.authSource = 'fake'; // fake | json | txt

  // usuario
  config.authUser = 'jperez';

  // obtener token usando AuthProvider
  var auth = karate.callSingle('classpath:features/auth/authProvider.feature', {
      source: config.authSource,
      user: config.authUser
  });

  config.authToken = auth.authToken;

  karate.log('Generated Global Token:', config.authToken);

  return config;
}