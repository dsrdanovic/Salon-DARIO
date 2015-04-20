<?php
include_once '../../konfiguracija.php';

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: ../../odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}


$izraz = $veza -> prepare("delete from pas where sifra=:sifra");
$izraz -> bindParam(':sifra', $sifra, PDO::PARAM_STR);
$izraz -> execute();

header("location: index.php");


