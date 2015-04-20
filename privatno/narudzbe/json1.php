<?php

include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"])) {
	header("location: ../../odjavi.php");
}

$sp=$_GET["sifraPsa"];

if($sp==0){
	
	echo "FALSE";
	return;
}


$izraz = $veza -> prepare("select b.naziv
from pas a inner join pasmina b on a.pasmina=b.sifra where a.sifra=:sifraPsa");

$izraz -> bindParam(":sifraPsa", $sp);
$izraz -> execute();
$pas = $izraz -> fetch(PDO::FETCH_OBJ);

$niz=array();


array_push($niz,$pas);

echo json_encode($niz);