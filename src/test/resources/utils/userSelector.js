function selectUser(credentials, targetUser) {

    for (var i = 0; i < credentials.users.length; i++) {

        if (credentials.users[i].username == targetUser) {
            return credentials.users[i];
        }
    }

    throw "User not found: " + targetUser;
}