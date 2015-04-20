<?php

include_once '../../konfiguracija.php';

if ($_POST) {

	$veza->beginTransaction();
	
	//INSERT NARUDŽBA

	$izraz = $veza -> prepare("insert into narudzba(zaposlenik,klijent,pas,datumnarudzbe,termin,dan,status,napomena,datumunosa,datumpromjene,operater) 
	values (:zaposlenik,:klijent,:pas,:datumnarudzbe,:termin,:dan,:status,:napomena,now(),now(),:operater)");
	 
	$d = $_POST["datumnarudzbe"];
	$datumNarudzbe = substr($d, 6,4) . "-" . substr($d, 3,2) . "-" . substr($d, 0,2);
	
	$sifraOperatera = $_SESSION[$ida . "operater"]->sifra;
		
	$izraz -> bindParam(':zaposlenik', $_POST["sifraZaposlenika"], PDO::PARAM_INT);
	$izraz -> bindParam(':klijent', $_POST['sifraKlijenta'], PDO::PARAM_INT);
	$izraz -> bindParam(':pas', $_POST['pas'], PDO::PARAM_INT);
	$izraz -> bindParam(':datumnarudzbe', $datumNarudzbe, PDO::PARAM_STR);
	$izraz -> bindParam(':termin', $_POST['termin'], PDO::PARAM_STR);
	$izraz -> bindParam(':dan', $_POST['dan'], PDO::PARAM_STR);
	$izraz -> bindValue(':status', FALSE, PDO::PARAM_INT);
	$izraz -> bindParam(':napomena', $_POST['napomena'], PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $sifraOperatera, PDO::PARAM_INT);
	
	$izraz -> execute();

	$sifraNarudzbe = $veza->lastInsertId('sifra');

	$izraz = $veza -> prepare("insert into narudzba_usluga(narudzba,usluga)	values (:narudzba,:usluga)");

	$izraz -> bindValue(':narudzba', $sifraNarudzbe, PDO::PARAM_INT);
	$izraz -> bindParam(':usluga', $_POST["usluga"], PDO::PARAM_INT);
	
	$izraz -> execute();
	
	$selektirano = $_POST["usluga"];
	
	for ($i=0; $i < sizeof($selektirano) ; $i++) { 
		
	$izraz = $veza -> prepare("insert into narudzba_usluga(narudzba,usluga)	values (:narudzba,:usluga)");

	$izraz -> bindParam(':narudzba', $sifraNarudzbe, PDO::PARAM_INT);
	$izraz -> bindParam(':usluga', $selektirano[$i], PDO::PARAM_INT);
	
	$izraz -> execute();
	
	} 
	
	$veza->commit();
	
	echo "OK";
}






