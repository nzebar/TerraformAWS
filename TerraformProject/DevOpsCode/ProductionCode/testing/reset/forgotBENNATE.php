
<?php
ob_start();
session_start();

$errors = [];
/* This is where the password reset form will start */
$conn = mysqli_connect("localhost", "root", "Root@123456789", "cart1");

if($conn -> connect_errno) {
  echo "failed to connect:".$conn -> connect_error;
  exit();
}

/*get action string*/
//$action = isset($_GET['action']) ? $_GET['action'] : "";

/* filterdb call function */
$email = mysqli_real_escape_string($conn, $_POST['email']);
$query = "SELECT email FROM users WHERE email = '$email'";
$results = mysqli_query($conn, $query);

if (empty($email)) {
	array_push($errors, "Your email is required");
	echo "Your email is required";
}else if(mysqli_num_rows($results) <= 0) {
	array_push($errors, "Sorry, no user exists on our system with that email");
	echo "Sorry, no user exists on our system with that email";
    }
else {
    
    $action = isset($_GET['action']) ? $_GET['action'] : "";

    if ($action == 'reset' && $_SERVER['REQUEST_METHOD'] == 'POST') {
    
    $resetpswd = $_POST('password');
    $reset = "UPDATE users SET password = '$resetpswd' WHERE email = '$email'";
    $results = mysqli_query($conn, $reset);
};
    
    echo '
    <!DOCTYPE html>
    <html>
    <body>
    <form method="post" action="forgot.php?action=reset">
        <p>
            <label for="password">Password:</label>
            <input type="password" name="password" required>
        </p>
        <p>
            <label for="password">Confirm Password:</label>
            <input type="password" name="password" required>
        </p>
            <input type="submit" value="Submit">
    </form>
        
};






