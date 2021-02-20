<html lang="en">
<?php
$conn = new PDO("mysql:host=localhost;dbname=cart1", 'root', 'Root@123456789');
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

/* Function to add an item to the database*/
$action = isset($_GET['action']) ? $_GET['action'] : "action";

if ($action == 'addinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') {
/*
        $name = $_POST['name'];
	$description = $_POST['description'];
	$price = $_POST['price'];
        $code = $_POST['code'];
	$quantity = $_POST['quantity'];

        $sql = "INSERT INTO products (id, name, description, code, price, quantity) VALUES ( ?, ?, ?, ?, ?,)";
	/*if($stmt = mysqli_prepare($conn, $sql)){}*/
/*	
	$stmt = $conn->prepare($sql);
	$stmt->bind_param('sssii', $name, $description, $code, $price, $qauntity);
*/
	/*$stmt = $conn->prepare($stmt);
	$stmt->execute();
 */
	$name = $_POST['name'];
	$description = $_POST['description'];
        $code = $_POST['code'];
	$price = $_POST['price'];
	$quantity = $_POST['quantity'];

	$sql = "INSERT INTO products (name, description, code, price, quantity) VALUES ($name, $description, $code, $price, $quantity)";
	$stmt = $conn->prepare($sql);
	$stmt->execute();
}


/*Function to change item properties in database */
if ($action == 'changeinventory' && $_SERVER['REQUEST_METHOD'] == 'POST') {

    /*$stmt = function renderForm($id ,$name,$description, $code, $price, $quantity, $error){
        $sel_query = "SELECT * FROM `users1` WHERE code =='".$code."'";
	$stmt = $conn->prepare($sel_query);
     */
    };
/*    
$stmt->execute();
$conn = null;
 */    

?>
<body>
<h1> Add Inventory</h1>
<form action="Form.php?action=addinventory" method="post">
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


<form id="searchform" action="Form.php?action=ChangeInventory" method="post" enctype="multipart/form-data">
  <div align="center">
 <fieldset>

   <div align="center">
     <legend align="center" >Stock!</legend>
   </div>
   <div class="fieldset">
     <p>
   <label class="field" for="date">Date: </label>

       <input name="date" type="text" class="tcal" value="<?php echo date("Y-m-d");; ?>" size="30"/>
         </p>
   <p>
     <label class="field" for="item">Item: </label>

     <input name="item" type="text"  value=" "  size="30"/>
   </p>

       <p>
       <label class="field" >Quantity :</label>
       <input  name="quantity" type="text" value=""  size="30"/>
     </p> 
       <p>
       <label class="field" >Amount :</label>
       <input  name="amount" type="text" value=""  size="30"/>
     </p> 
  </div>
 </fieldset>
   <p align="center" class="required style3">Please Fill The Complete Form </p>
   <div align="center">
     <input name="submit" type="submit" class="style1" value="Submit">

   </div>
 </form> 



</body>
</html>    
