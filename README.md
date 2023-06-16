# EasyMeal_Cloud Computing
![EasyMeal](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC/assets/97155903/1568123a-f59e-4cb0-8c62-085af733276c)

Hello guys!! this is backend from application Easy Meal

# EasyMeal-Cloud Computing
Hello, this is backend EasyMeal application made by Capstone Team C23-PC677
if you want to know our team member please check this [link](https://github.com/Team-EasyMeal-C23-PC677#-team-member)

# Table of Contents
- [Introduction](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#cloud-computing-team)
- [CC Team](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#cloud-computing-team)
- [What We Do?](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#what-we-do)
- [What We Use?](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#what-services-that-we-use-in-gcp)
- [Endpoints](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#endpoint)
- [Tutorial](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#how-to-)
- [Cloud Architecture](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#cloud-architecture)

# Cloud Computing Team

|  Name | Bangkit ID | Contacts |
| ------------ | ------------ | ------------ |
| Galang Adi Putra Pratama Lissanto	 | C125DKX4622 | [Github](https://github.com/GalangHaze) & [Linkedin](https://www.linkedin.com/in/galang-adi-putra-pratama-lissanto-2603991b0/)|
| Jihan Defina Rani	 | C163DSY0793	| [Github](https://github.com/JihanDefina28) & [Linkedin](https://www.linkedin.com/in/jihan-defina/) |

# What We Do?
We build backend applications as an intermediary between Database and Mobile Development using NodeJS & MySQL. After that, we deploy all the code to Google Cloud Platform

# What Services that we use in GCP?
|   Google Cloud Services |                                Platform                                |
| :----------------: | :----------------------------------------------------------------: |
|   Cloud App Engine     |      NodeJS (Backend)                        |
| Cloud Storage |  Images & Dataset          |
| Cloud SQL |  Database (MySQL)          |

# Endpoint

|  Endpoint | Method | Body Request (JSON) | Body Response (JSON) |
| ------------ | ------------ | ------------ | ------------ |
| / | GET | - | Response to this server is success |
| /ingredients | GET | - | ing_id, ing_name, categories_name |
| /pantry/:userId | GET | - | ing_id, ing_name, categories_name |
| /shopping-list/:userId | GET | qty, unit | ing_id, ing_name, qty, unit |
| /recipe | GET | - | recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url |
| /recipe/:recipeId | GET | - | recipe, listIngredients, listStep |
| /favorite/:userId | GET | - | recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url |
| /recipes/:userId' | GET | - | recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url |
| /register | POST | nama_profil, email, password | Register Successful |
| /login | POST | email, password | Success Login |
| /pantry/:userId/:ingId | POST | - | Success add to Pantry |
| /shopping-list/:userId/:ingId | POST | - | Success add to Shopping List |
| /favorite/:userId/:recipeId | POST | - | Success add Favorite |
| /user/:user_id | Put | nama_profil | Success change Name |
| /pantry/:userId/:ingId | Delete | - | Success Delete Ingredient |
| /shopping-list/:userId/:ingId | Delete | - | Success delete List  |
| /favorite/:userId/:recipeId | Delete | - | Success Unlist Recipe |

# How To ?

Prepare your code in local device

1. Prepare your GCP project
2. Create your Cloud SQL and create database
3. Import "recipe.sql" to your Cloud SQL
4. Open terminal and make sure you're in backend-nanamyuk directory
5. Replace line 11-14 in "/routes/recipe.js" to your Cloud SQL data
6. Run "npm run start" in your terminal (make sure nodemon is installed if you're running on local device)
7. Try open your browser and put the same link and port with your localhost (Ex: http://localhost:8080)
8. If you're trying to use HTTP Request on you endpoint link please look at [this](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC#endpoint)


Deploy your code in Google App Engine
1. Prepare your GCP project
2. Open App Engine and if you don't know how to use it please follow this [link](https://cloud.google.com/appengine/docs/standard/nodejs/create-app)
3. After App Engine installed upload all the code to Cloud Shell and change "backend" to "default" in "app.yaml" file if this is your first time using App Engine
4. Replace back "default" to "backend" and re-deploy your code
5. Now you have link endpoint globally in the internet and everyone can use it :)

# Cloud Architecture
![Cloud Diagram baru](https://github.com/Team-EasyMeal-C23-PC677/EasyMeal_CC/assets/97155903/cdbd5cc4-c728-4889-9b63-18d577b57468)
