<?php

$file = file_get_contents('db.json');
$json = @json_decode($file, TRUE);
$vId = $_GET["id"];
$json["keys"][$vId]["enabled"] = 0;
$data = json_encode($json, JSON_PRETTY_PRINT);

file_put_contents('db.json',$data);
Header("Location: index.html");

?>
