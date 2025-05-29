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

async function fetchBooks() {
  const res = await fetch('/api/books');
  const data = await res.json();
  return data;
}

async function renderBooks() {
  const selectedCategory = document.getElementById('categoryFilter').value;
  const container = document.getElementById('booksContainer');
  container.innerHTML = '';

  const books = await fetchBooks();

  books
    .filter(book => selectedCategory === 'all' || book.category_id == selectedCategory)
    .forEach(book => {
      const div = document.createElement('div');
      div.className = 'book';
      div.innerHTML = `
        <h3>${book.title}</h3>
        <p><strong>Author:</strong> ${book.author}</p>
        <p><strong>Publisher:</strong> ${book.publisher}</p>
        <p><strong>Year:</strong> ${book.year_published}</p>
        <p><strong>ISBN:</strong> ${book.isbn}</p>
        <p><strong>Category ID:</strong> ${book.category_id}</p>
        <p><strong>Available:</strong> ${book.available_copies}</p>
      `;
      container.appendChild(div);
    });

  showUser();
}

function showUser() {
  const user = JSON.parse(localStorage.getItem('user'));
  if (user) {
    const info = document.getElementById('userInfo');
    if (info) {
      info.innerHTML = `<strong>Logged in as:</strong> ${user.username} (${user.role})`;
    }
  }
}

populateCategoryFilter();
renderBooks();
