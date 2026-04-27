<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PageTurn — Free Library & eBooks</title>
<link rel="stylesheet" href="p1.css">
</head>
<body>
<!-- NAVBAR -->
<nav>
<div class="logo">Page<span>Turn</span></div>
<ul class="nav-links">
<li><a href="index.jsp">Home</a></li>
<li><a href="index.jsp#new-arrivals">Physical Books</a></li>
<li><a href="index.jsp#categories">Categories</a></li>
<li><a href="#">About</a></li>
</ul>
<div class="nav-actions">
<% if (session.getAttribute("userId") != null) { %>
  <div class="profile-dropdown" style="position:relative; display:inline-block;">
    <button class="btn-login" style="background:#f0f0ff; color:#1a1a2e; border:none; cursor:pointer;" onclick="const c = document.getElementById('dd-content'); c.style.display = c.style.display === 'block' ? 'none' : 'block';">
      👤 <%= session.getAttribute("userName") %> ▼
    </button>
    <div id="dd-content" style="display:none; position:absolute; right:0; top:100%; margin-top:10px; background:#fff; min-width:160px; box-shadow:0px 8px 16px rgba(0,0,0,0.1); border-radius:8px; overflow:hidden; z-index:100; text-align:left;">
      <a href="#" style="color:#1a1a2e; padding:12px 16px; text-decoration:none; display:block;">My Books</a>
      <a href="LogoutServlet" style="color:#ff6b6b; padding:12px 16px; text-decoration:none; display:block; border-top:1px solid #eee;">Log Out</a>
    </div>
  </div>
<% } else { %>
  <button class="btn-login" onclick="window.location.href='login.jsp'">Log In</button>
  <button class="btn-signup" onclick="window.location.href='signup.jsp'">Sign Up</button>
<% } %>
</div>
</nav>
<!-- HERO -->
<section class="hero">
<div class="hero-content">
<div class="hero-tag">🎓 School Library Portal</div>
<h1>Read Freely.<br><em>Borrow Easily.</em></h1>
<p>Reserve physical books from our library — all in one place. Knowledge is just a click away.</p>
<div class="search-bar" style="padding: 0; background: transparent; box-shadow: none;">
<form action="index.jsp" method="GET" style="display:flex; width:100%; max-width:600px; border-radius:50px; background:#fff; padding:8px; box-shadow:0 10px 30px rgba(0,0,0,0.1);">
<input type="text" name="search" placeholder="Search by title, author, or genre..." style="border:none; outline:none; flex:1; padding:0 20px; font-size:1rem; border-radius:50px;" value="<%= request.getParameter("search") != null ? request.getParameter("search").replace("\"", "&quot;") : "" %>">
<button type="submit" style="background:#ff6b6b; color:#fff; border:none; border-radius:50px; padding:12px 30px; font-weight:600; cursor:pointer;">Search</button>
</form>
</div>
<div style="display:flex; gap:20px; margin-top:30px;">
<div class="stat">
<div class="stat-num">1<span>K+</span></div>
<div class="stat-label">Physical Books</div>
</div>
<div class="stat">
<div class="stat-num">20<span>+</span></div>
<div class="stat-label">Genres</div>
</div>
</div>
</div>
</div>
</section>
<% String searchParam = request.getParameter("search"); %>
<% if (searchParam != null && !searchParam.trim().isEmpty()) { %>
<!-- SEARCH RESULTS -->
<section class="section" style="background:#fff; padding-top:4rem; padding-bottom:4rem;">
<div class="section-header">
<h2 class="section-title">Search Results for "<span><%= searchParam.replace("\"", "&quot;").replace("<", "&lt;") %></span>"</h2>
<a href="index.jsp" class="see-all">Clear Search ✕</a>
</div>
<div class="books-grid" id="search-results">
<p style="color:#888;">Searching...</p>
</div>
</section>
<script>
    fetch('BooksServlet?search=<%= searchParam.replace("'", "\\'").replace("\"", "\\\"") %>')
      .then(r => r.json())
      .then(books => {
          const c = document.getElementById('search-results');
          if (books.length === 0) {
              c.innerHTML = '<p style="color:#888;">No books found matching your search.</p>';
              return;
          }
          c.innerHTML = books.map(book => `
            <div class="book-card">
                <div class="book-cover" style="background-image: url('${book.coverUrl || 'https://via.placeholder.com/200x300?text=No+Cover'}')">
                    <span class="book-badge ${book.type === 'eBook' ? 'ebook' : 'physical'}">${book.type}</span>
                </div>
                <div class="book-info">
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">${book.author}</div>
                    <div class="book-meta">
                        <span class="book-genre">${book.genre}</span>
                        ${book.available ? `<a href="reserve.jsp?book_id=${book.id}&title=${encodeURIComponent(book.title)}&author=${encodeURIComponent(book.author)}&genre=${encodeURIComponent(book.genre)}&cover_url=${encodeURIComponent(book.coverUrl)}" class="book-action reserve">Reserve Now →</a>` : '<span style="color:#ccc">Unavailable</span>'}
                    </div>
                </div>
            </div>
          `).join('');
      })
      .catch(e => {
          document.getElementById('search-results').innerHTML = '<p style="color:#ff6b6b;">Failed to load search results.</p>';
      });
