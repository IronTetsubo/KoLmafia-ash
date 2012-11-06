// A simple VIP Hopping script by Bale: BAfH 1.6

script "bafh.ash";
notify <Bale>;

// If leader_replacement is set to a player ID, that player will be considered for clan leadership if leaving that position.
// If you are leader_replacement, it will use alternate_replacement instead. This way you can have two characters.
int leader_replacement = 0;  
int alternate_replacement = 0;


// Find the id of the clan that the player belongs to.
int origin_clan() {
	matcher clan = create_matcher("Clan: .*whichclan\=(\\d+)", visit_url("showplayer.php?who="+ to_string(my_id())));
	if(clan.find())
		return clan.group(1).to_int();
	return 0;
}
int origin_clan = origin_clan();

// Goes to a clan identified by number.
boolean goto_clan(int target_id) {
	if(target_id == 90485)   // That's the ID for Bonus Adventures from Hell
		print("Hopping over to Bonus Adventures from Hell.");
	else print("Returning to home clan.");
	string page = visit_url("showclan.php?recruiter=1&whichclan="+ target_id +"&pwd&whichclan=" + target_id + "&action=joinclan&apply=Apply+to+this+Clan&confirm=on");
	if(page.contains_text("clanhalltop.gif"))
		return true;
	if(page.contains_text("You have submitted a request to join") && target_id == 90485) {
		print("You need a whitelist to Bonus Adventures from Hell!", "red");
		cli_execute("csend to bumcheekcity || whitelist bafh");
		print("A request for whitelisting has been submitted.", "green");
		print("The next time that bumcheekcity signs on, you'll be automatically whitelisted.", "green");
		goto_clan(origin_clan);
		return false;
	}
	if(page.contains_text("You can't apply to a new clan when you're the leader of an existing clan")) {
		print("Clan leaders cannot move to another clan without designating a replacement!", "red");
		if(leader_replacement != 0) {
			if(my_id().to_int() == leader_replacement) {
				if(alternate_replacement == 0)
					return false;
				leader_replacement = alternate_replacement;
			}
			print("Transfering leadership of the clan to player ID #"+ leader_replacement);
			page = visit_url("clan_admin.php?action=changeleader&pwd&newleader="+ leader_replacement + "&confirm=on&transfer=Transfer");
			if(page.contains_text("Leadership of clan transferred.  A leader is no longer you"))
				return goto_clan(target_id);
			print("Cannot tansfering leadership of the clan to player ID #"+ leader_replacement, "red");
			return false;
		}
		return false;
	}
	print("Something went wrong! You did not hop into Bonus Adventures from Hell.", "red");
	return false;
}

// Do your business in the VIP room
void visit_vip(string command) {
	if(command == "glass") {
		visit_url("clan_viplounge.php?action=lookingglass");
	} else
		(!cli_execute(command));
}

// Heads over to BAfH and uses the vip room.
void bafh(string command) {
	int buffing_clan = 90485; // Bonus Adventures from Hell

	if(substring(command, 0, 1) == ":") {
		print("Invalid command"+command, "red");
		return;
	}
	if(substring(command, 0, 5) == "pool " && get_property("_poolGames").to_int() > 2) {
		print("You've already played enough pool today!");
		return;
	} else if(command.contains_text("shower ") && get_property("_aprilShower").to_boolean()) {
		print("You've already had a shower today!");
		return;
	}
	
	switch(command) {
	case "return home":
		if(get_property("baleBAfH_origin") == "")
			print("I ain't done nothing wrong, but I can't find my way home.", "red");
		else if(origin_clan.to_string() == get_property("baleBAfH_origin"))
			print("Looks like I've already returned home.", "red");
		else goto_clan(get_property("baleBAfH_origin").to_int());
		return;
	case "glass":
		if(get_property("_lookingGlass").to_boolean()) {
			print("Already visited the Looking Glass today.");
			return;
		}
		break;
	case "ballpit":
		if(get_property("_ballpit").to_boolean()) {
			print("You've already played around in the ballpit today. Get to work!");
			return;
		}
		break;
	case "rollover":
		if(origin_clan == buffing_clan)
			print("Already in BafH and ready to bed in for the night. Zzzzz.");
		break;
	}
	
	if(origin_clan != buffing_clan && !goto_clan(buffing_clan))  // Clanhop only if not starting in BAfH
		return;   // If failed to go to BAfH, then end
		
	if(command == "rollover") {
		if(origin_clan != buffing_clan)
			set_property("baleBAfH_origin", to_string(origin_clan));
		return; 	// Spending rollover here, so we're done.
	}
	
	visit_vip(command);
	
	if(origin_clan != 0 && origin_clan != buffing_clan) 	// Don't return if started in BAfH, or started in no clan.
		goto_clan(origin_clan);
}

string parse_command(string command) {
	switch {
	case length(command) > 4 && substring(command, 0, 5) == "pool ":
	case length(command) > 6 && substring(command, 0, 7) == "shower ":
		return command;
	case command.contains_text("ball"):
		return "ballpit";
	case command.contains_text("mirror"):
	case command.contains_text("glass"):
	case command.contains_text("look"):
		return "glass";
	case command.contains_text("crimbo"):
	case command.contains_text("tree"):
		return "crimbotree get";
	case command.contains_text("roll"):
	case command.contains_text("night"):
	case command.contains_text("sleep"):
		return "rollover";
	case command.contains_text("return"):
	case command.contains_text("home"):
		return "return home";
	}
	return ": "+command;
}

void main(string command) {
	if(in_bad_moon())
		print("You decide not to go near the VIP room, since the brimstone stench of Bad Moon isn't appreciated there.", "red");
	else bafh( command.parse_command() );
}

