<!DOCTYPE html>
<html lang="en">
<?php

$errors = [];
/* This is where the password reset form will start */
$conn = mysqli_connect("localhost", "root", "Root@123456789", "cart1");

if($conn -> connect_errno) {
  echo "failed to connect:".$conn -> connect_error;
  exit();
}

/*get action string*/
$action = isset($_GET['action']) ? $_GET['action'] : "";

/* filterdb call function */
if ($action == 'filterdb' && $_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $query = "SELECT email FROM users WHERE email = '$email'";
    $results = mysqli_query($conn, $query);
    if (empty($email)) {
	echo "Need a valid email";

    }else if(mysqli_num_rows($results) <= 0) {
	echo "Sorry, no user exists on our system with that email";
    }
    else {
        header ("location: forgot.php");
    }
}
?>

<body>
<form method="post" action="resetraj.php?action=filterdb">
    <p>Enter Your Email Address:</p>
    <input type="test" name="email" placeholder="username@email.com"/>
    <input type="submit"name="sumbit_email" value="submit"/>
</form>
</body>
</html>
