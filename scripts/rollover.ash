/*
  bumcheekcity and hippoking's Rollover Management Script v0.63
  
  Designed to optimise rollover adventure amounts and remind you to do daily stuff. With great thanks to hippoking.
  ...who actually wrote most of it.
  
  Also, thanks to TH3Y who added some stuff.
  
  VERSION:
  0.5	- Released to the general public.
  0.55	- Fixed bug in maximiser code and wand code.  Extra checks.
  0.56	- Fixed bug in hot tub check
  0.6	- Used built-in maximizer, support for soda and new houses, few bug fixes
  0.61  - Maximize command now -tie
  0.62	- Canticle, bricko, sugar shupport.
  0.625 - check for mad hatter buff and Crimbo present (Y0U)
  0.626 - check for Lunch Break, selling bugged beanie / balaclava (Y0U)
  0.63  - better hand support
*/

notify bumcheekcity;
import <zlib.ash>
check_version("bumcheekcity and hippoking's Rollover Management Script", "bumcheekcityroll", "0.63", 2299);



//Change this to true if you want to be told about bugged items
boolean checkBugged = False;



void debug(string s)
{
  //print("DEBUG: " + s, "blue");
}

boolean valid(string query) {
    item type = to_item(query);
    return(item_amount(type)>0&&can_equip(type)||have_equipped(type));
}


