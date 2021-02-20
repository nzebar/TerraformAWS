<!DOCTYPE html>
<html lang="en">
<?php
/*PHP Functions to communicate with the Database Start */

     /* Function to store Username and Email values from form into PHP session variables */
     /* End of function */


     /* Function to use Username and Email PHP Session variables to filter database. Use SELECT query. Then pull Security question and answer.
        Security question and answer are then put into PHP session variables. */
     /* End of function */


     /* Function to store answer to security question in PHP session variable after Security question has been displayed and security answer is given. */
     /* End of Function */

     /* Function to compare both security answers. One was stored from PHP sesion variable from database. The other was stored from PHP session variable from user input*/
         /* If Security answer from database = Security answer from user input, then the user is prompted to reset password */
         /* If security answers do not match then the message "incorrect answer is displayed */
     /* End of Function */

     /* Function to overwite password for users account on database after the reset password prompt has been filled with a new password */
     /* End of function */

/* PHP end of functions */
?>

<?php
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

    /* This is where the form filters through the database to verify email */
    if(isset($_POST["email"]) && (!empty($_POST["email"]))){
        $email = $_POST["email"];
        $email = filter_var($email, FILTER_SANITIZE_EMAIL);
        $email = filter_var($email, FILTER_VALIDATE_EMAIL);
        if (!$email) {
            $error .="<p>Invalid email address please type a valid email address!</p>";
         }
        elseif ($row==""){
            $error .= "<p>No user is registered with this email address!</p>";
            /*else if statements for security question and answer to check if not equal
            to what is stored in db

            }elseif (!securityQuestion){
            $error .= "<p>Security question does not match.</p>";
            }elseif (!securityAnswer) {
            $error .= "<p>Security question answer does not match.</p>";
            }

            */
        else{
            $sel_query = "SELECT * FROM `users1` WHERE email =='".$email."'";
            $results = mysqli_query($conn,$sel_query);
            $row = mysqli_num_rows($results);
        }
    else {}
}
/* End of Verify Email in Database */
?>


<body>
/* This is where the user will input there Username and Email */
<form method="post" action="reset.php?action=filterdb" name="reset"><br /><br />
<label><strong>Enter Your Email Address:</strong></label><br /><br />
<input type="email" name="email" placeholder="username@email.com" />
<br/><br />
<input type="submit" value="Reset Password"/>
</form>


/* Form to insert New password into Database */
<form method="post" action="" name="reset"><br /><br />
<label><strong>Enter Your Email Address:</strong></label><br /><br />
<input type="email" name="email" placeholder="username@email.com" />
<br /><br />
<input type="submit" value="Reset Password"/>
</form>
</body>
</html>
