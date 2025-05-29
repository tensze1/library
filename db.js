const mysql = require('mysql2');

const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '', 
  database: 'Moduł do zarządzania biblioteką',
  charset: 'utf8mb4'
});

module.exports = db;
