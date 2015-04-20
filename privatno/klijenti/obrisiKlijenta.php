<?php
include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: ../../odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}

$veza->beginTransaction();

$izraz = $veza -> prepare("delete from klijent where sifra=:sifra");
$izraz -> bindParam(':sifra', $sifra, PDO::PARAM_STR);
$izraz -> execute();

$izraz = $veza -> prepare("delete from osoba where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifraOsobe'], PDO::PARAM_STR);
$izraz -> execute();

$izraz = $veza -> prepare("delete from operater where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifraOperatera'], PDO::PARAM_STR);
$izraz -> execute();

header("location: index.php");

$veza->commit();
