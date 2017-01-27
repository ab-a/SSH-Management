<?php
  $file = dirname(__FILE__).'/form-data.json';
  file_put_contents($file, json_encode($_REQUEST));
?>
