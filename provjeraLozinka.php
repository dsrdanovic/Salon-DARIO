<?php

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("select * from operater where lozinka=:lozinka and sifra=:sifra");

$l=$_POST['lozinka'];
$s=$_POST['sifra'];
	$izraz -> bindParam(':lozinka', $l);
	$izraz -> bindParam(':sifra', $s);
	$izraz -> execute();
	$operater = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($operater==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
