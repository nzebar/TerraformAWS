<?php
/* Attempt to connect to MySQL database */
$link = mysqli_connect("127.0.0.1", "root", "Root@123456789", "ServerDB");

//check connection
if($link === false){
  die("ERROR: Could not connect. " . mysqli_connect_error());
}

$user = mysqli_real_escape_string($link, $_REQUEST['username']);
$pass = mysqli_real_escape_string($link, $_REQUEST['password']);

$sql = "INSERT INTO Customer_info (username, password, timestamp) VALUES ('$user','$pass', now())";

if(mysqli_query($link, $sql)){
  echo "Records added successfully."."<br>";
} else{
  echo "ERROR: Could not able to execute $sql. " . mysqli_error($link);
}

$sql1 = "SELECT timestamp FROM Customer_info ORDER BY id DESC LIMIT 1";
$result = $link->query($sql1);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "Timestamp: " . $row["timestamp"]. "<br>";
  }
} else {
  echo "0 results";
}

// Close connection
mysqli_close($link);
?>
