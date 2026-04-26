<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PageTurn — Login</title>
<link rel="stylesheet" href="p1.css">
<style>
  .auth-wrapper {
    min-height: 100vh;
    background: #1a1a2e;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
  }
  .auth-card {
    background: #fff;
    border-radius: 20px;
    padding: 3rem 2.5rem;
    width: 100%;
    max-width: 420px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.3);
  }
  .auth-logo {
    text-align: center;
    font-family: Georgia, serif;
    font-size: 1.8rem;
    font-weight: 900;
    color: #1a1a2e;
    margin-bottom: 0.4rem;
  }
  .auth-logo span { color: #ff6b6b; }
  .auth-subtitle {
    text-align: center;
    color: #888;
    font-size: 0.9rem;
    margin-bottom: 2rem;
  }
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
  .form-group {
    margin-bottom: 1.3rem;
  }
  .form-group label {
    display: block;
    font-size: 0.85rem;
    font-weight: 600;
    color: #1a1a2e;
    margin-bottom: 0.4rem;
  }
  .form-group input {
    width: 100%;
    padding: 0.85rem 1rem;
    border: 1.5px solid #e0e0e0;
    border-radius: 8px;
    font-size: 0.92rem;
    outline: none;
    box-sizing: border-box;
  }
  .form-group input:focus { border-color: #ff6b6b; }
  .btn-submit {
    width: 100%;
    padding: 0.95rem;
    background: #ff6b6b;
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 700;
    cursor: pointer;
    margin-top: 0.5rem;
  }
  .btn-submit:hover { background: #ff4f4f; }
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

<div class="auth-wrapper">
  <div class="auth-card">

    <div class="auth-logo">Page<span>Turn</span></div>
    <div class="auth-subtitle">Log in to your account</div>

    <!-- Show error if login fails -->
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="error-msg"><%= error %></div>
    <% } %>

    <form action="LoginServlet" method="post">
      <div class="form-group">
        <label>Email</label>
        <input type="email" name="email" placeholder="you@example.com" required>
      </div>
      <div class="form-group">
        <label>Password</label>
        <input type="password" name="password" placeholder="Enter your password" required>
      </div>
      <button type="submit" class="btn-submit">Log In</button>
    </form>

    <div class="bottom-links">
      No account? <a href="signup.jsp">Sign Up</a> &nbsp;|&nbsp;
      <a href="index.html">Back to Home</a>
    </div>

  </div>
</div>

</body>
</html>
