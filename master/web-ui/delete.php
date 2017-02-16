<?php

$file = file_get_contents('db.json');
$json = @json_decode($file, TRUE);
$vId = $_GET["id"];

array_splice($json["keys"], $vId, 1);

$data = json_encode($json, JSON_PRETTY_PRINT);

file_put_contents('db.json',$data);
Header("Location: index.html");

?>
