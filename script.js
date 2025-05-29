const categories = {
  1: 'Fiction',
  2: 'IT / Programming',
  3: 'Science',
  4: 'Fantasy',
  5: 'Classic Literature',
  6: 'Philosophy / Strategy',
  7: 'History / Sociology',
  8: 'Psychology / Economy'
};

const books = [
  { title: '1984', author: 'George Orwell', publisher: 'Secker & Warburg', year: 1949, isbn: '9780451524935', category_id: 1, available: 3 },
  { title: 'The Pragmatic Programmer', author: 'Andrew Hunt, David Thomas', publisher: 'Addison-Wesley', year: 1999, isbn: '9780201616224', category_id: 2, available: 2 },
  { title: 'A Brief History of Time', author: 'Stephen Hawking', publisher: 'Bantam', year: 1988, isbn: '9780553380163', category_id: 3, available: 2 },
  { title: 'Clean Code', author: 'Robert C. Martin', publisher: 'Prentice Hall', year: 2008, isbn: '9780132350884', category_id: 2, available: 1 },
  { title: 'Harry Potter and the Philosopher’s Stone', author: 'J.K. Rowling', publisher: 'Bloomsbury', year: 1997, isbn: '9780747532699', category_id: 4, available: 4 },
  { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', publisher: 'Scribner', year: 1925, isbn: '9780743273565', category_id: 5, available: 2 },
  { title: 'The Art of War', author: 'Sun Tzu', publisher: 'Oxford Univ Press', year: -500, isbn: '9780195015409', category_id: 6, available: 1 },
  { title: 'Sapiens: A Brief History of Humankind', author: 'Yuval Noah Harari', publisher: 'Harper', year: 2011, isbn: '9780062316097', category_id: 7, available: 2 },
  { title: 'Thinking, Fast and Slow', author: 'Daniel Kahneman', publisher: 'Farrar, Straus', year: 2011, isbn: '9780374533557', category_id: 8, available: 3 },
  { title: 'The Lord of the Rings', author: 'J.R.R. Tolkien', publisher: 'Allen & Unwin', year: 1954, isbn: '9780261103252', category_id: 4, available: 2 },
  { title: 'To Kill a Mockingbird', author: 'Harper Lee', publisher: 'J.B. Lippincott & Co.', year: 1960, isbn: '9780061120084', category_id: 5, available: 3 },
  { title: 'Introduction to Algorithms', author: 'Cormen, Leiserson, Rivest, Stein', publisher: 'MIT Press', year: 2009, isbn: '9780262033848', category_id: 2, available: 2 },
  { title: 'Deep Work', author: 'Cal Newport', publisher: 'Grand Central Publishing', year: 2016, isbn: '9781455586691', category_id: 8, available: 2 },
  { title: 'Dune', author: 'Frank Herbert', publisher: 'Chilton Books', year: 1965, isbn: '9780441172719', category_id: 4, available: 3 },
  { title: 'The Catcher in the Rye', author: 'J.D. Salinger', publisher: 'Little, Brown and Company', year: 1951, isbn: '9780316769488', category_id: 5, available: 2 },
  { title: 'Zero to One', author: 'Peter Thiel', publisher: 'Crown Business', year: 2014, isbn: '9780804139298', category_id: 8, available: 2 },
  { title: 'Cosmos', author: 'Carl Sagan', publisher: 'Random House', year: 1980, isbn: '9780345331359', category_id: 3, available: 1 },
  { title: 'Brave New World', author: 'Aldous Huxley', publisher: 'Chatto & Windus', year: 1932, isbn: '9780060850524', category_id: 1, available: 2 },
  { title: 'The Clean Coder', author: 'Robert C. Martin', publisher: 'Prentice Hall', year: 2011, isbn: '9780137081073', category_id: 2, available: 1 },
  { title: 'Homo Deus', author: 'Yuval Noah Harari', publisher: 'Harper', year: 2015, isbn: '9780062464316', category_id: 7, available: 2 }
];

function populateCategoryFilter() {
  const filter = document.getElementById('categoryFilter');
  Object.entries(categories).forEach(([id, name]) => {
    const option = document.createElement('option');
    option.value = id;
    option.textContent = name;
    filter.appendChild(option);
  });
  filter.addEventListener('change', renderBooks);
}

function renderBooks() {
  const selectedCategory = document.getElementById('categoryFilter').value;
  const container = document.getElementById('booksContainer');
  container.innerHTML = '';

  books
    .filter(book => selectedCategory === 'all' || book.category_id == selectedCategory)
    .forEach(book => {
      const div = document.createElement('div');
      div.className = 'book';
      div.innerHTML = `
        <h3>${book.title}</h3>
        <p><strong>Author:</strong> ${book.author}</p>
        <p><strong>Publisher:</strong> ${book.publisher}</p>
        <p><strong>Year:</strong> ${book.year}</p>
        <p><strong>ISBN:</strong> ${book.isbn}</p>
        <p><strong>Category:</strong> ${categories[book.category_id]}</p>
        <p><strong>Available Copies:</strong> ${book.available}</p>
      `;
      container.appendChild(div);
    });
}

populateCategoryFilter();
renderBooks();
