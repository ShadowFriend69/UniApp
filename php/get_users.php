<?php
require_once 'db.php';

$connection = connect();

$sql = "SELECT 
            u.user_id,
            u.user_name,
            e.education_id,
            e.education, 
            GROUP_CONCAT(c.city SEPARATOR ', ') as cities
        FROM users u
        LEFT JOIN user_education ue ON u.user_id = ue.user_id
        LEFT JOIN edu e ON ue.education_id = e.education_id
        LEFT JOIN user_cities uc ON u.user_id = uc.user_id
        LEFT JOIN city c ON uc.city_id = c.city_id
        GROUP BY u.user_id, u.user_name, e.education, e.education_id
        ";

$result = $connection->query($sql);

$users = array();
while($row = $result->fetch_assoc()) {
    $users[] = $row;
}

echo json_encode($users);

