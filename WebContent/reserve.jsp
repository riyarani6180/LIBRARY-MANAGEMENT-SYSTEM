<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PageTurn — Reserve Book</title>
<link rel="stylesheet" href="p1.css">
<style>
  .reserve-wrapper {
    min-height: 100vh;
    background: #fdf6ec;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
  }
  .reserve-card {
    background: #fff;
    border-radius: 20px;
    padding: 3rem 2.5rem;
    width: 100%;
    max-width: 480px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.10);
  }
  .reserve-title {
    font-family: Georgia, serif;
    font-size: 1.5rem;
    font-weight: 900;
    color: #1a1a2e;
    margin-bottom: 0.3rem;
  }
  .reserve-subtitle {
    color: #888;
    font-size: 0.88rem;
    margin-bottom: 2rem;
  }
  .book-details {
    background: #fdf6ec;
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
    display: flex;
    gap: 1.2rem;
    align-items: center;
  }
  .book-cover-img {
    width: 80px;
    height: 110px;
    border-radius: 6px;
    object-fit: cover;
    flex-shrink: 0;
    background: #eee;
  }
  .book-info-detail { flex: 1; }
  .book-info-title {
    font-family: Georgia, serif;
    font-size: 1.1rem;
    font-weight: 700;
    color: #1a1a2e;
    margin-bottom: 0.3rem;
  }
  .book-info-author {
    font-size: 0.85rem;
    color: #888;
    margin-bottom: 0.5rem;
  }
  .book-info-genre {
    display: inline-block;
    font-size: 0.72rem;
    font-weight: 600;
    padding: 3px 8px;
    border-radius: 4px;
    background: #f0f0f0;
    color: #555;
    margin-bottom: 0.5rem;
  }
  .book-status {
    font-size: 0.78rem;
    font-weight: 600;
    color: #0abf8a;
  }
  .book-status.unavailable { color: #ff6b6b; }
  .error-msg {
    background: #fff0ee;
    color: #ff6b6b;
    border: 1px solid #ffccc7;
    border-radius: 8px;
    padding: 0.8rem 1rem;
    font-size: 0.88rem;
    margin-bottom: 1.5rem;
    text-align: center;
  }
  .success-msg {
    background: #e8faf5;
    color: #0abf8a;
    border: 1px solid #0abf8a;
    border-radius: 8px;
    padding: 0.8rem 1rem;
    font-size: 0.88rem;
    margin-bottom: 1.5rem;
    text-align: center;
  }
  .btn-reserve {
    width: 100%;
    padding: 0.95rem;
    background: #0abf8a;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
  }
  .btn-reserve:hover { background: #089970; }
  .btn-reserve:disabled {
    background: #ccc;
    cursor: not-allowed;
  }
  .bottom-links {
    text-align: center;
    margin-top: 1.5rem;
    font-size: 0.88rem;
    color: #666;
  }
  .bottom-links a {
    color: #ff6b6b;
    font-weight: 700;
    text-decoration: none;
  }
  .bottom-links a:hover { text-decoration: underline; }
</style>
</head>
<body>

<div class="reserve-wrapper">
  <div class="reserve-card">

    <div class="reserve-title">Reserve a Book</div>
    <div class="reserve-subtitle">Confirm your reservation and collect from the library</div>

    <!-- Show error or success message -->
    <% String error = (String) request.getAttribute("error"); %>
    <% String success = (String) request.getAttribute("success"); %>
    <% if (error != null) { %>
      <div class="error-msg"><%= error %></div>
    <% } %>
    <% if (success != null) { %>
      <div class="success-msg"><%= success %></div>
    <% } %>

    <!-- Book Details passed from index.html -->
    <div class="book-details">
      <img class="book-cover-img"
           src="${param.cover_url}"
           alt="Book Cover"
           onerror="this.style.background='#eee'">
      <div class="book-info-detail">
        <div class="book-info-title">${param.title}</div>
        <div class="book-info-author">${param.author}</div>
        <div class="book-info-genre">${param.genre}</div>
        <div class="book-status">✅ Available for Reservation</div>
      </div>
    </div>

    <!-- Reservation Form -->
    <form action="ReserveBookServlet" method="post">
      <!-- Hidden fields to send book info to servlet -->
      <input type="hidden" name="book_id"   value="${param.book_id}">
      <input type="hidden" name="user_id"   value="${sessionScope.userId}">
      <button type="submit" class="btn-reserve">Confirm Reservation</button>
    </form>

    <div class="bottom-links">
      <a href="index.html">← Back to Homepage</a>
    </div>

  </div>
</div>

</body>
</html>
