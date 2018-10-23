// Copyright 2018 Google Inc. All rights reserved.
// Use of this source code is governed by the Apache 2.0
// license that can be found in the LICENSE file.

package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

// Ingredient is an ingredient used in a recipe
type Ingredient struct {
	Quantity   int    `json:"quantity"`
	Measure    string `json:"measure"`
	Ingredient string `json:"ingredient"`
}

// Step is a step in the preparation and/or cooking of a recipe
type Step struct {
	Description string `json:"step"`
}

// Recipe is a description of how to cook a dish
type Recipe struct {
	ID               int          `json:"id"`
	Name             string       `json:"name"`
	ShortDescription string       `json:"short_description"`
	ImageID          string       `json:"image_id"`
	Ingredient       []Ingredient `json:"ingredients"`
	Preparation      []Step       `json:"preparation"`
	Cooking          []Step       `json:"cooking"`
}

// RecipeHeader is the highlights of a recipe for a summary view.
type RecipeHeader struct {
	ID               int    `json:"id"`
	Name             string `json:"name"`
	ShortDescription string `json:"short_description"`
	ImageID          string `json:"image_id"`
}

// Recipes is a list of recipes headers, for a summary view.
type Recipes struct {
	Recipes []RecipeHeader `json:"recipes"`
}

var recipes = []Recipe{
	{
		1,
		"Macaroni Cheese",
		"An all too cheesy home cooked favourite",
		"fxm3oIlRapk",
		[]Ingredient{
			{500, "g", "Macaroni"},
			{50, "g", "Butter"},
			{2, "tbs", "Flour"},
			{500, "ml", "Milk"},
			{300, "g", "Tasty cheese"},
			{50, "g", "Panko breadcrumbs"},
			{125, "g", "Bacon"},
		},
		[]Step{
			{"Grate tasty cheese"},
			{"Dice bacon"},
			{"Preheat oven to 200 degrees C"},
			{"Grease oven proof dish with butter"},
		},
		[]Step{
			{"Cook macaroni until almost al dente"},
			{"Warm milk in microwave or small pan"},
			{"Melt butter in a pan"},
			{"Work flour into melted butter and cook for a minute over medium heat"},
			{"Slowly work warmed milk into butter & flour mixture, stiring constantly until smooth. Bring to the boil, then simmer for a couple of minutes."},
			{"Remove the mixture from the heat and fold in the grated cheese, bacon, and cooked macaroni"},
			{"Put mixture in oven proof dish, cover with Panko breadcrumbs, season with salf and pepper, and cook for 15 minutes"},
		},
	},
	{
		2,
		"Spaghetti Bolognese",
		"A heart warming classic, perfect for a cold winter's night",
		"JDEEsQKEm7I",
		[]Ingredient{
			{2, "tbs", "Olive oil"},
			{2, "", "Brown onion"},
			{4, "cloves", "Garlic"},
			{1, "kg", "Beef mince"},
			{90, "g", "Tomato paste"},
			{500, "ml", "Beef stock"},
			{2, "cans", "Chopped tomatoes"},
			{1, "", "Bay leaf"},
			{400, "g", "Spaghetti"},
			{50, "g", "Shaved Parmesan"},
		},
		[]Step{
			{"Roughly chop brown onions"},
			{"Skin and finely mince garlic"},
		},
		[]Step{
			{"Heat oil in a pan, once shimmering add onion and stir over medium heat until softened"},
			{"Add garlic and cook for 20 seconds, until fragrant"},
			{"Add Beef mince and cook for 5 minutes, breaking apart and turning until browned all over"},
			{"Add tomatoes, tomato paste, beef stock and season with salt and pepper. Bring to a boild, then simmer for an hour until reduced"},
			{"Cook pasta in salted water until al dente"},
			{"Reserve a couple of cups of the pasta water, then drain the pasta"},
			{"In a frypan combine the pasta, a healthy serving of sauce, and some pasta water. Agitate over heat until combined"},
		},
	},
}

func main() {

	headersOk := handlers.AllowedHeaders([]string{"Authorization"})
	originsOk := handlers.AllowedOrigins([]string{"*"})
	methodsOk := handlers.AllowedMethods([]string{"GET", "POST", "OPTIONS"})

	var router = mux.NewRouter()
	router.HandleFunc("/", indexHandler).Methods("GET")
	router.HandleFunc("/recipes/", recipesListHandler).Methods("GET")
	router.HandleFunc("/recipes/{id:[0-9]+}", recipeHandler).Methods("GET")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Defaulting to port %s", port)
	}

	log.Printf("Listening on port %s", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), handlers.CORS(originsOk, headersOk, methodsOk)(router)))
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode("Flutter Recipe API")
}

func recipesListHandler(w http.ResponseWriter, r *http.Request) {
	var recipeHeaders []RecipeHeader
	for _, recipe := range recipes {
		recipeHeaders = append(recipeHeaders, RecipeHeader{
			recipe.ID,
			recipe.Name,
			recipe.ShortDescription,
			recipe.ImageID,
		})
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(recipeHeaders)
}

func recipeHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		log.Printf("Couldn't convert id '%v' to int: %v", vars["id"], err)
		http.NotFound(w, r)
		return
	}
	for _, recipe := range recipes {
		if recipe.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(recipe)
			return
		}
	}
	http.NotFound(w, r)
}
