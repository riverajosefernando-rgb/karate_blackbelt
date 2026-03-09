function fn() {

  function validateFile(fileContent) {
      if (!fileContent) {
          throw "credentials.txt no fue cargado o está vacío";
      }
  }

  function getCredentials(fileContent, targetUser) {

      validateFile(fileContent);

      var lines = fileContent.split('\n');

      for (var i = 0; i < lines.length; i++) {

          if (lines[i].includes('username=' + targetUser)) {

              return {
                  username: lines[i].split('=')[1].trim(),
                  password: lines[i + 1].split('=')[1].trim()
              };
          }
      }

      throw "Usuario no encontrado en credentials.txt: " + targetUser;
  }


  function getAllUsers(fileContent) {

      validateFile(fileContent);

      var lines = fileContent.split('\n');
      var users = [];

      for (var i = 0; i < lines.length; i++) {

          if (lines[i].includes('username=')) {

              users.push({
                  username: lines[i].split('=')[1].trim(),
                  password: lines[i + 1].split('=')[1].trim()
              });

          }
      }

      return users;
  }


  function getRandomUser(fileContent) {

      var users = getAllUsers(fileContent);

      var index = Math.floor(Math.random() * users.length);

      return users[index];
  }


  return {
      getCredentials: getCredentials,
      getAllUsers: getAllUsers,
      getRandomUser: getRandomUser
  };

}