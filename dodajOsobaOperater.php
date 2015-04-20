<?php

include_once 'konfiguracija.php';

//SELECT MJESTO

$izraz = $veza -> prepare("select * from mjesto");
$izraz -> execute();
$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);

if ($_POST) {

	//INSERT OSOBA

	$izraz = $veza -> prepare("insert into osoba(oib,ime,prezime,adresa,mjesto,telefon,mobitel,email,slika) values (:oib,:ime,:prezime,:adresa,:mjesto,:telefon,:mobitel,:email,null)");
	$izraz -> bindParam(':oib', $_POST['oib'], PDO::PARAM_STR);
	$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
	$izraz -> bindParam(':prezime', $_POST['prezime'], PDO::PARAM_STR);
	$izraz -> bindParam(':adresa', $_POST['adresa'], PDO::PARAM_STR);
	$izraz -> bindParam(':mjesto', $_POST['mjesto'], PDO::PARAM_STR);
	$izraz -> bindParam(':telefon', $_POST['telefon'], PDO::PARAM_STR);
	$izraz -> bindParam(':mobitel', $_POST['mobitel'], PDO::PARAM_STR);
	$izraz -> bindParam(':email', $_POST['email'], PDO::PARAM_STR);
	//$izraz -> bindParam(':slika', $_POST['slika'], PDO::PARAM_STR);
	$izraz -> execute();
	
	$sifraOsobe = $veza->lastInsertId('sifra');

	//INSERT OPERATER

	$izraz = $veza -> prepare("insert into operater(korisnickoime,lozinka,uloga,aktivan) values (:korisnickoime,MD5(:lozinka),:uloga,true)");
	$izraz -> bindParam(':korisnickoime', $_POST['korisnickoime'], PDO::PARAM_STR);
	$izraz -> bindParam(':lozinka', $_POST['lozinka'], PDO::PARAM_STR);
	$korisnik = "korisnik";
	$izraz -> bindParam(':uloga', $korisnik, PDO::PARAM_STR);
	$izraz -> execute();
	
	$sifraOperatera = $veza->lastInsertId('sifra');
	
	//INSERT KLIJENT
	
	$izraz = $veza -> prepare("insert into klijent(osoba,datumunosa,datumpromjene,operater) values (:osoba,now(),now(),:operater)");
	$izraz -> bindParam(':osoba', $sifraOsobe, PDO::PARAM_INT);
	$izraz -> bindParam(':operater', $sifraOperatera, PDO::PARAM_INT);

	$izraz -> execute();
}

echo "OK";






?>