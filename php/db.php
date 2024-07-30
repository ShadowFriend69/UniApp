<?php
require_once 'config.php';

function connect() {
    $connect = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

    if ($connect->connect_error) {
        die("Ошибка подключения: " . $connect->connect_error);
    }

    $connect->set_charset("utf8");
    return $connect;
}

