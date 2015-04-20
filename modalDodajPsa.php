<div id="modalDodajPsa" class="reveal-modal tiny" style="width: 15%" data-reveal data-animation="fade" data-animationspeed="300" data-closeonbackgroundclick="false" data-closeonesc="false">
	<a class="close-reveal-modal"><i class="fi-x-circle"></i> </a>
	<h4><i class="fi-guide-dog"></i> Novi pas</h4>
	<hr />
	
	
	<form id="myform1" action="dodajPsa.php" method="post" accept-charset="utf-8" >
		
		

					<label for="ime">Ime</label>
					<input id="ime" type="text" name="ime">

					<label for="pasmina">Pasmina</label>
					<select id="pasmina" name="pasmina">
						
						<option id="nemaSlike.png" value = "0"></option>
								
						<?php
						foreach ($pasmina as $p) : ?>

						 <option id="<?php echo $p -> slika; ?>" value="<?php echo $p -> sifra; ?>"><?php echo $p -> naziv; ?></option>

						<?php endforeach; ?>
						
						
					<input type="submit" id="dodajPsa" class="round button tipkaspremi4" value="DODAJ"/>
					
					
					
					</form>
					
		
		
</div>

