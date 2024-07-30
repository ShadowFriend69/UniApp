<?php
require_once 'db.php';

$connection = connect();

$data = json_decode(file_get_contents("php://input"));

$user_id = $data->user_id;
$education = $data->education;

// Проверка существования образования
$education_id_query = $connection->prepare("SELECT education_id FROM edu WHERE education = ?");
$education_id_query->bind_param("s", $education);
$education_id_query->execute();
$education_id_result = $education_id_query->get_result();

if ($education_id_result->num_rows > 0) {
    // Образование найдено, получить его ID
    $education_id_row = $education_id_result->fetch_assoc();
    $education_id = $education_id_row['education_id'];
    $education_id_query->close();
} else {
    // Образование не найдено, добавить его в таблицу edu
    $education_id_query->close();
    $insert_education_query = $connection->prepare("INSERT INTO edu (education) VALUES (?)");
    $insert_education_query->bind_param("s", $education);

    if ($insert_education_query->execute() === TRUE) {
        // Получить ID нового образования
        $education_id = $connection->insert_id;
        $insert_education_query->close();
    } else {
        echo json_encode(array("message" => "Ошибка при добавлении нового образования: " . $connection->error));
        $insert_education_query->close();
        exit();
    }
}

// Обновление образования пользователя
$update_query = $connection->prepare("UPDATE user_education SET education_id = ? WHERE user_id = ?");
$update_query->bind_param("ii", $education_id, $user_id);

if ($update_query->execute() === TRUE) {
    echo json_encode(array("message" => "Образование обновлено"));
} else {
    echo json_encode(array("message" => "Ошибка при обновлении образования: " . $connection->error));
}

$update_query->close();
$connection->close();
