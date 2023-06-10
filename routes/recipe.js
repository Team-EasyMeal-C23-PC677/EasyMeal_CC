const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
//const jwt = require('jsonwebtoken');

const router = express.Router();

// Konfigurasi koneksi database
const dbConfig = {
  host: '34.128.86.236',
  user: 'root',
  password: 'password',
  database: 'EasyMeal'
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


// Endpoint untuk register
router.post('/register', async (req, res) => {
  try {
    // Validasi Data
    const { nama_profil, email, password } = req.body;

    // Check apakah user ada di Database
    const emailExistQuery = 'SELECT * FROM userrecipe WHERE email = ?';
    connection.query(emailExistQuery, [req.body.email], async (err, results) => {
      if (err) {
        throw err;
      }

      if (results.length > 0) {
        return res.status(400).send('Email already exists!');
      }

      // Hashing Password
      const hashedPassword = await bcrypt.hash(req.body.password, 10);

      // Generate a unique user_id using UUID
      // const user_id = uuidv4();

      // Store the user data in the database
      const insertQuery = 'INSERT INTO userrecipe (nama_profil, email, password) VALUES (?, ?, ?)';
      connection.query(insertQuery, [req.body.nama_profil, req.body.email, hashedPassword], (err) => {
        if (err) {
          throw err;
        }

        res.status(200).json({ message: 'Registration successful' });
      });
    });
  } catch (err) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
// Endpoint untuk login
router.post('/login', async (req, res) => {
  try {
    // Validasi Data
    const { email, password } = req.body;

    // Check apakah user ada di Database
    const query = 'SELECT * FROM userrecipe WHERE email = ?';
    connection.query(query, [req.body.email], async (err, results) => {
      if (err) {
        throw err;
      }

      if (results.length === 0) {
        return res.status(400).send('Email does not exist!');
      }

      const user = results[0];

      // Checking Password is Correct
      const truePassword = await bcrypt.compare(req.body.password, user.password);
      if (!truePassword) {
        return res.status(400).send('Invalid Password');
      }

      res.status(200).json({
        error: false,
        message: 'success',
        user: {
          userId: user.user_id,
          userName: user.nama_profil,
          userEmail: user.email,
          userPassword: user.password
        }
      });
    });
  } catch (err) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// // Endpoint GET untuk mendapatkan data userrecipe
// router.get('/userrecipe', (req, res) => {
//   const selectQuery = 'SELECT * FROM userrecipe';

//   connection.query(selectQuery, (err, results) => {
//     if (err) {
//       console.error('Error retrieving userrecipe data:', err);
//       res.status(500).json({ error: 'Internal server error' });
//       return;
//     }

//     res.json(results);
//   });
// });

// Endpoint PUT untuk mengupdate data userrecipe berdasarkan user_id
router.put('/user/:user_id', (req, res) => {
  const user_id = req.params.user_id;
  const {user_name} = req.body;

  const updateQuery = 'UPDATE userrecipe SET nama_profil = ? WHERE user_id = ?';
  const values = [user_name, user_id];

  connection.query(updateQuery, values, (err, results) => {
    if (err) {
      console.error('Error updating userrecipe data:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.json({error: false, message: 'Success'});
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
        categoryName: row.ing_category,
        ingName: row.ing_name,
        
      }));
  
      res.json({ error: false, message: 'Success',listIngredient });
    });
  });

  // GET PANTRY INGREDIENTS
router.get('/pantry/:userId', (req, res) => {
    const userId = req.params.userId;
  
    const query = `
    SELECT ingredient.ing_id, ingredient.ing_name, categoris.categories_name AS ing_category
    FROM pantry
    INNER JOIN ingredient ON pantry.ing_id = ingredient.ing_id
    INNER JOIN categoris ON ingredient.category_id = categoris.id
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
        categoryName: row.ing_category,
        ingName: row.ing_name,
        
      }));
  
      res.json({ error: false, message: 'Success',listIngredient });
    });
  });
  
  // ADD PANTRY INGREDIENT
  router.post('/pantry/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId =  req.params.ingId;
  
    const insertQuery = `
    INSERT INTO pantry (user_id, ing_id) VALUES (?, ?)
    `;
    connection.query(insertQuery, [userId, ingId], (err, results) => {
      if (err) {
        console.error('Error adding pantry ingredient:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ error: false, message: 'Success' });
    });
  });
  
  // DELETE PANTRY INGREDIENT
  router.delete('/pantry/:userId/:ingId', (req, res) => {
    const userId = req.params.userId;
    const ingId =  req.params.ingId;
  
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
  
      res.json({ error: false, message: 'Success' });
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
        id: row.ing_id,
        ingName: row.ing_name,
        qty: row.qty,
        unit: row.unit,
      }));
  
      res.json({ error: false, message: 'Success', listIngredient });
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
  
      res.json({ error: false, message: 'Success' });
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
  
      res.json({ error: false, message: 'Success' });
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
        id: row.recipe_id,
        title: row.recipe_title,
        description: row.recipe_description,
        total_time: row.recipe_total_time,
        serving: row.recipe_serving,
        img_url: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'Success',listRecipe });
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
        id: recipeResults[0].recipe_id,
        title: recipeResults[0].recipe_title,
        description: recipeResults[0].recipe_description,
        totalTime: recipeResults[0].recipe_total_time,
        serving: recipeResults[0].recipe_serving,
        imgUrl: recipeResults[0].recipe_img_url,
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
          id: row.ing_id,
          name: row.ing_name,
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
            id: row.step_id,
            no: row.step_no,
            description: row.step_description,
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
      SELECT resep.recipe_id, recipe_title, recipe_description, recipe_total_time, recipe_serving, recipe_img_url
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
        id: row.recipe_id,
        title: row.recipe_title,
        description: row.recipe_description,
        total_time: row.recipe_total_time,
        serving: row.recipe_serving,
        img_url: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'success', listFavoriteRecipe });
    });
  });


  router.post('/favorite/:userId/:recipeId', (req, res) => {
    const userId = req.params.userId;
    const recipeId =  req.params.recipeId;
  
    const insertQuery = `
    INSERT INTO favorite (user_id, recipe_id) VALUES (?, ?)
    `;
    connection.query(insertQuery, [userId, recipeId], (err, results) => {
      if (err) {
        console.error('Error adding pantry ingredient:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ error: false, message: 'Success' });
    });
  });
  
  // DELETE PANTRY INGREDIENT
  router.delete('/favorite/:userId/:recipeId', (req, res) => {
    const userId = req.params.userId;
    const recipeId =  req.params.recipeId;
  
    const deleteQuery = `
      DELETE FROM favorite
      WHERE user_id = ? AND recipe_id = ?
    `;
    connection.query(deleteQuery, [userId, recipeId], (err, results) => {
      if (err) {
        console.error('Error deleting pantry ingredient:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
  
      res.json({ error: false, message: 'Success' });
    });
  });



  // Membuka koneksi database
// connection.connect((err) => {
//     if (err) {
//       console.error('Error connecting to database:', err);
//       return;
//     }
//     console.log('Connected to database');
//   });
  
  // GET RECOMMENDED RECIPES FROM PANTRY
  router.get('/recipes/:userId', (req, res) => {
    const userId = req.params.userId;
  
    // Query SQL untuk mendapatkan rekomendasi resep
    const sql = `
      SELECT r.recipe_id, r.recipe_title, r.recipe_description, r.recipe_total_time, r.recipe_serving, r.recipe_img_url
      FROM (
        SELECT ri.recipe_id, COUNT(DISTINCT ri.ing_id) AS ingredient_count
        FROM pantry p
        JOIN recipe_ingredient ri ON p.ing_id = ri.ing_id
        WHERE p.user_id = '${userId}'
        GROUP BY ri.recipe_id
      ) AS counts
      JOIN resep r ON counts.recipe_id = r.recipe_id
      ORDER BY counts.ingredient_count DESC
    `;
  
    // Lakukan query ke database dan kirim respon
    connection.query(sql, (err, results) => {
      if (err) {
        console.error('Error getting recipe recommendations:', err);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      const listRecipe = results.map((row) => ({
        id: row.recipe_id,
        title: row.recipe_title,
        description: row.recipe_description,
        total_time: row.recipe_total_time,
        serving: row.recipe_serving,
        img_url: row.recipe_img_url,
      }));
  
      res.json({ error: false, message: 'Success',listRecipe })
      
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