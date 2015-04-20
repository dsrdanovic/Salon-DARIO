<?php

include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

if ($_POST) {
	
	$veza->beginTransaction();

	//INSERT OSOBA
	
	if($_POST["mjesto"]==0){
		$mjesto = null;
	}

	$izraz = $veza -> prepare("insert into osoba (oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika) values (:oib,:ime,:prezime,:adresa,:mjesto,:telefon,:mobitel,:email,null)");
	$izraz -> bindParam(':oib', $_POST['oib'], PDO::PARAM_STR);
	$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
	$izraz -> bindParam(':prezime', $_POST['prezime'], PDO::PARAM_STR);
	$izraz -> bindParam(':adresa', $_POST['adresa'], PDO::PARAM_STR);
	$izraz -> bindParam(':mjesto', $mjesto, PDO::PARAM_STR);
	$izraz -> bindParam(':telefon', $_POST['telefon'], PDO::PARAM_STR);
	$izraz -> bindParam(':mobitel', $_POST['mobitel'], PDO::PARAM_STR);
	$izraz -> bindParam(':email', $_POST['email'], PDO::PARAM_STR);
	//$izraz -> bindParam(':slika', $_POST['slika'], PDO::PARAM_STR);
	$izraz -> execute();

	$sifraOsobe = $veza->lastInsertId('sifra');
	
	//INSERT OPERATER

	$izraz = $veza -> prepare("insert into operater(korisnickoime,lozinka,uloga,aktivan) values (:korisnickoime,MD5(:lozinka),'administrator',true)");
	$izraz -> bindParam(':korisnickoime', $_POST['korisnickoime'], PDO::PARAM_STR);
	$izraz -> bindParam(':lozinka', $_POST['lozinka'], PDO::PARAM_STR);
	$izraz -> execute();
	
	$sifraOperatera = $veza->lastInsertId('sifra');
	
	//INSERT ZAPOSLENIK
	
	$izraz = $veza -> prepare("insert into zaposlenik (osoba,nadredeni,radnomjesto,datumunosa,datumpromjene,operater) values (:osoba,1,'Radnik',now(),now(),:operater)");
	$izraz -> bindParam(':osoba', $sifraOsobe, PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $sifraOperatera, PDO::PARAM_STR);
	$izraz -> execute();
	
	

}

echo "OK";

$veza->commit();
