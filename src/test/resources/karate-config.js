function fn() {

  var env = karate.env;
  if (!env) {
    env = 'dev';
  }

  var config = {
    baseUrl: 'https://jsonplaceholder.typicode.com'
  };

  if (env == 'qa') {
    config.baseUrl = 'https://qa-api.mycompany.com';
  }

  if (env == 'prod') {
    config.baseUrl = 'https://api.mycompany.com';
  }

  return config;
}