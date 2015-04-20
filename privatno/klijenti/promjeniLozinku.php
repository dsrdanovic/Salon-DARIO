<?php

include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

$izraz = $veza -> prepare("update operater set lozinka=md5(:lozinka) where sifra=:sifra");

	$lozinka=$_POST['lozinka'];
	$sifra=$_POST['sifra'];
	
	$izraz -> bindParam(':lozinka', $lozinka);
	$izraz -> bindParam(':sifra', $sifra);
	$izraz -> execute();

echo "OK";
