<?php
include "db.php";
header('Content-Type: application/json');


$work_id = $_POST['work_id'] ?? '';
$worker_id = $_POST['worker_id'] ?? '';
$submission_text = $_POST['submission_text'] ?? '';

if (!$work_id || !$worker_id || !$submission_text) {
    echo json_encode(["status" => "error", "message" => "Missing fields"]);
    exit;
}

$stmt = $conn->prepare("INSERT INTO tbl_submissions (work_id, worker_id, submission_text) VALUES (?, ?, ?)");
$stmt->bind_param("iis", $work_id, $worker_id, $submission_text);

if ($stmt->execute()) {

    $update = $conn->prepare("UPDATE tbl_works SET status = 'completed' WHERE id = ? AND assigned_to = ?");
    $update->bind_param("ii", $work_id, $worker_id);
    $update->execute();

    echo json_encode(["status" => "success", "message" => "Submission saved and task updated"]);
} else {
    echo json_encode(["status" => "error", "message" => "Submission failed"]);
}
?>
