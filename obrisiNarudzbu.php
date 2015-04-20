<?php
include_once 'konfiguracija.php';

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}

$izraz = $veza -> prepare("delete from narudzba_usluga where narudzba=:sifra");
$izraz -> bindParam(':sifra', $sifra, PDO::PARAM_STR);
$izraz -> execute();


$izraz = $veza -> prepare("delete from narudzba where sifra=:sifra");
$izraz -> bindParam(':sifra', $sifra, PDO::PARAM_STR);
$izraz -> execute();

header("location: mojeNarudzbe.php");
