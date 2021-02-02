<?php
error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$verify = rand(1000,9999);

$sqlinsert = "INSERT INTO USER(NAME,PHONE,EMAIL,PASSWORD,CREDIT,VERIFY) VALUES ('$name','$phone','$email','$password','0','$verify')";

if ($conn->query($sqlinsert) === TRUE)
{
    sendEmail($verify,$email);
    
    echo "success";
}
else
{
    echo "failed";
}

function sendEmail($verify,$email){
    $from = "noreply@meow.com";
    $to = $email;
    $subject = "From MEOW PET SHOP. Verify your account";
    $message = "Use the following link to verify your account :"."\n http://seriouslaa.com/meow/php/verify_account.php?email=".$email."&key=".$verify;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}

?>