const express = require('express');
const router = express.Router();
const db = require('../db');
const bcrypt = require('bcrypt');

router.post('/register', async (req, res) => {
  const { username, password, email, full_name } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);

  db.query(
    'INSERT INTO Users (username, password_hash, email, full_name) VALUES (?, ?, ?, ?)',
    [username, hashedPassword, email, full_name],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'User registered successfully' });
    }
  );
});

router.post('/login', (req, res) => {
  const { username, password } = req.body;

  db.query(
    'SELECT * FROM Users WHERE username = ?',
    [username],
    async (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length === 0) return res.status(401).json({ error: 'User not found' });

      const user = results[0];
      const match = await bcrypt.compare(password, user.password_hash);

      if (!match) return res.status(401).json({ error: 'Invalid password' });

      res.json({ 
        message: 'Login successful',
        user: {
          id: user.user_id,
          username: user.username,
          role: user.role,
          full_name: user.full_name
        }
      });
    }
  );
});

module.exports = router;
