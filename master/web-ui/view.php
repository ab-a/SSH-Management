<?php

$file = file_get_contents('db.json');
$json = @json_decode($file, TRUE);
$vId = $_GET["id"];
echo("The SSH key is : ");
echo($json['keys'][$vId]['key']);

?>
