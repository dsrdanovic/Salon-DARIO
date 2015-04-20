<?php

include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

if($_POST){
	
$veza->beginTransaction();
	
if (!(isset($_POST["adresa"]))){
	
	$adresa = null;

}else{
	$adresa = $_POST["adresa"];
}

if($_POST["mjesto"]==0){
		$mjesto = null;
	}else{
		$mjesto = $_POST["mjesto"];
	}

if (!(isset($_POST["telefon"]))){
	
	$telefon = null;

}else{
	$telefon = $_POST["telefon"];
}

$izraz = $veza -> prepare("update osoba set oib=:oib,ime=:ime,prezime=:prezime,adresa=:adresa,mjesto=:mjesto,telefon=:telefon,mobitel=:mobitel,email=:email,slika=null where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifraOsobe'], PDO::PARAM_STR);
$izraz -> bindParam(':oib', $_POST['oib'], PDO::PARAM_STR);
$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
$izraz -> bindParam(':prezime', $_POST['prezime'], PDO::PARAM_STR);
$izraz -> bindParam(':adresa', $adresa, PDO::PARAM_STR);
$izraz -> bindParam(':mjesto', $mjesto, PDO::PARAM_STR);
$izraz -> bindParam(':telefon', $telefon, PDO::PARAM_STR);
$izraz -> bindParam(':mobitel', $_POST['mobitel'], PDO::PARAM_STR);
$izraz -> bindParam(':email', $_POST['email'], PDO::PARAM_STR);
//$izraz -> bindParam(':slika', $_POST['slika'], PDO::PARAM_STR);
$izraz -> execute();



$izraz = $veza -> prepare("update operater set korisnickoime=:korisnickoime,uloga=:uloga,aktivan=:aktivan where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifraOperatera'], PDO::PARAM_STR);
$izraz -> bindParam(':korisnickoime', $_POST['korisnickoime'], PDO::PARAM_STR);
$izraz -> bindParam(':uloga', $_POST['uloga'], PDO::PARAM_STR);

if (!(isset($_POST["aktivan"]))){
	
	$aktivan = 0;

}else if($_POST["aktivan"]=="on"){
	$aktivan = 1;
}

$izraz -> bindParam(':aktivan', $aktivan, PDO::PARAM_STR);
$izraz -> execute();


$izraz = $veza -> prepare("update klijent set datumpromjene=now() where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
$izraz -> execute();



}

echo "OK";

$veza->commit();


