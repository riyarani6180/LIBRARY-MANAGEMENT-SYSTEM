<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PageTurn — <%= request.getParameter("genre") %> Books</title>
<link rel="stylesheet" href="p1.css">
</head>
<body>

<nav>
  <div class="logo">Page<span>Turn</span></div>
  <ul class="nav-links">
    <li><a href="index.html">Home</a></li>
    <li><a href="#">Physical Books</a></li>
    <li><a href="#">Categories</a></li>
    <li><a href="#">About</a></li>
  </ul>
  <div class="nav-actions">
    <button class="btn-login" onclick="window.location.href='login.jsp'">Log In</button>
    <button class="btn-signup" onclick="window.location.href='signup.jsp'">Sign Up</button>
  </div>
</nav>

<div style="background:#1a1a2e; padding: 3rem 5%;">
  <h1 style="font-family:Georgia,serif; color:#fff; font-size:2rem; margin-bottom:0.4rem;">
    <%= request.getParameter("genre") %> <span style="color:#ff6b6b;">Books</span>
  </h1>
  <p style="color:rgba(255,255,255,0.5); font-size:0.9rem;">
    Showing all books available in this category
  </p>
  <a href="index.html" style="color:#ff6b6b; font-size:0.88rem; text-decoration:none;">← Back to Homepage</a>
</div>

<section class="arrivals-section">
  <div class="arrivals-list" id="categoryList">
    <p style="color:#888;">Loading books...</p>
  </div>
</section>

<script>
  const genre = "<%= request.getParameter("genre") %>";

  window.onload = function () {
    fetch('CategoryServlet?genre=' + encodeURIComponent(genre))
      .then(response => response.json())
      .then(books => {
        const list = document.getElementById('categoryList');
        if (books.length === 0) {
          list.innerHTML = '<p style="color:#888;">No books found in this category.</p>';
          return;
        }
        list.innerHTML = books.map(book => `
          <div class="arrival-item">
            <div class="arrival-cover" style="background-image: url('${book.coverUrl}');"></div>
            <div class="arrival-info">
              <div class="arrival-title">${book.title}</div>
              <div class="arrival-author">${book.author}</div>
              <div class="arrival-tags">
                <span class="tag ${book.type === 'ebook' ? 'tag-ebook' : 'tag-physical'}">${book.type === 'ebook' ? 'eBook' : 'Physical'}</span>
                <span class="tag" style="background:#f0f0ff; color:#555;">${book.genre}</span>
              </div>
            </div>
            ${book.type === 'ebook' 
              ? `<a href="#" class="arrival-action">Read Now</a>`
              : book.available 
                ? `<a href="reserve.jsp?book_id=${book.id}&title=${encodeURIComponent(book.title)}&author=${encodeURIComponent(book.author)}&genre=${encodeURIComponent(book.genre)}&cover_url=${encodeURIComponent(book.coverUrl)}" class="arrival-action">Reserve</a>`
                : `<span class="arrival-action" style="color:#ccc; border-color:#ccc;">Unavailable</span>`
            }
          </div>
        `).join('');
      })
      .catch(error => {
        document.getElementById('categoryList').innerHTML = '<p style="color:#ff6b6b;">Failed to load books.</p>';
      });
  };
</script>

</body>
</html>
