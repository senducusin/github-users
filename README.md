**Github Users List**

An app that displays Github users.

This app does not use storyboards except for the launch screen.  
A sample app that demonstrates CRUD operations in realm. The data model is also set to Codable and can be used directly to fetch data from the API.

Note:   
RealmSwift has an open bug which the decoder fails if the key of an optional property is missing (https://github.com.cnpmjs.org/realm/realm-cocoa/issues/6991).  
This currently prevents the app to use a single model to fetch from Github's API. Fix will soon be applied after Realm fixes this issue.

---

## Features

- Loads and store Github users
- Search users from local database by username (login)
- Lazy loading. Automatically loads a new batch of users when reached the bottom of the view.
- Add a note on each user. If a note is added to a user, a note indicator is displayed on the list.

---

## Demo