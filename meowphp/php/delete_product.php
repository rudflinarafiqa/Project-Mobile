<?php
error_reporting(0);
include_once("dbconnect.php");
$prid = $_POST['prid'];

$sqldelete = "DELETE FROM PRODUCT WHERE ID='$prid'";

    if ($conn->query($sqldelete) === TRUE){
       echo "success";
    }else {
        echo "failed";
    }
?>