const express = require('express');
const cors = require('cors');
const app = express();
const booksRoutes = require('./routes/books');
const authRoutes = require('./routes/auth');

app.use(cors());
app.use(express.json());
app.use(express.static('public'));
app.use('/api/books', booksRoutes);
app.use('/api/auth', authRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
app.use(express.static('public'));
