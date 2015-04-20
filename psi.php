<?php
include_once 'konfiguracija.php';
?>

<!doctype html>
<html class="no-js" lang="en">
	<head>
		<?php
		include_once 'head.php';
		?>
	</head>
	<body>

		<?php
		include_once 'zaglavlje.php';
		?>
		<?php
		include_once 'navigacija.php';
		?>

		<div class="row">
			<div class="large-12 columns">

				<ul class="pagination">

					<li class="<?php
					if (basename($_SERVER['SCRIPT_NAME']) == 'psi.php') {echo 'current';
					} else { echo '';
					}
					?>">
						<a href="#A">A</a>
					</li>
					<li class="<?php
					if (basename($_SERVER['SCRIPT_NAME']) == 'psi.php#B') {echo 'current';
					} else { echo '';
					}
					?>">
						<a href="#B">B</a>
					</li>
					<li class="">
						<a href="">C</a>
					</li>
					<li class="">
						<a href="">D</a>
					</li>
					<li class="">
						<a href="">E</a>
					</li>
					<li class="">
						<a href="">F</a>
					</li>
					<li class="">
						<a href="">G</a>
					</li>
				</ul>

				<h1>A</h1>
				<ul class="accordion" data-accordion="">

					<li class="accordion-navigation">
						<a href="#panel1a">Američki koker španijel</a>
						<div id="panel1a" class="content">
							<ul class="small-block-grid-2 large-block-grid-3 ">
								<div class="large-7 columns">
									<div class="panel">
										<h4>Američki koker španijel</h4>
										<hr />
										<p>
											Američki Koker španijel je španijel manje veličine, s prekrasnom naravi i neograničenom energijom. To su sjajni psi za obitelj, ali i za samce.
										</p>
										<hr />
										<p>
											Jako vole biti u blizini ljudi, iako mogu provesti umjerenu količinu vremena sami ukoliko se njima i njihovoj vježbi posvećuje dovoljno vremena kad je obitelj doma.
										</p>
										<h5>Izgled</h5>
										<p>
											Koker španijel ima prekrasnu, svilenkastu srednje dugu dlaku koju je relativno jednostavno održavati, čak iako je pas uglavnom vani. Glava koker španijela je poput kupole između obješenih ušiju prekrivenih bujnim krznom. Oči su okrugle, okrenute prema središtu njuške, tamne su i izgledaju vrlo nježno, istovremeno pokazujući tračak veselja i zanimanja za okolinu.
										</p>
										<br />
										<p>
											Njuška ima nagli prijelaz u ravnini očiju, a oblik joj je dosta širok i četvrtast u odnosu na nos. Nos je velik i primjetan, crne boje na psima s tamnom dlakom, a više smeđe na psima sa svijetlom dlakom. Vrat je kratak i uspravno položen u odnosu na mišićava i vrlo razvijena ramena. Noge su obično kratke i prekrivene gustom i bujnom dlakom, dajući dojam da su ti psi teži no što zapravo jesu.
										</p>
										<br />
										<p>
											Gornja linija koker španijelovog trupa ima blagi nagib od ramena do kukova, stoga u stojećem položaju izgledaju „spremno". Iznenađujuće je atletski građen obzirom na svoju malu veličinu.</h6><h5>Njega i okruženje</h5><h6>Koker španijelu potrebno je redovito uređivanje (trimanje i održavanje). Čak i ako mu ostavite dugu dlaku, treba ga redovito njegovati. Svakodnevno češljanje i često šamponiranje je dovoljno. Ne linja se pretjerano.  Najmanje dva puta mjesečno treba mu čistiti uši, kako ne bi došlo do infekcije.
										</p>
										<br />
										<p>
											Što se tiče okruženja za život, Koker španijel je prilagodljiv i zadovoljan u bilo kakvom prostoru. No, malo dvorište bi mu dobro došlo jer treba redovito vježbati i istrčati se, kako bi se izbjegli problemi s težinom ili emocionalni stres.</h6>
											<br />
											<h5>Karakter</h5>
										<p>
											Koker španijel je tradicionalno bio lovački pas, ali i kućni ljubimac. Brzo se prilagodi na bilo što što se od njega traži. Prirodno je nježan, umiljat, osjećajan i poštuje autoritet. Vrlo je inteligentan, veseo i pas od povjerenja. Obično se dobro slaže s djecom.  Uravnoteženog je temperamenta, osim što je ponekad tvrdoglav, pa to može malo otežati dresuru. S njim treba puno strpljenja i upornosti, a imajte na umu da je vrlo osjetljiv na vaše emocije, stoga se nemojte uzrujavati, nego samo smireno i polako.
										</p>
									</div>
								</div>
								<div class="large-5 columns">
									<div class="panel">
										<img src="img/psi/americki_koker_spanijel.jpg" />
									</div>
								</div>
							</ul>
						</div>
					</li>
				</ul>
				<h1 id="B" >B</h1>
				<ul class="accordion" data-accordion="">

					<li class="accordion-navigation">
						<a href="#panel2a">Belgijski ovčar - Malinois</a>
						<div id="panel2a" class="content">
							<ul class="small-block-grid-2 large-block-grid-3 ">
								<li><img src="http://placehold.it/350x150">
								</li>
								<li><img src="http://placehold.it/350x150">
								</li>
								<li><img src="http://placehold.it/350x150">
								</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<?php
		include_once 'podnozje.php';
		?>
		
		<?php
		include_once 'skripte.php';
		?>
		
	</body>
