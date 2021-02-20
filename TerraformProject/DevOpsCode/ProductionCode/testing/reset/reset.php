<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../css/bootTEST.css">
        <link rel="stylesheet" type="text/css" href="../css/stylesTEST.css">
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
              <img class="mainlogo" src="../img/nutsandbolts.jpg" alt="Website's Logo">
              <p>HARDWARE TOOLS THAT DO THE JOB AT A FAIR PRICE</p>
            </div>
            </div>
            <!-- End of hero image section -->


            <!-- Start of header navigation bar navigation -->
            <div id="myNav">
            <ul class="fix">
                <li>
                    <a href="../index.php" class="hov">
                        <img class="logo" src="../img/logo.jpg" alt="Website's Logo">
                    </a>
                </li>
                <li>
                    <a href="../index.php" class="hov">Home</a>
                </li>
                <li>
                    <a href="../about.php" class="hov">About</a>
                </li>
                <li>
                    <a href ="../contact.php" class="hov">Contact</a>
                </li>
				<li>
                    <a href ="../shop.php" class="hov">Shop</a>
                </li>
                <li id="right">
                    <a href="../login.php" class="active">Login</a>
                </li>
            </ul>
                        </div>



<div class="InvContainer">
    <div class="InvContainerChild">  
        <div class="AddInvBox">	
        <form method="post" action="forgot.php">
       
        <p>Enter Your Email Address:</p>
        <input type="email" name="email" placeholder="username@email.com"/>

        <label for="securityquestions">Choose a Security Question:</label>
        <select name="securityquestions">
        <option value="What primary school did you attend?">What primary school did you attend?</option>
        <option value="What city were you born in?">What city were you born in?</option>
        <option value="In what town or city was your first job?">In what town or city was your first job?</option>
        </select>
        <input type="text" name="sa" required>		

        <input type="submit" name="sumbit_email" value="submit">
        </form>
        </div>
	</div>
</div>


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
            <li><a href="../about.php" rel="nofollow">Our Company</a></li>
            <li><a href="../about.php" rel="nofollow">Our Customers</a></li>
            <li><a href="../about.php" rel="nofollow">Our Team</a></li>
            <li><a href="../about.php" rel="nofollow"></a>Jobs</li>
          </ul>
        </div>
        <!--/.footer-list-wrap-->
        <div class="footer-list-wrap">
          <h6 class="ftr-hdr-column3">My Account</h6>
          <ul class="ftr-links-sub-column3">
            <art:content rule="!loggedin">
            <li class="ftr-Login"><span class="link login-trigger"><a href="../login.php">Login</a></span></li>
              <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Track my Order</span></li>
                          <li><span class="link" onclick="link('/asp/secure/your_account/track_orders-asp/_/posters.htm')">Order History</span></li>
						  <li><a class="link" href="../faq.php">FAQ</a></li>
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
