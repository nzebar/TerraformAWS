<?php
/* Attempt to connect to MySQL database */
ob_start();                                                                                                                                                                                   
$host="localhost"; // Host name                                                                                                                                                               
$username="root"; // Mysql username                                                                                                                                                        
$password="Root@123456789"; // Mysql password                                                                                                                                                    
$db_name="cart1"; // Database name                                                                                                                                                        
$tbl_name="users"; // Table name

// Connect to server and select databse.
$dbhandle = mysqli_connect("$host", "$username", "$password")or die("cannot connect");
mysqli_select_db($dbhandle, $db_name)or die("cannot select DB");

$username=$_POST['username'];
$password=$_POST['password'];

$username = stripslashes($username);
$password = stripslashes($password);
$username = mysqli_real_escape_string($dbhandle, $username);
$password = mysqli_real_escape_string($dbhandle, $password);


// To protect MySQL injection (more detail about MySQL injection)
//$username = stripslashes($username);
//$password = stripslashes($password);
//$username = mysqli_real_escape_string($username);
//$password = mysqli_real_escape_string($password);

$sql="SELECT * FROM $tbl_name WHERE username='$username' and password='$password'";
$result=mysqli_query($dbhandle, $sql);

// Mysql_num_row is counting table row
$count=mysqli_num_rows($result);

// If result matched $username and $password, table row must be 1 row

if($count==1){
  // Register $username, $password and redirect to file "login_success.php"
  $_SESSION["username"]=$username;
  $_SESSION["password"]=$password;	
	
  header("location: login_success.php");
  }
else {
	echo "Wrong Username or Password";
	echo "\nRedirecting Wait";
	header("refresh:5; url=login.php");
  //header ("location: login.php");
  }
  
ob_end_flush();

?>


