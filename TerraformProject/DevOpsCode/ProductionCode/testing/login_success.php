<?php
session_start();
if( isset($_SESSION['username'])) {
  header("location: login.php");
  }
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <link rel="stylesheet" type="text/css" href="css/bootTEST.css">
        <link rel="stylesheet" type="text/css" href="css/stylesTEST.css">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Shopping Cart</title>

        <!-- Bootstrap -->
       <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    </head>


    <body>

            <!-- Start of hero image, This is where the picture with all of the containers includeing the nutsandbolts logo is located -->
            <div class="hero-image">
            <div class="hero-text">
              <img class="mainlogo" src="img/nutsandbolts.jpg" alt="Website's Logo">
              <p>HARDWARE TOOLS THAT DO THE JOB AT A FAIR PRICE</p>
            </div>
            </div>
            <!-- End of hero image section -->


            <!-- Start of header navigation bar navigation -->
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
                    <a href ="contact.php" class="hov">Contact</a>
                </li>
                                <li>
                    <a href ="shop.php" class="active">Shop</a>
                </li>
                <li id="right">
                    <a href="logout.php" class="hov">Logout</a>
                </li>
            </ul>
                        </div>
           <!-- End of menu navigation bar -->


        <!-- Start of shopping cart -->

        <?php
error_reporting(0);
session_start();

$total = 0;

//database connection
$conn = new PDO("mysql:host=localhost;dbname=cart1", 'root', 'Root@123456789');
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//get action string
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
    header("Location:login_success.php");
}

/* Empty All */
if ($action == 'emptyall') {
    $_SESSION['products'] = array();
    header("Location:login_success.php");
}

/* Empty one by one */
if ($action == 'empty') {
    $code = $_GET['code'];
    $products = $_SESSION['products'];
    unset($products[$code]);
    $_SESSION['products'] = $products;
    header("Location:login_success.php");
}




//Get all Products
$query = "SELECT * FROM products";
$stmt = $conn->prepare($query);
$stmt->execute();
$products = $stmt->fetchAll();

