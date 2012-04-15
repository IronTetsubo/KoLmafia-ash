// OCD Inventory by Bale
script "OCD Inventory Control.ash";
notify <Bale>;
import "zlib.ash";
check_version("Bale's OCD Inventory Control", "BaleOCD", "3.7.1.2", 1818);

// The following variables should be set from the relay script.
setvar("BaleOCD_MallMulti", "");           // If mall_multi is not empty, then all MALL items will be sent to this multi.
setvar("BaleOCD_UseMallMulti", TRUE);      // If mall_multi is not empty, then all MALL items will be sent to this multi.
setvar("BaleOCD_MultiMessage", "Mall multi dump");
setvar("BaleOCD_DataFile", my_name());     // The name of the file that holds OCD data for this character.
setvar("BaleOCD_StockFile", my_name());    // The name of the file that holds OCD stocking data for this character.
setvar("BaleOCD_Stock", 0);                // Should items be acquired for stock
setvar("BaleOCD_Pricing", "auto");         // How to handle mall pricing. "auto" will use mall_price(). "max" will price at maximum.
setvar("BaleOCD_Sim", FALSE);              // If you set this to true, it won't actually do anything. It'll only inform you.
setvar("BaleOCD_EmptyCloset", 0);          // Should the closet be emptied and its contents disposed of?
setvar("BaleOCD_RemoveOutfit", 0);         // Should the outfit be removed before disposing of inventory?
setvar("BaleOCD_Ascension", -1);           // Leave this alone!
setvar("BaleOCD_MallDangerously", FALSE);  // If this set to TRUE, any uncategorized items will be malled instead of kept! OH NOES!
	// This last one can only be set by editing the vars file. It's too dangerous to make it easily accessible.

// Execute each part separately in case one fails. This will also keep the equip command from acquiring anything
void equip_outfit(string o) {
	// (familiar|equip|unequip)\s+(([^\s;]+)\s?([^;]+)?)(?:;|$)
	matcher com = create_matcher("(familiar|equip|unequip)\\s+(([^\\s;]+)\\s?([^;]+)?)(?:;|$)", o);
	while(find(com)) {
		item it = $item[none];
		switch(com.group(1)) {
		case "familiar":
			if(have_familiar(com.group(2).to_familiar()))
				use_familiar(com.group(2).to_familiar());
			break;
		case "equip":
			it = com.group(4).to_item();
			if(item_amount(it) + equipped_amount(it) < 1)
				it = $item[none];
		case "unequip":
			if(equipped_item(com.group(3).to_slot()) != it)
				equip(com.group(3).to_slot(), it);
			break;
		}
	}
}

