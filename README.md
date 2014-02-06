up-and-down
===========

up 'n down

GET /parties - Creates party
POST /parties/4252/user?name=Klaus - Creates user Klaus
GET /parties/4252 - Returns:
{
  "movies" : null,
  "users" : []
}

GET /parties/4252/questions - Returns all unanswered questions
PUT /parties/4252/questions/19 - Request body "true" or "false"