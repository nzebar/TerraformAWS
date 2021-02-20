<!DOCTYPE html>
<?php
$conn = mysqli_connect("localhost", "root", "Root@123456789", "cart1");

if($conn -> connect_errno) {
	echo "failed to connect:".$conn -> connect_error;
	exit();
}

/* This is function to add item to database */
$action = isset($_GET['action']) ? $_GET['action'] : "";

if ($action == 'addinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') {
	$sql =  "INSERT INTO products (id, name, description, code, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
	if($stmt = mysqli_prepare($conn, $sql)){
		mysqli_stmt_bind_param($stmt, "isssdis", $id, $name, $description, $code, $price, $quantity, $image);
		$id = '';
		$name = $_POST['name'];
		$description = $_POST['description'];
		$code = $_POST['code'];
		$price = $_POST['price'];
		$quantity = $_POST['quantity'];
		$image = '/image';
		
		if(mysqli_stmt_execute($stmt)){
			echo "records added";
		} else {
			echo "error: $sql.".mysqli_error($conn);
		}
	} else{
		echo "Error: $sql.".mysqli_error($conn);
	}

	mysqli_stmt_close($stmt);
	mysqli_close($conn);
}
?>


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
                    <a href="login.php" class="hov">Login</a>
                </li>
            </ul>
           </div>	
           
           
<div class="InvContainer">
	<div class="InvContainerChild">	
		<div class="AddInvBox">	
		<h1> Add Inventory</h1>
		<form action="inventory.php?action=addinventory" method="post">
   		<p>
        <label for="name">Product:</label>
        <input type="text" name="name" id="name" required>
    	</p>
    	<p> <label for="description">Description:</label>
        <input type="text" name="description" id="description" required>
    	</p>
    	<p> <label for="price">Price:</label>
        <input type="number" name="price" id="price" required>
    	</p>
    	<p> <label for="code">SKU:</label>
        <input type="number" name="code" id="code" required>
    	</p>
    	<p> <label for="quantity">Quantity:</label>
        <input type="number" name="quantity" id="quantity" required>
    	</p>
    	<input type="submit" value="Submit">
		</form>
		</div>
	</div>
	
	<div class="InvContainerChild">
		<div class="ChangeInvBox">
		<h1> Change Inventory</h1>
		<form action="inventory.php?action=pullinventory" method="post">
    	<p>
        <label for="code">SKU Number:</label>
        <input type="text" name="code" id="code" required>
    	</p>
    	<input type="submit" value="Submit">
		</form>	
		</div>
	</div>



<?php
/* This is function to change item in inventory */
if ($action == 'pullinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') {
    
     
    $code = mysqli_real_escape_string($conn, $_POST['code']);
    $query = "SELECT code FROM products WHERE code = '$code'";
    $results = mysqli_query($conn, $query);

if (empty($code)) {
	array_push($errors, "The SKU number is required.");
	echo "The SKU number is required";
}else if(mysqli_num_rows($results) <= 0) {
	array_push($errors, "Sorry, no products exists on our system with that SKU number");
	echo "Sorry, no products exists on our system with that SKU number";
    }
else {
    
    if ($action == 'changeinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') {
    	
         if($stmt = mysqli_prepare($conn, $sql)){
		    $name = $_POST['name'];
		    $description = $_POST['description'];
		    $code = $_POST['code'];
		    $price = $_POST['price'];
		    $quantity = $_POST['quantity'];
		    $image = '/image';
		    
		    $sql =  "UPDATE products SET name='$name', description='$description', code='$code', price='$price', quantity='$quantity', image='$image' WHERE code='$code'";
	    
	        if(mysqli_stmt_execute($stmt)){
	
	        echo "records added";
		    } 
		    else {
			echo "error: $sql.".mysqli_error($conn);
		}
	    
	}
	
	    mysqli_stmt_close($stmt);
	    mysqli_close($conn);
}

    echo '
    <!DOCTYPE html>
    <html>
    <body>
    <h1> Change the Item</h1>
    <form class="InvContainerChild" method="post" action="inventory.php?action=changeinventory">
	<p>
	    <label for="name">name:</label>
	    <input type="text" name="name" required>
	<p>
        <label for="description">Description:</label>
        <input type="text" name="description" required>
    </p>
    <p>
        <label for="code">SKU Number:</label>
        <input type="number" name="code" required>
        
    </p>
    <p>
        <label for="price">Price:</label>
        <input type="number" name="price" required>
    </p>
    <p>
        <label for="quantity">Stock:</label>
        <input type="number" name="quantity" required>
    </p>
        <input type="submit" name="changeinv" value="Submit">
    </form>
        
';}
}


/* Here is the change inventory function. I am attempting to use the SKU number (code) 
   from the HTML for below to filter through the database again in order to update the specific item
   So far the logs have been showing that the only variable not defined is the code variable.
   Almost there I think*/
   
if (isset($_POST['changeinv'])){
		$name = $_POST['name'];
		$description = $_POST['description'];
		$code = $_POST['code'];
		$price = $_POST['price'];
		$quantity = $_POST['quantity'];
		$image = '/image';

    	$sql =  "UPDATE products SET name='$name', description='$description', code='$code', price='$price', quantity='$quantity', image='$image' WHERE code='$code'";
   
/*
if ($action == 'changeinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') { 
    
        
		$nameNEW = $_POST['name'];
		$descriptionNEW = $_POST['description'];
		$code = $_POST['code'];
		$priceNEW = $_POST['price'];
		$quantityNEW = $_POST['quantity'];
		$imageNEW = '/image';
    
	$sql =  "UPDATE products SET id = '$id', name = '$nameNEW', description = '$descriptionNEW', code = '$code', price = '$priceNEW', quantity = '$quantityNEW', image = '$imageNEW' WHERE code = '$code'";
	    
*/	
	    if($stmt = mysqli_prepare($conn, $sql)){
	    
	        if(mysqli_stmt_execute($stmt)){
	
	        echo "records added";
		    } 
		    else {
			echo "error: $sql.".mysqli_error($conn);
		}
	    
	}
	
	mysqli_stmt_close($stmt);
	mysqli_close($conn);
	
    }


?>
</div>

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
