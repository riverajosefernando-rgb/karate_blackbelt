function getCredentials(fileContent, targetUser) {

    var lines = fileContent.split('\n');

    var username = '';
    var password = '';

    for (var i = 0; i < lines.length; i++) {

        if (lines[i].includes('username=' + targetUser)) {

            username = lines[i].split('=')[1].trim();
            password = lines[i + 1].split('=')[1].trim();

            break;
        }
    }

    return {
        username: username,
        password: password
    };
}