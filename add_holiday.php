<?php
session_start();
if (!isset($_SESSION['role'])) {
    header("Location: index.php"); exit;
}
include 'includes/db.php';
include 'includes/header.php';

$message = '';
if (isset($_POST['add'])) {
    $date = $_POST['holiday_date'];
    $desc = trim($_POST['description']);
    if (!$date || $desc === '') {
        $message = "<div class='alert alert-warning'>All fields are required.</div>";
    } else {
        $stmt = $conn->prepare("
          INSERT INTO Holidays (holiday_date, description)
          VALUES (?, ?)
        ");
        $stmt->bind_param("ss", $date, $desc);
        if ($stmt->execute()) {
            header("Location: holidays.php?added=1");
            exit;
        } else {
            $message = "<div class='alert alert-danger'>Error: " . $stmt->error . "</div>";
        }
    }
}
?>

<main class="flex-grow-1 container py-4">
  <div class="d-flex justify-content-between mb-3">
    <h2>Add Holiday</h2>
    <a href="holidays.php" class="btn btn-secondary">← Back to Holidays</a>
  </div>

  <?= $message ?>

  <form method="post" class="w-50">
    <div class="mb-3">
      <label class="form-label">Holiday Date</label>
      <input type="date" name="holiday_date" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Description</label>
      <input type="text" name="description" class="form-control" required>
    </div>
    <button name="add" class="btn btn-primary">Add Holiday</button>
  </form>
</main>


