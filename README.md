up-and-down
===========

up 'n down

POST /parties - creates party, returns vanity id
POST /parties/4252/user?name=Klaus - creates user Klaus
GET /parties/4252 - returns:
{
  "movies" : null,
  "users" : []
}

GET /parties/4252/questions - returns all unanswered questions
PUT /parties/4252/questions/19 - request body "true" or "false"