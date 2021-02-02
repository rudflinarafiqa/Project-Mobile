<?php
$servername = "localhost";
$username   = "seriousl_meowadmin";
$password   = "ym9iCJr_RpBe";
$dbname     = "seriousl_meow";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
?>