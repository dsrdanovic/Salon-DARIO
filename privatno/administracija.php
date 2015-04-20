<?php

include_once '../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"] -> uloga != "administrator") {
	header("location: ../index.php");
}
 ?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once '../head.php';
		?>
	</head>
	<body>

		<?php
		include_once '../zaglavlje.php';
		?>

		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-monitor"></i> Admin panel</h4>
				<hr />
				<div class="icon-bar four-up">
					<a href="<?php echo $putanjaApp; ?>privatno/zaposlenici/index.php" class="item"><i class="fi-torsos-all"></i><label>Zaposlenici</label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/klijenti/index.php" class="item"><i class="fi-torso-business"></i><label>Klijenti</label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/psi/index.php" class="item"><i class="fi-guide-dog"></i><label>Psi</label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/pasmine/index.php" class="item"><i class="fi-braille"></i><label>Pasmine</label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/mjesta/index.php" class="item"><i class="fi-target"></i><label>Mjesta</label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/usluge/index.php" class="item"><i class="fi-price-tag"></i><label>Usluge</label></a>
					<?php 
					
					$izraz = $veza -> prepare("select count(status) as ukupno from narudzba where status=false");
					$izraz -> execute();
					$ukupno = $izraz -> fetchColumn();
					
					?>
					<a href="<?php echo $putanjaApp; ?>privatno/narudzbe/index.php" class="item"><i class="fi-shopping-cart"></i><label>Narudžbe <?php echo "(".$ukupno.")" ?></label></a>
					<a href="<?php echo $putanjaApp; ?>privatno/statistike/index.php" class="item"><i class="fi-graph-bar"></i><label>Statistike</label></a>
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
		<br />
		<br />
		<br />
		<?php
		include_once '../podnozje.php';
		?>

		<?php
		include_once '../skripte.php';
		?>
	</body>

</html>
