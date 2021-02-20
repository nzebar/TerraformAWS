<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <title>Register User</title>
</head>

<body>
<div class="hero-image">
                   <div class="hero-text">
                   <img class="mainlogo" src="img/nutsandbolts.jpg" alt="Website's Logo">
                   <p>HARDWARE TOOLS THAT DO THE JOB AT A FAIR PRICE</p>
                   </div>
</div>

<div id="myNav">
    <ul class="fix">
        <li>
            <a href="index.php" class="hov">
                <img class="logo" src="img/logo.jpg" alt="Website's Logo">
            </a>
        </li>
        <li>
            <a href="index.php" class="hov">Home</a>
        </li>
        <li>
            <a href="about.php" class="hov">About</a>
        </li>
        <li>
            <a href="contact.php" class="hov">Contact</a>
        </li>
        <li>
            <a href="shop.php" class="hov">Shop</a>
        </li>
        <li id="right">
            <a href="login.php" class="hov">Login</a>
	</li>
        <li id="right">
          <button onclick="document.getElementById('id01').style.display='block'" class="userbutton" style="width:auto;">Sign Up</button>
        </li>
    </ul>
</div>

<?php

session_start();

$conn = mysqli_connect("localhost", "root", "Root@123456789", "cart1");

if($conn -> connect_errno) {
        echo "failed to connect:".$conn -> connect_error;
        exit();
}

$message = '';

$action = isset($_GET['action']) ? $_GET['action'] : "";

if($action == 'register' && $_SERVER['REQUEST_METHOD'] == 'POST'){
        $sql = "INSERT INTO users (id, username, password, Security_Questions, Security_Answers, email) VALUES (?, ?, ?, ?, ?, ?)";
        if($stmt = mysqli_prepare($conn, $sql)){
                mysqli_stmt_bind_param($stmt, "isssss", $id, $user, $pass, $sq, $sa, $email);
                if ($_POST['password'] == $_POST['cpassword']){
                        $id = '';
                        $user = $_POST['username'];
                        $pass = $_POST['password'];
                        $sq = $_POST['securityquestions'];
                        $sa = $_POST['sa'];
                        $email = $_POST['email'];

                        if(mysqli_stmt_execute($stmt)){
                                echo "Succesfully register account";
                                header ("refresh:5; url=login.php");
                        } else {
                                echo "error: $sql.".mysqli_error($conn);
                                header("refresh:2; url=register.php");
                        }
                } else {
                        echo "Password didnt match. Try again!!!";
                        header ("refresh:2; url=register.php");
                }
        } else {
                echo "Error: $sql.".mysqli_error($conn);
                header ("refresh:2l url=register,php");

        }
        mysqli_stmt_close($stmt);
        mysqli_close($conn);
}

?>

<!-- TEST Register Form -->


<button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Sign Up</button>

<div id="id01" class="modal">
  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
  <form class="modal-content" method="post" action="register.php?action=register">
    <div>
      <h1>Sign Up</h1>
      <p>Please fill in this form to create an account.</p>
      <hr>
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username"  required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" id="psw" required>

      <label for="psw-repeat"><b>Repeat Password</b></label>
      <input type="password" placeholder="Repeat Password" name="cpassword" id="psw-repeat" required>

      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="username@email.com" name="email" id="psw-repeat"  required>

      <label for="securityquestions">Choose a Security Question:</label>
      <select name="securityquestions">
         <option value="What primary school did you attend?">What primary school did you attend?</option>
         <option value="What city were you born in?">What city were you born in?</option>
         <option value="In what town or city was your first job?">In what town or city was your first job?</option>
      </select>
      <input type="text" name="sa" required>

      <p>By creating an account you agree to our <a href="#" style="color:dodgerblue">Terms & Privacy</a>.</p>

      <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <button type="submit" class="signupbtn">Sign Up</button>
      </div>
    </div>
  </form>
</div>


<script>
Get the modal
var modal = document.getElementById('id01');

/* When the user clicks anywhere outside of the modal, close it */
 window.onclick = function(event) {
   if (event.target == modal) {
       modal.style.display = "none";
         }
         }
</script>




<!-- Start of Footer -->
<footer>
  <div class="footer-gray">
    <div class="footer-custom">
      <div class="footer-lists">
        <div class="footer-list-wrap">
          <h6 class="ftr-hdr-column1">Contact Phone</h6>
          <ul class="ftr-links-sub-column1">
            <li>1-800-443-501</li>
          </ul>
                  <h6 class="ftr-hdr-column1">Address</h6>
                  <ul class="ftr-links-sub-column1">
                    <li>331 E Main Ave<br>Mountain View, OH 43026 USA</li>
          </ul>
                  <h6 class="ftr-hdr-column1">Email Us</h6>
                  <ul class="ftr-links-sub-column1">
                  <li><a href="contact.php" rel="nofollow">Boltz@NutzAndBoltz.com</a></li>
                  </ul>
	</div>
   </div>


        <!--/.footer-list-wrap-->
        <div class="footer-list-wrap">
          <h6 class="ftr-hdr-column2">About</h6>
          <ul class="ftr-links-sub-column2">
            <li><a href="about.php" rel="nofollow">Our Company</a></li>
            <li><a href="about.php" rel="nofollow">Our Customers</a></li>
            <li><a href="about.php" rel="nofollow">Our Team</a></li>
            <li><a href="about.php" rel="nofollow"></a>Jobs</li>
          </ul>
        </div>
        <!--/.footer-list-wrap-->
        <div class="footer-list-wrap">
          <h6 class="ftr-hdr-column3">My Account</h6>
          <ul class="ftr-links-sub-column3">
            <art:content rule="!loggedin">
              <li class="ftr-Login"><span class="link login-trigger"><a href="login.php">Login</a></span></li>
              <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Track my Order</span></li>
                          <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Order History</span></li>
                                                  <li><a class="link" href="faq.php">FAQ</a></li>
            </art:content>
          </ul>
        </div>
        <!--/.footer-list-wrap-->
      </div>
      <div class="footer-legal">
        <p>&copy; NutzAndBoltz.com All Rights Reserved. | <a href="/help/privacy-policy.html" rel="nofollow">Privacy Policy</a> | <a href="/help/terms-of-use.html" rel="nofollow">Terms of Use</a> | <a href="/help/terms-of-sale.html" rel="nofollow">Terms of Sale</a></p>
        <p>NutzAndBoltz.com and Photos [to] Art are trademarks or registered trademarks of NutzAndBoltz Inc.</p>
      </div>
      <!--/.footer-legal-->

      <!--/.footer-payment-->
    </div>
    <!--/.footer-custom-->
  </div>
  <!--/.footer-gray-->
</footer>
     <!--End of Footer -->

</body>
</html>
