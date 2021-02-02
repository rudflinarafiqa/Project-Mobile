<<<<<<< HEAD:meowphp/php/verify.php
<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_GET['email'];
    $verify = $_GET['key'];
    
    $sql = "SELECT * FROM USER WHERE EMAIL = '$email'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE USER SET VERIFY = '0' WHERE EMAIL = '$email' AND VERIFY = '$verify'";
        if ($conn->query($sqlupdate) === TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }   
    }else{
        echo "failed";
    }
    
    
?>
=======
<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_GET['email'];
    $otp = $_GET['key'];
    
    $sql = "SELECT * FROM USER WHERE EMAIL = '$email'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE USER SET OTP = '0' WHERE EMAIL = '$email' AND OTP = '$otp'";
        if ($conn->query($sqlupdate) === TRUE){
            echo 'success';
        }else{
            echo 'failed';
        }   
    }else{
        echo "failed";
    }
    
    
?>
>>>>>>> 37534222bec5e8ad9a27eabe6e297868852973cb:php/verify_account.php
