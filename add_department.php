<?php
session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: index.php"); exit;
}
include 'includes/db.php';
include 'includes/header.php';

$message = '';
if (isset($_POST['add'])) {
    $name = trim($_POST['name']);
    if ($name === '') {
        $message = "<div class='alert alert-warning'>Please enter a department name.</div>";
    } else {
        $stmt = $conn->prepare("INSERT INTO Departments (name) VALUES (?)");
        $stmt->bind_param("s", $name);
        if ($stmt->execute()) {
            header("Location: departments.php?added=1");
            exit;
        } else {
            $message = "<div class='alert alert-danger'>Error: " . $stmt->error . "</div>";
        }
    }
}
?>


<main class="flex-grow-1 container py-4">
  <div class="d-flex justify-content-between mb-3">
    <h2>Add Department</h2>
    <a href="departments.php" class="btn btn-secondary">← Back to Departments</a>
  </div>

  <?= $message ?>

  <form method="post" class="w-50">
    <div class="mb-3">
      <label class="form-label">Department Name</label>
      <input type="text" name="name" class="form-control" required>
    </div>
    <button name="add" class="btn btn-primary" onclick="">Add Department</button>
  </form>
</main>

