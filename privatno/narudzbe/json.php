<?php

include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"])) {
	header("location: ../../odjavi.php");
}

$sk=$_GET["sifraKlijenta"];

if($sk==0){
	
	echo "FALSE";
	return;
}


$izraz = $veza -> prepare("select b.oib,b.ime,b.prezime,b.adresa,b.telefon,b.mobitel,b.email,c.naselje as mjesto
from klijent a inner join osoba b on a.osoba=b.sifra inner join mjesto c on b.mjesto=c.sifra where a.sifra=:sifraKlijenta");

$izraz -> bindParam(":sifraKlijenta", $sk);
$izraz -> execute();
$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

if($osoba==null){

$izraz = $veza -> prepare("select b.oib,b.ime,b.prezime,b.adresa,b.telefon,b.mobitel,b.email from klijent
a inner join osoba b on a.osoba=b.sifra where a.sifra=:sifraKlijenta");
$izraz -> bindParam(":sifraKlijenta", $sk);
$izraz -> execute();
$osoba = $izraz -> fetch(PDO::FETCH_OBJ);
	
}




$izraz = $veza -> prepare("select a.sifra,a.ime,b.naziv as pasmina 
from pas a inner join pasmina b on a.pasmina=b.sifra where klijent=:sifraKlijenta");
					
$izraz -> bindParam(":sifraKlijenta", $sk);
$izraz -> execute();
$pas = $izraz -> fetchAll(PDO::FETCH_OBJ);

$osoba->pas=$pas;

$niz=array();

array_push($niz,$osoba);
//array_push($niz,$pas);

echo json_encode($niz);