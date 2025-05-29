<?php
header('Content-Type: application/json; charset=utf-8');
include "db.php";

$worker_id = isset($_POST['worker_id']) ? intval($_POST['worker_id']) : 0;

if ($worker_id <= 0) {
    echo json_encode([
        "status" => "error",
        "message" => "Missing or invalid worker ID"
    ]);
    exit;
}

$sql = "SELECT * FROM tbl_works WHERE assigned_to = ?";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo json_encode([
        "status" => "error",
        "message" => "Database prepare failed"
    ]);
    exit;
}

$stmt->bind_param("i", $worker_id);
$stmt->execute();
$result = $stmt->get_result();

$tasks = [];
while ($row = $result->fetch_assoc()) {
    $tasks[] = $row;
}

echo json_encode([
    "status" => "success",
    "tasks" => $tasks
]);
?>
