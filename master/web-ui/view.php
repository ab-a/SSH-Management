<?php

$file = file_get_contents('db.json');
$json = @json_decode($file, TRUE);
$vId = $_GET["id"];
$key = $json['keys'][$vId]['key'];

echo '<script type="text/javascript">alert("'.$key.'");window.location.href="index.html";</script>';

?>
