<?php
session_start();
if ($_SESSION['role'] !== 'admin') { header("Location: index.php"); exit; }
include 'includes/db.php';
include 'includes/header.php';
?>

<main class="flex-grow-1 container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Departments</h2>
    <a href="add_department.php" class="btn btn-primary">Add Department</a>
  </div>
  <table class="table table-bordered table-striped">
    <thead>
      <tr><th>ID</th><th>Name</th></tr>
    </thead>
    <tbody>
      <?php
      $res = $conn->query("SELECT * FROM Departments");
      if ($res->num_rows > 0) {
            $i = 1;
            while ($row = $res->fetch_assoc()) {
                echo "<tr>
                        <td>{$i}</td>
                        <td>{$row['name']}</td>
                        
                      </tr>";
                $i++;
            }
        } else {
            echo "<tr><td colspan='3' class='text-center'>No holidays found.</td></tr>";
        }?>
    </tbody>
  </table>
  <a href="admin_dashboard.php" class="btn btn-outline-secondary">← Back to Dashboard</a>
</main><?php if (isset($_SESSION['toast_message'])): ?>
  <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
    <div class="toast align-items-center text-bg-<?= $_SESSION['toast_type'] ?? 'success' ?> border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
      <div class="d-flex">
        <div class="toast-body">
          <?= htmlspecialchars($_SESSION['toast_message']) ?>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>
  <?php unset($_SESSION['toast_message'], $_SESSION['toast_type']); ?>
<?php endif; ?>