// Wrapping the entire script in ocd_control() to reduce variable conflicts if the script is imported to another.
// StopForMissingItems is a parameter in case someone wants to include this script.
// StopForMissingItems = FALSE to prevent a pop-up confirmation.
// DataFile can be used to supplement vars["BaleOCD_DataFile"]. This is completely optional. (See far below)
int ocd_control(boolean StopForMissingItems, string extraData) {
	int FinalSale;

	record OCDinfo {
		string action;	// What to do
		int q;			// How many of them to keep
		string info;	// Extra information (whom to send the gift)
		string message; // Message to send with a gift
	};
	OCDinfo [item] OCD;

	record {
		string type;
		int q;
	} [item] stock;

	int [item] make;
	int [item] untink;
	int [item] usex;
	int [item] pulv;
	int [item] mall;
	int [item] auto;
	int [item] disp;
	int [item] clst;
	int [item] clan;
	int [item] todo;
	int [string][item] gift;
	int [string][item] kbay;

	int [item] make_q;

	string [string] command;
	command ["MAKE"] = "transform ";
	command ["UNTN"] = "untinker ";
	command ["USE"]  = "use ";
	command ["PULV"] = "pulverize ";
	command ["MALL"] = "mallsell ";
	command ["AUTO"] = "autosell ";
	command ["DISP"] = "display ";
	command ["CLST"] = "closet ";
	command ["CLAN"]  = "stash put ";
	command ["GIFT"] = "send gift to ";
	command ["KBAY"] = "kBay ";
	
	boolean use_multi = vars["BaleOCD_MallMulti"] != "" && to_boolean(vars["BaleOCD_UseMallMulti"]);
	if(use_multi)
		command ["MALL"] = "send to mallmulti "+ vars["BaleOCD_MallMulti"] + ": ";

	int [item] price;
	int kBidTot;
	int kBayDuration = 120;  // kBay auction will last 120 hours (5 days)

	boolean load_OCD() {
		clear(OCD);
		if(!file_to_map("OCDdata_"+vars["BaleOCD_DataFile"]+".txt", OCD) && !file_to_map("OCD_"+my_name()+"_Data.txt", OCD))
			return vprint("Something went wrong trying to load OCDdata!", -1);
		OCDinfo [item] extraOCD;
		if(extraData != "" && file_to_map(extraData+".txt", extraOCD) && count(extraOCD) > 0)
			foreach it in extraOCD
				if(!(OCD contains it)) {
					OCD[it].action = extraOCD[it].action;
					OCD[it].q = extraOCD[it].q;
					OCD[it].info = extraOCD[it].info;
					OCD[it].message = extraOCD[it].message;
				}
		if(count(OCD) == 0)
			return vprint("All item information is corrupted or missing. Whoooah! I hope you didn't lose any data...", -1);
		return true;
	}

	boolean is_OCDable(item it) {
		if(is_displayable(it)) return true;
		switch(it) {
		case $item[Boris's key]:
		case $item[Jarlsberg's key]:
		case $item[Richard's star key]:
		case $item[Sneaky Pete's key]:
		case $item[digital key]:
		case $item[the Slug Lord's map]:
		case $item[Dr. Hobo's map]:
		case $item[Dolphin King's map]:
		case $item[Degrassi Knoll shopping list]:
		case $item[31337 scroll]:
			return true;
		}
		return false;
	}

	boolean[item] under_consideration; // prevent infinite recursion
	int count_ingredient(item source, item into) {
		int total = 0;
		foreach key, qty in get_ingredients(into)
			if(key == source) total += qty;
			else {
				#if(key == $item[flat dough]) return 0;
				if(under_consideration contains key) return 0;
				under_consideration[key] = true;
				total += count_ingredient(source, key);
				remove under_consideration[key];
			}
		return total;
	}

	// available_amount varies depending on whether the character can satisfy requests with the closet. This doesn't
	int full_amount(item it) {
		return item_amount(it) + equipped_amount(it) + storage_amount(it) + closet_amount(it);
	}
	
	// Amount to OCD. Consider equipment in terrarium (but not equipped) as OCDable.
	int ocd_amount(item it) {
		if(OCD[it].action == "KEEP") return 0;
		if(item_type(it) != "familiar equipment")
			return item_amount(it) - OCD[it].q;
		int amnt = available_amount(it) - equipped_amount(it)
			- (get_property("autoSatisfyWithCloset") == "true"? closet_amount(it): 0)
			- (get_property("autoSatisfyWithStash") == "true"? stash_amount(it): 0);
		if(amnt > item_amount(it) && amnt > OCD[it].q)
			retrieve_item(amnt - OCD[it].q, it);
		return amnt - OCD[it].q;
	}
	
	boolean AskUser = true;  // Once this has been set false, it will be false for all successive calls to the function
	boolean check_inventory(boolean StopForMissingItems) {
		AskUser = AskUser && StopForMissingItems;
		// Don't stop if "don't ask user" or it is a quest item, or it is being stocked.
		boolean stop_for_relay(item doodad) {
			if(!AskUser || !is_OCDable(doodad) || (stock contains doodad && full_amount(doodad) <= stock[doodad].q))
				return false;
			if(user_confirm("Uncategorized item(s) have been found in inventory.\nAbort to categorize those items with the relay script?"))
				return vprint("Please use the relay script to categorize missing items in inventory.", "red", 1);
			AskUser = false;
			return false;
		}

		int excess;
		foreach doodad in get_inventory() {
			excess = ocd_amount(doodad);
			if(OCD contains doodad) {
				if(excess > 0)
					switch(OCD[doodad].action) {
					case "MAKE":
						make_q[doodad] = count_ingredient(doodad, to_item(ocd[doodad].info));
						if(make_q[doodad] == 0) {
							vprint("You cannot transform a "+doodad+" into a "+ocd[doodad].info+". There's a problem with your data file or your crafting ability.", -3);
							break;
						}
						make[doodad] = excess;
						if(make_q[doodad] != 1) {
							make[doodad] = make[doodad] - (make[doodad] % make_q[doodad]);
							if(make[doodad] == 0) remove make[doodad];
						}
						break;
					case "UNTN":
						untink[doodad] = excess;
						break;
					case "USE":
						if(my_path() == "Bees Hate You" && to_string(doodad).contains_text("b"))
							break;
						usex[doodad] = excess;
						break;
					case "PULV":
						// Some pulverizable items aren't tradeable. If so, wadbot cannot be used
						if(have_skill($skill[Pulverize]) || is_tradeable(doodad))
							pulv[doodad] = excess;
						break;
					case "MALL":
						mall[doodad] = excess;
						break;
					case "AUTO":
						auto[doodad] = excess;
						break;
					case "DISP":
						disp[doodad] = excess;
						break;
					case "CLST":
						clst[doodad] = excess;
						break;
					case "CLAN":
						clan[doodad] = excess;
						break;
					case "GIFT":
						gift[OCD[doodad].info][doodad] = excess;
						break;
					case "KBAY":
						kbay[OCD[doodad].message][doodad] = excess;
						break;
					case "TODO":
						todo[doodad] = excess;
						break;
					case "KEEP":
						break;
					default:
						if(stop_for_relay(doodad))
							return false;
					}
			} else {
				if(stop_for_relay(doodad))
					return false;
				// Potentially disasterous, but this will cause the script to sell off unlisted items, just like it used to. 
				if(vars["BaleOCD_MallDangerously"].to_boolean())
					mall[doodad] = excess;   // Backwards compatibility FTW!
			}
		}
		return true;
	}

	void print_cat(int [item] cat, string act, string to) {
		if(count(cat) < 1) return;
		int len, total, linevalue;
		buffer queue;
		int [item] kBayCount;
		string com = command[act];
		if(act == "GIFT") com = com + to + ": ";
		else if(act == "KBAY") com = com + "\""+ to + "\" ";
		int kBayCount() {
			float tot;
			foreach key,q in kBayCount {
				switch(key) { // These have exception for rarity
				case $item[stuffed Hodgman]:
				case $item[designer handbag]:
				case $item[Jack-in-the-box]:
					return 999999;
				}
				// Items selling for less than 300 meat will require more quantity to make them worthwhile.
				if(to_float(OCD[key].info) < 300)
					tot += (q/4 * max(to_float(OCD[key].info)/300, .2));
				else tot += 1;
			}
			return tot;
		}
		boolean kBayClear() {
			vprint("Waiting for more items to "+com + queue, "gray", 3);
			foreach key in kBayCount
				remove kbay [to][key];
			clear(kBayCount);
			linevalue = 0;
			return true;
		}
		boolean print_line() {
			if(act == "KBAY" && kBayCount() < 4)
				return kBayClear();
			vprint(com + queue, "blue", 3);
			if(act == "KBAY") {
				clear(kBayCount);
				vprint("Minimum bid for this lot: "+rnum(linevalue), "blue", 3);
				kBidTot += linevalue;
			} else if(act == "MALL")
				vprint("Sale price for this line: "+rnum(linevalue), "blue", 3);
			vprint(" ", 3);
			len = 0;
			total += linevalue;
			linevalue = 0;
			set_length(queue, 0);
			return true;
		}

		foreach it, quant in cat {
			if(it == $item[Degrassi Knoll shopping list] && item_amount($item[bitchin' meatcar]) == 0)
				continue;
			if(len != 0)
				queue.append(", ");
			queue.append(quant + " "+ it);
			if(act == "MALL") {
				if(!use_multi) {
					if(historical_age(it) < 1 && historical_price(it) !=0) price[it] = historical_price(it);
						else price[it] = mall_price(it);
					if(vars["BaleOCD_Pricing"] == "auto")
						queue.append(" @ "+ rnum(price[it]));
				}
				linevalue += quant * price[it];
			} else if(act == "MAKE") {
				queue.append(" into "+ OCD[it].info);
			} else if(act == "AUTO") {
				linevalue += quant * autosell_price(it);
			} else if(act == "KBAY") {
				kBayCount[it] = quant;
				queue.append(" @ "+ rnum(to_int(OCD[it].info)));
				linevalue += quant * to_int(OCD[it].info);
			}
			len = len + 1;
			if(len == 11)
				print_line();
		}
		if(len > 0)
			print_line();

		if(act == "MALL") {
			if(!use_multi)
				vprint("Total mall sale = "+rnum(total), "blue", 3);
			#else vprint("Current mall price = "+rnum(total), "blue", 3);
		} else if(act == "AUTO")
			vprint("Total autosale = "+rnum(total), "blue", 3);
		#else if(act == "KBAY" && kBidTot > 0)
		#	vprint("Minimum biding for all auctions = "+rnum(total), "blue", 3);
		FinalSale += total;
	}
	
	item other_clover(item it) {
		if(it == $item[ten-leaf clover]) return $item[disassembled clover];
		return $item[ten-leaf clover];
	}
	
	// This is only called if the player has both kinds of clovers, so no need to check if stock contains both
	int clovers_needed() {
		return stock[$item[ten-leaf clover]].q + stock[$item[disassembled clover]].q
		  - full_amount($item[ten-leaf clover]) - full_amount($item[disassembled clover]);
	}
	
	boolean stock() {
		boolean success = true;
		boolean first = true;
		boolean getit(int q, item it) {
			if(first) first = !vprint("Stocking up on requred items!", "blue", 3);
			boolean autoSatisfyWithCloset = get_property("autoSatisfyWithCloset").to_boolean();
			if(autoSatisfyWithCloset && closet_amount(it) > 0)
				set_property("autoSatisfyWithCloset", "false");
			boolean autoSatisfyWithStorage = get_property("autoSatisfyWithStorage").to_boolean();
			if(autoSatisfyWithStorage && storage_amount(it) > 0)
				set_property("autoSatisfyWithStorage", "false");
			q = q - closet_amount(it) - storage_amount(it) - equipped_amount(it);
			boolean gotit = retrieve_item(q, it);
			if(autoSatisfyWithCloset && !get_property("autoSatisfyWithCloset").to_boolean())
				set_property("autoSatisfyWithCloset", "true");
			if(autoSatisfyWithStorage && !get_property("autoSatisfyWithStorage").to_boolean())
				set_property("autoSatisfyWithStorage", "true");
			return gotit;
		}
		
		load_OCD();
		batch_open();
		foreach it in stock {
			// Someone might want both assembled and disassembled clovers. Esure there are enough of combined tot
			if($items[ten-leaf clover,disassembled clover] contains it && stock contains other_clover(it)
			   && clovers_needed() > 0)
				cli_execute("cheapest ten-leaf clover, disassembled clover; acquire "
				  + to_string(clovers_needed() - available_amount(it)) +" it");
			if(full_amount(it) < stock[it].q && !getit(stock[it].q, it)) {
				success = false;
				print("Failed to stock "+(stock[it].q > 1? stock[it].q + " "+ it.plural: "a "+it), "red");
			}
			// Closet everything (except for gear) that is stocked so it won't get accidentally used.
			if(it.to_slot() == $slot[none] && stock[it].q - ocd[it].q > closet_amount(it) && item_amount(it) > ocd[it].q)
				put_closet(min(item_amount(it) - ocd[it].q, stock[it].q - ocd[it].q - closet_amount(it)), it); 
			// If you got clovers, closet them before they get protected into disassembled clovers.
			//if(it == $item[ten-leaf clover] && to_boolean(get_property("cloverProtectActive")))
			//	put_closet(item_amount(it), it);
		}
		batch_close();
		return success;
	}

	boolean is_wadable(item it) {
		if(it.to_int() > 1437 && it.to_int() < 1450)
			return true;
		switch(it) {
		case $item[sewer nugget]:
		case $item[floaty pebbles]: 
		case $item[floaty gravel]:
			return true;
		}
		return false;
	}

	boolean wadbot(int [item] pulverize) {
		boolean malusOnly = true;
		foreach thing, quant in pulverize
			if(thing.is_wadable()) {
				quant -= quant %5;
				if(quant < 1) remove pulv[thing];
			} else malusOnly = false;
		if(count(pulv) < 1) {
			vprint("Nothing to pulverize after all.", "blue", 3);
			return false;
		}
		if(is_online("wadbot"))
			kmail("wadbot", "", 0, pulv);
		else return vprint("Wadbot is not currently online! Pulverizables will not be sent at this time, just in case.", "olive", -3);
		if(malusOnly)
			return vprint("Asked wadbot to malus some wads.", "blue", 3);
		return vprint("Sent your pulverizables to wadbot.", "blue", 3);
	}

	boolean pulverize() {
		if(count(pulv) < 1) return false;
		if(!have_skill($skill[Pulverize]))
			return wadbot(pulv);
		int len;
		buffer queue;
		int [item] malus;
		foreach it, quant in pulv {
			if(my_primestat() != $stat[muscle] && it.is_wadable()) {
				malus[it] = quant;
			} else {
				if(len != 0)
					queue.append(", ");
				queue.append(quant + " \u00B6"+ it.to_int().to_string());
				len = len + 1;
				if(len == 11) {
					cli_execute(command["PULV"] + queue);
					len = 0;
					set_length(queue, 0);
				}
			}
		}
		if(len > 0)
			cli_execute(command["PULV"] + queue);
		if(count(malus) > 0)
			wadbot(malus);
		return true;
	}

	int sauce_mult(item itm) {
		if(my_class() == $class[sauceror])
			switch(itm) {
			case $item[philter of phorce]:
			case $item[Frogade]:
			case $item[potion of potency]:
			case $item[oil of stability]:
			case $item[ointment of the occult]:
			case $item[salamander slurry]:
			case $item[cordial of concentration]:
			case $item[oil of expertise]:
			case $item[serum of sarcasm]:
			case $item[eyedrops of newt]:
			case $item[eyedrops of the ermine]:
			case $item[oil of slipperiness]:
			case $item[tomato juice of powerful power]:
			case $item[banana smoothie]:
			case $item[perfume of prejudice]:
			case $item[libation of liveliness]:
			case $item[milk of magnesium]:
			case $item[papotion of papower]:
			case $item[oil of oiliness]:
			case $item[cranberry cordial]:
			case $item[concoction of clumsiness]:
			case $item[phial of hotness]:
			case $item[phial of coldness]:
			case $item[phial of stench]:
			case $item[phial of spookiness]:
			case $item[phial of sleaziness]:
			case $item[Ferrigno's Elixir of Power]:
			case $item[potent potion of potency]:
			case $item[plum lozenge]:
			case $item[Hawking's Elixir of Brilliance]:
			case $item[concentrated cordial of concentration]:
			case $item[pear lozenge]:
			case $item[Connery's Elixir of Audacity]:
			case $item[eyedrops of the ocelot]:
			case $item[peach lozenge]:
			case $item[cologne of contempt]:
			case $item[potion of temporary gr8tness]:
			case $item[blackberry polite]:
				return 3;
			}
		return 1;
	}

	boolean create_it(item it, int quant) {
		item obj = to_item(ocd[it].info);
		if(make_q[it] == 0) return false;
		quant = quant / make_q[it] * sauce_mult(it);
		if(quant > 0) return create(quant, obj);
		return false;
	}

	boolean use_it(int quant, item it) {
		boolean use_map(item required) {
			cli_execute("checkpoint");
			if(required == $item[none])
				cli_execute("maximize stench resistance, 1 min");
			else {
				retrieve_item(1, required);
				equip(required);
			}
			boolean success = use(1, it);
			cli_execute("outfit checkpoint");
			return success;
		}
		switch(it) {
		case $item[the Slug Lord's map]:
			return use_map($item[none]);
		case $item[Dr. Hobo's map]:
			item whip = $item[cool whip];
			foreach it in $items[Bar whip, Bat whip, Clown whip, Demon whip, Dishrag, Dreadlock whip, Gnauga hide whip,
			  Hippo whip, Palm-frond whip, Penguin whip, Rattail whip, Scorpion whip, Tail o' nine cats, White whip,
			  Wumpus-hair whip, Yak whip]
				if(item_amount(it) > 0 && can_equip(it)) {
					whip = it;
					break;
				}
			retrieve_item(1, $item[asparagus knife]);
			return use_map(whip);
		case $item[Dolphin King's map]:
			item breather = $item[snorkel];
			foreach it in $items[aerated diving helmet, makeshift SCUBA gear]
				if(item_amount(it) > 0 && can_equip(it)) {
					breather = it;
					break;
				}
			return use_map(breather);
		case $item[Degrassi Knoll shopping list]:
			if(item_amount($item[bitchin' meatcar]) == 0)
				return false;
			break;
		}
		return use(quant, it);
	}

	string message(int [item] cat) {
		foreach key in cat
			return OCD[key].message;
		return "";
	}


	// Break kBay into separate auctions because 100 meat needs to be sent with each.
	boolean kBayStuff(string group, int [item] cat) {
		int [item] goodies;
		int kBid;
		boolean auction() {
			if(count(goodies) == 1)  // If there's only one type of item, make it the title of the auction
				foreach it,q in cat
					group = q > 1? it.plural: to_string(it);
			string message = "list "+kBayDuration+"h "+kBid+"\n"+group;
			kBayDuration += 4;  // Each successive auction will be 4 hours later
			kBid = 0;
			return kmail("kBay", message, 100, goodies);
		}
		foreach it in cat {
			goodies[it] = cat[it];
			kBid += to_int(OCD[it].info) * cat[it];
			if(count(goodies) > 10) {
				if(!auction()) return false;
				clear(goodies);
			}
		}
		if(count(goodies) > 0 && !auction())
			return false;
		return true;
	}

	boolean act_cat(int [item] cat, string act, string to) {
		if(count(cat) == 0) return false;
		int i = 0;
		if(act == "TODO" && count(todo) > 0)
			print("");
		else
			print_cat(cat, act, to);
		if(vars["BaleOCD_Sim"].to_boolean()) return true;
		switch(act) {
		case "PULV":
			return pulverize();
		case "MALL":
			if(use_multi)
				return kmail(vars["BaleOCD_MallMulti"], vars["BaleOCD_MultiMessage"], 0, cat);
		case "AUTO":
		case "DISP":
		case "CLST":
		case "CLAN":
			batch_open();
			break;
		case "GIFT":
			string message = message(cat);
			return kmail(to, message, 0, cat, message);
		case "KBAY":
			return kBayStuff(to, cat);
		}
		foreach it, quant in cat {
			switch(act) {
			case "MALL":
				if(vars["BaleOCD_Pricing"] == "auto") {
					if(price[it]> 0)  // If price is -1, then there was an error.
						put_shop(price[it], 0, quant, it);  // price[it] was found during print_cat()
				} else
					put_shop(0, 0, quant, it);   // Set to max price of 999,999,999 meat
				break;
			case "AUTO":
				autosell(quant, it);
				break;
			case "USE":
				use_it(quant, it);
				break;
			case "MAKE":
				create_it(it, quant);
				break;
			case "UNTN":
				cli_execute("untinker "+quant+" \u00B6"+ it.to_int());
				break;
			case "DISP":
				put_display(quant, it);
				break;
			case "CLST":
				put_closet(quant, it);
				break;
			case "CLAN":
				put_stash(quant, it);
				break;
			case "TODO":
				print_html("<b>"+it+" ("+quant+"): "+OCD[it].info+"</b>");
				break;
			}
			i += 1;
			// If there are too many items batched mafia may run out of memory. It usually happens around 20 transfers so stop at 15.
			if(i >= 165 && (act == "MALL" || act == "AUTO" || act == "DISP" || act == "CLST" || act == "CLAN")) {
				batch_close();
				i = 0;
				batch_open();
			}
		}
		if(act == "MALL" || act == "AUTO" || act == "DISP"|| act == "CLST" || act == "CLAN") batch_close();
		return true;
	}

	void unequip_familiars() {
		matcher unequip = create_matcher("<a href='(familiar.php\\?pwd=.+?&action=unequip&famid=(.+?))'>\\[unequip\\]"
			, visit_url("familiar.php"));
		while(unequip.find())
			switch(unequip.group(2)) {
			case "124": case "136": break;
			default:
				visit_url(unequip.group(1));
			}
	}

	boolean ocd_inventory(boolean StopForMissingItems) {
		if(!load_OCD()) return false;
		if((!file_to_map("OCDstock_"+vars["BaleOCD_StockFile"]+".txt", stock) || count(stock) == 0)
		  && vars["BaleOCD_Stock"] == "1") {
			print("You are missing item stocking information.", "red");
			return false;
		}
		
		// Add stock list as quantity to keep.
		if(vars["BaleOCD_Stock"].to_int() > 0)
			foreach it in stock
				if(OCD contains it)
					OCD[it].q = max(OCD[it].q, stock[it].q - closet_amount(it));
		
		if(!check_inventory(StopForMissingItems)) return false;
		if(act_cat(make, "MAKE", "") && !check_inventory(StopForMissingItems))
			return false;
		if(act_cat(untink, "UNTN", "") && !check_inventory(StopForMissingItems))
			return false;
		if(act_cat(usex, "USE", "") && !check_inventory(StopForMissingItems))
			return false;
		if(act_cat(pulv, "PULV", "") && !check_inventory(StopForMissingItems))
			return false;
		
		act_cat(mall, "MALL", "");
		act_cat(auto, "AUTO", "");
		act_cat(disp, "DISP", "");
		act_cat(clst, "CLST", "");
		act_cat(clan, "CLAN", "");
		if(count(gift) > 0)
			foreach person in gift
				act_cat(gift[person], "GIFT", person);
		if(count(kbay) > 0) {
			foreach type in kbay
				act_cat(kbay[type], "KBAY", type);
			vprint("", 3);
			if(kBidTot > 0)  // Auctions might have been invalidated for lack of quantity
				vprint("Minimum biding for all auctions = "+rnum(kBidTot), "blue", 3);
			FinalSale += kBidTot;
		}
		
		if(vars["BaleOCD_Stock"] == "1" && !vars["BaleOCD_Sim"].to_boolean())
			stock();

		act_cat(todo, "TODO", "");

		if(vars["BaleOCD_Sim"].to_boolean())
			vprint("This was only a test. Had this been an actual OCD incident your inventory would be clean right now.", "green", 3);
		return true;
	}

// *******  Finally, here is the main for ocd_control()
// int ocd_control(boolean StopForMissingItems) {
	boolean first_run = vars["BaleOCD_Ascension"] != my_ascensions();
	boolean remove_outfit = (vars["BaleOCD_RemoveOutfit"] == "0" && first_run) || vars["BaleOCD_RemoveOutfit"] == "1";
	
	// Empty closet before emptying out Hangks
	if(to_int(vars["BaleOCD_EmptyCloset"]) >= 0 && get_property("lastEmptiedStorage").to_int() != my_ascensions() 
	  && vars["BaleOCD_Sim"] == "false")
		empty_closet();
	// Empty out Hangks, so it can be accounted for by what follows.
	if(get_property("lastEmptiedStorage").to_int() != my_ascensions())
		 visit_url("storage.php?action=pullall&pwd");
	
	// Save outfit information
	string outfit = "familiar "+my_familiar();
	#cli_execute("outfit save Rollover");
	foreach s in $slots[hat, weapon, off-hand, shirt, pants, acc1, acc2, acc3, familiar]
		if(equipped_item(s) == $item[none])
			outfit += "; unequip "+s;
		else outfit += "; equip "+ s +" "+ equipped_item(s);
	
	boolean success;
	try {
		// Now strip if this is first run this ascension, so I can dispose of EVERYTHING
		if(remove_outfit) {
			cli_execute("outfit birthday suit");
			// Get all familiars naked also.
			matcher unequip = create_matcher("<a href='(familiar.php\\?pwd=.+?&action=unequip&famid=.+?)'>\\[unequip\\]", visit_url("familiar.php"));
			while(unequip.find())
				visit_url(unequip.group(1));
		}
		
		// Yay! Get rid of the excess inventory!
		success = ocd_inventory(StopForMissingItems && !vars["BaleOCD_MallDangerously"].to_boolean());
	} finally {
		if(remove_outfit)
			equip_outfit(outfit);
		if(first_run && success && vars["BaleOCD_Sim"] == "false") {
			vars["BaleOCD_Ascension"] = my_ascensions();
			updatevars();
		}
	}
	print("");
	return success? FinalSale: -1;
}

int ocd_control(boolean StopForMissingItems) {
	return ocd_control(StopForMissingItems, "");
}

void main() {
	if(can_interact()) {
		int todaysFarming = ocd_control(true);
		if(todaysFarming < 0)
			vprint("OCD Control was unable to obssessively control your entire inventory.", -1);
		else if(todaysFarming == 0)
			vprint("Nothing to do. I foresee no additional meat in your future.", "olive", 3);
		else vprint("Anticipated monetary gain from inventory cleansing: "+rnum(todaysFarming)+" meat.", "green", 3);
	} else vprint("Whoa! Don't run this until you break the prism!", -3);
}