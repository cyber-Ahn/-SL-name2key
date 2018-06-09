<?php
include ("../TGN/gate/liberay/lib.php");
$username = $_GET["name"];
if($username == "")
{
echo '<div align="center"><font size="-1">
<form action="n2k.php" method="GET">
<input type="text" size="18" maxlength="40" value="SL Name" name="name">
<br><input type="submit" value="lookup">
</form>';
}
else
{
$uuid = name2Key($username);
echo "<br>$uuid";
}
?>