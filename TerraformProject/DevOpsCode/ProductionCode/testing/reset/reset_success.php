<?php
//include 'forgot.php';
$conn = mysqli_connect("localhost", "root", "Root@123456789", "cart1");

if($conn -> connect_errno) {
  echo "failed to connect:".$conn -> connect_error;
  exit();
}

//$action = isset($_GET['action']) ? $_GET['action'] : "";

//if ($action == 'reset' && $_SERVER['REQUEST_METHOD'] == 'POST'){
if ($_POST['password'] == $_POST['cpassword']){
	$pass = $_POST['password'];
	$user = $_POST["username"];
        $sql = "UPDATE users SET password='$pass' WHERE username='$user'";

        if ($conn->query($sql) == TRUE){
		echo "Password Update Successfully";
		header ("refresh:5;url=../login.php");
        } else {
		echo "Error Updating Password" .$conn->error;
		header ("refresh:5; url=../login.php");
        }
        $conn->close();
}
else {
	echo "Password didn't match";
	header ("refresh:5; url=forgot.php");
}
?>
