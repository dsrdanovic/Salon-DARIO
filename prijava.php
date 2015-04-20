<?php
include_once 'konfiguracija.php';
?>

<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once 'head.php';
		?>
		<link rel="stylesheet" href="strength/styled/strength.css" />
	</head>
	<body spellcheck="false">

		<?php
		include_once 'zaglavlje.php';
		?>

	
		<div class="row">
			
				<div class="large-4 columns">
				<h4><i class="fi-torso"></i> Prijava</h4>
				<hr />
				<form id="myform" action="prijavi.php" method="post" accept-charset="utf-8">

					<input id="korisnickoime" type="text" name="korisnickoime" placeholder="Korisničko ime">
					<small id="ki" class="error"></small>

					<input id="lozinka" type="password" name="lozinka" placeholder="Lozinka">
					<small id="l" class="error"></small>

					<input id="prijavitese" type="submit" class="round button prijavisebutton" value="Prijavite se"/>
					
					<h6>Zaboravili ste korisničko ime?</h6>
					<h6>Zaboravili ste lozinku?</h6>

				</form>
			</div>
			
	
				<div class="large-4 columns end">
					<div class="panel registrirajse">
						<h4><i class="fi-alert"></i> Nemate korisnički račun?</h4>
					<a href="registracija.php" class="button round registrirajsebutton">Registrirajte se</a>
					</div>
				
			</div>
		

		</div>


		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
	
		
		


		<?php
		include_once 'podnozje.php';
		?>

		<?php
		include_once 'skripte.php';
		?>

		<?php
		include_once 'JQueryPrijava.php';
		?>
		
	</body>
</html>
