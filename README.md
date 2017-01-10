# feedbk

Feedbk is an app that lets managers give their employees feedback in short (150 chars or less) snippets.  Feedbk also lets managers set goals for each employee.  Managers can write feedback and choose whether or not to attach a goal to it.

### API Documentation
The JSON API Documentation lives at localhost:3000/docs.  Make sure you set your Accept header to 'application/json' or else the API may return HTML.  Your requests should also be in JSON.

### API Authentication
To login via JSON, use the POST /users/sign_in endpoint.  

Your request should look like this:

```javascript
{
    "user": {
        "email": "rwiggum@gmail.com",
        "password": "muffins1"
    }
}
```

And your response will look like the below JSON.  You will get an authentication_token in the response.

```javascript
{
    "id": "327592a3-04a0-4907-a174-588aa64abbba",
    "email": "rwiggum@gmail.com",
    "created_at": "2015-12-09T05:28:25.198Z",
    "updated_at": "2015-12-21T03:15:44.799Z",
    "first_name": "Ralph",
    "last_name": "Wiggum",
    "username": "rwiggum",
    "team_id": 1,
    "avatar_file_name": "HappyCat.png",
    "avatar_content_type": "image/png",
    "avatar_file_size": 944948,
    "avatar_updated_at": "2015-12-09T05:43:23.470Z",
    "manager_id": "a3db9a59-594c-4bd1-917a-7766cbca09d7",
    "job_title": "Meow Co",
    "deleted": false,
    "authentication_token": "t48ArfuJhFfRm7pE3gdu"
}
```

You should send the authentication token with every request as a query parameter named "auth_token".  A typical request to get goals for a user might look like this:

```
GET /users/c756f7dc-632e-4ab5-904d-33f9f0a25b94/goals?auth_token=ajQ-4a3Vi2-Jz3_bGc45 HTTP/1.1
Host: localhost
Accept: application/json
User-Agent: Paw/2.2.7 (Macintosh; OS X/10.10.5) ASIHTTPRequest/v1.8.1-61
Content-Type: application/json
Accept-Encoding: gzip
```

To logout, use the DELETE /users/sign_out endpoint.

## Testing
* run 'bundle exec cucumber' to run the BDD tests in the features folder.
* run 'rspec spec' to run the api integration tests in the spec folder

## Models
Every user has a manager, except for admins.  A user can have many goals, feedbacks, replies, and invites.  A user also has a team, which identifies the company for which they work and the domain name their company admin used to sign up.

## Deployment
The app has usually been deployed to heroku, in which case the only work you'll need to deploy it is push it to heroku, add a PostgreSQL database to your project on heroku, set the environment variables, and run "heroku run rake db:migrate"

### Environment Variables
Below is a list of the environment variables with descriptions.  All are mandatory for deployment.

```
=== feedbk Config Vars
AWS_ACCESS_KEY_ID:          Your AWS access key id, used for S3 for storing profile photos
AWS_SECRET_ACCESS_KEY:      Your AWS secret access key, also used for S3 for user photos
DATABASE_URL:               The URL to a Postgres database accessible from your deployment server.  If you add a Postgres database to your project on heroku, this is automatically set for you.
DOMAIN:                     The domain name to use when creating links in emails.  Should be www.feedbk.co.
MAILGUN_API_KEY_PRODUCTION: Your mailgun API key for sending out forgot password emails, feedback emails, goal emails, and reply emails.
MAILGUN_DOMAIN_PRODUCTION:  Your mailgun domain name
MAILGUN_FROM_ADDRESS:       Your mailgun from address.  For example: "Feedbk <feedbk@mg.feedbk.co>""
RACK_ENV:                   This must be set to "production"
RAILS_ENV:                  This must be set to "production"
S3_BUCKET_NAME:             Your Amazon S3 bucket name where all the user photos will be stored
SECRET_KEY_BASE:            A rails secret key base.  If you are deploying to heroku, this will be automatically set for you.
```
