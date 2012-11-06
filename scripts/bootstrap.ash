/*

Bootstrap - handle all the stuff to do on initial ascension. large cribs from bcasc

*/

void bootstrap() {

	// Get clockwork maid, facsimile dictionary, and use 'em.
	// hit up noob cave, use all the stuff

	take_storage(1, $item["clockwork maid"]);
	use(1, $item["clockwork maid"]);

	take_storage(1, $item["facsimile dictionary"]);
	autosell(1, $item["facsimile dictionary"]);

    visit_url("tutorial.php?action=toot");
    if (item_amount($item["letter from King Ralph XI"]) > 0) use(1, $item[letter from King Ralph XI]);
	
	if (item_amount($item["pork elf goodies sack"]) > 0) use(1, $item[pork elf goodies sack]);

	if (item_amount($item[Newbiesport tent]) > 0) use(1, $item[Newbiesport tent]);
	if (item_amount($item["carton of astral energy drinks"]) > 0) use(1, $item[carton of astral energy drinks]);
	create(1, $item[bitchin meatcar]);
	buy(1, $item[detuned radio]);

}
