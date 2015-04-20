<?php

include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("update operater set lozinka=md5(:novaLozinka) where sifra=:sifraOperatera");

	$novaLozinka=$_POST['novaLozinka'];
	$sifraOperatera=$_POST['sifraOperatera'];
	
	$izraz -> bindParam(':novaLozinka', $novaLozinka);
	$izraz -> bindParam(':sifraOperatera', $sifraOperatera);
	$izraz -> execute();

echo "OK";
