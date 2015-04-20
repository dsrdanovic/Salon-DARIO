<?php
include_once '../../konfiguracija.php';
?>
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once '../../head.php';
		?>
	</head>
	<body spellcheck="false">

		<?php
		include_once '../../zaglavlje.php';
		?>

		<div class="row">
			<div class="large-12 columns">
				<h4><i class="fi-braille"></i> Nova pasmina</h4>
				<hr />
			</div>
		</div>

		<div class="row">
			<div class="large-4 columns">

				<form id="myform" action="" method="post" enctype="multipart/form-data" >

					<label for="naziv">Naziv</label>
					<input type="text" name="naziv" id="naziv">

					<label for="datoteka">Odaberi sliku</label>
					<input type="file" name="file" id="file" />

					<ul class="button-group round">
						<li>
							<a href="index.php" class="round button alert tipkanazad"><i class="fi-arrow-left"></i> Nazad</a>
						</li>
						<li>
							<a href="#" id="dodajPasminu" class="round button success tipkaspremi"><i class="fi-save"></i> Spremi</a>
												
						</li>
					</ul>

					<div data-alert class="alert-box success radius alertPasminaDodana" style="display: none;">
						Pasmina uspješno dodana.
						<a href="#" class="close"></a>
					</div>

			</div>
			<div class="large-4 columns end">
				<div id="image_preview"><img id="previewing" src="<?php echo $putanjaApp; ?>img/pasmine/nemaSlike.png" alt="your image" />
				</div>

			</div>
			</form>
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
			$(document).ready(function(e) {
				
				$('#file').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
				
				
				$(window).keypress(function() {
				$('#naziv').tooltipster('hide');
				$('#file').tooltipster('hide');
					
				});

				$(window).click(function() {
				$('#naziv').tooltipster('hide');
				$('#file').tooltipster('hide');
				});
				
					
				
				$("#file").on("change", function() {
					var reader = new FileReader();
							reader.onload = imageIsLoaded;
							reader.readAsDataURL(this.files[0]);
					
					function imageIsLoaded(e) {
				//	$("#file").css("color", "green");
					$('#image_preview').css("display", "block");
					$('#previewing').attr('src', e.target.result);
					$('#previewing').attr('width', '300px');
					$('#previewing').attr('height', 'auto');
				};
					});
			
				
				
				$("#dodajPasminu").click(function(e) {
					e.preventDefault();
					
					var i = $("#file").val();
				//	alert(i);
					if(i != ""){
					
									//	$(function() {
				
			//		$("#file").on("change", function() {
					//	$("#message").empty();
						// To remove the previous error message
				
						var x = document.getElementById("file");
						var file = x.files[0];
						var size = x.files[0].size;
						var imagefile = file.type;			
						var match = ["image/jpeg", "image/png", "image/jpg",""];
								
						if (!((imagefile == match[0]) || (imagefile == match[1]) || (imagefile == match[2])) || size > 1000000) {
						
							$('#previewing').attr('src', '../../img/pasmine/nemaSlike.png');
						//	$("#message").html("<p id='error'>Please Select A valid Image File</p>" + "<h4>Note</h4>" + "<span id='error_message'>Only jpeg, jpg and png Images type allowed</span>");
						//	alert("nevalja");
						//	alert(this.files[0].size);
					//	alert("ispred tooltipa");
						$('#file').tooltipster('content', 'Krivi format ili veličina slike. Dopušteni formati: jpg,jpeg i png do 1MB.');
						$('#file').tooltipster('show');
								
							return false;
						}
						
						
						//else {
							//var reader = new FileReader();
						//	reader.onload = imageIsLoaded;
						//	reader.readAsDataURL(this.files[0]);
					//	}
					//});
			//	});
					}
					
					
			
			
					
					$('#naziv').tooltipster({
					position : 'left',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

					});
					
			
					
				//PROVJERA NAZIVA

					var naziv = $('#naziv').val();
					var naziv_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;
					var alertBox = $('.alertPasminaDodana');
					
					
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
					
						
				//	$("#message").empty();
				//	$('#loading').show();
				
				var formElement = document.getElementById("myform");
				var formData = new FormData(formElement);
					$.ajax({
						url : "dodajPasminu.php", // Url to which the request is send
						type : "POST", // Type of request to be send, called as method
						data : formData, // Data sent to server, a set of key/value pairs (i.e. form fields and values)
						contentType : false, // The content type used when sending data to the server.
						cache : false, // To unable request pages to be cached
						processData : false, // To send DOMDocument or non processed data file it is set to false
						success : function(data)// A function to be called if request succeeds
						{
						//	$('#loading').hide();
						//	$("#message").html(data);
						
							if (data == "KRIVI FORMAT ILI VELICINA") {
								//alert("KRIVI FORMAT ILI VELICINA");
								$('#file').tooltipster('content', 'Krivi format ili veličina slike. Dopušteni formati: jpg,jpeg i png do 1MB.');
								$('#file').tooltipster('show');
								return false;
							}
						
							if (data == "SLIKA POSTOJI S TIM NAZIVOM") {
								$('#file').tooltipster('content', 'Slika s tim nazivom već postoji u bazi.');
								$('#file').tooltipster('show');
								return false;
							}					
						
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