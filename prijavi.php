<?php

if (!isset($_POST) || !isset($_POST["korisnickoime"]) || !isset($_POST["lozinka"])) {
	exit ;
}

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("select * from operater where korisnickoime=:korisnickoime and lozinka=:lozinka");
$korisnickoime = $_POST["korisnickoime"];
$izraz -> bindParam(":korisnickoime", $korisnickoime);
$lozinka = md5($_POST["lozinka"]);
$izraz -> bindParam(":lozinka", $lozinka);
$izraz -> execute();
$operater = $izraz -> fetch(PDO::FETCH_OBJ);


if ($operater != null) {

	$_SESSION[$ida . "operater"] = $operater;
	if ($_SESSION[$ida . "operater"]->uloga == "administrator") {
		header("location: privatno/administracija.php");
	} else {
		if ($_SESSION[$ida . "operater"]->uloga == "korisnik") {
			header("location: mojeNarudzbe.php");
		}
	}

}
?>

<?php include_once 'konfiguracija.php'
?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php include_once 'head.php'
		?>
	</head>
	<body>

		<?php include_once 'zaglavlje.php'
		?>

		<div class="row">
			<div class="large-4 columns">
				<br />
				<h4>Greška</h4>
				<hr />
				Netočno korisničko ime ili lozinka
			</div>
		</div>

		<?php include_once 'podnozje.php'
		?>

		<?php include_once 'skripte.php'
		?>

		<?php include_once 'JQueryPrijava.php'
		?>

	</body>
</html>