</script>
<% } else { %>
<!-- CATEGORIES -->
<section class="section" id="categories">
<div class="section-header">
<h2 class="section-title">Browse by <span>Category</span></h2>
<a href="#" class="see-all">See all →</a>
</div>
<div class="categories-grid">
<a class="cat-card" href="category.jsp?genre=Science">
<span class="cat-icon">🔬</span>
<div class="cat-name">Science</div>
<div class="cat-count">320 books</div>
</a>
<a class="cat-card" href="category.jsp?genre=Fiction">
<span class="cat-icon">📖</span>
<div class="cat-name">Fiction</div>
<div class="cat-count">890 books</div>
</a>
<a class="cat-card" href="category.jsp?genre=Self-Help">
<span class="cat-icon">💡</span>
<div class="cat-name">Self-Help</div>
<div class="cat-count">210 books</div>
</a>
<a class="cat-card" href="category.jsp?genre=Technology">
<span class="cat-icon">💻</span>
<div class="cat-name">Technology</div>
<div class="cat-count">380 books</div>
</a>
</div>
</section>
<!-- FEATURED EBOOKS -->
<section class="section" style="background:#fff; padding-top:4rem; padding-bottom:4rem;">
<div class="section-header">
<h2 class="section-title">Featured <span>eBooks</span></h2>
<a href="#" class="see-all">See all →</a>
</div>
<div class="books-grid" id="featured-books">
</div>
</div>
</section>
<!-- NEW ARRIVALS -->
<section class="arrivals-section">
<div class="section-header">
<h2 class="section-title">New <span>Arrivals</span></h2>
<a href="#" class="see-all">See all →</a>
</div>
<div class="arrivals-list" id="new-arrivals">
</div>
</section>
<!-- SIGNUP BANNER -->
<div class="banner">
<div class="banner-text">
<h2>Start Reading for Free Today</h2>
<p>Join thousands of readers. Access free eBooks instantly or reserve a physical book from our library in seconds.</p>
</div>
<button class="btn-white" onclick="window.location.href='signup.jsp'">Create Free Account</button>
</div>
<% } %>
<!-- FOOTER -->
<footer>
<div class="footer-grid">
<div class="footer-brand">
<div class="logo">Page<span>Turn</span></div>
<p>Your school's digital library portal. Reserve physical books and collect them from the library.</p>
</div>
<div class="footer-col">
<h4>Explore</h4>
<ul>
<li><a href="index.jsp#new-arrivals">Physical Books</a></li>
<li><a href="index.jsp#new-arrivals">New Arrivals</a></li>
<li><a href="index.jsp#categories">Categories</a></li>
</ul>
</div>
<div class="footer-col">
<h4>Account</h4>
<ul>
<li><a href="signup.jsp">Sign Up</a></li>
<li><a href="login.jsp">Log In</a></li>
</ul>
</div>
<div class="footer-col">
<h4>Info</h4>
<ul>
<li><a href="#">About</a></li>
<li><a href="#">Library Hours</a></li>
<li><a href="#">Contact</a></li>
<li><a href="#">Help</a></li>
</ul>
</div>
</div>
<div class="footer-bottom">
<span>© 2026 PageTurn Library. All rights reserved.</span>
</div>
</footer>
<script>
async function loadFeaturedBooks() {
    try {
        const response = await fetch('BooksServlet?action=featured');
        const books = await response.json();
        
        const container = document.getElementById('featured-books');
        container.innerHTML = books.map(book => `
            <div class="book-card">
                <div class="book-cover" style="background-image: url('${book.coverUrl || 'https://via.placeholder.com/200x300?text=No+Cover'}')">
                    <span class="book-badge ${book.type === 'eBook' ? 'ebook' : 'physical'}">${book.type}</span>
                </div>
                <div class="book-info">
                    <div class="book-title">${book.title}</div>
                    <div class="book-author">${book.author}</div>
                    <div class="book-meta">
                        <span class="book-genre">${book.genre}</span>
                        <a href="reserve.jsp?book_id=${book.id}&title=${encodeURIComponent(book.title)}&author=${encodeURIComponent(book.author)}&genre=${encodeURIComponent(book.genre)}&cover_url=${encodeURIComponent(book.coverUrl)}" class="book-action reserve">Reserve Now →</a>
                    </div>
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading featured books:', error);
    }
}

async function loadNewArrivals() {
    try {
        const response = await fetch('BooksServlet?action=latest');
        const books = await response.json();
        
        const container = document.getElementById('new-arrivals');
        container.innerHTML = books.map(book => `
            <div class="arrival-item">
                <div class="arrival-cover" style="background-image: url('${book.coverUrl || 'https://via.placeholder.com/100x150?text=No+Cover'}')"></div>
                <div class="arrival-info">
                    <div class="arrival-title">${book.title}</div>
                    <div class="arrival-author">${book.author}</div>
                    <div class="arrival-tags">
                        <span class="tag tag-new">New</span>
                        <span class="tag tag-${book.type === 'eBook' ? 'ebook' : 'physical'}">${book.type}</span>
                    </div>
                </div>
                <a href="reserve.jsp?book_id=${book.id}&title=${encodeURIComponent(book.title)}&author=${encodeURIComponent(book.author)}&genre=${encodeURIComponent(book.genre)}&cover_url=${encodeURIComponent(book.coverUrl)}" class="arrival-action">Reserve Now</a>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading new arrivals:', error);
    }
}

// Load books when page is ready
document.addEventListener('DOMContentLoaded', () => {
    loadFeaturedBooks();
    loadNewArrivals();
});

const urlParams = new URLSearchParams(window.location.search);
if (urlParams.get('reserved') === 'true') {
    alert("The book has been successfully reserved for 7 days!\n\nPlease pick it up from the library within 24 hours.");
    window.history.replaceState({}, document.title, "index.jsp");
}
</script>
</body>
</html>
