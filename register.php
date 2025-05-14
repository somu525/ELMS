<?php
session_start();
include 'includes/db.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - Leave Portal</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script>
    function clearForm() {
      document.getElementById("registerForm").reset();
    }
  </script>
</head>
<body class="container mt-5">
  <div class="card mx-auto p-4" style="max-width: 500px;">
    <h3 class="text-center mb-3">Employee Registration</h3>

    <form method="post" id="registerForm">
      <input type="text" name="name" placeholder="Full Name" class="form-control mb-2" required>
      <input type="email" name="email" placeholder="Email" class="form-control mb-2" required>
      <input type="text" name="position" placeholder="Position" class="form-control mb-2" required>
      <input type="date" name="hire_date" class="form-control mb-2" required>

      <select name="department_id" class="form-control mb-2" required>
        <option value="">Select Department</option>
        <?php
        $result = $conn->query("SELECT * FROM Departments");
        while ($row = $result->fetch_assoc()) {
            echo "<option value='" . htmlspecialchars($row['department_id']) . "'>" . htmlspecialchars($row['name']) . "</option>";
        }
        ?>
      </select>

      <input type="password" name="password" placeholder="Password" class="form-control mb-3" required>

      <div class="mb-2">
        <img id="captchaImg" src="captcha.php" alt="CAPTCHA" style="height: 40px;">
        <button type="button" class="btn btn-sm btn-link" onclick="document.getElementById('captchaImg').src='captcha.php?' + Date.now();">
          Reload CAPTCHA
        </button>
        <input type="text" name="captcha_input" placeholder="Enter CAPTCHA" class="form-control mt-2" required>
      </div>

      <div class="d-flex justify-content-between">
        <button name="register" class="btn btn-primary w-50 me-1">Register</button>
        <button type="button" onclick="clearForm()" class="btn btn-secondary w-50 ms-1">Clear</button>
      </div>
    </form>

    <p class="mt-3 text-center">
      Already have an account? <a href="index.php">Login</a>
    </p>

    <?php
    if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['register'])) {
        $name = $_POST['name'];
        $email = $_POST['email'];
        $position = $_POST['position'];
        $hire_date = $_POST['hire_date'];
        $department_id = $_POST['department_id'];
        $password = $_POST['password'];
        $captcha_input = $_POST['captcha_input'];

        if ($captcha_input !== $_SESSION['captcha']) {
            echo "<div class='alert alert-danger mt-3'>Incorrect CAPTCHA. Please try again.</div>";
        } else {
            try {
                $stmt = $conn->prepare("INSERT INTO Employees (name, email, department_id, position, hire_date, status, password)
                                        VALUES (?, ?, ?, ?, ?, 'inactive', ?)");
                $stmt->bind_param("ssisss", $name, $email, $department_id, $position, $hire_date, $password);

                if ($stmt->execute()) {
                    echo "<div class='alert alert-success mt-3'>Registration successful. Awaiting manager approval.</div>";
                    echo "<script>setTimeout(() => window.location.href='index.php', 2000);</script>";
                }
            } catch (mysqli_sql_exception $e) {
                if (str_contains($e->getMessage(), 'Duplicate entry')) {
                    echo "<div class='alert alert-danger mt-3'>Email already exists. Please use another email.</div>";
                } else {
                    echo "<div class='alert alert-danger mt-3'>Something went wrong. Please try again later.</div>";
                }
            }
        }
    }
    ?>
  </div>

  <footer class="text-center mt-auto py-3 text-muted small bottom-0">
    &copy; <?= date("Y") ?> Employee Leave Portal
  </footer>
</body>
</html>
