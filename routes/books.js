const express = require('express');
const router = express.Router();
const db = require('../db');

// Get all books
router.get('/', (req, res) => {
  db.query('SELECT * FROM Books', (err, results) => {
    if (err) {
      console.error('Error fetching books:', err);
      return res.status(500).json({ error: 'Server error' });
    }
    res.json(results);
  });
});

// Add a new book
router.post('/', (req, res) => {
  const { title, author, publisher, year_published, isbn, category_id } = req.body;
  const query = 'INSERT INTO Books (title, author, publisher, year_published, isbn, category_id) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(query, [title, author, publisher, year_published, isbn, category_id], (err, result) => {
    if (err) {
      console.error('Error adding book:', err);
      return res.status(500).json({ error: 'Server error' });
    }
    res.status(201).json({ message: 'Book added', book_id: result.insertId });
  });
});

// Delete a book by ID
router.delete('/:id', (req, res) => {
  const bookId = req.params.id;
  db.query('DELETE FROM Books WHERE book_id = ?', [bookId], (err, result) => {
    if (err) {
      console.error('Error deleting book:', err);
      return res.status(500).json({ error: 'Server error' });
    }
    res.json({ message: 'Book deleted' });
  });
});

module.exports = router;
