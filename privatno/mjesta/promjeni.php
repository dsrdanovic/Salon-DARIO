<?php
include_once '../../konfiguracija.php';

if (!((isset($_GET["sifra"]) && ctype_digit($_GET["sifra"])) || isset($_POST["sifra"]))) {
	header("location: ../../odjavi.php");
}else{
	if(isset($_GET["sifra"])){
		$sifra=$_GET["sifra"];
	}else{
		$sifra=$_POST["sifra"];
	}
}

$izraz = $veza -> prepare("select * from mjesto where sifra=:sifra");
$izraz->bindParam("sifra",$sifra);
$izraz -> execute();
$mjesto = $izraz -> fetch(PDO::FETCH_OBJ);

?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php include_once '../../head.php';?>
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>strength/styled/strength.css" />
		<link rel="stylesheet" href="<?php echo $putanjaApp; ?>tooltipster/css/tooltipster.css"/>
	</head>
	<body spellcheck="false">

		<?php include_once '../../zaglavlje.php';?>
		
		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-target"></i> Mjesto: <?php echo $mjesto -> naselje?></h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form id="myform" action="promjeniMjesto.php" method="post" accept-charset="utf-8" >

					
					<label for="naselje">Naselje</label>
					<input id="naselje" type="text" name="naselje" value="<?php echo $mjesto->naselje;?>">

					<label for="postanskibroj">Poštanski broj</label>
					<input id="postanskibroj" type="text" name="postanskibroj" value="<?php echo $mjesto->postanskibroj;?>">

					<label for="opcina">Općina</label>
					<input id="opcina" type="text" name="opcina" value="<?php echo $mjesto->opcina;?>">

					<label for="zupanija">Županija</label>
					<input id="zupanija" type="text" name="zupanija" value="<?php echo $mjesto->zupanija;?>">
					
					<input type="hidden" name="sifra" value="<?php echo $mjesto->sifra;?>" />
									
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($mjesto -> datumunosa);
											?>
												<input id="datumunosa" name="datumunosa" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum promjene</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($mjesto -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
						
													<ul class="button-group round">
					<li><a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a></li>
					<li><a href="#" id="promjeniMjesto" type="submit" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a></li>
					</ul>
					
					<div data-alert class="alert-box success radius alertMjestoPromjenjeno" style="display: none;">
  									Podaci uspješno promjenjeni.
 									 <a href="#" class="close"></a>
									</div>
					
					</form>				
					
					</div>
					
		</div>		
					

		<?php
	include_once '../../podnozje.php';
		?>

		<?php
	include_once '../../skripte.php';
		?>
		
		<script src="<?php echo $putanjaApp; ?>tooltipster/js/jquery.tooltipster.min.js"></script>
		<script>
			
			
		$(document).ready(function($) {
			
		$(window).keypress(function() {
					$('#oib').tooltipster('hide');
					$('#ime').tooltipster('hide');
					$('#prezime').tooltipster('hide');
					$('#mobitel').tooltipster('hide');
					$('#email').tooltipster('hide');
					$('#korisnickoime').tooltipster('hide');
					$('#lozinka').tooltipster('hide');
					$('#lozinkaponovo').tooltipster('hide');
				});
				
		$(window).click(function() {
	
		$('.alert-box').fadeOut();
				
		});
	
		$('#oib').tooltipster({
					position : 'left',
					hideOnClick: 'true',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
		$('#promjeniMjesto').click(function(event) {
			
			event.preventDefault();
			
			
			
		var sifra = <?php echo $sifra; ?>	
		// označavanje forme kojom pristupam
		var forma = $("#myform");
		// kupljenje podataka iz forme
		var podaci = forma.serialize();
		// adresa di je stranica za dodavanje osobe
		var url = forma.attr('action');
		// alert box za moj profil
		var alertBox = $('.alertMjestoPromjenjeno');
				
				$.ajax({
			type : "POST",
			url : url,
			data : podaci+"&sifra="+sifra,
			cache : false,
			success : function(data) {
	
			if (data == "OK") {
					
			setTimeout(function(){
      			$(alertBox).fadeIn(500);
    				}, 1000);		
			
		
					}

				}
			});
			
			
		});
				
					
 
								
			});
			
		</script>
		
		
		
	</body>
</html>