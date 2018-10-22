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

```
GET /recipes
```

### Get Recipe Details

```
GET /recipe/1
```