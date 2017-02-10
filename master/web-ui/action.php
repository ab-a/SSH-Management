<?php

function checkValue($json, $vUser, $vKey) {
    foreach($json['keys'] as $key => $value) {
        if ($vUser == $value['username'] && $vKey == $value['key']) {
            return $key;
        }
    }
    return FALSE;
}

function searchEntry($json, $vUser, $vKey) {
    $i = 0;
    foreach($json['keys'] as $key => $value) {
        if ($vUser == $value['username'] && $vKey == $value['key']) {
            return $i;
        }
        $i++;
    }
    return FALSE;
}

$file = file_get_contents('db.json');
$json = @json_decode($file, TRUE);

if(!is_array($json)){ $json = []; }
if(!array_key_exists("keys", $json)){$json["keys"] = [];}

$vUser = $_GET["username"];
$vKey = $_GET["key"];
$vStatus = $_GET["status"];

$status = false;

if($vStatus == "enable"){
  $status = true;
}

$vValue = checkValue($json, $vUser, $vKey);

if ($vValue !== FALSE) {
    if ($vStatus == "delete") {
        $i = searchEntry($json, $vUser, $vKey);
        unset($json["keys"][$i]);
    } else {
        $json["keys"][$vValue]["enabled"] = (int)$status;
    }
} else {
    $obj = array(
        'username'=>$vUser,
        'key'=>$vKey,
        'enabled'=>(int)$status,
    );
    $json["keys"][] = $obj;
}
$data = json_encode($json);
file_put_contents('db.json',$data);
Header("Location: list.html");

?>
