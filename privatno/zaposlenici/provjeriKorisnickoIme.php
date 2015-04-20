<?php

include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("select * from operater where korisnickoime=:korisnickoIme and sifra!=:sifraOperatera");

$korisnickoIme=$_POST['korisnickoIme'];
$sifraOperatera=$_POST['sifraOperatera'];


	$izraz -> bindParam(':korisnickoIme', $korisnickoIme, PDO::PARAM_STR);
	$izraz -> bindParam(':sifraOperatera', $sifraOperatera, PDO::PARAM_STR);
	$izraz -> execute();
	$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($osoba==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
