# An API server backend

This Go AppEngine API server acts as a backend for our Flutter Food app.

## Deploying

Assuming you have created a [Google Cloud Platform](https://cloud.google.com/)
project, and installed [`gcloud` tooling](https://cloud.google.com/sdk/gcloud/),
deploying this API server should be as simple as:

```bash
$ gcloud app deploy
Services to deploy:

descriptor:      [/Users/brettmorgan/Documents/GitHub/sydney-flutter-jam/week3/week_3_gae_api/app.yaml]
source:          [/Users/brettmorgan/Documents/GitHub/sydney-flutter-jam/week3/week_3_gae_api]
target project:  [flutter-recipe-api]
target service:  [default]
target version:  [20181022t163020]
target url:      [https://flutter-recipe-api.appspot.com]


Do you want to continue (Y/n)?  y

Beginning deployment of service [default]...
╔════════════════════════════════════════════════════════════╗
╠═ Uploading 1 file to Google Cloud Storage                 ═╣
╚════════════════════════════════════════════════════════════╝
File upload done.
Setting traffic split for service [default]...done.
Deployed service [default] to [https://flutter-recipe-api.appspot.com]

You can stream logs from the command line by running:
  $ gcloud app logs tail -s default

To view your application in the web browser run:
  $ gcloud app browse
```

## The Recipe API

### List Recipes

```bash
$ curl https://flutter-recipe-api.appspot.com/recipes/
[
   {
      "id":1,
      "name":"Macaroni Cheese",
      "short_description":"An all too cheesy home cooked favourite",
      "image_id":"fxm3oIlRapk"
   },
   {
      "id":2,
      "name":"Spaghetti Bolognese",
      "short_description":"A heart warming classic, perfect for a cold winter's night",
      "image_id":"JDEEsQKEm7I"
   }
]
```

### Get Recipe Details

```bash
$ curl https://flutter-recipe-api.appspot.com/recipes/2
{
   "id":2,
   "name":"Spaghetti Bolognese",
   "short_description":"A heart warming classic, perfect for a cold winter's night",
   "image_id":"JDEEsQKEm7I",
   "ingredients":[
      {
         "quantity":2,
         "measure":"tbs",
         "ingredient":"Olive oil"
      },
      {
         "quantity":2,
         "measure":"",
         "ingredient":"Brown onion"
      },
      {
         "quantity":4,
         "measure":"cloves",
         "ingredient":"Garlic"
      },
      {
         "quantity":1,
         "measure":"kg",
         "ingredient":"Beef mince"
      },
      {
         "quantity":90,
         "measure":"g",
         "ingredient":"Tomato paste"
      },
      {
         "quantity":500,
         "measure":"ml",
         "ingredient":"Beef stock"
      },
      {
         "quantity":2,
         "measure":"cans",
         "ingredient":"Chopped tomatoes"
      },
      {
         "quantity":1,
         "measure":"",
         "ingredient":"Bay leaf"
      },
      {
         "quantity":400,
         "measure":"g",
         "ingredient":"Spaghetti"
      },
      {
         "quantity":50,
         "measure":"g",
         "ingredient":"Shaved Parmesan"
      }
   ],
   "preparation":[
      {
         "step":"Roughly chop brown onions"
      },
      {
         "step":"Skin and finely mince garlic"
      }
   ],
   "cooking":[
      {
         "step":"Heat oil in a pan, once shimmering add onion and stir over medium heat until softened"
      },
      {
         "step":"Add garlic and cook for 20 seconds, until fragrant"
      },
      {
         "step":"Add Beef mince and cook for 5 minutes, breaking apart and turning until browned all over"
      },
      {
         "step":"Add tomatoes, tomato paste, beef stock and season with salt and pepper. Bring to a boild, then simmer for an hour until reduced"
      },
      {
         "step":"Cook pasta in salted water until al dente"
      },
      {
         "step":"Reserve a couple of cups of the pasta water,then drain the pasta"
      },
      {
         "step":"In a frypan combine the pasta, a healthy serving of sauce, and some pasta water. Agitate over heat until combined"
      }
   ]
}
```