?>

    <div class="container" style="width:600px; padding:0px;">
        <?php if (!empty($_SESSION['products'])) : ?>
            <nav class="navbar navbar-inverse" style="background:#04B745;">
                <div class="container-fluid pull-left" style="width:300px;">
                    <div class="navbar-header"> <a class="navbar-brand" href="#" style="color:#FFFFFF;">Shopping Cart</a> </div>
                </div>
                <div class="pull-right" style="margin-top:7px;margin-right:7px;"><a href="login_success.php?action=emptyall" class="btn btn-info">Empty cart</a></div>
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
                        <td><a href="login_success.php?action=empty&code=<?php print $key ?>" class="btn btn-info">Delete</a></td>
                    </tr>
                    <?php $total = $total + $product['price']; ?>
                <?php endforeach; ?>
                <tr>
                    <td colspan="5" align="right">
                        <h4>Total:$<?php print $total ?></h4>
                        <button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Checkout</button>
                    </td>
                </tr>
            </table>
        <?php endif; ?>


        <nav class="navbar navbar-inverse" style="background:#04B745; padding:0px;">
            <div class="container-fluid">
                <div class="navbar-header"> <a class="navbar-brand"  href="#" style="color:#FFFFFF;">Products</a> </div>
            </div>
        </nav>
            <div class="" style="display:grid; grid-template-columns: auto auto auto; justify-content:start; align-items:start;">
            <?php foreach ($products as $product) : ?>
              <div class="col-md-4" style="height:320px; width:200px;">
                        <div class="thumbnail"> <img style="height:150px; width:200px" src="<?php print $product['image'] ?>" alt="Lights">
                        <p>In Stock:</p><div><?php print $product['quantity'] ?></div>
                            <div class="caption" style="padding:0px">
                               <div>
                                <p style="text-align:center; padding-bottom:0px;"><?php print $product['name'] ?></p>
                               </div>
                                <p style="text-align:center;color:#04B745; padding-top:5px;"><b>$<?php print $product['price'] ?></b></p>
                                <form method="post" action="login_success.php?action=addcart">
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

        <!-- End of shopping cart -->


        <!--Start of Checkout -->
        <div id="id01" class="modal">
            <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
            <form class="modal-content" method="post" action="register.php?action=register">
            <div>
                <div class="row">
                  <div class="col-75">
                    <div class="container-checkout">
                      <form action="/action_page.php">
                            <div class="row">
                              <div class="col-50">
                                <h3>Billing Address</h3>
                                <label for="fname"><i class="fa fa-user"></i> Full Name</label>
                                <input type="text" id="fname" name="firstname" placeholder="John M. Doe">
                                <label for="email"><i class="fa fa-envelope"></i> Email</label>
                                <input type="text" id="email" name="email" placeholder="john@example.com">
                                <label for="adr"><i class="fa fa-address-card-o"></i> Address</label>
                                <input type="text" id="adr" name="address" placeholder="542 W. 15th Street">
                                <label for="city"><i class="fa fa-institution"></i> City</label>
                                <input type="text" id="city" name="city" placeholder="New York">

                <div class="row">
                  <div class="col-50">
                        <label for="state">State</label>
                        <input type="text" id="state" name="state" placeholder="NY">
              </div>

              <div class="col-50">
                <label for="zip">Zip</label>
                <input type="text" id="zip" name="zip" placeholder="10001">
              </div>
            </div>
          </div>

          <div class="col-50">
            <h3>Payment</h3>
            <label for="fname">Accepted Cards</label>
            <div class="icon-container">
              <i class="fa fa-cc-visa" style="color:navy;"></i>
              <i class="fa fa-cc-amex" style="color:blue;"></i>
              <i class="fa fa-cc-mastercard" style="color:red;"></i>
              <i class="fa fa-cc-discover" style="color:orange;"></i>
            </div>
            <label for="cname">Name on Card</label>
            <input type="text" id="cname" name="cardname" placeholder="John More Doe">
            <label for="ccnum">Credit card number</label>
            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
            <label for="expmonth">Exp Month</label>
            <input type="text" id="expmonth" name="expmonth" placeholder="September">
            <div class="row">
              <div class="col-50">
                <label for="expyear">Exp Year</label>
                <input type="text" id="expyear" name="expyear" placeholder="2018">
              </div>
              <div class="col-50">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" placeholder="352">
              </div>
            </div>
          </div>

        </div>
        <label>
          <input type="checkbox" checked="checked" name="sameadr"> Shipping address same as billing
        </label>
        <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <button type="submit" class="signupbtn">Checkout</button>
        </div>
      </form>
    </div>
  </div>

  <div class="col-25">
      <div class="container-checkout">
      <h4>Cart </h4>
       <?php if (!empty($_SESSION['products'])) : ?>
            <nav class="navbar navbar-inverse" style="background:#04B745;">
                <div class="container-fluid pull-left" style="width:300px;">
                    <div class="navbar-header"> <a class="navbar-brand" href="#" style="color:#FFFFFF;">Shopping Cart</a> </div>
                </div>
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
                        <td><a href="login_success.php?action=empty&code=<?php print $key ?>" class="btn btn-info">Delete</a></td>
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

        </div>
    </div>
                </div>
              </form>
        </div>
    </div>

<script>
var modal = document.getElementById('id01');

/* When the user clicks anywhere outside of the modal, close it */
 window.onclick = function(event) {
   if (event.target == modal) {
       modal.style.display = "none";
         }
         }
</script>


        <!--
            Code for sticky navigation bar, removes class "sticky" on scroll down
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
         <!-- End of javascript sticky navigation bar -->


                        <!-- Footer -->
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
      <!-- End of footer section -->



    </body>
</html>
