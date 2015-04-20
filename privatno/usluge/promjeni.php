<?php
include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("select * from usluga where sifra=:sifra");
$izraz -> bindParam(':sifra', $_GET["sifra"], PDO::PARAM_STR);
$izraz -> execute();
$usluga = $izraz -> fetch(PDO::FETCH_OBJ);


?>

		
		<label for="naziv">Naziv</label>
		<input id="naziv" type="text" name="naziv" value="<?php echo $usluga->naziv; ?>" style="width:302px;">
		<input type="hidden" name="sifra" value="<?php echo $usluga->sifra; ?>" />
		
		
	

		
		
