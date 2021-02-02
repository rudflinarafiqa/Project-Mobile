<?php
error_reporting(0);
include_once("dbconnect.php");
$id = $_POST['prid'];
$name = $_POST['prname'];
$price = $_POST['price'];
$quantity = $_POST['quantity'];
$size = $_POST['size'];
$type = $_POST['type'];

$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

if (isset($name)){
    $nama = ucwords($name);
    $sqlupdate = "UPDATE PRODUCT SET NAME = '$name', PRICE = '$price', QUANTITY = '$quantity', SIZE = '$size', TYPE = '$type' WHERE ID = '$id'";
    
    if ($conn->query($sqlupdate)){
        echo 'success';    
    }else{
        echo 'failed';
    }
}

if (isset($encoded_string)){
    $path = '../productimage/'.$id.'.jpg';
    if (file_put_contents($path, $decoded_string)){
        echo 'success';    
    }else{
        echo 'failed';
    }
}

?>