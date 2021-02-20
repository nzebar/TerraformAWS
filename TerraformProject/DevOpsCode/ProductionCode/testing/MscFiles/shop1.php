<?php
error_reporting(0);
session_start();

$total = 0;

//Database connection, replace with your connection string.. Used PDO
//$conn = new mysqli("localhost", "root", "raj240699", "cart1");

//if ($conn->connect_error) {
//  die("Connection failed: " . $conn->connect_error);
//}
//echo "Connected successfully";

//database connection
$conn = new PDO("mysql:host=localhost;dbname=cart", 'root', 'Root@123456789');
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

//get action string
$action = isset($_GET['action']) ? $_GET['action'] : "";

//Add to cart
if ($action == 'addcart' && $_SERVER['REQUEST_METHOD'] == 'POST') {

    //Finding the product by code
    $query = "SELECT * FROM products WHERE code=:code";
    $stmt = $conn->prepare($query);
    $stmt->bindParam('code', $_POST['code']);
    $stmt->execute();
    $product = $stmt->fetch();

    $currentQty = $_SESSION['products'][$_POST['code']]['qty'] + 1; //Incrementing the product qty in cart
    $_SESSION['products'][$_POST['code']] = array('qty' => $currentQty, 'name' => $product['name'], 'image' => $product['image'], 'price' => $product['price']);
    $product = '';
    header("Location:shopping-cart.php");
}

//Empty All
if ($action == 'emptyall') {
    $_SESSION['products'] = array();
    header("Location:shopping-cart.php");
}

//Empty one by one
if ($action == 'empty') {
    $code = $_GET['code'];
    $products = $_SESSION['products'];
    unset($products[$code]);
    $_SESSION['products'] = $products;
    header("Location:shopping-cart.php");
}




//Get all Products
$query = "SELECT * FROM products";
$stmt = $conn->prepare($query);
$stmt->execute();
$products = $stmt->fetchAll();

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PHP registration form</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="css/styles.css">
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
                <a href="index.html" class="hov">
                    <img class="logo" src="img/logo.jpg" alt="Website's Logo">
                </a>
            </li>
            <li>
                <a href="home.html" class="hov">Home</a>
            </li>
            <li>
                <a href="about.html" class="hov">About</a>
            </li>
            <li>
                <a href="contact.html" class="hov">Contact</a>
            </li>
            <li>
                <a href="shop.html" class="active">Shop</a>
            </li>
            <li id="right">
                <a href="login.html" class="hov">Login</a>
            </li>
        </ul>
    </div>
    <!-- End of menu navigation bar -->

    <div class="container" style="width:600px;">
        <?php if (!empty($_SESSION['products'])) : ?>
            <nav class="navbar navbar-inverse" style="background:#04B745;">
                <div class="container-fluid pull-left" style="width:300px;">
                    <div class="navbar-header"> <a class="navbar-brand" href="#" style="color:#FFFFFF;">Shopping Cart</a> </div>
                </div>
                <div class="pull-right" style="margin-top:7px;margin-right:7px;"><a href="shopping-cart.php?action=emptyall" class="btn btn-info">Empty cart</a></div>
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
                        <td><a href="shopping-cart.php?action=empty&code=<?php print $key ?>" class="btn btn-info">Delete</a></td>
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
        <nav class="navbar navbar-inverse" style="background:#04B745;">
            <div class="container-fluid">
                <div class="navbar-header"> <a class="navbar-brand" href="#" style="color:#FFFFFF;">Products</a> </div>
            </div>
        </nav>
        <div class="row">
            <div class="container" style="width:600px;">
                <?php foreach ($products as $product) : ?>
                    <div class="col-md-4">
                        <div class="thumbnail"> <img src="<?php print $product['image'] ?>" alt="Lights">
                            <div class="caption">
                                <p style="text-align:center;"><?php print $product['name'] ?></p>
                                <p style="text-align:center;color:#04B745;"><b>$<?php print $product['price'] ?></b></p>
                                <form method="post" action="shopping-cart.php?action=addcart">
                                    <p style="text-align:center;color:#04B745;">
                                        <button type="submit" class="btn btn-warning">Add To Cart</button>
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

    <!--
            Code for sticky navigation bar, removes class "sticky" on scroll down
        -->
    <script type="text/javascript">
        window.onscroll = function() {
            myFunction()
        };

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
    <!-- End of javascript for sticky navigation bar -->
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
                            <li><a href="contact.html" rel="nofollow">Boltz@NutzAndBoltz.com</a></li>
                        </ul>
                    </div>
                    <!--/.footer-list-wrap-->
                    <div class="footer-list-wrap">
                        <h6 class="ftr-hdr-column2">About</h6>
                        <ul class="ftr-links-sub-column2">
                            <li><a href="about.html" rel="nofollow">Our Company</a></li>
                            <li><a href="about.html" rel="nofollow">Our Customers</a></li>
                            <li><a href="about.html" rel="nofollow">Our Team</a></li>
                            <li><a href="about.html" rel="nofollow"></a>Jobs</li>
                        </ul>
                    </div>
                    <!--/.footer-list-wrap-->
                    <div class="footer-list-wrap">
                        <h6 class="ftr-hdr-column3">My Account</h6>
                        <ul class="ftr-links-sub-column3">
                            <art:content rule="!loggedin">
                                <li class="ftr-Login"><span class="link login-trigger">Login</span></li>
                                <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Track my Order</span></li>
                                <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Order History</span></li>
                                <li><a class="link" href="faq.html">FAQ</a></li>
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
    <!-- End of Footer -->
</body>

</html>
