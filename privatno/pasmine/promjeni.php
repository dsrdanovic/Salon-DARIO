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

$izraz = $veza -> prepare("select * from pasmina where sifra=:sifra");
$izraz->bindParam("sifra",$sifra);
$izraz -> execute();
$pasmina = $izraz -> fetch(PDO::FETCH_OBJ);

?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php include_once '../../head.php';?>

	</head>
	<body>

		<?php include_once '../../zaglavlje.php';?>
		
		<div class="row">
			<div class="large-12 columns">
				<h4>Pasmina: <?php echo $pasmina -> naziv; ?></h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">
				
			
			<form enctype="multipart/form-data" id="myform" action="promjeniPasminu.php" method="post">

					<label for="naziv">Naziv</label>
					<input type="text" name="naziv" id="naziv" value="<?php echo $pasmina->naziv;?>">

					<label for="datoteka">Odaberi sliku</label>
					<input type="file" name="imgFile" id="imgFile" />

					
					
					<input type="hidden" name="sifra" value="<?php echo $pasmina->sifra;?>" />
	
									
					<div class="row collapse prefix-radius">
											<div class="large-5 columns">
												<span class="prefix">Datum unosa</span>
											</div>
											<div class="large-7 columns">
											<?php
											$date = date_create($pasmina -> datumunosa);
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
											$date = date_create($pasmina -> datumpromjene);
											?>
												<input id="datumpromjene" name="datumpromjene" type="text" disabled="disabled" value="<?php echo date_format($date, 'd.m.Y. H:i:s'); ?>">
											</div>
										</div>
					
						
							<input type="hidden" name="sifra" id="sifra" value="<?php echo $pasmina->sifra; ?>" />
					
							
							<ul class="button-group round">
						<li>
							<a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a>
						</li>
						<li>
							<a href="#" id="promjeniPasminu" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a>
												
						</li>
					</ul>
					
					
					<div data-alert class="alert-box success radius alertPasminaPromjenjena" style="display: none;">
  									Podaci uspješno promjenjeni.
 									 <a href="#" class="close"></a>
									</div>
					
					</form>				
					
					</div>
						
					<div class="large-4 columns end">
				<img id="preview" src="<?php echo $putanjaApp; ?>img/pasmine/<?php echo $pasmina -> slika; ?>" alt="your image" />
			</div>
					
					</div>
					
	<br />
			<br />
			<br />
			<br />
			<br />
			<br />
		<?php
	include_once '../../podnozje.php';
		?>

		<?php
	include_once '../../skripte.php';
		?>
		
	
		<script>
			
			
		$(document).ready(function($) {
				
					$(window).keypress(function() {
					$('#naziv').tooltipster('hide');
					
				});

				$(window).click(function() {
					$('#naziv').tooltipster('hide');

				});

				function readURL(input) {

					if (input.files && input.files[0]) {
						var reader = new FileReader();

						reader.onload = function(e) {
							$('#preview').attr('src', e.target.result);
						}

						reader.readAsDataURL(input.files[0]);
					} 
				}


				$("#imgFile").change(function() {
					readURL(this);
				});
							
				$('#naziv').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
				
				
				$('#promjeniPasminu').click(function(event) {
					
					event.preventDefault();
				
					
					//PROVJERA NAZIVA

					var naziv = $('#naziv').val();
					var naziv_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;
					var alertBox = $('.alertPasminaPromjenjena');
					
					
					if (naziv.length == 0) {

						$('#naziv').tooltipster('content', 'Ovo polje je obavezno.');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}
					
					if (!naziv.match(naziv_regex)) {

						$('#naziv').tooltipster('content', 'Dozvoljena samo slova i razmak. 2-50');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}
										
					
				var formElement = document.getElementById("myform");
				var formData = new FormData(formElement);
					
					$.ajax({
						type : "POST",
						url : "promjeniPasminu.php",
						data : formData,
						cache : false,
						success : function(data) {

							if (data == "OK") {
								
								setTimeout(function() {
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