void main() 
{
	string body;

	//Make sure the user is logged in.
	boolean notLoggedIn = true;
	while (notLoggedIn) {
    //body is a piece of depleted grimacite gear. 
		body = visit_url("/desc_item.php?whichitem=642914247");
		if (!contains_text(body,"not available")) {
			notLoggedIn = false;
		} else {
			cli_execute("login "+my_name());
		}
	}

    if(can_equip($item[time sword])&&have_familiar($familiar[Disembodied Hand])&&(!in_hardcore())){
        familiar oldFam = my_familiar();
        use_familiar($familiar[Disembodied Hand]);
        if (valid("time sword")) {
            cli_execute("maximize adv -tie");
        }
        else {
            use_familiar(oldFam);
            cli_execute("maximize adv -tie -familiar");
        }
    }
    else {
        cli_execute("maximize adv -tie -familiar");
    }
    
	print("Finished checking for rollover adventures.", "green");
	
	/*
    This ends the section of the code dealing with the equipment for rollover adventures,
    and the part where the code starts becoming logical again. 
	*/
	print("");
	if (stills_available() > 0) {
		print("You can still upgrade "+stills_available()+" ingredients at the Still");
	}
	
	if (pulls_remaining() > 0) {
		print("You can still pull "+pulls_remaining()+" items from Hagnk's today");
	}
	
	
	// Skills
	body = visit_url("/skills.php");
	int start = index_of(body,"select a skill");

	body = substring(body,start,index_of(body,"</select>",start));
	string [int] skills = split_string(body, "><");
	
	if (my_mp()<10) {
		print("You have less than 10 MP, all skills will not be checked");
	}
	
	foreach X in skills {
		if (contains_text(skills[X],"MP")) 
    {
			string skillName = substring(skills[X],index_of(skills[X],">")+1,index_of(skills[X]," ("));
			string skillCost = substring(skills[X],index_of(skills[X]," (")+2,index_of(skills[X],")"));
			if (!contains_text(skills[X],"disabled") && (
				contains_text(skillName, "Stickers")	||
				contains_text(skillName, "Snowcone")	||
				contains_text(skillName, "Sugar")		||
				contains_text(skillName, "Advanced Saucecrafting")		||
				contains_text(skillName, "Advanced Cocktailcrafting")	||
				contains_text(skillName, "Pastamastery")				||
				contains_text(skillName, "Crimbo Candy")				||
				contains_text(skillName, "Lunch Break")				||
				contains_text(skillName, "Carboloading"))){
					print("You can still cast "+skillName+" today.");
			} else if (contains_text(skillName,"Rainbow Gravitation")) {
				if (!contains_text(skills[x],"disabled")) {
					print("You can still make Prismatic Wads today");
				} else if (my_MP()<mp_cost(to_skill("Rainbow Gravitation"))) {
					print("You don't have enough MP check to Rainbow Gravitation");
				}
			} else if(!in_bad_moon( ) && (
				contains_text(skillName,"Love Song")	||
				contains_text(skillName,"Candy Heart")	||
				contains_text(skillName,"Party Favor")	||
				contains_text(skillName,"BRICKO"))) {
					print("You can "+skillName+" for "+skillCost);
			}
		}
	}
	
	if (my_inebriety() <= inebriety_limit()) {
		print("You're not drunk yet");
	}
	if (my_fullness() < fullness_limit()) {
		print("You're not full yet");
	}
	if (my_spleen_use() < spleen_limit() ) {
		print("Your spleen could take more of a kicking");
	}
	
	if (in_bad_moon()) {
		body = visit_url("/heydeze.php?place=styx");
		if(!contains_text(body, "already sampled")){
			print("You haven't used your styx pixie buff today");
		}
	}
	
	//We have to check that the war is done, or else it complains about the blank response from
	//postwarisland.php. Thanks, Jick.
	body = visit_url("questlog.php?which=2");
	
	if(contains_text(body,"Make War")) {
		body = visit_url("/postwarisland.php?place=nunnery");
		if(contains_text(body, "allow us")) {
			print("The nuns still have some favours to bestow upon you");
		}
		
		body = visit_url("/postwarisland.php?place=concert");
		if(contains_text(body,"roll up to the amphitheater")&&!contains_text(body,"tapped out")) {
			print("You haven't used your arena buff");
		}
	}

	body = visit_url("/friars.php?bro=2");
	if(contains_text(body,"like a blessing")) {	
		print("You haven't used your Friar reward yet");
	}
	
	//Hermit clovers
	body = visit_url("/hermit.php");
	
	if(contains_text(body,"left in stock")) {
		print("You can still get hermit clovers today");
	}
	
	body = visit_url("/campground.php");
	
	//Check if telescope buff has been used
	if(contains_text(body,"telescope")&&!to_boolean(get_property("telescopeLookedHigh"))) {
		print("You can still use your telescope buff today");
	}
	
	if(contains_text(body,"_free.gif")) {
		print("You haven't used your free disco rests");
	}
	
	//Check not wasting rollover MP
	int rollMP;
	int ind = index_of(body,"campground/rest")+15;
	int house = to_int(substring(body,ind,ind+1));
	if (item_amount(to_item("Instant House"))>0&&house<4) {
		print("You forgot to use your instant house");
	}
	
	if (house == 0) {
		print("You will get no rollover MP without a house - buy a tent");
	}
	else {
		rollMP = house*10;
		if (house == 7) {
			rollMP = 85;
		} else if (house == 8) {
			rollMP = 70;
		} else if (house == 9) {
			rollMP = 35;
		}

		if (contains_text(body,"bartender.gif")) {
			rollMP = rollMP+15;
		}
		
		if (my_mp()+rollMP>my_maxmp()) {
			print("Some of your rollover MP will be wasted");
		}
	}
	
	//Check pool table has been used for the day.
	body = visit_url("clan_viplounge.php?action=pooltable");
	if(contains_text(body,"You approach the pool table")&&!contains_text(body,"quite a bit")) {
		print("You can still play pool today");
	}
	
	// Check if zap wand is cold
	body = visit_url("inventory.php?which=3");
	ind = index_of(body,"wand.php");
	if(ind>=0) {
    debug("You have a wand.");
		string url = substring(body,ind,index_of(body,'"',ind));
		debug(url);
		body = visit_url(url);
		if(!contains_text(body,"warm to the touch")&&!contains_text(body,"be careful")) {
			print("Your wand is cold");
		} else {
		  debug("You've used your wand at least once today.");
		}
	} else {
    debug("You don't have a wand at all.");
	}
	
	// Check burrowgrub consumptions used
	if (to_int(get_property("burrowgrubSummonsRemaining"))>0) {
		print("You can still consume burrowgrubs today");
	}
	
	// Check if the day's demon summon has been used
	if (!to_boolean(get_property("demonSummoned"))) {
		print("You can still summon a demon today");
	}
	
	// Check if the hot tub can still be used today
	if (item_amount($item[Clan VIP Lounge key])>0&&to_int(get_property("_hotTubSoaks"))<5&&!in_bad_moon()) {
		print("You can still relax in the hot tub today");
	}

	// Check if the mad hatter buff can still be used today
	if (item_amount($item[Clan VIP Lounge key])>0&&!in_bad_moon()&&get_property("_lookingGlass")==true&&get_property("_madTeaParty")==false) {
		print("You can still visit the mad hatter today, use the 'hatter' command to see which buffs are available");
	}

	// Check if there is a Crimbo Tree present available
	if (item_amount($item[Clan VIP Lounge key])>0&&!in_bad_moon()&&get_property("_crimboTree")==true&&to_int(get_property("crimboTreeDays"))==0) {
		print("You have a present available under the Crimbo Tree");
	}
	
	if (item_amount(to_item("neverending soda"))>0 &&get_property("oscusSodaUsed")==false) {
		print("You can still drink Oscus's Soda today");
	}
	
    
    if(checkBugged){
        if (item_amount(to_item("bugged balaclava"))>0 ) {
            print("You could sell your bugged balaclava today (and get another tomorrow)");
        }

        if (item_amount(to_item("bugged beanie"))>0 ) {
            print("You could sell your bugged beanie today (and get another tomorrow)");
        }
    }
    
	// Visit the BHH to redeem any completed bounties
	body = visit_url("/bhh.php");
	
	print("");
	print("Rollover checking complete", "green");
	
}