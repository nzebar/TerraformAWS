<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="css/styles.css">
        <link rel="stylesheet" type="text/css" href="css/bootTEST.css">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>

        <!-- Bootstrap -->
       <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    </head>
    <body>

	    <!-- This is where the picture with all of the containers along with the NutsandBolts logo is located -->
         <div class="hero-image">
            <div class="hero-text">
              <img class="mainlogo" src="img/nutsandbolts.jpg" alt="Website's Logo">
              <p>HARDWARE TOOLS THAT DO THE JOB AT A FAIR PRICE</p>
         </div>
         </div>
         <!-- End of her image-->

         <!-- This is where the header with items that link to othe parts of the website -->
	 
         <div id="myNav">
			<ul class="fix">
                <li>
                    <a href="index.php" class="hov">
                        <img class="logo" src="img/logo.jpg" alt="Website's Logo                                   ">
                    </a>
                </li>
                <li>
                    <a href="index.php" class="active">Home</a>
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
                <li>
                    <button onclick="document.getElementById('id01').style.display='block'" class="buttonintervention" style="width:auto;">Cart Items</button>
		        </li>
                <li id="right">
                    <a href="login.php" class="hov">Login</a>
		</li>
		        <li id="right">
          <button onclick="document.getElementById('id02').style.display='block'" class="hov">Sign Up</button>
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


<div id="id02" class="modal">
  <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
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
        <button type="button" onclick="document.getElementById('id02').style.display='none'" class="cancelbtn">Cancel</button>
        <button type="submit" class="signupbtn">Sign Up</button>
      </div>
    </div>
  </form>
</div>


<script>
var modal = document.getElementById('id02');

/* When the user clicks anywhere outside of the modal, close it */
 window.onclick = function(event) {
   if (event.target == modal) {
       modal.style.display = "none";
         }
         }
</script>



            <!-- ZigZag Grid, This is were the content under the header section is lcoated . -->
<div class="" style="margin: auto; wiidth: 80%; background-color:#f1f1f1">
  <div class="row">
    <div class="column-33">
      <img src="img/powertool.jpg" alt="App" height="100%">
    </div>
    <div class="column-66">
      <h1 class="xlarge-font"><b>We take pride in providing you with the right tools for your DIY projects!</b></h1>
      <h1 class="large-font" style="color:red;"><b>So come on down or shop online!</b></h1>
    </div>
  </div>
</div>
           <!-- End of ZigZag Grid -->

       <!--Start of Test for sale items -->
<?php
error_reporting(0);
session_start();

$total = 0;

/*database connection*/
$conn = new PDO("mysql:host=localhost;dbname=cart1", 'root', 'Root@123456789');
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

/*Get action String */
$action = isset($_GET['action']) ? $_GET['action'] : ""; 

/* Add to cart */
if ($action == 'addcart' && $_SERVER['REQUEST_METHOD'] == 'POST') {

/*Finding the product by code */
$query = "SELECT * FROM products WHERE code=:code";
$stmt = $conn->prepare($query);
$stmt->bindParam('code', $_POST['code']);
$stmt->execute();
$product = $stmt->fetch();

$currentQty = $_SESSION['products'][$_POST['code']]['qty'] + 1; //Incrementing the product qty in cart
$_SESSION['products'][$_POST['code']] = array('qty' => $currentQty, 'name' => $product['name'], 'image' => $product['image'], 'price' => $product['price']);
$product = '';
header("Location:index.php");
}

/* Empty All */
if ($action == 'emptyall') {
$_SESSION['products'] = array();
header("Location:index.php");
}

/* Empty one by one */
if ($action == 'empty') {
$code = $_GET['code'];
$products = $_SESSION['products'];
unset($products[$code]);
$_SESSION['products'] = $products;
header("Location:index.php");
}


/* Get all Products */
$query = "SELECT * FROM products";
$stmt = $conn->prepare($query);
$stmt->execute();
$products = $stmt->fetchAll();

?> 


<div id="id01" class="modal" style="display: none;">
<span onclick="document.getElementById('id01').style.display='block'" class="close" title="Close Modal">&times;</span>
<div class="modal-content">
<div class="container" style="width:600px; padding:0px;">
        <?php if (!empty($_SESSION['products'])) : ?>
            <nav class="navbar navbar-inverse" style="background:#04B745;">
                <div class="container-fluid pull-left" style="width:300px;">
                    <div class="navbar-header"> <a class="navbar-brand" href="#" style="color:#FFFFFF;">Shopping Cart</a> </div>
                </div>
                <div class="pull-right" style="margin-top:7px;margin-right:7px;"><a href="index.php?action=emptyall" class="btn btn-info">Empty cart</a></div>
            </nav>
            <table class="table table-striped">
            <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <?php foreach ($_SESSION['products'] as $key => $product) : ?>
                    <tr>
                        <td><img src="<?php print $product['image'] ?>" width="50"></td>
                        <td><?php print $product['name'] ?></td>
                        <td>$<?php print $product['price'] ?></td>
                        <td><?php print $product['qty'] ?></td>
                        <td><a href="index.php?action=empty&code=<?php print $key ?>" class="btn btn-info">Delete</a></td>
                    </tr>
                    <?php $total = $total + $product['price']; ?>
                <?php endforeach; ?>
                <tr>
                    <td colspan="5" align="right">
                        <h4>Total:$<?php print $total ?></h4>
                    </td>
                </tr>
            </table>
	    <?php endif; ?>
	    <button><a href="shop.php">Checkout</a></button>
            <button><a href="index.php">Return</a></button>
         </div>
     </div>
  </div>

	</nav>
	    <div style="margin: auto; display: inline-block;">
           <?php foreach ($products as $product) : ?>   
	      <div class="col-md-4" style="height:300px; width:200px;"> 
                        <div class="thumbnail"> <img style="height:150px; width:200px" src="<?php print $product['image'] ?>" alt="Lights">
			    <div class="caption" style="padding:0px">
                               <div>
				<p style="text-align:center; padding-bottom:0px;"><?php print $product['name'] ?></p>
                               </div>
                                <p style="text-align:center;color:#04B745; padding-top:5px;"><b>$<?php print $product['price'] ?></b></p>
				<form method="post" action="index.php?action=addcart">
                                    <p style="text-align:center;color:#04B745;">
                                        <button type="submit" class="btn btn-warning" style="padding-top: 5px;">Add To Cart</button>
                                        <input type="hidden" name="code" value="<?php print $product['code'] ?>">
				    </p>
                                </form>
                            </div>
                        </div>
                    </div>
		<?php endforeach; ?>
               </div>
	   </div>
       </div>
    </div>  
    
    
    
    <script>
/* Get the modal */
var modal = document.getElementById('id01');

/* When the user clicks anywhere outside of the modal, close it */
 window.onclick = function(event) {
   if (event.target == modal) {
       modal.style.display = "none";
         }
         }
</script>
             <!-- End of for sale items test-->

		 
        <!--
            Code for sticky navigation bar, removes class "sticky" on scroll down
	    This affects the header where the menu items are located
        -->
        <script type="text/javascript">

            window.onscroll = function() {myFunction()};

            var nav = document.getElementById("myNav");
            var sticky = nav.offsetTop;

            function myFunction() {
              if (window.pageYOffset > sticky) {
                nav.classList.add("sticky");
              } else {
                nav.classList.remove("sticky");
              }
            }
            </script>




	    <!--Start of the Footer section, meaning the section at the very bott of all webpages -->    
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

    </body>
</html>
