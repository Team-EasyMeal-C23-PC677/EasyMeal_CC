const express = require('express');
const mysql = require('mysql');
const router = express.Router();
const { 
    v4: uuidv4
  } = require('uuid');

// SQL Connection
const connection = mysql.createConnection({
    host: 'your_sql_ip_public',
    user: 'root',
    database: 'your_database',
    password: 'your_password'
})

// Get all recipe from database
router.get("/resep", (req, res) => {
    const query = "SELECT * FROM recipe"
    connection.query(query, (err, rows, field) => {
        if(err) {
            res.status(500).send({ message: err.sqlMessage })
        } else {
            res.json(rows)
        }
    })
})


// GET specific recipe that user choose
router.get("/recipe/:id", (req, res) => {
    const id = req.params.id;

    const query = "SELECT * FROM recipe WHERE id = ?"
    connection.query(query, [id], (err, rows, field) => {
        if(err) {
            res.status(500).send({ message: err.sqlMessage })
        } else {
            res.json(rows)
        }
    })
})

// Mendapatkan langkah-langkah (steps) untuk sebuah resep berdasarkan ID resep
router.get("/recipe/:id/steps", (req, res) => {
  const id = req.params.id;
  
  const query = "SELECT * FROM step WHERE recipe_id = ?";
  connection.query(query, [id], (err, rows) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      res.json(rows);
    }
  });
});

// Mendapatkan bahan-bahan (ingredients) untuk sebuah resep berdasarkan ID resep
router.get("/recipe/:id/ingredients", (req, res) => {
  const id = req.params.id;
  
  const query = "SELECT * FROM ingredient WHERE recipe_id = ?";
  connection.query(query, [id], (err, rows) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      res.json(rows);
    }
  });
});

// Mendapatkan resep favorit berdasarkan ID resep favorit
router.get("/favorite/:id", (req, res) => {
  const id = req.params.id;
  
  const query = "SELECT * FROM favorite WHERE id = ?";
  connection.query(query, [id], (err, rows) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      if (rows.length === 0) {
        res.status(404).send({ message: "Favorite recipe not found" });
      } else {
        const favoriteData = rows[0];

        const recipeQuery = "SELECT * FROM recipe WHERE id = ?";
        connection.query(recipeQuery, [favoriteData.recipe_id], (recipeErr, recipeRows) => {
          if (recipeErr) {
            res.status(500).send({ message: recipeErr.sqlMessage });
          } else {
            if (recipeRows.length === 0) {
              res.status(404).send({ message: "Recipe not found" });
            } else {
              const recipeData = recipeRows[0];
              favoriteData.recipe = recipeData;
              
              res.json(favoriteData);
            }
          }
        });
      }
    }
  });
});

// Mendapatkan daftar belanja berdasarkan ID daftar belanja
router.get("/shopping-list/:id", (req, res) => {
  const id = req.params.id;
  
  const query = "SELECT * FROM shopping_list WHERE id = ?";
  connection.query(query, [id], (err, rows) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      if (rows.length === 0) {
        res.status(404).send({ message: "Shopping list not found" });
      } else {
        const shoppingListData = rows[0];

        const ingredientQuery = "SELECT * FROM ingredient WHERE id = ?";
        connection.query(ingredientQuery, [shoppingListData.ingredient_id], (ingredientErr, ingredientRows) => {
          if (ingredientErr) {
            res.status(500).send({ message: ingredientErr.sqlMessage });
          } else {
            if (ingredientRows.length === 0) {
              res.status(404).send({ message: "Ingredient not found" });
            } else {
              const ingredientData = ingredientRows[0];
              shoppingListData.ingredient = ingredientData;
              
              res.json(shoppingListData);
            }
          }
        });
      }
    }
  });
});

// Mendapatkan bahan di pantry berdasarkan ID bahan di pantry
router.get("/pantry/:id", (req, res) => {
  const id = req.params.id;
  
  const query = "SELECT * FROM pantry WHERE id = ?";
  connection.query(query, [id], (err, rows) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      if (rows.length === 0) {
        res.status(404).send({ message: "Ingredient in pantry not found" });
      } else {
        const pantryData = rows[0];

        const ingredientQuery = "SELECT * FROM ingredient WHERE id = ?";
        connection.query(ingredientQuery, [pantryData.ingredient_id], (ingredientErr, ingredientRows) => {
          if (ingredientErr) {
            res.status(500).send({ message: ingredientErr.sqlMessage });
          } else {
            if (ingredientRows.length === 0) {
              res.status(404).send({ message: "Ingredient not found" });
            } else {
              const ingredientData = ingredientRows[0];
              pantryData.ingredient = ingredientData;
              
              res.json(pantryData);
            }
          }
        });
      }
    }
  });
});

// Menambahkan bahan ke dalam pantry
router.post("/pantry", (req, res) => {
  const { ingredient_id, quantity } = req.body;
  const pantry_id = uuidv4(); // Generate UUID

  const insertQuery = "INSERT INTO pantry (id, ingredient_id, quantity) VALUES (?, ?, ?)";
  connection.query(insertQuery, [pantry_id, ingredient_id, quantity], (err, result) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      const selectQuery = "SELECT * FROM pantry WHERE id = ?";
      connection.query(selectQuery, [pantry_id], (selectErr, selectRows) => {
        if (selectErr) {
          res.status(500).send({ message: selectErr.sqlMessage });
        } else {
          if (selectRows.length === 0) {
            res.status(404).send({ message: "Failed to add ingredient to pantry" });
          } else {
            const pantryData = selectRows[0];
            res.json(pantryData);
          }
        }
      });
    }
  });
});

// Menambahkan resep favorit
router.post("/favorite", (req, res) => {
  const { recipe_id } = req.body;
  const favorite_id = uuidv4(); // Generate UUID

  const insertQuery = "INSERT INTO favorite (id, recipe_id) VALUES (?, ?)";
  connection.query(insertQuery, [favorite_id, recipe_id], (err, result) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      const selectQuery = "SELECT * FROM favorite WHERE id = ?";
      connection.query(selectQuery, [favorite_id], (selectErr, selectRows) => {
        if (selectErr) {
          res.status(500).send({ message: selectErr.sqlMessage });
        } else {
          if (selectRows.length === 0) {
            res.status(404).send({ message: "Failed to add recipe to favorites" });
          } else {
            const favoriteData = selectRows[0];
            res.json(favoriteData);
          }
        }
      });
    }
  });
});

// Menghapus resep favorit berdasarkan ID favorit
router.delete("/favorite/:id", (req, res) => {
  const id = req.params.id;
  
  const deleteQuery = "DELETE FROM favorite WHERE id = ?";
  connection.query(deleteQuery, [id], (err, result) => {
    if (err) {
      res.status(500).send({ message: err.sqlMessage });
    } else {
      if (result.affectedRows === 0) {
        res.status(404).send({ message: "Favorite recipe not found" });
      } else {
        res.send({ message: "Favorite recipe deleted successfully" });
      }
    }
  });
});


module.exports = router;