const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const { v4: uuidv4 } = require('uuid');
const router = express.Router();

// Konfigurasi koneksi database
const dbConfig = {
  host: '34.128.86.236',
  user: 'root',
  password: 'password',
  database: 'Ea'
};

const connection = mysql.createConnection(dbConfig);

// Membuka koneksi database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    return;
  }
  console.log('Connected to database');
});

// Menggunakan middleware body-parser untuk parsing body request
router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true }));

// Endpoint GET untuk mendapatkan data userrecipe
router.get('/userrecipe', (req, res) => {
  const selectQuery = 'SELECT user_id, nama_profil, img_url FROM userrecipe';

  connection.query(selectQuery, (err, results) => {
    if (err) {
      console.error('Error retrieving userrecipe data:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.json(results);
  });
});

// Endpoint POST untuk menambah data userrecipe
router.post('/userrecipe', (req, res) => {
  const user_id = uuidv4();
  const nama_profil = req.body;
  const insertQuery = 'INSERT INTO userrecipe (user_id, nama_profil) VALUES (?, ?)';
  const values = [user_id, nama_profil];

  connection.query(insertQuery, values, (err, results) => {
    if (err) {
      console.error('Error adding userrecipe data:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.send('Userrecipe data added successfully');
  });
});

// Endpoint PUT untuk mengupdate data userrecipe berdasarkan user_id
router.put('/userrecipe/:user_id', (req, res) => {
  const user_id = req.params.user_id;
  const nama_profil = req.body;

  const updateQuery = 'UPDATE userrecipe SET nama_profil = ? WHERE user_id = ?';
  const values = [nama_profil, user_id];

  connection.query(updateQuery, values, (err, results) => {
    if (err) {
      console.error('Error updating userrecipe data:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.send('Userrecipe data updated successfully');
  });
});


  // GET ALL INGREDIENTS
router.get('/ingredients', (req, res) => {
    const query = `
      SELECT ingredient.ing_id, ingredient.ing_name, categoris.categories_name AS ing_category
      FROM ingredient
      INNER JOIN categoris ON ingredient.category_id = categoris.id
    `;
    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error getting ingredients:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listIngredient = results.map((row) => ({
        ingId: row.ing_id,
        ingName: row.ing_name,
        ingCategory: row.ing_category,
      }));
  
      res.json({ listIngredient });
    });
  });

  // GET PANTRY INGREDIENTS
router.get('/pantry/:userId', (req, res) => {
    const userId = req.params.userId;
  
    const query = `
      SELECT ingredient.ing_id, ingredient.ing_name, ingredient.ing_category, ingredient.ing_img_url
      FROM pantry
      INNER JOIN ingredient ON pantry.ing_id = ingredient.ing_id
      WHERE pantry.user_id = ?
    `;
    connection.query(query, [userId], (err, results) => {
      if (err) {
        console.error('Error getting pantry ingredients:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listIngredient = results.map((row) => ({
        ingId: row.ing_id,
        ingName: row.ing_name,
        ingCategory: row.ing_category,
        ingImgUrl: row.ing_img_url,
      }));
  
      res.json({ listIngredient });
    });
  });
  
  // ADD PANTRY INGREDIENT
  router.post('/pantry/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId = parseInt(req.params.ingId);
  
    const insertQuery = `
      INSERT INTO pantry (user_id, ing_id)
      VALUES (?, ?)
    `;
    connection.query(insertQuery, [userId, ingId], (err, results) => {
      if (err) {
        console.error('Error adding pantry ingredient:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ message: 'Pantry item added successfully' });
    });
  });
  
  // DELETE PANTRY INGREDIENT
  router.delete('/pantry/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId = parseInt(req.params.ingId);
  
    const deleteQuery = `
      DELETE FROM pantry
      WHERE user_id = ? AND ing_id = ?
    `;
    connection.query(deleteQuery, [userId, ingId], (err, results) => {
      if (err) {
        console.error('Error deleting pantry ingredient:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ message: 'Pantry item deleted successfully' });
    });
  });

  // GET USER SHOPPING LIST
router.get('/shopping-list/:userId', (req, res) => {
    const userId = req.params.userId;
  
    const query = `
      SELECT shopping_list.ing_id, ingredient.ing_name, shopping_list.s_qty AS qty, shopping_list.s_unit AS unit
      FROM shopping_list
      INNER JOIN ingredient ON shopping_list.ing_id = ingredient.ing_id
      WHERE shopping_list.user_id = ?
    `;
    connection.query(query, [userId], (err, results) => {
      if (err) {
        console.error('Error getting user shopping list:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listIngredient = results.map((row) => ({
        ingId: row.ing_id,
        ingName: row.ing_name,
        qty: row.qty,
        unit: row.unit,
      }));
  
      res.json({ listIngredient });
    });
  });
  
  // ADD SHOPPING LIST ITEM
  router.post('/shopping-list/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId = parseInt(req.params.ingId);
    const { qty, unit } = req.body;
  
    const insertQuery = `
      INSERT INTO shopping_list (user_id, ing_id, s_qty, s_unit)
      VALUES (?, ?, ?, ?)
    `;
    connection.query(insertQuery, [userId, ingId, qty, unit], (err, results) => {
      if (err) {
        console.error('Error adding shopping list item:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ message: 'Shopping list item added successfully' });
    });
  });
  
  // DELETE SHOPPING LIST ITEM
  router.delete('/shopping-list/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId = parseInt(req.params.ingId);
  
    const deleteQuery = `
      DELETE FROM shopping_list
      WHERE user_id = ? AND ing_id = ?
    `;
    connection.query(deleteQuery, [userId, ingId], (err, results) => {
      if (err) {
        console.error('Error deleting shopping list item:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ message: 'Shopping list item deleted successfully' });
    });
  });

  // GET ALL RECIPE
router.get('/recipe', (req, res) => {
    const query = `
      SELECT recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url
      FROM resep
    `;
    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error getting all recipes:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listRecipe = results.map((row) => ({
        recipeId: row.recipe_id,
        recipeTitle: row.recipe_title,
        recipeDescription: row.recipe_description,
        recipeTotalTime: row.recipe_total_time,
        recipeServing: row.recipe_serving,
        recipeImgUrl: row.recipe_img_url,
      }));
  
      res.json({ listRecipe });
    });
  });

  // GET RECIPE DETAIL
router.get('/recipe/:recipeId', (req, res) => {
    const recipeId = parseInt(req.params.recipeId);
  
    // Query untuk mendapatkan detail resep
    const recipeQuery = `
      SELECT recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url
      FROM resep
      WHERE recipe_id = ?
    `;
  
    // Query untuk mendapatkan bahan-bahan resep
    const ingredientQuery = `
      SELECT ingredient.ing_id, ingredient.ing_name, recipe_ingredient.qty, recipe_ingredient.unit
      FROM ingredient
      INNER JOIN recipe_ingredient ON ingredient.ing_id = recipe_ingredient.ing_id
      WHERE recipe_ingredient.recipe_id = ?
    `;
  
    // Query untuk mendapatkan langkah-langkah resep
    const stepQuery = `
      SELECT step_id, step_no, step_description
      FROM step
      WHERE recipe_id = ?
      ORDER BY step_no ASC
    `;
  
    // Eksekusi query
    connection.query(recipeQuery, [recipeId], (err, recipeResults) => {
      if (err) {
        console.error('Error getting recipe detail:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      if (recipeResults.length === 0) {
        res.status(404).json({ error: 'Recipe not found' });
        return;
      }
  
      const recipe = {
        recipeId: recipeResults[0].recipe_id,
        recipeTitle: recipeResults[0].recipe_title,
        recipeDescription: recipeResults[0].recipe_description,
        recipeTotalTime: recipeResults[0].recipe_total_time,
        recipeServing: recipeResults[0].recipe_serving,
        recipeImgUrl: recipeResults[0].recipe_img_url,
        listIngredient: [],
        listStep: [],
      };
  
      // Mendapatkan bahan-bahan resep
      connection.query(ingredientQuery, [recipeId], (err, ingredientResults) => {
        if (err) {
          console.error('Error getting recipe ingredients:', err);
          res.status(500).json({ error: 'Internal server error' });
          return;
        }
  
        recipe.listIngredient = ingredientResults.map((row) => ({
          ingId: row.ing_id,
          ingName: row.ing_name,
          qty: row.qty,
          unit: row.unit,
        }));
  
        // Mendapatkan langkah-langkah resep
        connection.query(stepQuery, [recipeId], (err, stepResults) => {
          if (err) {
            console.error('Error getting recipe steps:', err);
            res.status(500).json({ error: 'Internal server error' });
            return;
          }
  
          recipe.listStep = stepResults.map((row) => ({
            stepId: row.step_id,
            stepNo: row.step_no,
            stepDescription: row.step_description,
          }));
  
          res.json({ recipe });
        });
      });
    });
  });

  // GET FAVORITE RECIPES
router.get('/favorite/:userId', (req, res) => {
    const userId = req.params.userId;
  
    // Query untuk mendapatkan daftar resep favorit
    const favoriteQuery = `
      SELECT recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url
      FROM resep
      INNER JOIN favorite ON resep.recipe_id = favorite.recipe_id
      WHERE favorite.user_id = ?
    `;
  
    // Eksekusi query
    connection.query(favoriteQuery, [userId], (err, results) => {
      if (err) {
        console.error('Error getting favorite recipes:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listFavoriteRecipe = results.map((row) => ({
        recipeId: row.recipe_id,
        recipeTitle: row.recipe_title,
        recipeDescription: row.recipe_description,
        recipeTotalTime: row.recipe_total_time,
        recipeServing: row.recipe_serving,
        recipeImgUrl: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'success', listFavoriteRecipe });
    });
  });

  // Membuka koneksi database
connection.connect((err) => {
    if (err) {
      console.error('Error connecting to database:', err);
      return;
    }
    console.log('Connected to database');
  });
  
  // GET RECOMMENDED RECIPES FROM PANTRY
  router.get('/recommendations', (req, res) => {
    const { listingredientsid, query } = req.query;
  
    // Query untuk mendapatkan rekomendasi resep berdasarkan bahan-bahan di pantry
    const recommendationsQuery = `
      SELECT resep.recipe_id, resep.recipe_title, resep.recipe_description, resep.recipe_total_time, resep.recipe_serving, resep.recipe_img_url
      FROM resep
      INNER JOIN recipe_ingredient ON resep.recipe_id = recipe_ingredient.recipe_id
      WHERE recipe_ingredient.ing_id IN (?)
      AND resep.recipe_title LIKE ?
      GROUP BY resep.recipe_id
    `;
  
    // Eksekusi query
    connection.query(recommendationsQuery, [listingredientsid, `%${query}%`], (err, results) => {
      if (err) {
        console.error('Error getting recipe recommendations:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listRecipe = results.map((row) => ({
        recipeId: row.recipe_id,
        recipeTitle: row.recipe_title,
        recipeDescription: row.recipe_description,
        recipeTotalTime: row.recipe_total_time,
        recipeServing: row.recipe_serving,
        recipeImgUrl: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'success', listRecipe });
    });
  });

  // SEARCH RECIPES BY TITLE
router.get('/search', (req, res) => {
    const { query } = req.query;
  
    // Query untuk mencari resep berdasarkan judul resep
    const searchQuery = `
      SELECT recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url
      FROM resep
      WHERE recipe_title LIKE ?
    `;
  
    // Eksekusi query
    connection.query(searchQuery, [`%${query}%`], (err, results) => {
      if (err) {
        console.error('Error searching for recipes:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      const listRecipe = results.map((row) => ({
        recipeId: row.recipe_id,
        recipeTitle: row.recipe_title,
        recipeDescription: row.recipe_description,
        recipeTotalTime: row.recipe_total_time,
        recipeServing: row.recipe_serving,
        recipeImgUrl: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'success', listRecipe });
    });
  });
  
module.exports = router;