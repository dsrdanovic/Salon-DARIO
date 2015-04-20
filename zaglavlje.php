<div class="panel gornjatraka"></div>

<div class="row">
	<div class="large-12 columns">
		<div class="panel gornjatraka1">
			<ul class="right prijava_registracija">

				<!-- ################################################################################################# -->

				<?php if(isset($_SESSION[$ida . "operater"]) && $_SESSION[$ida . "operater"]->uloga=="administrator"){
				?>

				<li>
					<i class="fi-monitor logoadminpanel"></i>
				</li>
				<li>
					<a class="tipkaadminpanel" href="<?php echo $putanjaApp; ?>privatno/administracija.php">ADMIN PANEL</a>
				</li>
				<li class="razmak"></li>
				
				<li>
					<i class="fi-torso logoprijava"></i>
				</li>

				<li>
					<a href="<?php echo $putanjaApp; ?>mojProfil.php" class="tipkaadminpanel">MOJ PROFIL</a>
				</li>

				<li class="razmak"></li>

				<?php } else {

	if(isset($_SESSION[$ida . "operater"]) && $_SESSION[$ida . "operater"]->uloga=="korisnik") {
				?>

				<li>
					<i class="fi-star logoadminpanel"></i>
				</li>
				<li>
					<a class="tipkaadminpanel" href="<?php echo $putanjaApp; ?>mojeNarudzbe.php">MOJE NARUDŽBE</a>
				</li>
				<li class="razmak"></li>

				<li>
					<i class="fi-torso logoprijava"></i>
				</li>

				<li>
					<a href="<?php echo $putanjaApp; ?>mojProfil.php" class="tipkaadminpanel">MOJ PROFIL</a>
				</li>

				<li class="razmak"></li>

				<?php } } ?>

				<!-- ################################################################################################# -->

				<?php if(isset($_SESSION[$ida . "operater"])){
				?>
				<li>
					<i class="fi-power logoprijava"></i>
				</li>
				<li>
					<a class="tipkaodjava" href="<?php echo $putanjaApp; ?>odjavi.php">ODJAVITE SE (<?php echo $_SESSION[$ida . "operater"]->korisnickoime ?>) </a>
				</li>
				<?php }else{ ?>
				<li>
					<i class="fi-torso logoprijava"></i>
				</li>
				<li>
					<a class="tipkaprijava" href="<?php echo $putanjaApp; ?>prijava.php">PRIJAVITE SE</a>
				</li>
				<?php } ?>
				<li class="razmak"></li>
				<li>
					<i class="fi-clipboard-pencil logoregistracija"></i>
				</li>
				<li>
					<a class="tipkaregistracija" href="<?php echo $putanjaApp; ?>registracija.php">REGISTRIRAJTE SE</a>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="panel zaglavlje">
	<div class="row">
		<div class="large-5 columns">
			<img class="logo" src="<?php echo $putanjaApp; ?>img/logo2015.png" alt=""/>
		</div>

		<div class="large-7 columns">
			<?php
			include_once 'navigacija.php';
			?>
		</div>
	</div>
</div>

