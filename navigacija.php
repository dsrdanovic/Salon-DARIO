<ul class="right navigacija">

	<li class="rotate <?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'index.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>index.php">Početna</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'cjenik.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>cjenik.php">Cjenik</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'galerija.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>galerija.php">Galerija</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'psi.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>psi.php">Psi</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'onama.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>onama.php">O nama</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'kontakt.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>kontakt.php">Kontakt</a>
	</li>

	<li class="divider"></li>

	<li class="<?php
	if (basename($_SERVER['SCRIPT_NAME']) == 'gdjesmo.php') {echo 'active';
	} else { echo '';
	}
	?>">
		<a href="<?php echo $putanjaApp; ?>gdjesmo.php">Gdje smo</a>
	</li>
</ul>