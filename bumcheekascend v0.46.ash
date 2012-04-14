/*
	bumcheekascend.ash v0.46
	A script to ascend a character from start to finish.
	
	0.1 - Spun initial release. Gets up to about level 10, haphazardly. 
	0.2 - Added checking for the trapper after the goat cheese.
	    - Fixed bug where it wouldn't get the teleportitis choiceadv immediately after the plus sign. 
		- Added majority of pirate quest.
	0.3 - Implemented Zarqon's excellent scripts for the Level 11 and 12 quests.
		- Fixed bug where it would continue to adventure in the Billiards Room even after you got the key.
		- Fixed bug where it'd get the sonar-in-a-biscuits even if you had them. 
	0.4 - Fixed bug whereby it wouldn't account for Game Grid tokens if you had them, when switching familiars. 
		- Going to start to use a lot more clovers since the change. Levelling post-10 will be done with clovers, as will getting 2 sonars. 
		- Various other small bugs. 
		- Moved all of Zarqon's Level 11 script to this, extensively modified. 
		- Moved some of Zarqon's Level 12 script to this, but unfinished. 
		- Level 13 now completely automated, though a litle buggy. 
		- He-Boulder use now basically supported.
	0.5 - Making both innaboxen post-bonerdagon. 
		- Automating beer pong.
		- Moved the hidden city to being inside the script rather than being called from outside it. 
		- Changed to the full version of bumAdv() moving the goals, etc. to the function rather than calling them individually. 2032 lines before I started this. 
		- Do the Daily Dungeon and zap legend items as appropriate.
	0.6 - Moved (some of) the level 12 script to here, rather than making people run Wossname.ash
		- Moved the billiards room to the part at Level 7.
		- Open the guild store at level 9.
		- Fixed bug whereby it would continue to try to adventure to get insults when you had no adventures. 
		- Fixed bug whereby it would try to get the swashbuckling outfit even if you had the fledges and had sold an outfit piece.
		- Made the script automatically fight the Defiled area bosses.
		- Use noncombat in the > Sign and DoD.
		- Sort problem where it would attempt to level in the Temple immediately even if you couldn't.
		- Added aborts to the spooky sapling and tavern areas as mafia support for those is currently in the pipeline. 
		- Throw a visit to trapper.php when we use the black paint at Level 11, just in case we haven't got cold resistance yet. 
		- Make DB Epic Weapon if applicable. 
		- Only adventure in the DoD to get the wand if you have > 6000 meat.
	0.7 - Fix issue where it wouldn't stop adventuring in the HitS.
		- Fix issue with not turning in the arena adventure. 
		- Fix bug where it wouldn't do the Sonofa Beach quest at all. 
		- Add support for 100% familiars.
		- Added support for pumpkin bombs where we don't have a he-boulder or are on a 100% run. 
		- Changed a lot of IFs to WHILEs to account for sugar items breaking. 
		- Actually adventure at the shore instead of breaking. 
		- Fixed issue where the script would break if you didn't get Minniesota Indoodlywhatatis from the Billiards Room in 5 advs.
		- Every time we change the MCD, we must check if we can using the canMCD() function which I've added. 
		- Added support for a cloverless option. 
		- Used Rinn's scripts to add support for Beer Pong
		- Use spleen items automatically (aguas, coffee pixie sticks) including turning tokens into tickets using the skeeball machine.
		- Some more testing on completing the war as a Hippy, which has now been tested. 
		- Don't adventure in the Knoll if you have no adventures. 
		- Fix problem where it wouldn't equip stench resistance to adventure in Guano junction.
		- Sort out the spooky sapling thing, finally!
		- There's now an items mood, which will be expanded on shortly. 
	0.8 - Accommodated change to Mr. Alarm
		- Made sure that there weren't any maximize commands without -melee added
		- Check for meat when shoreing.
		- Other misc. issues. 
		- Update the Boss Bat quest to account for Nov 2010 Changes. 
		- Added support for phat/leash when you need item drops. 
		- Added default options, so that this is ACTUALLY zero setup again. 
	0.9 - Fix problem with moods +-combat moods that cancel each other out. 
		- Set wheel choiceadventures in the Castle
		- Fix bug whereby it'd adventure in the goatlet even once you gave the cheese back. 
		- Change "f" to "familiar". 
		- Make it not crash on DB chars when making boxen. 
		- Made making a bartender an opt-in preference. 
		- Do GMoB instead of Cyrus. Figuring out the Cyrus logic is too hard. 
	0.10- Open ballroom by going through bedroom.
		- Check for the He-Boulder BEFORE making the pumpkin bomb. Not after. That would be a stupid idea. 
		- Force MCD=0 in Junkyard. Maximize DR/DA as well. Force MCD=4,7 in Boss Bat, Throne Room.
		- Fix bug where it'd continue to get the steel items. 
		- Made a slight change to the way the script checks for clovers. 
		- Set the library choice adventures. 
		- Also set moods if we have >100MP or >7000 meat.
		- Start moving things into separate functions per quests.
		- Set moods when trying to level.
	0.11- Fixed bug with trapzor quest where it wouldn't get the goat cheese at all. 
		- Only adventure in the Upper Chamber if you DON'T have the wheel. And use tomb ratchets if one drops. 
		- Don't mark the guild tests as being done if they haven't been done.
		- Don't worry about safe moxie in the starting areas.
		- Adventure in the haunted pantry during levelMe when still level 1.
		- Visit Toot and use the letter. 
		- Check for if you're cloverless and hence can't get an EW. 
		- Use Spleen items on change of familiar. 
		- Beaten up check in Hidden City added.
		- Don't try to make Epic weapons if you don't have meat or the tenderizing hammer. 
		- Add tavern code. Thanks, picklish!
	0.12- Added option to fight the NS. 
		- Don't get innaboxen if you're cloverless.
		- Add -melee -ML to the default maximize command.
		- Fix bug with levelling not working with buffed moxie. 
		- Add mining command.
		- Use an item drop familiar in the gremlins (to solve problems with snatch and DB attacks).
	0.13- If you don't have an accordion, get one. 
		- Don't abort if you don't have a big rock for the Epic Weapon(s)
		- Don't think you can shop in the KGE store if you don't have the lab key. Because you can't. 
		- Use a spanglerack if possible. 
		- Move the Level 11 quest into sub-functions. 
		- Make sure to set familiars when levelling. Also don't use your last clover on levelling. 
		- Don't make a meatcar if you have a pumpkin carriage or desert bus pass.
		- Do the Bedroom. Yay!
	0.14- Fix bug with using clovers to level in cloverless runs. 
		- Don't cast Mojo if you want NCs or items. This solves problems with setting 4 songs. 
		- Create a new mood called "bumcheekascend" to use.
		- Fixed bug whereby it would mark the bats1 as done when it wasn't. 
		- Let's not equip the pool cue, eh? Also, moved the Billiards Room to earlier. 
		- Only set skills in your mood if you can use them.
		- Add some fixes by picklish for burning teleportitis. 
		- Fix Hole in the Sky for about the zillionth time. 
		- Add a check for a one-handed item during the 8-bit. 
		- Improved logic for Level 13, which will now correctly get a DoD potion as well as a couple other items. 
	0.15- Add red ray use. Fix potion of blessing for Level 13. Thanks, picklish!
		- Add telescope checking. 
		- Fix bug where it wouldn't do the DD.
		- Change maximize commands for mus/mys compatibility. 
		- Add basic support for muscle classes.
	0.16- Various fixes for muscle ascensions. 
		- Fix some telescope stuff, expand on options there. 
		- Added some "base" entries to the maximizer, which are always on. Melee and shield for Mus, ranged for Mox.
		- It's probably best if muscle classes DON'T attack the gremlins.
		- Hit the questlog to see if you've completed the Hidden City for (pah!) SOFTcore players...
		- Added new Azazel quest.
	0.17- Fixed bug where muscle classes basically wouldn't fight the Bonerdagon
		- Use the hipster for the temple.
		- No need to hit the guild for the meatcar quest anymore. 
		- Continued muscle fixes. 
		- Don't abort at Yossarian if you have the outfit on already.
		- Don't abort at the 8bit for muscle classes.
		- Start the steel quest properly now. 
	0.18- Only make an RNR Legend if you have relevant skills. Thanks, St. Doodle!
		- Don't switch to the hipster if you're on a 100% run. 
		- Fix "try" now being a reserved word. 
		- Dont cast Mojo if you can't. 
	0.19- Change for Cobb's Knob changes. 
		- Don't go to the chasm if you already have the scroll. Important now with faxbot.
		- Remove the eyedrops from use.
		- Option to NOT get your stuff from Hagnks
		- Only get the 1-handed weapon if you're moxie. And get a disco ball.
		- Get the AT epic weapon last. 
		- Major tavern fix from picklish. 
		- Revamped Level 5 quest. 
		- Open Gallery as Muscle class.
	0.20- Some better Sven logic.
		- Fixed detection of Cyrpt, KnobKing, Steel Item and Innaboxen stages if they were done out-of-script. Thanks, Winterbay!
		- Improved Tavern handling from picklish. 
		- Stuff. Various actually quite large fixes that I forgot to mention. 
		- Ability to set default familiar. Check your relay scripts.
	0.21- Get mariachi instruments. Thanks, picklish!
		- Add option to NOT level in the temple.
		- Get meelgra pills, more tavern fixes. Another picklish addition. 
		- Fix bug with Sven and failing to get the Unicorn. 
		- Fix bug with getting a box if you can't access the Fun House. Thanks, gruddlefitt!
		- Don't use the scope if you've passed the mariachis.
		- Added default options for those who can't work out the relay script. This is finally zero-setup again!
		- Don't remove goals when getting a firecracker for pumpkin bomb. 
	0.22- Allow 2-handed weapons or DFSS when you don't have a shield. 
		- Use your CCS actions and be more robust to wandering monsters thanks to picklish.
		- Dont fight the Boss Bat if there's rubble there. 
		- Don't open the prok sack if you don't want to autosell the gems. 
		- Myst ascension. Oh yes.
	0.23- Myst fixes ranging from minor to major. Added various sauce spells.
		- Set choiceadvs on levelMe()
		- Set a while rather than an if for the level 9 quest.
		- Should zap legend keys if you have MORE than one of them. Also move zapKeys() into the global space. 
		- Have myst consult script fire in all appropriate locations. 
		- Don't equip hippy outfit in Hidden City as myst. 
		- Don't use the hipster in the temple if you're on a 100% run. 
		- New Cyrpt added. 
	0.24- Change MCD to only go up to 10.
		- Use evilometer at cyrpt to stop bug whereby it won't know how evil things are. 
		- Don't infinitely adventure at Chasm for Myst characters.
		- Warn if you don't have a recoveryScript or counterScript.
		- Fix changes to the moon signs due to 2011 Valhalla update. 
	0.25- Add an option to disable the MCD.
		- Fix bug where the script would adventure in the black forest to get the map if you had it. 
		- Don't bother with your classes EW if you have the astral items that kick ass. 
		- Massive fixes for Bees Hate You (virtually all of them from Winterbay). Thanks, Winterbay!
		- Closet clovers instead of using them in BHY. 
		- Use Massive Manual of Moodly Whatsis in BHY. 
		- No YOROIDS or pumpkin bomb either. 
		- Check for familiars with 'b' in their name. And don't use them in BHY. 
		- Little things like the chest of the Bonerdagon, Innaboxen, tomb ratchets, black forest and a couple other places. 
		- Major change for the meatcar. 
		- Get the dispensiry password. If you're OK with bees. 
		- When trying for the GMoB, set the choice adventure to primestat. 
		- Fix bug where it would advnture in the pantry when it would be massively inappropriate to do so. 
		- Fix bug where it wouldn't adventure in the filthworms if you already had the Heart of the Queen.
		- Olfact stuff as a myst class if it's set in your CCS.
		- Estimate monster HP where necessary as a myst class.
	0.26- Massive changes to get the script to run better in softcore and casual. 
	0.27- Init boost in the relevant Cyrpt zone. 
		- Fix issue where bumRunCombat WOULD adventure in the n00b cave. 
		- Fix issue with the Dooks quest which would break if you didn't have a chaos butterfly. 
		- Equip scratch 'n' sniff for nuns. 
		- Fixed handling of the sorceress quest when you have the SCUBA gear. Or, more likely, broke it horrifically for hardcore. 
	0.28- Don't use consultMyst for softcore.
		- Fix he-bo for myst classes and BHY.
		- Use antique hand mirror aganist GMOB. Not Cyrus.
		- Calculate Weapon of the Pastalord damage correctly. Also abort properly if necessary. 
		- Work out if you're already unlocked the beach manually. 
	0.29- Don't unlock the temple if you don't want to level in it. Until level 11, of course.
		- Fax support added. 
		- Major extra support for BHY, mostly from Winterbay, who is awesome. 
		- Extra support for casual. 
		- Use the harem outfit instead of the KGE one if you're moxie to kill the Knob Goblin King.
		- Add options to override Myst and Casual handing and just fight using your CCS.
		- Add options to skip getting the steel item.
	0.30- New guild challenge.
		- Fix bug with adventuring in the chasm forever. 
		- Fix nuns if you have the scratch and sniff sword.
		- Do the beach if you have five barrels of gunpowder, even if you don't have the setting on. Optimal!
		- Use wallet-style items (coin purses, pension check, etc.)
		- Call buMax and setFamiliar before faxing.
	0.31- Improved optimisation for the nuns. 
		- Register aliases for operation. 
		- Prepare food in a ridiculously stupid and unintelligent way.
		- Actually abort bumMiniAdv() if you abort the script. 
	0.32- Use astral shell in the daily dungeon. 
		- Use guild meat. 
		- Use obtuse angel against LFM.
		- Tidy up willMood() function. 
		- Cast astral shell in the DD.
		- Fix pulling items from hagnks.
		- Disable autosell in Fist, as well as KGE faxing, KGE fighting, mining support and buMax issues.
	0.33- Fix maximizer in fist runs. 
		- Change choices for bedroom in fist runs. 
		- A couple of aborts and meat checks for fist runs. 
	0.34- Don't sell gems in fist runs. Also change some mood working. 
		- We can fight the protector spirit if we're in Fistcore or not moxie.
		- Fix a problem with the nuns aborting due to bumMiniAdv() not returning true.
		- Fix a bug with telescopes in Bad Moon. 
		- Stop too much levelling in fistcore.
	0.35- Fix a bug with outfits and fistcore. 
		- Don't use radio if you can't afford it. 
		- Fix bug with telescope backfarming.
		- Save you from drunk self.
		- Don't fax LFM after the war.
		- Don't use DOD potions if you're > 16 drunk.
		- Don't fax a monster if you have no adventures. 
	0.36- Fix bug where it wouldn't update the airship as done. 
		- Don't get stuck if you can't get into the bedroom. 
		- Don't REQUIRE the softcore warning in the relay script. But still give the warning every time. 
		- Use unbearable light if necessary.
		- Add support for Trendy via Winterbay's patch for familiars. 
		- Remove poisoned when levelling because it buggers with the amount of buffed stat you need. 
		- Put in an option to not consume spleen. 
		- Make the function for telescope stuff more verbose (from morgad).
		- Add option to not use clovers to level.
		- Fix bug where it wouldn't stop adventuring in the DD.
		- Use boots spleen items too, but don't get them.
		- Change to credit RINN correctly. 
		- Major revision of moods, optimisation of bats, cyrpt, and various bugfixes thanks to Winterbay. 
	0.37- Improve the telescope information even more. 
		- Speed up the war stage a bit (hopefully this won't screw it up) and print some helpful debugging information for when fighting the war. 
		- Fix clover levelling for BHY.
		- Make sure we have appropriate gear before levelling.
		- Consider the Spanglypants as well as the Spanglyrack for item drops.
		- Make sure we don't crash due to not having a non-trendy spleen familiar.
		- Fix bug where it wouldn't fax anything due to an incorrectly read property.
		- Make sure we have the right choice adventure set when myst-levelling.
		- Set familiar before guild quest.
	0.38- Use Knob Goblin Perfume if we can and are using the Harem outfit to kill the Knob King.
		- Make sure we have all 5 bus passes before moving on to the Comedy club to potentially minimize some levelling.
		- Use an item-drop familiar for the Dark Neck of the Woods
		- Don't auto-adventure if all goals have already been met
		- Fix clover levelling going to the wrong place
		- Don't use spleen items in casual.
		- Don't pickpocket if there are no items to drop in casual. 
		- Fix bug where it wouldn't make the meatcar due to a new crimbo item. 
		- "outfit" not "+outfit"
		- Don't set a default mood in casual runs. 
		- Fix creation of wind-up meatcar instead of bitchin' meatcar
		- Correctly deal with the pirates in casual runs. 
		- Actively make an unbearable light. 
	0.39- Don't re-get the tower items if you already used them in the tower. 
		- Add option to completely disable all moods. 
		- Add Groose Support
		- Add option to fight the Protector Spectre as Moxie. We'll always fight as Muscle/Myst
		- Fix bug where it would stop at Sonofa Beach and report a false positive if a SR counter came up. 
		- Don't try to pull stuff if there are none available (because take_storage returns true which leads to infinite loops)
		- Fix some code for detection of gate items
		- Fix bug where it would adventure forever in the Ballroom if there was a rogue condition somewhere. 
		- Don't make a 2nd unbearble light if we have one already.
		- Don't YR Harem Madams
		- Don't check the tower more than once, and abort if there are known items that we can't get
		- Make sure to create a myst epic weapon if we have told the script to create innaboxen
		- Shrug Just the Best Anapests since it screws with automatic detection of things
		- Ask the user before creating a Knob Cake if requireBoxServants is set to true
		- Make sure to always use the full outfit name in case people have similarly named custom outfits
	0.40- Don't adventure in the Noob Cave after fighting the Lobsterfrogman as a Myst-class (or in a casual run)
		- Don't maximize into a shield everytime anHero() is called, instead check if we have a shield with a new function
		- Fix for Mafia changing the Hidden City to two different zones
		- Make the aliases use the filename of the current file rather than anything else
		- Fix fix for knob cake
		- Only maximize what's necessary for the area, using MP regen and +exp gear if possible. 
		- Make it easier to fight the NS as myst. 
	0.41- Don't use the groose in BHY runs.
		- Add option to ignore safe moxie in hardcore.
		- Make sure that 100% runs are respected for the NS. 
		- Refactor path handling for familiars
		- Complete the guild before getting the items in the three starter areas for the scope. 
		- Remove the "-tie" from maximizer calls.
		- Don't fail getting stench resist for myst classes.
		- Check for advs before doing the DD.
		- Fix the fix for fighting knob goblin harem girls.
	0.42- Add "resolution: be wealthier" as a meat-boost for the nuns
		- Fixes for Avatar of Boris (Should be fairly workable now, even upto including instrument swapping). You do need to learn your own skills.
		- Less confusing message for people on 100%-runs without pumpkins and clipart
		- Don't set nuns to completion just because we run out of turns. Check the Mafia preference for it.
		- Ignore 100% setting for Boris runs. 
		- Fix bug where it'd get the first item for the gates again once you were through them. 
	0.43- Add handsomeness potion as an item to get automatically, also rejigger the chewing-gum-getting code
		- Use minstrel_instrument() rather than checking for Clancy's image, also use use() to use the instrument instead of visit_url()
		- Properly abort leveling if we fulfill the required goal with a clover.
		- Fix bug caused when mafia removed the to_float(boolean) function. 
	0.44- Go back to to_float(boolean) and not to_int(to_float(boolean)) as it works again also don't try to use the sackbut if Clancy's already using it
	0.45- Fix all warnings for "sloppy" code and add return values to all functions needing it
		- Use noncombat in the friars zones. 
		- Basic moods for Boris runs
		- Adventure at your primestat's location only. 
		- Correct misspelled pandamonium.php and fix fullness-check for Boris runs in friarssteel()
		- Don't get the hippy outfit in softcore. Or, for that matter, telescope items. 
		- Abort at the beach to putty. (Softcore only)
		- Add a couple of non-class specific options at the Gremlins
		- Zap Boris' key last to avoid problems with the Gates in Avatar of Boris
	0.46- Remove temple levelling code, abort if we don't want to level in the temple
		- Fix some Boris related errors in the Steel-quest
		- Try to do the entryway in a lucky way if we have at least one clover
		- Take that back and only do it if we've got an option set. 
		- Use non-combats when trying for 70 myst for the frat outfit
		- Indicate that we are loading a map, in case it halts and the user has no idea what's going on
		- Don't get the Wand of Nagmar if we're in Boris. 		
		- Fix bug with Safe Moxie in the temple.
		- Add a new way to level up after the temple went out of fashion.
*/

script "bumcheekascend.ash";
notify bumcheekcity;

string bcasc_version = "0.46";
string bcasc_doWarAs = get_property("bcasc_doWarAs"), bcasc_100familiar = get_property("bcasc_100familiar"), bcasc_warOutfit;
boolean bcasc_bartender = get_property("bcasc_bartender").to_boolean(), bcasc_bedroom = get_property("bcasc_bedroom").to_boolean(), bcasc_chef = get_property("bcasc_chef").to_boolean(), bcasc_cloverless = get_property("bcasc_cloverless").to_boolean(), bcasc_doSideQuestArena = get_property("bcasc_doSideQuestArena").to_boolean(), bcasc_doSideQuestJunkyard = get_property("bcasc_doSideQuestJunkyard").to_boolean(), bcasc_doSideQuestBeach = get_property("bcasc_doSideQuestBeach").to_boolean(), bcasc_doSideQuestOrchard = get_property("bcasc_doSideQuestOrchard").to_boolean(), bcasc_doSideQuestNuns = get_property("bcasc_doSideQuestNuns").to_boolean(), bcasc_doSideQuestDooks = get_property("bcasc_doSideQuestDooks").to_boolean(), bcasc_fightNS = get_property("bcasc_fightNS").to_boolean(), bcasc_MineUnaccOnly = get_property("bcasc_MineUnaccOnly").to_boolean();

/***************************************
* DO NOT EDIT ANYTHING BELOW THIS LINE *
***************************************/


if (bcasc_doWarAs == "frat") {
	bcasc_warOutfit = "frat warrior";
} else if (bcasc_doWarAs == "hippy") {
	bcasc_warOutfit = "war hippy";
} else {
	//abort("Please specify whether you would like to do the war as a frat or hippy by downloading the relay script at http://kolmafia.us/showthread.php?t=5470 and setting the settings for the script.");
	bcasc_doWarAs = "frat";
	bcasc_warOutfit = "frat warrior";
	bcasc_doSideQuestArena = true;
	bcasc_doSideQuestJunkyard = true;
	bcasc_doSideQuestBeach = true;
	print("BCC: IMPORTANT - You have not specified whether you would like to do the war as a frat or a hippy. As a result, the script is assuming you will be doing it as a frat, doing the Arena, Junkyard and Beach. Visit the following page to download a script to help you change these settings. http://kolmafia.us/showthread.php?t=5470");
	wait(5);
}

record lairItem {
	string gatename;
	string effectname;
	string a; //Item name 1
	string b;
	string c;
	string d;
	string e;
};
record alias {
	string cliref;
	string functionname;
};
lairItem [int] lairitems;
string councilhtml, html;
int max_bees = 0;
if (get_property("bcasc_maxBees").to_int() > 0) max_bees = get_property("bcasc_maxBees").to_int();

boolean load_current_map(string fname, lairItem[int] map) {
	print("BCC: Trying to check " + fname + " on the Bumcheekcity servers.", "purple");
	string domain = "http://bumcheekcity.com/kol/maps/";
	string curr = visit_url("http://bumcheekcity.com/kol/maps/index.php?name="+fname);
	file_to_map(fname+".txt", map);
	
	//If the map is empty or the file doesn't need updating
	if ((count(map) == 0) || (curr != "" && get_property(fname+".txt") != curr)) {
		print("Updating "+fname+".txt from '"+get_property(fname+".txt")+"' to '"+curr+"'...");
		
		if (!file_to_map(domain + fname + ".txt", map) || count(map) == 0) return false;
		
		map_to_file(map, fname+".txt");
		set_property(fname+".txt", curr);
		print("..."+fname+".txt updated.");
		return true;
	}
	
	return false;
}

boolean load_current_map(string fname, alias[int] map) {
	print("BCC: Trying to check " + fname + " on the Bumcheekcity servers.", "purple");
	string domain = "http://bumcheekcity.com/kol/maps/";
	string curr = visit_url("http://bumcheekcity.com/kol/maps/index.php?name="+fname);
	file_to_map(fname+".txt", map);
	
	//If the map is empty or the file doesn't need updating
	if ((count(map) == 0) || (curr != "" && get_property(fname+".txt") != curr)) {
		print("Updating "+fname+".txt from '"+get_property(fname+".txt")+"' to '"+curr+"'...");
		
		if (!file_to_map(domain + fname + ".txt", map) || count(map) == 0) return false;
		
		map_to_file(map, fname+".txt");
		set_property(fname+".txt", curr);
		print("..."+fname+".txt updated.");
		return true;
	}
	
	return false;
}

boolean load_current_map(string fname, string[int] map) {
	print("BCC: Trying to check " + fname + " on the Bumcheekcity servers.", "purple");
	string domain = "http://bumcheekcity.com/kol/maps/";
	string curr = visit_url("http://bumcheekcity.com/kol/maps/index.php?name="+fname+"&username="+my_name());
	file_to_map(fname+".txt", map);
	
	//If the map is empty or the file doesn't need updating
	if ((count(map) == 0) || (curr != "" && get_property(fname+".txt") != curr)) {
		print("Updating "+fname+".txt from '"+get_property(fname+".txt")+"' to '"+curr+"'...");
		
		if (!file_to_map(domain + fname + ".txt", map) || count(map) == 0) return false;
		
		map_to_file(map, fname+".txt");
		set_property(fname+".txt", curr);
		print("..."+fname+".txt updated.");
	}
	
	return true;
}

/******************
* BEGIN FUNCTIONS *
******************/

void ascendLog(string finished) {
	string [int] settingsMap;
	string settings = "{";
	string stages;
	string turns = my_turncount().to_string();
	string days = my_daycount().to_string();
	string ascnum = my_ascensions().to_string();
	string url = "http://bumcheekcity.com/kol/asclog.php?username="+my_name()+"&mafiaversion="+get_version()+"&mafiarevision="+get_revision();
		url += "&scriptversion="+bcasc_version+"&finished="+finished+"&scriptname="+__FILE__+"&days="+days+"&turns="+turns+"&ascnum="+ascnum;
	
	load_current_map("bcsrelay_settings", settingsMap);
	foreach x in settingsMap {
		settings += "\""+settingsMap[x]+"\":"+url_encode(get_property(settingsMap[x]))+",";
	}
	url += "&settings="+settings+"}";
	
	string api = visit_url("api.php?what=status&for=bumcheekascend v"+bcasc_version);
	
	api = replace_all(create_matcher("\"pwd\":\"[a-z0-9]+\",", api), "");
	
	url += "&api="+api;
	
    string response;
    try { response = visit_url(url); }
	finally { response = "a"; }
}

boolean have_path_familiar(familiar fam) {
	if(my_path() == "Trendy")
		return have_familiar(fam) && is_trendy(fam);
	else if(my_path() == "Bees Hate You")
		return have_familiar(fam) && !contains_text(to_lower_case(to_string(fam)), "b");
	else if(my_path() == "Avatar of Boris")
		return false;
	else
		return have_familiar(fam);
}

int i_a(string name) {
	item i = to_item(name);
	int a = item_amount(i) + closet_amount(i) + equipped_amount(i);
	
	//Make a check for familiar equipment NOT equipped on the current familiar. 
	foreach fam in $familiars[] {
		if (have_path_familiar(fam) && fam != my_familiar()) {
			if (name == to_string(familiar_equipped_equipment(fam)) && name != "none") {
				a = a + 1;
			}
		}
	}
	
	//print("Checking for item "+name+", which it turns out I have "+a+" of.", "fuchsia");
	return a;
}

boolean hasShield() {
	foreach str in $strings[Ancient stone head, Antique shield, Astral shield, BRICKO bulwark, Balloon shield, Barskin buckler, Battered hubcap, Black shield,
		Box turtle, Brass dorsal fin, Brimstone Bunker, Cardboard box turtle, Catskin buckler, Cloaca-Cola shield, Clownskin buckler, 
		Coffin lid, Dallas Dynasty Falcon Crest shield, Demon buckler, Detour shield, Duct tape buckler, Dyspepsi-Cola shield, Eelskin shield, 
		Flimsy clipboard, Giant clay ashtray, Gnauga hide buckler, Grisly shield, Hippo skin buckler, Hors d'oeuvre tray, Hot plate, Keg shield, 
		Loathing Legion pizza stone, Meat shield, Mer-kin roundshield, Ol' Scratch's stove door, Old-school flying disc, Operation Patriot Shield, 
		Oscus's garbage can lid, Padded tortoise, Painted shield, Peanut brittle shield, Penguin skin buckler, Pilgrim shield, Pixel shield, 
		Polyalloy shield, Pottery shield, Rxr shield, Sawblade shield, Sealhide buckler, Sebaceous shield, Sewer turtle, Six-rainbow shield, 
		Slippery when wet shield, Snake shield, Snarling wolf shield, Speed limit shield, Spiky turtle shield, Spongy shield, Star buckler, 
		Stinky cheese wheel, Stop shield, Teflon shield, Tortoboggan shield, Turtle wax shield, Velcro shield, Vinyl shield, Washboard shield, 
		White satin shield, Wicker shield, Wonderwall shield, Yakskin buckler, Yield shield, Zombo's shield]
	{
		if(i_a(str) > 0 && can_equip(to_item(str)))
			return true;
	}
	return false;
}

boolean isExpectedMonster(string opp) {
	location loc = my_location();

	boolean haveOutfitEquipped(string outfit) {
		boolean anyEquipped = false;
		boolean allEquipped = true;
		foreach key, thing in outfit_pieces(outfit) {
			if (have_equipped(thing)) {
				anyEquipped = true;
			} else {
				allEquipped = false;
				break;
			}
		}

		return anyEquipped && allEquipped;
	}

	//Fix up location appropriately. :(
	if (loc == $location[wartime frat house]) {
		if (haveOutfitEquipped("hippy disguise") || haveOutfitEquipped("war hippy fatigues"))
			loc = $location[wartime frat house (hippy disguise)];
	} else if (loc == $location[wartime hippy camp]) {
		if (haveOutfitEquipped("frat boy ensemble") || haveOutfitEquipped("frat warrior fatigues"))
		loc = $location[wartime hippy camp (frat disguise)];
	}

	monster mon = opp.to_monster();
	boolean expected = appearance_rates(loc) contains mon;
	return expected;
}

//Returns the string which we'll use for the maximiser, or nothing if this would be inappropriate. 
string prepSNS() {
	void fold() {
		visit_url("bedazzle.php?action=fold&pwd=");
	}
	
	//If we don't have a sticker tome, abort.
	if (!can_interact() && !contains_text(visit_url("campground.php?action=bookshelf"), "Sticker")) {
		return "";
	} else {
		item i = $item[scratch 'n' sniff UPC sticker];
		foreach s in $slots[sticker1, sticker2, sticker3] {
			if (equipped_item(s) != i && item_amount(i) > 0) {
				equip(s, i);
			}
		}
	}

	if (my_primestat() == $stat[Moxie] && in_hardcore()) {
		if (i_a("scratch n sniff sword") > 0) fold();
		if (i_a("scratch n sniff crossbow") > 0) return "+equip scratch n sniff crossbow";
		return "";
	} else {
		if (i_a("scratch n sniff crossbow") > 0) fold();
		if (i_a("scratch n sniff sword") > 0) return "+equip scratch n sniff sword";
		return "";
	}
	return "";
}

string safe_visit_url(string url) {
    string response;
    try { response = visit_url( url ); }
    finally { return response; }
    return response;
}

//Thanks to Bale and slyz here!
effect [item] allBangPotions() {
	effect [item] potion;
	for id from 819 to 827 {
		switch( get_property("lastBangPotion"+id) ) {
			case "sleepiness": potion[id.to_item()] = $effect[ Sleepy ]; break;
			case "confusion": potion[id.to_item()] = $effect[ Confused ]; break;
			case "inebriety": potion[id.to_item()] = $effect[ Antihangover ]; break;
			case "ettin strength": potion[id.to_item()] = $effect[ Strength of Ten Ettins ]; break;
			case "blessing": potion[id.to_item()] = $effect[ Izchak's Blessing ]; break;
			case "healing": break;
			default: potion[id.to_item()] = get_property("lastBangPotion"+id).to_effect();
		}
	}
	return potion;
}

//Returns true if we have a shield and Hero of the Halfshell.
boolean anHero() {
	if (!have_skill($skill[Hero of the Half-Shell])) return false;
	if (my_path() == "Way of the Surprising Fist") return false;  
	if (!(my_primestat() == $stat[Muscle])) return false;
	if (get_property("bcasc_lastShieldCheck") == today_to_string()) return true;
	
	//cli_execute("maximize "+max_bees+" beeosity, +shield"); 
	//if (item_type(equipped_item($slot[off-hand])) == "shield") {
	if(hasShield()) {
		cli_execute("set bcasc_lastShieldCheck = "+today_to_string());
		print("BCC: You appear to have a shield. If you autosell your last shield, this script is going to behave very strangely and you're an idiot.", "purple");
		return true;
	}
	
	print("BCC: You don't have a shield. It might be better to get one. ", "purple");
	return false;
}

//Returns a string of "dark potion", or whatever. 
string bangPotionWeNeed() {
	effect effectWeNeed() {
		string html = visit_url("lair1.php?action=gates");
		effect e = $effect[none];
		
		if (contains_text(html, "Gate of Light")) { e = $effect[Izchak's Blessing]; }
		if (contains_text(html, "Gate of That Which is Hidden")) { e = $effect[Object Detection]; }
		if (contains_text(html, "Gate of the Mind")) { e = $effect[Strange Mental Acuity]; }
		if (contains_text(html, "Gate of the Ogre")) { e = $effect[Strength of Ten Ettins]; }
		if (contains_text(html, "Gate that is Not a Gate")) { e = $effect[Teleportitis]; }
		print("BCC: The effect we need for the gate is "+e.to_string(), "purple");
		if (e == $effect[none]) abort("Error determining effect needed to pass the gates!");
		return e;
	}
	
	effect e = effectWeNeed();
	foreach pot, eff in allBangPotions() {
		if (e == eff) {
			print("BCC: The potion we need is the "+pot, "purple");
			return pot;
		}
	}
	print("BCC: We could not yet determine which potion gives us the necessary effect.", "purple");
	return "";
}

string bcCouncil() {
	if (get_property("lastCouncilVisit") != my_level() || councilhtml == "") {
		councilhtml = visit_url("council.php");
	}
	return councilhtml;
}

//Thanks, Rinn!
string beerPong(string page) {
	record r {
		string insult;
		string retort;
	};

	r [int] insults;
	insults[1].insult="Arrr, the power of me serve'll flay the skin from yer bones!";
	insults[1].retort="Obviously neither your tongue nor your wit is sharp enough for the job.";
	insults[2].insult="Do ye hear that, ye craven blackguard?  It be the sound of yer doom!";
	insults[2].retort="It can't be any worse than the smell of your breath!";
	insults[3].insult="Suck on <i>this</i>, ye miserable, pestilent wretch!";
	insults[3].retort="That reminds me, tell your wife and sister I had a lovely time last night.";
	insults[4].insult="The streets will run red with yer blood when I'm through with ye!";
	insults[4].retort="I'd've thought yellow would be more your color.";
	insults[5].insult="Yer face is as foul as that of a drowned goat!";
	insults[5].retort="I'm not really comfortable being compared to your girlfriend that way.";
	insults[6].insult="When I'm through with ye, ye'll be crying like a little girl!";
	insults[6].retort="It's an honor to learn from such an expert in the field.";
	insults[7].insult="In all my years I've not seen a more loathsome worm than yerself!";
	insults[7].retort="Amazing!  How do you manage to shave without using a mirror?";
	insults[8].insult="Not a single man has faced me and lived to tell the tale!";
	insults[8].retort="It only seems that way because you haven't learned to count to one.";

	while (!page.contains_text("victory laps"))
	{
		string old_page = page;

		if (!page.contains_text("Insult Beer Pong")) abort("You don't seem to be playing Insult Beer Pong.");

		if (page.contains_text("Phooey")) {
			print("Looks like something went wrong and you lost.", "lime");
			return page;
		}
	
		foreach i in insults {
			if (page.contains_text(insults[i].insult)) {
				if (page.contains_text(insults[i].retort)) {
					print("Found appropriate retort for insult.", "lime");
					print("Insult: " + insults[i].insult, "lime");
					print("Retort: " + insults[i].retort, "lime");
					page = visit_url("beerpong.php?value=Retort!&response=" + i);
					break;			
				} else {
					print("Looks like you needed a retort you haven't learned.", "red");
					print("Insult: " + insults[i].insult, "lime");
					print("Retort: " + insults[i].retort, "lime");
	
					// Give a bad retort
					page = visit_url("beerpong.php?value=Retort!&response=9");
					return page;
				}
			}
		}

		if (page == old_page) abort("String not found. There may be an error with one of the insult or retort strings."); 
	}

	print("You won a thrilling game of Insult Beer Pong!", "lime");
	return page;
}

void betweenBattle() {
	cli_execute("mood execute; uneffect beaten up;");
	if (to_float(my_hp()) / my_maxhp() < to_float(get_property("hpAutoRecovery"))) restore_hp(0); 
	if (to_float(my_mp()) / my_maxmp() < to_float(get_property("mpAutoRecovery"))) restore_mp(0);  

	if (have_effect($effect[Beaten Up]) > 0) abort("Script could not remove Beaten Up.");
	if (my_adventures() == 0) abort("No adventures left");
}

boolean buMax(string maxme, int maxMainstat) {
	print("BCC: Maximizing '"+maxme+"'", "blue");
	
	if (my_path() == "Way of the Suprising Fist") maxme += " -weapon -offhand";

	if (!in_hardcore()) {
		if (cli_execute("outfit bumcheekascend")) {}
		if (contains_text(maxme, "+outfit") && contains_text(maxme, "+equip")) {
			string [int] strs = split_string(maxme, "\\+");
			foreach i in strs {
				if (strs[i] != "") {
					//print(strs[i], "green");
					cli_execute(strs[i]);
				}
			}
			return true;
		}
		if (contains_text(maxme, "+outfit")) {
			cli_execute("outfit "+maxme.replace_string("+outfit ", ""));
			return true;
		}
		if (contains_text(maxme, "pirate fledges")) {
			cli_execute("equip acc3 pirate fledges");
			return true;
		}
		if (contains_text(maxme, "mega gem")) {
			cli_execute("equip acc3 mega gem");
			cli_execute("equip acc2 talisman o' nam");
			return true;
		}
		if (contains_text(maxme, "talisman")) {
			cli_execute("equip acc3 talisman o' nam");
			return true;
		}
		if (contains_text(maxme, "nuns")) {
			cli_execute("outfit "+bcasc_warOutfit);
			return true;
		}
		return true;
	}

	//We should sell these to avoid hassle when muscle classes.
	foreach i in $items[antique helmet, antique shield, antique greaves, antique spear] {
		autosell(item_amount(i), i);
	}

	//Just a quick check for this.
	if (contains_text(maxme, "continuum transfunctioner") && my_primestat() == $stat[Muscle]) {
		cli_execute("maximize "+max_bees+" beeosity, mainstat "+maxme+" +melee -ml"); 
		return true;
	}
	if (contains_text(maxme, "knob goblin elite") && !(my_path() == "Way of the Surprising Fist")) {
		if (my_basestat($stat[Muscle]) < 15) abort("You need 15 base muscle to equip the KGE outfit.");
		if (my_basestat($stat[Moxie]) < 15) abort("You need 15 base moxie to equip the KGE outfit.");
		cli_execute("maximize "+max_bees+" beeosity, mainstat "+maxme+" -ml"); 
		return true;
	}
	if (maxme.contains_text("item") && have_path_familiar($familiar[Mad Hatrack])) {
		maxme += " -equip spangly sombrero";
	}
	
	//Manual override for the nuns.
	if (maxme == "nuns") {
		cli_execute("maximize mainstat -10 ml +outfit "+bcasc_warOutfit);
		switch (my_primestat()) {
			case $stat[Muscle] : 		cli_execute("maximize 0.5 mp regen max, mainstat -10 ml +melee "+((anHero()) ? "+shield" : "")+" +outfit "+bcasc_warOutfit); break;
			case $stat[Mysticality] : 	cli_execute("maximize 0.5 mp regen max, mainstat -10 ml +outfit "+bcasc_warOutfit); break;
			case $stat[Moxie] : 		cli_execute("maximize 0.5 mp regen max, mainstat -10 ml -melee +outfit "+bcasc_warOutfit); break;
		}
		string sns = prepSNS();
		if (sns != "") {
			equip(to_item(sns.replace_string("+equip ", "")));
		}
		return true;
	}
	
	//Basically, we ALWAYS want and -ml, for ALL classes. Otherwise we let an override happen. 
	switch (my_primestat()) {
		case $stat[Muscle] : 		cli_execute("maximize "+max_bees+" beeosity, 0.5 mp regen max, mainstat "+maxMainstat+" max, "+maxme+" +melee "+((anHero()) ? "+shield" : "")+" -10 ml +muscle experience +5 mp regen min +5 mp regen max "); break;
		case $stat[Mysticality] : 	cli_execute("maximize "+max_bees+" beeosity, 0.5 mp regen max, mainstat "+maxMainstat+" max, "+maxme+" +10spell damage +5 mp regen min +5 mp regen max -10 ml +mysticality experience"); break;
		case $stat[Moxie] : 		cli_execute("maximize "+max_bees+" beeosity, 0.5 mp regen max, mainstat "+maxMainstat+" max, "+maxme+" -melee -10 ml +moxie experience +5 mp regen min +5 mp regen max "); break;
	}
	return true;
}
boolean buMax(string maxme) { return buMax(maxme, 999999999); }
boolean buMax() { return buMax(""); }

//This is just a glorified wrapper for adventure()
boolean bumMiniAdv2(int adventures, location loc, string override) {
	betweenBattle();
	if (override != "") {
		try {
			adventure(adventures, loc, override);
			boolean success = true;
		} finally {
			return success;
		}
	} else if (my_primestat() == $stat[Mysticality] && in_hardcore()) {
		try {
			adventure(adventures, loc, "consultMyst");
			boolean success = true;
		} finally {
			return success;
		}
	} else {
		try {
			adventure(adventures, loc);
			boolean success = true;
		} finally {
			return success;
		}
	}
}

boolean bumMiniAdvNoAbort(int adventures, location loc, string override) {
	if(!bumMiniAdv2(adventures, loc, override)) {
		//abort("BCC: You aborted, so so am I. This abort may have been caused by a rogue condition not being met. If this is unexpected, please paste the CLI output, as well as the results of typing 'condition check' without the quotes, into the mafia CLI window now.");
	}
	return true;
}
boolean bumMiniAdvNoAbort(int adventures, location loc) { return bumMiniAdvNoAbort(adventures, loc, ""); }

boolean bumMiniAdv(int adventures, location loc, string override) {
	if(!bumMiniAdv2(adventures, loc, override)) {
		abort("BCC: You aborted, so so am I. This abort may have been caused by a rogue condition not being met. If this is unexpected, please paste the CLI output, as well as the results of typing 'condition check' without the quotes, into the mafia CLI window now.");
	}
	return true;
}
boolean bumMiniAdv(int adventures, location loc) { return bumMiniAdv(adventures, loc, ""); }

string bumRunCombat(string consult) {
	//If we're not in a combat, we don't need to run this
	if (!contains_text(visit_url("fight.php"), "Combat")) {
		print("BCC: You aren't in a combat (or something to do with Ed which I can't work out), so bumRunCombat() doesn't need to do anything.", "purple");
		return to_string(run_combat());
	}
	
	if (consult != "") {
		print("BCC: This isn't actually adventuring at the noob cave. Don't worry! (Consult Script = "+consult+")", "purple");
		adv1($location[noob cave], -1, consult);
	}
	else if (my_primestat() == $stat[Mysticality] && in_hardcore()) {
		print("BCC: This isn't actually adventuring at the noob cave. Don't worry! (Myst)", "purple");
		adv1($location[noob cave], -1, "consultMyst");
	}
	else if (can_interact()) {
		print("BCC: This isn't actually adventuring at the noob cave. Don't worry. (Can_Interact() == True)", "purple");
		adv1($location[noob cave], -1, "consultCasual");
	}
	print("BCC: Run_Combat() being used normally.", "purple");
	return to_string(run_combat());
}
string bumRunCombat() { return bumRunCombat(""); }

boolean canMCD() {
	if (knoll_available() && item_amount($item[detuned radio]) == 0 && my_meat() < 300) return false;
	return ((knoll_available() || canadia_available()) || (gnomads_available() && (item_amount($item[bitchin' meatcar]) + item_amount($item[bus pass]) + item_amount($item[pumpkin carriage])) > 0));
}

boolean canZap() {
	int wandnum = 0;
	if (item_amount($item[dead mimic]) > 0) use(1, $item[dead mimic]);
	for wand from  1268 to 1272 {
		if (item_amount(to_item(wand)) > 0) {
			wandnum = wand;
		}
	}
	if (wandnum == 0) { return false; }
	return (!(contains_text(visit_url("wand.php?whichwand="+wandnum), "warm") || contains_text(visit_url("wand.php?whichwand="+wandnum), "careful")));
}

//Returns true if we've completed this stage of the script. 
boolean checkStage(string what, boolean setAsWell) {
	if (setAsWell) {
		print("BCC: We have completed the stage ["+what+"] and need to set it as so.", "navy");
		set_property("bcasc_stage_"+what, my_ascensions());
	}
	if (get_property("bcasc_stage_"+what) == my_ascensions()) {
		print("BCC: We have completed the stage ["+what+"].", "navy");
		return true;
	}
	print("BCC: We have not completed the stage ["+what+"].", "navy");
	return false;
}
boolean checkStage(string what) { return checkStage(what, false); }

int cloversAvailable(boolean makeOneTenLeafClover) {
	if (bcasc_cloverless) {
		if (item_amount($item[ten-leaf clover]) > 0 && my_path() != "Bees Hate You")
			use(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		else if(item_amount($item[ten-leaf clover]) > 0)
			put_closet(item_amount($item[ten-leaf clover]), $item[ten-leaf clover]);
		print("BCC: You have the option for a cloverless ascention turned on, so we won't be using them.", "purple");
		return 0;
	}
	
	if (get_property("bcasc_lastHermitCloverGet") != today_to_string()) {
		print("BCC: Getting Clovers", "purple");
		while (hermit(1, $item[Ten-leaf clover])) {}
		set_property("bcasc_lastHermitCloverGet", today_to_string());
	} else {
		print("BCC: We've already got Clovers Today", "purple");
	}
	
	if (my_path() != "Bees Hate You") {
		if (makeOneTenLeafClover && (item_amount($item[ten-leaf clover]) + item_amount($item[disassembled clover])) > 0) {
			print("BCC: We're going to end up with one and exactly one ten leaf clover", "purple");
			if (item_amount($item[ten-leaf clover]) > 0) {
				cli_execute("use * ten-leaf clover; use 1 disassembled clover;");
			} else {
				cli_execute("use 1 disassembled clover;");
			}
		}
	} else {
		if (makeOneTenLeafClover && (item_amount($item[ten-leaf clover]) + closet_amount($item[ten-leaf clover])) > 0) {
			print("BCC: We're going to end up with one and exactly one ten leaf clover", "purple");
			if (item_amount($item[ten-leaf clover]) > 0) {
				put_closet(item_amount($item[ten-leaf clover]) - 1, $item[ten-leaf clover]);
			} else {
				take_closet(1,$item[ten-leaf clover]);
			}
		}		
	}
	
	return (my_path() == "Bees Hate You") ? item_amount($item[ten-leaf clover]) + closet_amount($item[ten-leaf clover]) : item_amount($item[ten-leaf clover]) + item_amount($item[disassembled clover]);
}
int cloversAvailable() { return cloversAvailable(false); }

//Has to be before the other consult functions, as they call it some of the time. 
string consultMyst(int round, string opp, string text) {
	if (get_property("bcasc_doMystAsCCS") != "false") return get_ccs_action(round);
	
	if (opp == "rampaging adding machine") {
		print("The script will not, at the moment, automatically fight rampagaing adding machines. Please fight manually.");
		return "abort";
	}
	
	//Override for olfaction. 
	if (contains_text(get_ccs_action(round), "olfact")) {
		if (contains_text(text, ">Transcendent Olfaction (")) {
			return "skill Transcendent Olfaction";
		}
	}

	boolean [skill] allMySkills() {
		boolean [skill] allmyskills;
		
		foreach s in $skills[Spaghetti Spear, Ravioli Shurikens, Cannelloni Cannon, Stuffed Mortar Shell, Weapon of the Pastalord, Fearful Fettucini,
			Salsaball, Stream of Sauce, Saucestorm, Wave of Sauce, Saucegeyser, K&auml;seso&szlig;esturm, Surge of Icing] {
			if (have_skill(s)) { allmyskills[s] = true; }
		}
		return allmyskills;
	}
	
	//Returns the element of the cookbook we have on, if we have one. 
	element cookbook(boolean isPasta) {
		//These two work for all classes spells.
		if (equipped_amount($item[Gazpacho's Glacial Grimoire]) > 0) return $element[cold];
		if (equipped_amount($item[Codex of Capsaicin Conjuration]) > 0) return $element[hot];
		if (!isPasta) return $element[none];
		//Else the following three work for only pasta spells.
		if (equipped_amount($item[Cookbook of the Damned]) > 0) return $element[stench];
		if (equipped_amount($item[Necrotelicomnicon]) > 0) return $element[spooky];
		if (equipped_amount($item[Sinful Desires]) > 0) return $element[sleaze];
		return $element[none];
	}
	
	element elOfSpirit(effect e) {
		switch (e) {
			case $effect[Spirit of Cayenne]: return $element[hot];
			case $effect[Spirit of Peppermint]: return $element[cold];
			case $effect[Spirit of Garlic]: return $element[stench];
			case $effect[Spirit of Wormwood]: return $element[spooky];
			case $effect[Spirit of Bacon Grease]: return $element[sleaze];
		}
		return $element[none];
	}
	
	//This estimates monster HP if necessary.
	int monsterHP() {
		if (monster_hp(to_monster(opp)) > 0) {
			return monster_hp();
		}
		
		print("BCC: This script is estimating this ("+to_string(opp)+") monster's HP as "+monster_attack()+" "+monster_hp()+".", "purple");
		
		return monster_attack() - monster_hp();
	}
	
	//Checks if the monster we're fighting is weak against element e. For sauce spells, if called directly. 
	int isWeak(element e) {
		boolean [element] weakElements;
 
		switch (monster_element()) {
		   case $element[cold]:   weakElements = $elements[spooky, hot];    break;
		   case $element[spooky]: weakElements = $elements[hot, stench];    break;
		   case $element[hot]:    weakElements = $elements[stench, sleaze]; break;
		   case $element[stench]: weakElements = $elements[sleaze, cold];   break;
		   case $element[sleaze]: weakElements = $elements[cold, spooky];   break;
		   default: return 1;
		}
		
		if (weakElements contains e) {
			print("BCC: Weak Element to our pasta tuning.", "olive");
			return 2;
		} else if (monster_element() == e) {
			print("BCC: Strong Element to our pasta tuning.", "olive");
			return 0.01;
		} else {
			print("BCC: Neutral Element to our pasta tuning.", "olive");
			return 1;
		}
		return 1;
	}
	//Checks if the monster we're fighting is weak against the Flavor of Magic element. For pasta spells. 
	int isWeak() {
		foreach e in $effects[Spirit of Cayenne, Spirit of Peppermint, Spirit of Garlic, Spirit of Wormwood, Spirit of Bacon Grease] {
			if (have_effect(e) > 0) {
				print("BCC: We are under the effect of "+to_string(e), "olive");
				return isWeak(elOfSpirit(e));
			}
		}
		return 1;
	}
	//Checks if the monster is weak against whatever Sauce element would be appropriate. The actual string is ignored.
	int isWeak(string ignored) {
		if (have_skill($skill[Immaculate Seasoning])) {
			if ($elements[spooky, stench, sleaze, cold] contains monster_element()) return 2;
		}
		return isWeak($element[none]);
	}
	
	//Returns which skill has the lowest MP in a given range of skills. 
	skill lowestMP(boolean [skill] ss) {
		int lowestMPCostSoFar = 999999;
		skill skillToReturn = $skill[none];
		
		foreach s in ss {
			if (mp_cost(s) < lowestMPCostSoFar) {
				lowestMPCostSoFar = mp_cost(s);
				skillToReturn = s;
			}
		}
		return skillToReturn;
	}
	
	float wtfpwnageExpected(skill s) {
		float bAbs = numeric_modifier("Spell Damage");
		float bPer = numeric_modifier("Spell Damage Percent")/100 + 1;
		//Should multiply the bonuses below by bonus spell damage. 
		float bCol = numeric_modifier("Cold Spell Damage");
		float bHot = numeric_modifier("Hot Spell Damage");
		float bSte = numeric_modifier("Stench Spell Damage");
		float bSle = numeric_modifier("Sleaze Spell Damage");
		float bSpo = numeric_modifier("Spooky Spell Damage");
		float bElm = bCol+bHot+bSte+bSle+bSpo;
		float myst = my_buffedstat($stat[Mysticality]);
		print("BCC: These are the figures for "+to_string(s)+": Bonus: "+bAbs+" and "+bPer+"%//"+bCol+"/"+bHot+"/"+bSte+"/"+bSle+"/"+bSPo+"/El: "+bElm+"/Myst: "+myst, "purple");
		
		//Uses the above three functions to estimate the wtfpwnage from a given skill. 
		switch (s) {
			case $skill[Spaghetti Spear] :
				return (2.5*bPer + min(5, bAbs))*isWeak();
			case $skill[Ravioli Shurikens] :
				return (5.5*bPer + 0.07*myst*bPer + min(25, bAbs) + bElm)*isWeak();
			case $skill[Cannelloni Cannon] :
				return (12*bPer + 0.15*myst*bPer + min(40, bAbs) + bElm)*isWeak();
			case $skill[Stuffed Mortar Shell] :
				return (40*bPer + 0.35*myst*bPer + min(55, bAbs) + bElm)*isWeak();
			case $skill[Weapon of the Pastalord] :
				float weak = isWeak();
				if (weak == 2) weak = 1.5;
				return (48*bPer + 0.35*myst*bPer + bAbs + bElm)*weak;
			case $skill[Fearful Fettucini] :
				return (48*bPer + 0.35*myst*bPer + bAbs + bElm)*isWeak($element[spooky]);
			case $skill[Salsaball] :
				return (2.5*bPer + min(5, bAbs))*isWeak($element[hot]);
			case $skill[Stream of Sauce] :
				return (3.5*bPer + 0.10*myst*bPer + min(10, bAbs) + bElm)*isWeak("");
			case $skill[Saucestorm] :
				return (16*bPer + 0.20*myst*bPer + min(15, bAbs) + bElm)*isWeak("");
			case $skill[Wave of Sauce] :
				return (22*bPer + 0.30*myst*bPer + min(25, bAbs) + bElm)*isWeak("");
			case $skill[Saucegeyser] :
				return (40*bPer + 0.35*myst*bPer + min(10, bAbs) + bElm)*isWeak("");
			case $skill[K&auml;seso&szlig;esturm] :
				return (16*bPer + 0.20*myst*bPer + min(15, bAbs) + bElm)*isWeak($element[stench]);
			case $skill[Surge of Icing] :
				//Sugar Rush has an effect on this skill. 
				return (16*bPer + 0.20*myst*bPer + min(15, bAbs) + bElm);
			default:
				return 0;
		}
		return -1;
	}

	int hp = monsterHP();
	print("BCC: Monster HP is "+hp, "purple");
	int isWeak = isWeak();
	int wtfpwn;
	int mostDamage;
	skill bestSkill;
	boolean [skill] oneShot;
	boolean [skill] twoShot;
	boolean [skill] threeShot;
	boolean [skill] fourShot;
	boolean oneShotHim = true;
	string cast;
	
	foreach s in allMySkills() {
		wtfpwn = wtfpwnageExpected(s);
		
		if (wtfpwn > mostDamage) {
			bestSkill = s;
		}
		
		print("BCC: I expect "+wtfpwn+" damage from "+to_string(s), "purple");
		if (wtfpwn > hp) {
			//Then we can one-shot the monster with this skill.
			oneShot[s] = true;
		} else if (wtfpwn > hp/2) {
			twoShot[s] = true;
		} else if (wtfpwn > hp/3) {
			threeShot[s] = true;
		}else if (wtfpwn > hp/5) {
			fourShot[s] = true;
		}
	}
	
	//If we're fighting the NS, then it's best skill, ALL THE TIME.
	if (contains_text(text, "Naughty Sorceress")) {
		print("BCC: This is the Naughty Sorceress you're fighting here. SPELL ALL THE THINGS!", "purple");
		if (contains_text(text, ">Entangling Noodles (")) {
			return "skill Entangling Noodles";
		}
		return "skill "+to_string(bestSkill);
	}
	
	//If we can one-shot AND noodles/twoshot isn't cheaper, do that. 
	if (count(oneShot) > 0) {
		if (have_skill($skill[Entangling Noodles])) {
			if (count(twoShot) > 0) {
				int mpOneShot = mp_cost(lowestMP(oneShot));
				int mpTwoShot = mp_cost(lowestMP(twoShot));
				if (mpOneShot > 3+2*mpTwoShot) {
					print("BCC: We're actually NOT going to one-shot because noodles and then two shotting would be cheaper.", "purple");
					oneShotHim = false;
				}
			}
		}
	}
	
	if (oneShotHim && count(oneShot) > 0) {
		cast = to_string(lowestMP(oneShot));
		print("BCC: We are going to one-shot with "+cast, "purple");
		return "skill "+cast;
	} else {
		//Basically, we should cast noodles if we haven't already done this, and we're not going to one-shot the monster. 
		if (contains_text(text, ">Entangling Noodles (")) {
			return "skill Entangling Noodles";
		}
		if (count(twoShot) > 0) {
			cast = to_string(lowestMP(twoShot));
			print("BCC: We are going to two-shot with "+cast, "purple");
			return "skill "+cast;
		}
		if (count(threeShot) > 0) {
			cast = to_string(lowestMP(threeShot));
			print("BCC: We are going to three-shot with "+cast, "purple");
			return "skill "+cast;
		}
		if (count(fourShot) > 0) {
			cast = to_string(lowestMP(fourShot));
			print("BCC: We are going to three-shot with "+cast, "purple");
			return "skill "+cast;
		}
	}
	print("Please fight the remainder of the fight yourself. You will be seeing this because you do not have a spell powerful enough to even four-shot the monster.", "red");
	return "abort";
}

string consultBarrr(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	if (round == 1) {
		if (my_path() == "Bees Hate You") return "item Massive Manual of Marauder Mockery";
		return "item the big book of pirate insults";
	}
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultCasual(int round, string opp, string text) {
	print("BCC: Round: "+round+" Opp: "+opp, "purple");

	if (get_property("bcasc_doCasualAsHC") != "false") {
		print("BCC: You have selected to do casual runs like hardcore (using your CCS). Feel free to change this setting in the relay browser if you want a one-day-casual set of runaways..", "purple");
		return get_ccs_action(round);
	} else {
		print("BCC: You do not have the option set to do casual runs as Hardcore. This means the script will attempt to use the default action specified in your bcasc_defaultCasualAction setting. The current setting is designed for a one-day casual. To make this all go away, set bcasc_doCasualAsHC to true in the relay script.", "purple");
	}
	
	boolean bookThisMonster() {
		return $strings[tetchy pirate, toothy pirate, tipsy pirate] contains opp;
	}

	boolean fightThisMonster() {
		if (opp == "cleanly pirate" && item_amount($item[rigging shampoo]) == 0) return true;
		if (opp == "creamy pirate" && item_amount($item[ball polish]) == 0) return true;
		if (opp == "curmudgeonly pirate" && item_amount($item[mizzenmast mop]) == 0) return true;
	
		return $strings[Ed the Undying, ancient protector spirit, protector spirit, gaudy pirate, modern zmobie, conjoined zmombie, gargantulihc, huge ghuol, giant skeelton, 
			dirty old lihc, swarm of ghuol whelps, big swarm of ghuol whelps, giant swarm of ghuol whelps, The Bonerdagon, The Boss Bat, booty crab,
			black panther, black adder, Dr. Awkward, Lord Spookyraven, Protector Spectre, lobsterfrogman, The Knob Goblin King] contains opp;
	}
	
	boolean olfactThisMonster() {
		if (opp == "cleanly pirate" && item_amount($item[ball polish]) == 1 && item_amount($item[mizzenmast mop]) == 1) return true;
		if (opp == "creamy pirate" && item_amount($item[mizzenmast mop]) == 1 && item_amount($item[rigging shampoo]) == 1) return true;
		if (opp == "curmudgeonly pirate" && item_amount($item[ball polish]) == 1 && item_amount($item[rigging shampoo]) == 1) return true;
		
		return $strings[dirty old lihc] contains opp;
	}
	
	boolean pickpocketThisMonster() {
		return $strings[spiny skelelton, toothy sklelton] contains opp;
	}	

	//Pickpocket a certain whitelist of monsters, else those monsters with no item drops cause issues.
	if (contains_text(text, "type=submit value=\"Pick") && pickpocketThisMonster()) {
		print("BCC: Yoink!", "purple");
		return "pickpocket";
	}
		
	//If we have RBF, we may as well use them. 
	if (item_amount($item[rock band flyers]) > 0) {
		if (contains_text(text, ">Entangling Noodles (")) {
			print("BCC: Noodle pre-flyer", "purple");
			return "skill Entangling Noodles";
		}
		print("BCC: Use Flyers", "purple");
		return "item rock band flyers";
	}
		
	//If we have RBF, we may as well use them. 
	if (item_amount($item[big book of pirate insults]) > 0 && bookThisMonster() && round == 0) {
		print("BCC: Use the Big Book of Pirate Insults", "purple");
		return "item Big Book of Pirate Insults";
	}
		
	//Monsters to simply attack
	//print(opp);
	if (fightThisMonster()) {
		print("BCC: One of the few monsters we're going to attack.", "purple");
		if (round == 2) {
			print("BCC: Special Action", "purple");
			return "special action";
		}
		
		if (olfactThisMonster()) {
			if (have_effect($effect[on the trail]) == 0 && my_mp() >= 40 && contains_text(text, "Olfaction (")) {
				print("BCC: And olfact. Gotta get me some of that sweet monster smell...", "purple");
				return "skill olfaction";
			}
		}
		
		print("BCC: Attack", "purple");
		return "attack with weapon";
	}
	
	//Special Case 
	if ($strings[rampaging adding machine] contains opp) {
		if (have_skill($skill[Ambidextrous Funkslinging])) {
			if (item_amount($item[64735 scroll]) == 0) {
				if (item_amount($item[64067 scroll]) > 0 && item_amount($item[668 scroll]) > 0) {
					return "item 64067 scroll, 668 scroll";
				}
				
				if (item_amount($item[64067 scroll]) == 0) {
					return "item 30669 scroll, 33398 scroll";
				}
				
				if (item_amount($item[668 scroll]) == 0) {
					return "item 334 scroll, 334 scroll";
				}
			}
		} else {
			print("BCC: Fight this one yourself.", "purple");
			return "abort";
		}
	}
	
	get_ccs_action(round);
	if (get_property("bcasc_defaultCasualAction") != "") return get_property("bcasc_defaultCasualAction");
	
	print("BCC: Attacking is the default action for casual runs. Change bcasc_defaultCasualAction in the relay script if you want something else.", "purple");
	return "attack";
}

string consultCyrus(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	if (round == 1) {
		if (bcasc_doWarAs == "frat") {
			return "item rock band flyers";
		} else {
			return "item jam band flyers";
		}
	}
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

//This consult script is just to be used to sling !potions against 
string consultDoD(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	foreach pot, eff in allBangPotions() {
		if (item_amount(pot) > 0) {
			if (eff == $effect[none]) return "item "+pot;
			print("BCC: We've identified "+pot+" already.", "purple");
		}
	}
	print("BCC: We've identified all the bang potions we have to hand.", "purple");
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultGMOB(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	if (contains_text(text, "Guy Made Of Bees")) {
		print("BCC: We are fighting the GMOB!", "purple");
		if (bcasc_doWarAs == "frat") {
			if(item_amount(to_item("antique hand mirror")) == 0)
				return "item rock band flyers";
			else
				return "item rock band flyers;item antique hand mirror";
		} else {
			if(item_amount(to_item("antique hand mirror")) == 0)
				return "item jam band flyers";
			else
				return "item jam band flyers;item antique hand mirror";
		}
	}
	print("BCC: We are not fighting the GMOB!", "purple");
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultHeBo(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality]) ? consultMyst(round, opp, text) : get_ccs_action(round));
	//If we're under the effect "Everything Looks Yellow", then ignore everything and attack.
	if (have_effect($effect[Everything Looks Yellow]) > 0) {
		print("BCC: We would LIKE to use a Yellow Ray somewhere in this zone, but we can't because Everything Looks Yellow.", "purple");
		return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
	}

	boolean isGremlin = contains_text(text, "A.M.C. gremlin") || contains_text(text, "batwinged gremlin") || contains_text(text, "erudite gremlin") || contains_text(text, "spider gremlin") || contains_text(text, "vegetable gremlin");
	
	//Let's check that the monster IS the correct one
	if (contains_text(text, "y hippy") || contains_text(text, "War Hippy") || contains_text(text, "Foot Dwarf") || contains_text(text, "bobrace.gif") || contains_text(text, "Frat Warrior") || contains_text(text, "War Pledge") || isGremlin) {
		if (my_path() == "Bees Hate You") {
			print("BCC: We are trying to use the HeBoulder, but you can't use it (nor a pumpkin bomb or a light) due to bees hating you, so I'm attacking.", "purple");
			return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
		}
		
		if (my_familiar() == $familiar[He-Boulder]) {
			print("BCC: We are using the hebo against the right monster.", "purple");
			if (contains_text(text, "yellow eye")) {
				return "skill point at your opponent";
			} else {
				switch (my_class()) {
					case $class[turtle tamer] : return "skill toss";
					case $class[seal clubber] : return "skill clobber";
					case $class[pastamancer] : return "skill Spaghetti Spear";
					case $class[sauceror] : return "skill salsaball";
					case $class[Disco Bandit] : return "skill suckerpunch";
					case $class[Accordion Thief] : return "skill sing";
					default: abort("unsupported class");
				}
			}
		} else if (item_amount($item[unbearable light]) > 0) {
			print("BCC: We are trying to use the HeBoulder, but you don't have one (or perhaps are on a 100% run), so I'm using an unbearable light.", "purple");
			return "item unbearable light";
		} else if (item_amount($item[pumpkin bomb]) > 0) {
			print("BCC: We are trying to use the HeBoulder, but you don't have one (or perhaps are on a 100% run), so I'm using a pumpkin bomb.", "purple");
			return "item pumpkin bomb";
		} else {
			print("BCC: We are trying to use the HeBoulder, but you don't have one (or perhaps are on a 100% run without pumpkins or clipart), so I'm attacking.", "purple");
			return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
		}
	}
	print("BCC: We are trying to use the HeBoulder, but this is not the right monster, so I'm attacking.", "purple");
	
	if (my_familiar() == $familiar[He-Boulder] && have_effect($effect[Everything Looks Red]) == 0 && contains_text(text, "red eye"))
		return "skill point at your opponent";
	
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultJunkyard(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	boolean isRightMonster = false;
	
	//AMC Gremlins are useless. 
	if (opp == $monster[a.m.c. gremlin]) {
		if (item_amount($item[divine champagne popper]) > 0) return "item divine champagne popper";
		return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
	} else {
		//Check to see if the monster CAN carry the item we want. This comes straight from Zarqon's SmartStasis.ash. 
		if (my_location() == to_location(get_property("currentJunkyardLocation"))) {
			print("BCC: Right location.", "purple");
			isRightMonster = (item_drops() contains to_item(get_property("currentJunkyardTool")));
		} else {
			print("BCC: Wrong location.", "purple");
			isRightMonster = (!(item_drops() contains to_item(get_property("currentJunkyardTool"))));
		}
	}
	
	if (isRightMonster) {
		print("BCC: We have found the correct monster, so will stasis until the item drop occurrs.", "purple");
		if (contains_text(text, "It whips out a hammer") || contains_text(text, "He whips out a crescent") || contains_text(text, "It whips out a pair") || contains_text(text, "It whips out a screwdriver")) {
			print("BCC: The script is trying to use the moly magnet. This may be the cause of the NULL errors here.", "purple");
			return "item molybdenum magnet";
		} else {
			if (my_hp() < 50) {
				//print("BCC: Let's cast bandages to heal you.", "purple");
				return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
				//For some reason, this doesn't work at all and I can't work out why. 
				return "skill lasagna bandages";
			} else {
				switch (my_class()) {
					case $class[turtle tamer] : return "skill toss";
					case $class[seal clubber] : return "skill clobber";
					case $class[Pastamancer] : return "skill Spaghetti Spear";
					case $class[Sauceror] : return "skill Salsaball";
					case $class[Disco Bandit] : return "skill suckerpunch";
					case $class[Accordion Thief] : return "skill sing";
				}
				if (i_a("seal tooth") > 0) return "item seal tooth";
				if (i_a("facsimile dictionary") > 0) return "item facsimile dictionary";
				if (i_a("spectre scepter") > 0) return "item spectre scepter";
			}
		}
	} else {
		print("BCC: This is the wrong monster.", "purple");
	}
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultLFM(int round, string opp, string text) {
	print("BCC: Consulting for LFM.", "purple");
	if (my_familiar() == $familiar[Obtuse Angel]) {
		print("BCC: Obtuse Angel detected.", "purple");
		if (contains_text(text, "romantic arrow (")) {
			print("BCC: Romantic Arrow Detected.", "purple");
			return "skill fire a badly romantic arrow";
		}
		return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
	}
	return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round)); 
}

string consultRunaway(int round, string opp, string text) {
	if (!isExpectedMonster(opp)) return ((my_primestat() == $stat[Mysticality] && in_hardcore()) ? consultMyst(round, opp, text) : get_ccs_action(round));
	if (round == 1 && have_skill($skill[Entangling Noodles])) { return "skill entangling noodles"; }
	return "try to run away";
}

void defaultMood(boolean castMojo) {
	//Save time in casual runs. 
	if (can_interact()) return;
	//if (my_path() == "Way of the Surprising Fist") return;
	cli_execute("mood bumcheekascend");
	cli_execute("mood clear");
	cli_execute("trigger gain_effect, just the best anapests, uneffect just the best anapests");
	switch (my_primestat()) {
		case $stat[Muscle] :
			if(my_path() != "way of the surprising fist") {
				if (my_level() > 5 && my_path() != "Bees Hate You") { cli_execute("trigger lose_effect, Tiger!, use 5 Ben-Gal Balm"); }
				if (my_level() < 7 && castMojo && have_skill($skill[The Magical Mojomuscular Melody])) cli_execute("trigger lose_effect, The Magical Mojomuscular Melody, cast 1 The Magical Mojomuscular Melody");
				if (anHero()) {
					if (have_skill($skill[The Power Ballad of the Arrowsmith])) cli_execute("trigger lose_effect, Power Ballad of the Arrowsmith, cast 1 The Power Ballad of the Arrowsmith");
				} else {
					if (have_skill($skill[The Moxious Madrigal])) cli_execute("trigger lose_effect, The Moxious Madrigal, cast 1 The Moxious Madrigal");
				}
				if (have_skill($skill[Patience of the Tortoise])) cli_execute("trigger lose_effect, Patience of the Tortoise, cast 1 Patience of the Tortoise");
				if (have_skill($skill[Seal Clubbing Frenzy])) cli_execute("trigger lose_effect, Seal Clubbing Frenzy, cast 1 Seal Clubbing Frenzy");
				if (my_level() > 9 && have_skill($skill[Rage of the Reindeer])) cli_execute("trigger lose_effect, Rage of the Reindeer, cast 1 Rage of the Reindeer");
 			} else {
				if (my_level() < 7 && castMojo && have_skill($skill[The Magical Mojomuscular Melody])) cli_execute("trigger lose_effect, The Magical Mojomuscular Melody, cast 1 The Magical Mojomuscular Melody");
				if (have_skill($skill[Patience of the Tortoise])) cli_execute("trigger lose_effect, Patience of the Tortoise, cast 1 Patience of the Tortoise");
				if (have_skill($skill[Seal Clubbing Frenzy])) cli_execute("trigger lose_effect, Seal Clubbing Frenzy, cast 1 Seal Clubbing Frenzy");
				if (my_level() > 9 && have_skill($skill[Rage of the Reindeer])) cli_execute("trigger lose_effect, Rage of the Reindeer, cast 1 Rage of the Reindeer");				
				if (have_skill($skill[Miyagi Massage])) cli_execute("trigger lose_effect, Retrograde Relaxation, cast 1 Miyagi Massage");
				if (have_skill($skill[Salamander Kata])) cli_execute("trigger lose_effect, Salamanderenity, cast 1 Salamander Kata");
			}			
		break;
		
		case $stat[Mysticality] :
			if (my_level() > 5 && my_meat() > 2000) { cli_execute("trigger lose_effect, Butt-Rock Hair, use 5 hair spray"); }
			//if (my_level() > 5 && my_meat() > 2000) { cli_execute("trigger lose_effect, Glittering Eyelashes, use 5 glittery mascara"); }
			if ((my_level() < 7 && castMojo && have_skill($skill[The Moxious Madrigal])) || my_meat() < 2000) cli_execute("trigger lose_effect, The Moxious Madrigal, cast 1 The Moxious Madrigal");
 			if (my_level() < 7  && have_skill($skill[Springy Fusilli])) cli_execute("trigger lose_effect, Springy Fusilli, cast 1 Springy Fusilli");
			if (have_skill($skill[The Magical Mojomuscular Melody]) && my_maxmp() < 200) cli_execute("trigger lose_effect, The Magical Mojomuscular Melody, cast 1 The Magical Mojomuscular Melody");
			if (have_skill($skill[Manicotti Meditation]) && my_level() < 5) cli_execute("trigger lose_effect, Pasta Oneness, cast 1 Manicotti Meditation");
			if (have_skill($skill[Sauce Contemplation]) && my_level() < 5) cli_execute("trigger lose_effect, Saucemastery, cast 1 Sauce Contemplation");
 			if (have_skill($skill[Moxie of the Mariachi])) cli_execute("trigger lose_effect, Mariachi Mood, cast 1 Moxie of the Mariachi");
 			if (have_skill($skill[Disco Aerobics])) cli_execute("trigger lose_effect, Disco State of Mind, cast 1 Disco Aerobics");
			if ((i_a("5-alarm saucepan") + i_a("17-alarm saucepan") > 0) && have_skill($skill[Jaba&ntilde;ero Saucesphere]) && my_class() == $class[sauceror]) cli_execute("trigger lose_effect, Jaba&ntilde;ero Saucesphere, cast 1 Jaba&ntilde;ero Saucesphere");
			if ((i_a("5-alarm saucepan") + i_a("17-alarm saucepan") > 0) && have_skill($skill[Jalape&ntilde;o Saucesphere]) && my_class() == $class[sauceror]) cli_execute("trigger lose_effect, Jalape&ntilde;o Saucesphere, cast 1 Jalape&ntilde;o Saucesphere");
			if (have_skill($skill[Flavour of magic])) cli_execute("trigger lose_effect, Spirit of Peppermint, cast 1 Spirit of Peppermint");
			if (have_skill($skill[Springy Fusilli]) && my_class() == $class[Pastamancer]) cli_execute("trigger lose_effect, Springy Fusilli, cast 1 Springy Fusilli");
		break;
		
		case $stat[Moxie] :
			if(my_path() != "way of the surprising fist") {
				if (my_level() > 5) { cli_execute("trigger lose_effect, Butt-Rock Hair, use 5 hair spray"); }
				if (have_skill($skill[The Moxious Madrigal])) cli_execute("trigger lose_effect, The Moxious Madrigal, cast 1 The Moxious Madrigal");
				if (my_level() < 7 && castMojo && have_skill($skill[The Magical Mojomuscular Melody])) cli_execute("trigger lose_effect, The Magical Mojomuscular Melody, cast 1 The Magical Mojomuscular Melody");
				if (have_skill($skill[Moxie of the Mariachi])) cli_execute("trigger lose_effect, Mariachi Mood, cast 1 Moxie of the Mariachi");
				if (have_skill($skill[Disco Aerobics])) cli_execute("trigger lose_effect, Disco State of Mind, cast 1 Disco Aerobics");
			} else {
				if (have_skill($skill[The Moxious Madrigal])) cli_execute("trigger lose_effect, The Moxious Madrigal, cast 1 The Moxious Madrigal");
				if (my_level() < 7 && castMojo && have_skill($skill[The Magical Mojomuscular Melody])) cli_execute("trigger lose_effect, The Magical Mojomuscular Melody, cast 1 The Magical Mojomuscular Melody");
				if (have_skill($skill[Moxie of the Mariachi])) cli_execute("trigger lose_effect, Mariachi Mood, cast 1 Moxie of the Mariachi");
				if (have_skill($skill[Disco Aerobics])) cli_execute("trigger lose_effect, Disco State of Mind, cast 1 Disco Aerobics");
				if (have_skill($skill[Miyagi Massage])) cli_execute("trigger lose_effect, Retrograde Relaxation, cast 1 Miyagi Massage");
				if (have_skill($skill[Salamander Kata])) cli_execute("trigger lose_effect, Salamanderenity, cast 1 Salamander Kata");
			}
		break;
	}
}
void defaultMood() { defaultMood(true); }

//Thanks, picklish!
boolean faxMeA(monster mon) {
	// Time to wait for FaxBot in seconds.
    int wait_time = 60;
    // Number of tries to repeat before failing.
    int faxbot_tries = 3;

    // Return the text to search for in the photocopied monster item
    // description to verify that this fax has the right monster. Most of the
    // time this is just to_string(monster), but there are special cases due to
    // KoLmafia's naming scheme.
    string photocopy_text(monster mon) {
        switch (mon) {
            case $monster[Knight (snake)]: return "knight";
            case $monster[Somebody Else's Butt]: return "butt";
            case $monster[Slime1]: return "slime";
            case $monster[Slime2]: return "slime";
            case $monster[Slime3]: return "slime";
            case $monster[Slime4]: return "slime";
            case $monster[Slime5]: return "slime";
            case $monster[Some Bad ASCII Art]: return "bad ASCII art";
        }

        return mon;
    }

    // Return true if you have a fax and it contains this monster.
    boolean check_fax(monster mon) {
        if (item_amount($item[photocopied monster]) == 0)
            return false;

        string fax = visit_url("desc_item.php?whichitem=835898159");
        if (!contains_text(fax, "This is a sheet of copier paper"))
            return false;
        if (contains_text(fax, "grainy, blurry likeness of a monster on it."))
            return false;

        return contains_text(to_lower_case(fax), to_lower_case(photocopy_text(mon)));
    }

    // Returns true if we were able to get a fax into the inventory.
    boolean get_fax() {
        if (item_amount($item[photocopied monster]) != 0)
            return true;
        cli_execute("fax get");
        return item_amount($item[photocopied monster]) != 0;
    }

    // Returns true if we were able to remove all faxes from the inventory.
    boolean put_fax() {
        if (item_amount($item[photocopied monster]) == 0)
            return true;
        cli_execute("fax put");
        return item_amount($item[photocopied monster]) == 0;
    }

    // Return the request string that FaxBot expects for a given monster.
    // See: http://kolspading.com/forums/viewtopic.php?f=13&t=169
    string faxbot_name(monster mon) {
        switch (mon) {
            case $monster[Blooper]: return "blooper";
            case $monster[Knob Goblin Elite Guard Captain]: return "kge";
            case $monster[Lobsterfrogman]: return "lobsterfrogman";
            case $monster[Rampaging Adding Machine]: return "adding_machine";
            case $monster[Sleepy Mariachi]: return "sleepy_mariachi";
            case $monster[Some Bad ASCII Art]: return "ascii";
            case $monster[7-Foot Dwarf]: return "miner";
            case $monster[Alphabet Giant]: return "alphabet";
            case $monster[Angels of Avalon]: return "avalon";
            case $monster[Astronomer]: return "astronomer";
            case $monster[Batwinged Gremlin]: return "batwinged";
            case $monster[Blur]: return "blur";
            case $monster[Bob Racecar]: return "bob";
            case $monster[Booze Giant]: return "booze";
            case $monster[Brainsweeper]: return "brainsweeper";
            case $monster[Cleanly Pirate]: return "cleanly";
            case $monster[Creamy Pirate]: return "creamy";
            case $monster[Curmudgeonly Pirate]: return "curmudgeonly";
            case $monster[Dairy Goat]: return "dairy_goat";
            case $monster[Dirty Thieving Brigand]: return "brigand";
            case $monster[Erudite Gremlin]: return "erudite";
            case $monster[Furry Giant]: return "furry";
            case $monster[Gang of Hobo Muggers]: return "muggers";
            case $monster[Gaudy Pirate]: return "gaudy";
            case $monster[Ghost]: return "ghost";
            case $monster[Gnollish Crossdresser]: return "crossdresser";
            case $monster[Gnollish Gearhead]: return "gearhead";
            case $monster[Gnollish Tirejuggler]: return "tirejuggler";
            case $monster[Goth Giant]: return "goth";
            case $monster[Harem Girl]: return "harem_girl";
            case $monster[Hellion]: return "hellion";
            case $monster[Jilted Mistress]: return "jilted";
            case $monster[Knight (snake)]: return "knight";
            case $monster[Lemon-in-the-Box]: return "lemonbox";
            case $monster[Ninja Snowman Janitor]: return "janitor";
            case $monster[Peeved Roommate]: return "hipster";
            case $monster[Quantum Mechanic]: return "mechanic";
            case $monster[Quiet Healer]: return "healer";
            case $monster[Raver Giant]: return "raver";
            case $monster[Screambat]: return "screambat";
            case $monster[Shaky Clown]: return "shaky";
            case $monster[Skeletal Sommelier]: return "wine";
            case $monster[Skinflute]: return "skinflute";
            case $monster[Spider Gremlin]: return "spider_gremlin";
            case $monster[Swarm of Scarab Beatles]: return "beatles";
            case $monster[Tomb Rat]: return "tomb_rat";
            case $monster[Unemployed Knob Goblin]: return "beer_lens";
            case $monster[Vegetable Gremlin]: return "vegetable";
            case $monster[War Hippy Elite Fire Spinner]: return "fire_spinner";
            case $monster[White Lion]: return "white_lion";
            case $monster[White Snake]: return "white_snake";
            case $monster[Zombie Waltzers]: return "waltzers";
            case $monster[Baseball Bat]: return "baseball";
            case $monster[Big Creepy Spider]: return "spider";
            case $monster[Black Widow]: return "black_widow";
            case $monster[Plaque of Locusts]: return "locust";
            case $monster[Claw-foot Bathtub]: return "bathtub";
            case $monster[Demonic Icebox]: return "icebox";
            case $monster[Grungy Pirate]: return "grungy";
            case $monster[Handsome Mariachi]: return "handsomeness";
            case $monster[Irate Mariachi]: return "irate";
            case $monster[MagiMechTech MechaMech]: return "mech";
            case $monster[Mariachi Calavera]: return "calavera";
            case $monster[Pygmy Assault Squad]: return "pygmy_assault";
            case $monster[Sub-Assistant Knob Mad Scientist]: return "firecracker";
            case $monster[Tomb Servant]: return "tomb_servant";
            case $monster[Writing Desk]: return "writing_desk";
            case $monster[XXX pr0n]: return "pron";
            case $monster[W Imp]: return "wimp";
            case $monster[Reanimated Baboon Skeleton]: return "reanim_baboon";
            case $monster[Reanimated Bat Skeleton]: return "reanim_bat";
            case $monster[Reanimated Demon Skeleton]: return "reanim_demon";
            case $monster[Reanimated Giant Spider Skeleton]: return "reanim_spider";
            case $monster[Reanimated Serpent Skeleton]: return "reanim_serpent";
            case $monster[Reanimated Wyrm Skeleton]: return "reanim_wyrm";
            case $monster[Clod Hopper]: return "clodhopper";
            case $monster[Rockfish]: return "rockfish";
            case $monster[Toilet-Papered Tree]: return "tp_tree";
            case $monster[C. H. U. M. Chieftain]: return "chieftain";
            case $monster[Scary Pirate]: return "cursed";
            case $monster[Hustled Spectre]: return "hustled_spectre";
            case $monster[Neptune Flytrap]: return "neptune_flytrap";
            case $monster[Slime1]: return "slime";
            case $monster[Slime2]: return "slime";
            case $monster[Slime3]: return "slime";
            case $monster[Slime4]: return "slime";
            case $monster[Slime5]: return "slime";
            case $monster[Unholy Diver]: return "unholy_diver";
            case $monster[Large Kobold]: return "kobold";
            case $monster[Smarmy Pirate]: return "smarmy";
            case $monster[Spam Witch]: return "spam_witch";
            case $monster[Triffid]: return "triffid";
            case $monster[Bolt-Cuttin' Elf]: return "bolt_elf ";
            case $monster[Cement Cobbler Penguin]: return "cement_penguin";
            case $monster[Mesmerizing Penguin]: return "mesmerizing";
            case $monster[Mob Penguin Demolitionist]: return "demolitionist";
            case $monster[Monkey Wrenchin' Elf]: return "monkey_elf ";
            case $monster[Propaganda-spewin' Elf]: return "prop_elf";
            case $monster[Hobelf]: return "hobo_elf";
            case $monster[Somebody Else's Butt]: return "bigbutt";
        }

        return "";
    }

    // Attempt to request a monster from FaxBot. Returns true if successful.
    boolean faxbot_request(monster mon) {
        string request = faxbot_name(mon);
        if (request == "")
            return false;

        if (!put_fax())
            return false;

        print("BCC:Making faxbot request for " + request + ". (Waiting for " + wait_time + " seconds.)", "purple");

        chat_private("FaxBot", request);
        wait(wait_time);

        if (!get_fax())
            return false;

        return check_fax(mon);
    }

    if (faxbot_name(mon) == "") {
        print("BCC: Unknown fax monster: " + mon, "red");
        return false;
    }

    print("BCC: Checking existing fax first. Don't panic if this is the wrong monster - we won't use the wrong monster.", "purple");
    if (!get_fax()) {
        print("BCC: Unable to get fax. Do you have a fax machine?", "red");
        return false;
    }
    if (check_fax(mon)) {
        print("BCC: You already have a " + mon + " fax.", "purple");
        return true;
    }

    for i from 1 to faxbot_tries {
        if (faxbot_request(mon)) {
            print("BCC: Successfully got a " + mon + " fax.", "purple");
            return true;
        }
    }

    print("BCC: Unable to receive fax for " + mon + " after " + faxbot_tries + " tries.", "red");
    return false;
}

//Returns true if we have the elite guard outfit. 
boolean haveElite() {
	if (get_property("lastDispensaryOpen") != my_ascensions()) return false;
	int a,b,c;
	if (i_a("Knob Goblin elite helm") > 0) { a = 1; }
	if (i_a("Knob Goblin elite polearm") > 0) { b = 1; }
	if (i_a("Knob Goblin elite pants") > 0) { c = 1; }
	return (a+b+c==3)&&(i_a("Cobb's Knob lab key")>0);
}

//identifyBangPotions will be true if we've identified them all out of {blessing, detection, acuity, strength, teleport}, false if there are still some left to identify. 
boolean identifyBangPotions() {
	//Returns the number of the 5 important potions we've found. 
	int numPotionsFound() {
		int i = 0;
		foreach pot, eff in allBangPotions() {
			switch (eff) {
				case $effect[Izchak's Blessing] :
				case $effect[Object Detection] :
				case $effect[Strange Mental Acuity] :
				case $effect[Strength of Ten Ettins] :
				case $effect[Teleportitis] :
					i = i + 1;
				break;
			}
		}
		return i;
	}
	
	//Returns true if there are some unknown potions that we should find out about by throwing them against monsters. (i.e. we HAVE them)
	boolean somePotionsUnknown() {
		foreach pot, eff in allBangPotions() {
			if (eff == $effect[none] && item_amount(pot) > 0) return true;
		}
		return false;
	}
	
	boolean usedPotion = false;
	while (numPotionsFound() < 5 && somePotionsUnknown()) {
		if (!in_hardcore() && my_inebriety() <= inebriety_limit() - 3) {
			usedPotion = false;
			foreach pot, eff in allBangPotions() {
				if (item_amount(pot) > 0) {
					if (eff == $effect[none] && !usedPotion) {
						use(1, pot);
						usedPotion = true;
					}
				}
			}
		} else {
			bumMiniAdv(1, $location[Hole in the Sky], "consultDoD");
		}
	}
	
	print("BCC: We have found "+numPotionsFound()+"/5 important DoD potions", "purple");
	return (numPotionsFound() >= 5);
}

int numPirateInsults() {
	int t = 0, i = 1;
	while (i <= 8) {
		if (get_property("lastPirateInsult"+i) == "true") {
			t = t + 1;
		}
		i = i + 1;
	}
	return t;
}

int numOfWand() {
	if (item_amount($item[dead mimic]) > 0) use(1, $item[dead mimic]);
	for wandcount from  1268 to 1272 {
		if (item_amount(to_item(wandcount)) > 0) {
			return wandcount;
		}
	}
	return 0;
}

int numUniqueKeys() {
	int keyb, keyj, keys;
	if (i_a("boris's key") > 0) { keyb = 1; }
	if (i_a("jarlsberg's key") > 0) { keyj = 1; }
	if (i_a("sneaky pete's key") > 0) { keys = 1; }
	return keyb+keyj+keys;
}

//Creates cocktails and reagent pasta.
boolean omNomNom() {
	int howManyDoWeHave(string type) {
		int numberOfItems;
		
		switch (type) {
			case "acc" :
				foreach i in $items[tropical swill, pink pony, slip 'n' slide, fuzzbump, ocean motion, fruity girl swill, ducha de oro, horizontal tango, 
					roll in the hay, a little sump'm sump'm, blended frozen swill, slap and tickle, rockin' wagon, perpendicular hula, calle de miel] {
					numberOfItems += item_amount(i);
				}
			break;
			
			case "reagentpasta" :
				foreach i in $items[fettucini inconnu, gnocchetti di Nietzsche, hell ramen, spaghetti with Skullheads, spaghetti con calaveras] {
					numberOfItems += item_amount(i);
				}
			break;
			
			case "scc" :
				foreach i in $items[Neuromancer, vodka stratocaster, Mon Tiki, teqiwila slammer, Divine, Gordon Bennett, gimlet, yellow brick road, 
					mandarina colada, tangarita, Mae West, prussian cathouse] {
					numberOfItems += item_amount(i);
				}
			break;
		}
		
		return numberOfItems;
	}
	
	int needBooze() {
		return to_int((inebriety_limit() - my_inebriety())/4);
	}
	
	int needFood() {
		return to_int((fullness_limit() - my_fullness())/6);
	}
	
	if (get_property("bcasc_prepareFoodAndDrink") != "true") return false;
	//Only do this if we're rich enough or something. Might want this to not be exactly the same as willMood(), so copying rather than using the function. 
	if (!(haveElite() || my_meat() > 5000 || my_mp() > 100 || my_level() > 9)) return false;
	if (!in_hardcore()) return false;
	
	if (have_skill($skill[Pastamastery]) && have_skill($skill[Advanced Saucecrafting])) {
		print("BCC: Preparing Food (Have "+howManyDoWeHave("reagentpasta")+" Reagent Pastas)", "purple");
		
		foreach i in $items[fettucini inconnu, gnocchetti di Nietzsche, hell ramen, spaghetti with Skullheads, spaghetti con calaveras] {
			if (item_amount($item[dry noodles]) == 0) cli_execute("cast pastamastery");
			if (item_amount($item[scrumptious reagent]) == 0) cli_execute("cast advanced sauce");
			if (creatable_amount(i) > 0 && howManyDoWeHave("reagentpasta") < needFood()) {
				cli_execute("make 1 "+to_string(i));
			}
		}
	}
	
	if (have_skill($skill[Advanced Cocktailcrafting])) {
		print("BCC: Preparing Booze (Have "+howManyDoWeHave("scc")+" SCC and "+howManyDoWeHave("acc")+" ACC)", "purple");
		
		if (have_skill($skill[Superhuman Cocktailcrafting])) {
			foreach i in $items[Neuromancer, vodka stratocaster, Mon Tiki, teqiwila slammer, Divine, Gordon Bennett, gimlet, yellow brick road, 
						mandarina colada, tangarita, Mae West, prussian cathouse] {
				if (get_property("cocktailSummons") < 3 + to_int(have_skill($skill[Superhuman Cocktailcrafting]))*2) cli_execute("cast 5 cocktail");
				if (creatable_amount(i) > 0 && howManyDoWeHave("acc") + howManyDoWeHave("scc") < needBooze()) {
					cli_execute("make 1 "+to_string(i));
				}
			}
		}
			
		foreach i in $items[tropical swill, pink pony, slip 'n' slide, fuzzbump, ocean motion, fruity girl swill, ducha de oro, horizontal tango, 
					roll in the hay, a little sump'm sump'm, blended frozen swill, slap and tickle, rockin' wagon, perpendicular hula, calle de miel] {
			if (get_property("cocktailSummons") < 3 + to_int(have_skill($skill[Superhuman Cocktailcrafting]))*2) cli_execute("cast 5 cocktail");
			if (creatable_amount(i) > 0 && howManyDoWeHave("acc") + howManyDoWeHave("scc") < needBooze()) {
				cli_execute("make 1 "+to_string(i));
			}
		}
	}
	return true;
}

string runChoice(string page_text) {
	while( contains_text( page_text , "choice.php" ) ) {
		## Get choice adventure number
		int begin_choice_adv_num = ( index_of( page_text , "whichchoice value=" ) + 18 );
		int end_choice_adv_num = index_of( page_text , "><input" , begin_choice_adv_num );
		string choice_adv_num = substring( page_text , begin_choice_adv_num , end_choice_adv_num );
		
		string choice_adv_prop = "choiceAdventure" + choice_adv_num;
		string choice_num = get_property( choice_adv_prop );
		
		if( choice_num == "" ) abort( "Unsupported Choice Adventure!" );
		
		string url = "choice.php?pwd&whichchoice=" + choice_adv_num + "&option=" + choice_num;
		page_text = visit_url( url );
	}
	return page_text;
}

void sellJunk() {	
	if (my_path() == "Way of the Surprising Fist") return;
	foreach i in $items[meat stack, dense meat stack, meat paste, magicalness-in-a-can, moxie weed, strongness elixir] {
		if (item_amount(i) > 0) autosell(item_amount(i), i);
	}
	foreach i in $items[Old coin purse, old leather wallet, black pension check, warm subject gift certificate, Penultimate Fantasy chest] {
		if (item_amount(i) > 0) use(item_amount(i), i);
	}
}

//Returns the safe Moxie for given location, by going through all the monsters in it.
int safeMox(location loc) {
	//Softcore is deemed to be able to take care of virtually any ML. 
	if (loc == $location[primordial soup] || !in_hardcore()) return 0;
	
	//Scaling monsters play havoc with this. The actual number used isn't really important as we'll only hit this after Level 11 anyway. 
	if (loc == $location[Hidden Temple]) return 60;
	
	int ret = 0;
	
	//Find the hardest monster. 
	foreach mob, freq in appearance_rates(loc) {
		if (freq >= 0 && mob != $monster[Guy Made of Bees]) ret = max(ret, monster_attack(mob));
	}
	//Note that monster_attack() takes into account ML. So just add something to account for this.
	return ret + 4;
}

//Function to tell if we can adventure at a specific location
boolean can_adv(location where) {
	// load permanently unlocked zones
	string theprop = get_property("unlockedLocations");
	if (theprop == "" || index_of(theprop,"--") < 0 || substring(theprop,0,index_of(theprop,"--")) != to_string(my_ascensions()))
		theprop = my_ascensions()+"--";
	if (contains_text(theprop,where)) return true;

	boolean primecheck(int req) {
		if (my_buffedstat(my_primestat()) < req)
			return false;
		return true;
	}
	boolean levelcheck(int req) {
		if (my_level() < req) return false;
		return true;
	}
	boolean itemcheck(item req) {
		if (available_amount(req) == 0)
			return false;
		return true;
	}
	boolean equipcheck(item req) {
		if (!can_equip(req)) return false;
		return (item_amount(req) > 0 || have_equipped(req));
	}
	boolean outfitcheck(string req) {
		if (!have_outfit(req)) return false;
		return true;
	}
	boolean perm_urlcheck(string url, string needle) {
		if (contains_text(visit_url(url),needle)) {
		set_property("unlockedLocations",theprop+" "+where);
		return true;
		}
		return false;
	}
	boolean pirate_check(string url) {
	  if (!(equipcheck($item[pirate fledges]) || outfitcheck("swashbuckling getup"))) return false;
	  return true;
	}

	// begin location checking
	if (contains_text(to_string(where),"Haunted Wine Cellar"))
	  return (levelcheck(11) && itemcheck($item[your father's macguffin diary]) && perm_urlcheck("manor.php","sm8b.gif"));
	switch (where) {
	// always open
	case $location[Sleazy Back Alley]:
	case $location[Haunted Pantry]:
	case $location[Outskirts of The Knob]: return true;
	// level-opened
	case $location[Spooky Forest]: return (levelcheck(2));
	case $location[A Barroom Brawl]: return (levelcheck(3));
	case $location[8-Bit Realm]: return (primecheck(20));
	case $location[Bat Hole Entryway]: return (levelcheck(4) && primecheck(13));
	case $location[Guano Junction]: return (levelcheck(4) && primecheck(13) && numeric_modifier("Stench Resistance") > 0);
	case $location[Batrat and Ratbat Burrow]:
	case $location[Beanbat Chamber]: if (!primecheck(13)) return false;
									if (!levelcheck(4)) return false;
									string bathole = visit_url("bathole.php");
									int sonarsneeded = to_int(!contains_text(bathole,"batratroom.gif")) +
										to_int(!contains_text(bathole,"batbeanroom.gif"));
									if (sonarsneeded > 0) {
										return (item_amount($item[sonar-in-a-biscuit]) >= sonarsneeded);
									}
									return (perm_urlcheck("bathole.php",to_url(where)));
	case $location[Knob Kitchens]: if (!primecheck(20)) return false;
	case $location[Knob Barracks]:
	case $location[Knob Treasury]:
	case $location[Knob Harem]: if (!levelcheck(5) || contains_text(visit_url("plains.php"), "knob1.gif")) return false; return (perm_urlcheck("cobbsknob.php",to_url(where)));
	case $location[Greater-Than Sign]: return (primecheck(44) && contains_text(visit_url("da.php"),"Greater"));
	case $location[Dungeons of Doom]: return (primecheck(44) && perm_urlcheck("da.php","ddoom.gif"));
	case $location[Itznotyerzitz Mine]: return (levelcheck(8) && primecheck(53));
	case $location[Black Forest]: return (levelcheck(11) && primecheck(104));
	// key opened
	case $location[Knob Shaft]:
	case $location[Knob Laboratory]: return (primecheck(30) && itemcheck($item[lab key]));
	case $location[Menagerie 1]: return (primecheck(35) && itemcheck($item[menagerie key]));
	case $location[Menagerie 2]: return (primecheck(40) && itemcheck($item[menagerie key]));
	case $location[Menagerie 3]: return (primecheck(45) && itemcheck($item[menagerie key]));
	case $location[Hippy Camp]: return (itemcheck($item[dingy dinghy]) && get_property("warProgress") != "started" && get_property("sideDefeated") != "hippies" && get_property("sideDefeated") != "both" && primecheck(30));
	case $location[Frat House]: return (itemcheck($item[dingy dinghy]) && get_property("warProgress") != "started" && get_property("sideDefeated") != "fratboys" && get_property("sideDefeated") != "both" && primecheck(30));
	case $location[Pirate Cove]: return (itemcheck($item[dingy dinghy]) && !have_equipped($item[pirate fledges]) && get_property("warProgress") != "started" && primecheck(45));
	case $location[Giant Castle]: return (primecheck(95) && item_amount($item[S.O.C.K]) + item_amount($item[intragalactic rowboat]) > 0);
	case $location[Hole in the Sky]: return (primecheck(100) && itemcheck($item[intragalactic rowboat]));
	case $location[Haunted Library]: return (primecheck(40) && itemcheck($item[library key]));
	case $location[Haunted Gallery]: return (itemcheck($item[gallery key]));
	case $location[Haunted Ballroom]: return (itemcheck($item[ballroom key]));
	case $location[Palindome]: return (primecheck(65) && equipcheck($item[talisman o'nam]));
	case $location[Fernswarthy Ruins]: return (primecheck(11) && itemcheck($item[fernswarthy letter]));
	case $location[Oasis in the Desert]: return (itemcheck($item[your father's macguffin diary]) && perm_urlcheck("beach.php","oasis.gif"));
	case $location[The Upper Chamber]:
	case $location[The Middle Chamber]: return (itemcheck($item[staff of ed]));
	// signs
	case $location[Thugnderdome]: if (!primecheck(25)) return false;
	case $location[Outskirts of Camp]: return (canadia_available());
	case $location[Camp Logging Camp]: return (canadia_available() && primecheck(30));
	case $location[Post-Quest Bugbear Pens]: return (knoll_available() && primecheck(13) && contains_text(visit_url("questlog.php?which=2"),"You've helped Mayor Zapruder") && perm_urlcheck("woods.php","pen.gif"));
	case $location[Bugbear Pens]: return (knoll_available() && primecheck(13) && !contains_text(visit_url("questlog.php?which=2"),"You've helped Mayor Zapruder") && perm_urlcheck("woods.php","pen.gif"));
	// misc
	case $location[Hidden Temple]: return (levelcheck(2) && primecheck(5) && perm_urlcheck("woods.php","temple.gif"));
	case $location[Degrassi Knoll]: return (!knoll_available() && primecheck(10) && guild_store_available( ) && perm_urlcheck("plains.php","knoll1.gif"));
	case $location[Fun House]: return (guild_store_available( ) && primecheck(15) && perm_urlcheck("plains.php","funhouse.gif"));
	case $location[Pre-Cyrpt Cemetary]: return (primecheck(11) && guild_store_available( ) && !visit_url("questlog.php?which=2").contains_text("defeated the Bonerdagon"));
	case $location[Post-Cyrpt Cemetary]: return (primecheck(40) && perm_urlcheck("questlog.php?which=2","defeated the Bonerdagon"));
	case $location[Goatlet]: return (levelcheck(8) && primecheck(53) && perm_urlcheck("mclargehuge.php","bottommiddle.gif"));
	case $location[Ninja Snowmen]: return (levelcheck(8) && primecheck(53) && perm_urlcheck("mclargehuge.php","leftmiddle.gif"));
	case $location[eXtreme Slope]: return (levelcheck(8) && perm_urlcheck("mclargehuge.php","rightmiddle.gif"));
	case $location[Whitey Grove]: return (levelcheck(7) && primecheck(34) && guild_store_available( ) && perm_urlcheck("woods.php","grove.gif"));
	case $location[Belilafs Comedy Club]:
	case $location[Hey Deze Arena]:
	case $location[Pandamonium Slums]: return (primecheck(29) && (have_skill($skill[liver of steel]) || have_skill($skill[spleen of steel]) ||
										 have_skill($skill[stomach of steel]) || perm_urlcheck("questlog.php?which=2","cleansed the taint")));
	case $location[Orc Chasm]: return (levelcheck(9) && perm_urlcheck("mountains.php","valley2.gif"));
	case $location[Fantasy Airship]: return (levelcheck(10) && primecheck(90) && (perm_urlcheck("plains.php","beanstalk.gif") || use(1,$item[enchanted bean])));
	case $location[White Citadel]: return (!white_citadel_available() && guild_store_available( ) && visit_url("woods.php").contains_text("wcroad.gif"));
	case $location[Haunted Kitchen]: return (primecheck(5) && (itemcheck($item[library key]) || perm_urlcheck("town_right.php","manor.gif")));
	case $location[Haunted Conservatory]: return (primecheck(6) && perm_urlcheck("town_right.php","manor.gif"));
	case $location[Haunted Billiards Room]: return (primecheck(10) && perm_urlcheck("town_right.php","manor.gif"));
	case $location[Haunted Bathroom]: return (primecheck(68) && to_int(get_property("lastSecondFloorUnlock")) == my_ascensions());
	case $location[Haunted Bedroom]: return (primecheck(85) && to_int(get_property("lastSecondFloorUnlock")) == my_ascensions());
	case $location[Icy Peak]: return (levelcheck(8) && primecheck(53) && perm_urlcheck("questlog.php?which=2","L337 Tr4pz0r") && numeric_modifier("Cold Resistance") > 0);
	case $location[Barrrney's Barrr]: return (itemcheck($item[dingy dinghy]) && (equipcheck($item[pirate fledges]) || outfitcheck("swashbuckling getup")));
	case $location[F'c'le]: return (pirate_check("cove3_3x1b.gif"));
	case $location[Poop Deck]: return (pirate_check("cove3_3x3b.gif"));
	case $location[Belowdecks]: return (pirate_check("cove3_5x2b.gif"));
	case $location[Hidden City (encounter)]: return (levelcheck(11) && itemcheck($item[your father's macguffin diary]) && perm_urlcheck("woods.php","hiddencity.php"));
	default: return false;
	}
}

//Changes the familiar based on a string representation of what we want. 
boolean setFamiliar(string famtype) {
	item bootsSpleenThing() {
		for i from 5198 to 5219 {
			if (item_amount(to_item(i)) > 0) return to_item(i);
		}
		return $item[none];
	}

	//The very first thing is to check 100% familiars
	if(bcasc_100familiar != "" && my_path() != "Avatar of Boris") {
		print("BCC: Your familiar is set to a 100% "+bcasc_100familiar, "purple");
		cli_execute("familiar "+bcasc_100familiar);
		return true;
	}
	
	if (famtype == "nothing") {
		use_familiar($familiar[none]);
		return true;
	}
	
	//Then a quick check for if we have Everything Looks Yellow
	if ((have_effect($effect[Everything Looks Yellow]) > 0 || (my_path() == "Bees Hate You") || my_path() == "Avatar of Boris") && famtype == "hebo") { famtype = "items"; }
	
	//THEN a quick check for a spanglerack
	if (i_a("spangly sombrero") > 0 && have_path_familiar($familiar[Mad Hatrack]) && (contains_text(famtype, "item") || contains_text(famtype, "equipment"))) {
		print("BCC: We are going to be using a spanglerack for items. Yay Items!", "purple");
		use_familiar($familiar[Mad Hatrack]);
		if (equipped_item($slot[familiar]) != $item[spangly sombrero]) equip($slot[familiar], $item[spangly sombrero]);
		if (equipped_item($slot[familiar]) == $item[spangly sombrero]) return true;
		print("BCC: There seemed to be a problem and you don't have a spangly sombrero equipped. I'll use a 'normal' item drop familiar.", "purple");
	} else if(i_a("spangly mariachi pants") > 0 && have_path_familiar($familiar[fancypants scarecrow]) && (contains_text(famtype, "item") || contains_text(famtype, "equipment"))) {
		print("BCC: We are going to be using the spanglepants for items. Yay Items!", "purple");
		use_familiar($familiar[Fancypants Scarecrow]);
		if (equipped_item($slot[familiar]) != $item[spangly mariachi pants]) equip($slot[familiar], $item[spangly mariachi pants]);
		if (equipped_item($slot[familiar]) == $item[spangly mariachi pants]) return true;
		print("BCC: There seemed to be a problem and you don't have the spangly mariachi pants equipped. I'll use a 'normal' item drop familiar.", "purple");
	}
	
	if (my_path() == "Avatar of Boris") {	//Lute = +item, Crumhorn = +stats, Sackbut = +HP/MP
		string charpane = visit_url("charpane.php");
		if((famtype == "items" || famtype == "itemsnc" || famtype == "equipmentnc")) {
			if(minstrel_instrument() == $item[Clancy's lute])
				return true;
			else if(i_a("Clancy's lute") > 0) {
				use(1, $item[Clancy's lute]);
				return true;
			}
		} else {
			if(i_a("Clancy's crumhorn") > 0) {
				use(1, $item[Clancy's crumhorn]);
				return true;
			} else if(minstrel_instrument() == $item[Clancy's crumhorn]) {
				return true;
			} else if(i_a("Clancy's sackbut") > 0){
				use(1, $item[Clancy's sackbut]);
				return true;
			} else {
				return true;
			}
		}
	}
	
	//Finally, actually start getting familiars.
	if (famtype != "" && my_path() != "Avatar of Boris") {
		string [int] famlist;
		load_current_map("bcs_fam_"+famtype, famlist);
		foreach x in famlist {
			print("Checking for familiar '"+famlist[x]+"' where x="+x, "purple");
			if (have_path_familiar(famlist[x].to_familiar())) {
				use_familiar(famlist[x].to_familiar());
				return true;
			}
		}
	}

	print("BCC: Switching Familiar for General Use", "aqua");
	int maxspleen = 12;
	if (have_skill($skill[Spleen of Steel])) maxspleen = 20;
	
	if (have_path_familiar($familiar[Rogue Program]) || have_path_familiar($familiar[Baby Sandworm]) || have_path_familiar($familiar[Bloovian Groose])) {
		//Before we do anything, let's check if there's any spleen to do. May as well do this as we go along.

		if (my_spleen_use() <= maxspleen-4 && get_property("bcasc_doNotUseSpleen") != "true" && !can_interact()) {
			print("BCC: Going to try to use some spleen items if you have them.", "purple");

			while (my_spleen_use()  <= maxspleen-4 && item_amount($item[groose grease]) > 0) {
				use(1, $item[groose grease]);
				cli_execute("uneffect just the best anapests");
			}
		}

		if (my_spleen_use() <= maxspleen-4 && my_level() >= 4 && get_property("bcasc_doNotUseSpleen") != "true" && !can_interact()) {
			print("BCC: Going to try to use some spleen items if you have them.", "purple");
			
			while (my_spleen_use()  <= maxspleen-4 && item_amount($item[agua de vida]) > 0) {
				use(1, $item[agua de vida]);
			}
			
			while (bootsSpleenThing() != $item[none] && my_spleen_use()  <= maxspleen-4) {
				use(1, bootsSpleenThing());
			}
			
			visit_url("town_wrong.php");
			while (my_spleen_use()  <= maxspleen-4 && (available_amount($item[coffee pixie stick]) > 0 || item_amount($item[Game Grid token]) > 0)) {
				if (available_amount($item[coffee pixie stick]) == 0) {
					visit_url("arcade.php?action=skeeball&pwd="+my_hash());
				}
				use (1, $item[coffee pixie stick]);
			}
		}
		
		//If they have these, then check for spleen items that we have. 
		if (my_spleen_use() + (i_a("agua de vida") + i_a("coffee pixie stick") + i_a("Game Grid token") + i_a("Game Grid ticket")/10 + i_a("groose grease")) * 4 < maxspleen + 4) {
			print("Spleen: "+my_spleen_use()+" Agua: "+i_a("agua de vida")+" Stick: "+i_a("coffee pixie stick")+" Token: "+i_a("Game Grid token") + " Grease: " + i_a("groose grease"), "purple");
			print("Total Spleen: "+(my_spleen_use() + (i_a("agua de vida") + i_a("coffee pixie stick") + i_a("Game Grid token") + i_a("groose grease")) * 4), "purple");
			
			//Then we have space for some spleen items.
			if (have_path_familiar($familiar[Bloovian Groose])) {
				use_familiar($familiar[Bloovian Groose]);
				return true;
			} else if (have_path_familiar($familiar[Rogue Program]) && have_path_familiar($familiar[Baby Sandworm])) {
				//Then randomly pick between the two.
				if (random(2) == 0) {
					use_familiar($familiar[Rogue Program]);
					return true;
				} else {
					use_familiar($familiar[Baby Sandworm]);
					return true;
				}
			} else if (have_path_familiar($familiar[Rogue Program])) {
				use_familiar($familiar[Rogue Program]);
				return true;
			} else if (have_path_familiar($familiar[Baby Sandworm])) {
				use_familiar($familiar[Baby Sandworm]);
				return true;
			}
		}
	}
	
	//If we set a familiar as default, use it. 
	if (get_property("bcasc_defaultFamiliar") != "") {
		print("BCC: Setting the default familiar to your choice of '"+get_property("bcasc_defaultFamiliar")+"'.", "purple");
		return use_familiar(to_familiar(get_property("bcasc_defaultFamiliar")));
	}
	
	print("BCC: Using a default stat familiar.", "purple");
	//Now either we have neither of the above, or we have enough spleen today.
	if (have_path_familiar($familiar[Frumious Bandersnatch])) {
		use_familiar($familiar[Frumious Bandersnatch]);
		return true;
	} else if (have_path_familiar($familiar[Li'l Xenomorph])) {
		use_familiar($familiar[Li'l Xenomorph]);
		return true;
	} else if (have_path_familiar($familiar[Smiling Rat])) {
		use_familiar($familiar[Smiling Rat]);
		return true;
	} else if (have_path_familiar($familiar[Blood-Faced Volleyball])) {
		use_familiar($familiar[Blood-Faced Volleyball]);
		return true;
	}
	return false;
}

boolean setMCD(int moxie, int sMox) {
	if (get_property("bcasc_disableMCD") == "true") return false;
	
	if (canMCD()) {
		print("BCC: We CAN set the MCD.", "purple");
		//We do. Check maxMCD value
		int maxmcd = 10;
		int mcdval = my_buffedstat(my_primestat()) - sMox;
		
		if (mcdval > maxmcd || !in_hardcore()) {
			mcdval = maxmcd;
		}
		cli_execute("mcd "+mcdval);
		return true;
	}
	return false;
}

//Thanks, Rinn!
string tryBeerPong() {
	string page = visit_url("adventure.php?snarfblat=157");
	
	if (contains_text(page, "Combat")) {
		//The way I use this, we shouldn't ever have a combat with this script, but there's no harm in a check for a combat. 
		if ((numPirateInsults() < 8) && (contains_text(page, "Pirate"))) throw_item($item[The Big Book of Pirate Insults]);
		while(!page.contains_text("You win the fight!")) page = bumRunCombat();
	} else if (contains_text(page, "Arrr You Man Enough?")) {
		int totalInsults = numPirateInsults();
		if (totalInsults > 6) {
			print("You have learned " + to_string(totalInsults) + "/8 pirate insults.", "blue");
			page = beerPong( visit_url( "choice.php?pwd&whichchoice=187&option=1" ) );
		} else {
			print("You have learned " + to_string(totalInsults) + "/8 pirate insults.", "blue");
			print("Arrr You Man Enough?", "red");
			page = visit_url( "choice.php?pwd&whichchoice=187&option=2" );
		}
	} else if (contains_text(page, "Arrr You Man Enough?")) {
		//Doesn't this do just the same as above? Rinn has it like this, so I'll leave it like this for the moment. 
		page = beerPong(page);
	} else {
		page = runChoice(page);
	}

	return page;
}

monster whatShouldIFax() {
	if (my_adventures() == 0) return $monster[none]; // don't try and fax a monster if you have no adventures left to fight it
	if (get_property("bcasc_lastFax") == today_to_string() || get_property("_photocopyUsed") != "false") return $monster[none];
	if (get_property("bcasc_doNotFax") == true) return $monster[none];
	if (can_interact()) return $monster[none];
	if (my_path() == "Avatar of Boris") return $monster[none];
	if (item_amount($item[Clan VIP Lounge key]) == 0) return $monster[none];
	if (!contains_text(visit_url("clan_viplounge.php"), "faxmachine.gif")) return $monster[none];
	
	//Set p to be primestat as a shortcut.
	int p = my_buffedstat(my_primestat());
	if (my_primestat() == $stat[Mysticality]) p = p + 30;
	
	if (my_path() != "Bees Hate You" && my_path() != "Way of the Surprising Fist" && (i_a("Knob Goblin elite helm") == 0 || i_a("Knob Goblin elite polearm") == 0 || i_a("Knob Goblin elite pants") == 0)) {
		if (p > monster_attack($monster[Knob Goblin Elite Guard Captain])) return $monster[Knob Goblin Elite Guard Captain];
	}
	
	if (!contains_text(visit_url("questlog.php?which=2"), "with his monster problem") && i_a("64735 scroll") == 0) {
		boolean a = (i_a("668 scroll") > 0) || (i_a("334 scroll") > 1);
		boolean b = (i_a("64067 scroll") > 0) || ((i_a("30669 scroll") > 0) && (i_a("33398 scroll") > 0));
		print("BCC: Checking the ASCII, a is "+to_string(a)+" and b is "+to_string(b), "purple");
		
		if (p > monster_attack($monster[Bad ASCII Art])) {
			print("BCC: Checking a Bad ASCII Art", "purple");
			if (!a || !b) {
				return $monster[Bad ASCII Art];
			}
		}
		
		if (p > monster_attack($monster[rampaging adding machine]) && (a && b)) {
			return $monster[rampaging adding machine];
		}
	}

	if (p > monster_attack($monster[lobsterfrogman])) {
		if (bcasc_doSideQuestBeach && i_a("barrel of gunpowder") < 5 && (get_property("sidequestLighthouseCompleted") == "none")) {
			return $monster[lobsterfrogman];
		}
	}
	return $monster[none];
}

boolean willMood() {
	return (!in_hardcore() || haveElite() || my_meat() > 5000 || my_mp() > 100);
}

void zapKeys() {
	if (item_amount($item[fat loot token]) > 0) {
		foreach i in $items[boris's key, jarlsberg's key, sneaky pete's key] {
			if (item_amount(i) == 0) {
				buy($coinmaster[Vending Machine], 1, i);
				return;
			}
		}
	}
	
	if (canZap()) {
		if (i_a("boris's ring") + i_a("jarlsberg's earring") + i_a("sneaky pete's breath spray") > 0 ) {
			print("BCC: Your wand is safe, so I'm going to try to zap something");
			if (i_a("boris's ring") > 0) { cli_execute("zap boris's ring"); 
			} else if (i_a("jarlsberg's earring") > 0) { cli_execute("zap jarlsberg's earring"); 
			} else if (i_a("sneaky pete's breath spray") > 0) { cli_execute("zap sneaky pete's breath spray"); 
			} else if (i_a("jarlsberg's key") > 1) { cli_execute("zap jarlsberg's key");  
			} else if (i_a("sneaky pete's key") > 1) { cli_execute("zap sneaky pete's key"); 
			} else if (i_a("boris's key") > 1) { cli_execute("zap boris's key");  
			}
		}
	} else {
		print("BCC: You don't have a wand, or it's not safe to use one. No Zapping for you.", "purple");
	}
}

/***********************************************
* BEGIN FUNCTIONS THAT RELY ON OTHER FUNCTIONS *
***********************************************/

void setMood(string combat) {
	if (get_property("bcasc_disableMoods") == "true") {
		cli_execute("mood apathetic");
		return;
	}

	cli_execute("mood bumcheekascend");
	defaultMood(combat == "");
	if (my_path() != "Avatar of Boris") {
		if (contains_text(combat,"+")) {
			if (willMood()) {
				print("BCC: Need moar combat! WAAARGH!", "purple");
				if (have_skill($skill[Musk of the Moose])) cli_execute("trigger lose_effect, Musk of the Moose, cast 1 Musk of the Moose");
				if (have_skill($skill[Carlweather's Cantata of Confrontation])) cli_execute("trigger lose_effect, Carlweather's Cantata of Confrontation, cast 1 Carlweather's Cantata of Confrontation");
				cli_execute("trigger gain_effect, The Sonata of Sneakiness, uneffect sonata of sneakiness");
			}
		} 
		if (contains_text(combat,"-")) {
			if (willMood()) {
				print("BCC: Need less combat, brave Sir Robin!", "purple");
				if (have_skill($skill[Smooth Movement])) cli_execute("trigger lose_effect, Smooth Movements, cast 1 smooth movement");
				if (have_skill($skill[The Sonata of Sneakiness])) cli_execute("trigger lose_effect, The Sonata of Sneakiness, cast 1 sonata of sneakiness");
				cli_execute("trigger gain_effect, Carlweather's Cantata of Confrontation, uneffect Carlweather's Cantata of Confrontation");
			}
		}
		if (contains_text(combat,"i")) {
			if (willMood()) {
				print("BCC: Need items!", "purple");
				if (have_skill($skill[Fat Leon's Phat Loot Lyric])) cli_execute("trigger lose_effect, Fat Leon's Phat Loot Lyric, cast 1 Fat Leon's Phat Loot Lyric");
				if (have_skill($skill[Leash of Linguini])) cli_execute("trigger lose_effect, Leash of Linguini, cast 1 Leash of Linguini");
				//if (haveElite() && my_meat() > 3000) cli_execute("trigger lose_effect, Peeled Eyeballs, use 1 Knob Goblin eyedrops");
			}
		}
		if (contains_text(combat,"n")) {
			if (willMood()) {
				print("BCC: Need initiative!", "purple");
				if (have_skill($skill[Springy Fusilli])) cli_execute("trigger lose_effect, Springy Fusilli, cast 1 Springy Fusilli");
			}
		}
		if (contains_text(combat,"m")) {
			print("BCC: Need meat (this will always trigger)!", "purple");
			if (have_skill($skill[Polka of Plenty])) cli_execute("trigger lose_effect, Polka of Plenty, cast 1 Polka of Plenty");
		}
	} else {
		// Since we can only have one song, checking in the order of best priority.
		// Assume non-combats will always save the most turns, followed by items, then combats
		// Trigger Accompaniment if no other song is required to get some benefit.
		// No check is currently made for ML song, as this could significantly increase combat difficulty.
		// Return once a song has been cast to prevent overwriting.
		if (contains_text(combat,"-")) {
			print("BCC: Need less combat, brave Sir Robin!", "purple");
			if (have_skill($skill[Song of Solitude])) cli_execute("trigger lose_effect, Song of Solitude, cast 1 Song of Solitude");
		} else if (contains_text(combat,"i")) {
			print("BCC: Need items!", "purple");
			if (have_skill($skill[Song of Fortune])) cli_execute("trigger lose_effect, Song of Fortune, cast 1 Song of Fortune");
		} else if (contains_text(combat, "m")) {
			print("BCC: Need meat!", "purple");
			if (have_skill($skill[Song of Fortune])) cli_execute("trigger lose_effect, Song of Fortune, cast 1 Song of Fortune");			
		} else if (contains_text(combat,"+")) {
			print("BCC: Need moar combat! WAAARGH!", "purple");
			if (have_skill($skill[Song of Battle])) cli_execute("trigger lose_effect, Song of Battle, cast 1 Song of Battle");
		// No other song was found, run song of Accompaniment to get some benefit from the song slot.
		} else if (have_skill($skill[Song of Accompaniment ])) {
			print("BCC: Need to run a song! Accompaniment chosen by default", "purple");
			cli_execute("trigger lose_effect, Song of Accompaniment , cast 1 Song of Accompaniment");
		}
	}
}

//Where is it best to level?
location level_location(boolean bcasc_ignoreSafeMoxInHardcore, int value) {
	location best = $location[haunted pantry];
	int one;
	int two = safeMox(best);
	//my_buffedstat(my_primestat())
	if (value < 120) {
		foreach loc in $locations[Sleazy Back Alley, Haunted Pantry, Outskirts of The Knob, Spooky Forest, A Barroom Brawl, 8-Bit Realm, 
			Bat Hole Entryway, Guano Junction, Batrat and Ratbat Burrow, Beanbat Chamber, Knob Kitchens, Knob Barracks, Knob Treasury, 
			Knob Harem, Greater-Than Sign, Dungeons of Doom, Itznotyerzitz Mine, Black Forest, Knob Shaft, Knob Laboratory, Menagerie 1, 
			Menagerie 2, Menagerie 3, Hippy Camp, Frat House, Pirate Cove, Giant Castle, Hole in the Sky, Haunted Library, Haunted Gallery, 
			Haunted Ballroom, Palindome, Fernswarthy Ruins, Oasis in the Desert, The Upper Chamber, The Middle Chamber, Thugnderdome, 
			Outskirts of Camp, Camp Logging Camp, Post-Quest Bugbear Pens, Bugbear Pens, Hidden Temple, Degrassi Knoll, Fun House, 
			Pre-Cyrpt Cemetary, Post-Cyrpt Cemetary, Goatlet, Ninja Snowmen, eXtreme Slope, Whitey Grove, Belilafs Comedy Club, 
			Hey Deze Arena, Pandamonium Slums, Orc Chasm, Fantasy Airship, White Citadel, Haunted Kitchen, Haunted Conservatory, 
			Haunted Billiards Room, Haunted Bathroom, Haunted Bedroom, Icy Peak, Barrrney's Barrr, F'c'le, Poop Deck, Belowdecks, 
			Hidden City (encounter)]
		{
			if (can_adv(loc)) {
				one = safeMox(loc);
				if (one < value && one > two) {
					best = loc;
					two = safeMox(best);
				}
			}
		}
	} else {
		switch(my_primestat()) {
			case $stat[Muscle]: best = $location[Haunted Gallery]; break;
			case $stat[Mysticality]: best = $location[Haunted Bathroom]; break;
			case $stat[Moxie]: best = $location[Haunted Ballroom]; break;
		}
	}
	return best;
}

boolean levelMe(int sMox, boolean needBaseStat) {
	print("BCC: levelMe("+sMox+", "+to_string(needBaseStat)+") called.", "fuchsia");
	
	//In softcore/casual we'll always assume we're strong enough to wtfpwn everything. 
	if (!needBaseStat && !in_hardcore()) return true; 
	
	if (have_effect($effect[Beaten Up]) > 0) {
		cli_execute("uneffect beaten up");
	}
	if (have_effect($effect[Beaten Up]) > 0) { abort("Please cure beaten up"); }

	//Uneffect poisoning since it screws with the calculation of how many buffed stats I need to level
	if (have_effect(to_effect(436)) > 0 || have_effect(to_effect(284)) > 0 || have_effect(to_effect(283)) > 0 || 
			have_effect(to_effect(282)) > 0 || have_effect(to_effect(264)) > 0 || have_effect(to_effect(8)) > 0) {
		use(1, $item[antiantiantidote]);
	}
	if (have_effect(to_effect(436)) > 0 || have_effect(to_effect(284)) > 0 || have_effect(to_effect(283)) > 0 || 
			have_effect(to_effect(282)) > 0 || have_effect(to_effect(264)) > 0 || have_effect(to_effect(8)) > 0) {
		abort("Please cure your poisoning");
	}
	
	if (needBaseStat) {
		if (my_basestat(my_primestat()) >= sMox) return true;
		print("Need to Level up a bit to get at least "+sMox+" base Primestat", "fuchsia");
		buMax();
	} else {		
		//buMax();
		setMood("");
		cli_execute("mood execute");

		int extraMoxieNeeded = sMox - my_buffedstat(my_primestat());
		if (extraMoxieNeeded <= 0) return true;
		print("Need to Level up a bit to get at least "+sMox+" buffed Primestat. This means getting "+extraMoxieNeeded+" Primestat.", "fuchsia");
		sMox = my_basestat(my_primestat()) + extraMoxieNeeded;
		
		if (my_primestat() == $stat[Mysticality]) {
			//Don't level for buffed stat AT ALL above level 10
			if (my_level() >= 10) {
				print("BCC: But, we're a myst class and at or over level 10, so we won't bother with buffed stats.", "fuchsia");
				return true;
			}
			
			//Because of the lack of need of +mainstat, we'll only care if we need 20 or more. 
			extraMoxieNeeded = extraMoxieNeeded - 20;
			print("BCC: But, we're a myst class, so we don't really mind about safe moxie that much. We'll only try to get "+sMox+" instead.", "fuchsia");
			if (extraMoxieNeeded <= 0) return true;
		}
		
		if (my_path() == "Way of the Surprising Fist") {
			//Because of the lack of need of +mainstat, we'll only care if we need 20 or more. 
			extraMoxieNeeded = extraMoxieNeeded - 20 - (my_level() * 3);
			print("BCC: But, we're in a fist run, so we don't really mind about safe moxie that much. We'll only try to get "+sMox+" instead.", "fuchsia");
			if (extraMoxieNeeded <= 0) return true;
		}
	}
	cli_execute("goal clear; goal set "+sMox+" "+to_string(my_primestat()));
	
	location levelHere;
	switch (my_primestat()) {
		case $stat[Muscle] :
			if (my_buffedstat($stat[Muscle]) < 120) {
				print("I need "+sMox+" base muscle (going levelling)", "fuchsia");
				if(to_boolean(get_property("bcasc_dontLevelInTemple")))
					abort("BCC: You want to handle levelling yourself.");
				else {
					setMood("");
					setFamiliar("");
					levelHere = level_location(to_boolean(get_property("bcasc_ignoreSafeMoxInHardcore")), my_buffedstat($stat[Muscle]));
					return bumMiniAdv(my_adventures(), levelHere);
				}
			} else {
				setMood("-");
				setFamiliar("");
				print("I need "+sMox+" base muscle (going to Gallery)", "fuchsia");
				
				//Get as many clovers as possible. The !capture is so that it doesn't abort on failure. 
				print("BCC: Attempting to get clovers to level with. (Don't worry - if don't want to use them to level, we won't).", "purple");
				cloversAvailable();
				
				//If we're above level 11, then use clovers as necessary. 
				if (my_level() >= 10) {
					if (cloversAvailable() > 1 && get_property("bcasc_doNotCloversToLevel") != "true") {
						print("BCC: Going to use clovers to level.", "purple");
						//First, just quickly use all ten-leaf clovers we have. 
						if(my_path() != "Bees Hate you") {
							//First, just quickly use all ten-leaf clovers we have. 
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("use * ten-leaf clover");
							}
						
							while (my_basestat($stat[Muscle]) < sMox && item_amount($item[disassembled clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+item_amount($item[disassembled clover])+" clovers and are using one to level.", "purple");
								use(1, $item[disassembled clover]);
								visit_url("adventure.php?snarfblat=106&confirm=on");
							}
						} else {
							//Bees hate broken clovers so use the closet instead
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("closet put * ten-leaf clover");
							}
						
							while (my_basestat($stat[Mysticality]) < sMox && closet_amount($item[ten-leaf clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+closet_amount($item[ten-leaf clover])+" clovers and are using one to level.", "purple");
								take_closet(1, $item[ten-leaf clover]);
								visit_url("adventure.php?snarfblat=106&confirm=on");
							}
						}	
					}
				}
				if(my_basestat(my_primestat()) < sMox)
					return bumMiniAdv(my_adventures(), $location[Haunted Gallery]);
			}
		break;
		
		case $stat[Mysticality] :
			if (my_buffedstat($stat[Mysticality]) < 80) {
				print("I need "+sMox+" base Mysticality (going levelling)", "fuchsia");
				if(to_boolean(get_property("bcasc_dontLevelInTemple")))
					abort("BCC: You want to handle levelling yourself.");
				else {
					setMood("");
					setFamiliar("");
					levelHere = level_location(to_boolean(get_property("bcasc_ignoreSafeMoxInHardcore")), my_buffedstat($stat[Mysticality]));
					return bumMiniAdv(my_adventures(), levelHere);
				}
			} else {
				setMood("-");
				setFamiliar("");
				print("I need "+sMox+" base Mysticality (going to Bathroom)", "fuchsia");
				
				//Get as many clovers as possible. The !capture is so that it doesn't abort on failure. 
				print("BCC: Attempting to get clovers to level with. (Don't worry - if don't want to use them to level, we won't).", "purple");
				cloversAvailable();
				
				//If we're above level 11, then use clovers as necessary. 
				if (my_level() >= 10) {
					set_property("choiceAdventure105","1");
					set_property("choiceAdventure402","2");
					if (cloversAvailable() > 1 && get_property("bcasc_doNotCloversToLevel") != "true") {
						print("BCC: Going to use clovers to level.", "purple");
						//First, just quickly use all ten-leaf clovers we have. 
						if(my_path() != "Bees Hate you") {
							//First, just quickly use all ten-leaf clovers we have. 
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("use * ten-leaf clover");
							}
						
							while (my_basestat($stat[Mysticality]) < sMox && item_amount($item[disassembled clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+item_amount($item[disassembled clover])+" clovers and are using one to level.", "purple");
								use(1, $item[disassembled clover]);
								visit_url("adventure.php?snarfblat=107&confirm=on");
							}
						}
						else {
							//Bees hate broken clovers so use the closet instead
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("closet put * ten-leaf clover");
							}
						
							while (my_basestat($stat[Mysticality]) < sMox && closet_amount($item[ten-leaf clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+closet_amount($item[ten-leaf clover])+" clovers and are using one to level.", "purple");
								take_closet(1, $item[ten-leaf clover]);
								visit_url("adventure.php?snarfblat=107&confirm=on");
							}
						}						
					}
				}
				if(to_int(get_property("choiceAdventure105")) != 1)
					set_property("choiceAdventure105",1);
				if(my_basestat(my_primestat()) < sMox)
					return bumMiniAdv(my_adventures(), $location[Haunted Bathroom]);
			}
		break;
		
		case $stat[Moxie] :
			if (my_buffedstat($stat[Moxie]) < 90) {
				print("I need "+sMox+" base Moxie (going levelling)", "fuchsia");
				if(to_boolean(get_property("bcasc_dontLevelInTemple")))
					abort("BCC: You want to handle levelling yourself.");
				else {
					setMood("");
					setFamiliar("");
					levelHere = level_location(to_boolean(get_property("bcasc_ignoreSafeMoxInHardcore")), my_buffedstat($stat[Moxie]));
					return bumMiniAdv(my_adventures(), levelHere);
				}
			} else if (my_path() != "way of the surprising fist" && my_buffedstat($stat[Moxie]) < 120) {
				setMood("-i");
				setFamiliar("");
				//There's pretty much zero chance we'll get here without the swashbuckling kit, so we'll be OK.
				if(i_a("pirate fledges") == 0 || my_basestat($stat[mysticality]) < 60)
					buMax("+outfit swashbuckling getup");
				else
					buMax("+equip pirate fledges");
				return bumMiniAdv(my_adventures(), $location[Barrrney's Barrr]);
			} else {
				setMood("-i");
				setFamiliar("itemsnc");
				print("I need "+sMox+" base moxie", "fuchsia");
				
				//Get as many clovers as possible. The !capture is so that it doesn't abort on failure. 
				print("BCC: Attempting to get clovers to level with. (Don't worry - if don't want to use them to level, we won't).", "purple");
				cloversAvailable();
				
				//If we're above level 11, then use clovers as necessary. 
				if (my_level() >= 10) {
					if (my_adventures() == 0) abort("No Adventures to level :(");
					if (cloversAvailable() > 1 && get_property("bcasc_doNotCloversToLevel") != "true") {
						print("BCC: Going to use clovers to level.", "purple");
						if(my_path() != "Bees Hate you")
						{
							//First, just quickly use all ten-leaf clovers we have. 
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("use * ten-leaf clover");
							}
							while (my_basestat($stat[Moxie]) < sMox && item_amount($item[disassembled clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+item_amount($item[disassembled clover])+" clovers and are using one to level.", "purple");
								use(1, $item[disassembled clover]);
								visit_url("adventure.php?snarfblat=109&confirm=on");
							}
						}
						else
						{
							//Bees hate broken clovers so use the closet instead
							if (item_amount($item[ten-leaf clover]) > 0) {
								cli_execute("closet put * ten-leaf clover");
							}
							while (my_basestat($stat[Moxie]) < sMox && closet_amount($item[ten-leaf clover]) > 1) {
								if (my_adventures() == 0) abort("No Adventures to level :(");
								print("BCC: We have "+closet_amount($item[ten-leaf clover])+" clovers and are using one to level.", "purple");
								take_closet(1, $item[ten-leaf clover]);
								visit_url("adventure.php?snarfblat=109&confirm=on");
							}
						}
					}
				}
			
				cli_execute("goal clear");
				setFamiliar("itemsnc");
				while (my_basestat($stat[Moxie]) < sMox) {
					if (my_adventures() == 0) abort("No Adventures to level :(");
					if ((my_buffedstat($stat[Moxie]) < 130) && canMCD()) cli_execute("mcd 0");
					if (item_amount($item[dance card]) > 0) {
						use(1, $item[dance card]);
						bumMiniAdv(4, $location[Haunted Ballroom]);
					} else {
						bumMiniAdv(1, $location[Haunted Ballroom]);
					}
				}
				if(my_basestat($stat[Moxie]) < sMox) return true;
			}
		break;
	}
	return false;
}
boolean levelMe(int sMox) { return levelMe(sMox, false); }

boolean bumAdv(location loc, string maxme, string famtype, string goals, string printme, string combat, string consultScript) {
	//Prepare food if appropriate. 
	omNomNom();
	
	int sMox = safeMox(loc) - (get_property("bcasc_ignoreSafeMoxInHardcore") == "true" ? safeMox(loc) : 0);
	buMax(maxme, sMox);
	
	sellJunk();
	setFamiliar(famtype);
	
	//First, we'll check the faxes. 
	monster f = whatShouldIFax();
	if (f != $monster[none]) {
		print("BCC: We are going to fax a "+to_string(f), "purple");
		
		if (faxMeA(f)) {
			set_property("bcasc_lastFax", today_to_string());
			if (f == $monster[rampaging adding machine]) abort("Can't fight the adding machine. Do this manually.");
			if (f == $monster[lobsterfrogman]) setFamiliar("obtuseangel");
			//Have to do this rather than use() because otherwise, mafia fights immediately.
			visit_url("inv_use.php?pwd=&which=3&whichitem=4873");
			bumRunCombat((f == $monster[lobsterfrogman]) ? "consultLFM" : "");
		} else {
			print("BCC: The monster faxing failed for some reason. Let's continue as normal though.", "purple");
		}
	} else {
		print("BCC: Nothing to fax according to whatShouldIFax", "purple");
	}
	
	//Do we have a HeBo, and are we blocked from using it by a 100% run? Have to do this first, because we re-set the goals below.
	if ((my_path() != "Bees Hate You") && (consultScript == "consultHeBo") && (my_familiar() != $familiar[He-Boulder]) && have_effect($effect[Everything Looks Yellow]) == 0) {
		if (contains_text(visit_url("campground.php?action=bookshelf"), "Summon Clip Art")) {
			if(i_a("unbearable light") == 0)
			{
				print("BCC: We are getting an unbearable light, which the script prefers to pumpkin bombs where possible.", "purple");
				cli_execute("make 1 unbearable light");
			}
		} else {		
			print("BCC: We don't have the HeBo equipped, so we're either on a 100% run or you just don't have one. Trying a pumpkin bomb. If you have one, we'll use it.", "purple");
			//Hit the pumpkin patch
			visit_url("campground.php?action=garden&pwd="+my_hash());
			
			//Have a quick check for a KGF first. 
			if (i_a("pumpkin bomb") == 0 && i_a("pumpkin") > 0 && i_a("knob goblin firecracker") == 0) {
				cli_execute("conditions clear; conditions set 1 knob goblin firecracker");
				adventure(my_adventures(), $location[Outskirts of the Knob]);
			}
			
			if (((i_a("pumpkin") > 0 && i_a("knob goblin firecracker") > 0)) || i_a("pumpkin bomb") > 0) {
				if (i_a("pumpkin bomb") == 0) { cli_execute("make pumpkin bomb"); }
			}
			//That's it. It's just about getting a pumpkin bomb in your inventory. Nothing else.
		}
	}

	//We initially set the MCD to 0 just in case we had it turned on before. 
	if (my_adventures() == 0) { abort("No Adventures. How Sad."); }
	if (canMCD()) cli_execute("mcd 0");
	
	if (length(printme) > 0) {
		print("BCC: "+printme, "purple");
	}
	
	cli_execute("trigger clear");
	setMood(combat);

	cli_execute("mood execute");
	
	if (my_buffedstat(my_primestat()) < sMox && loc != $location[Haunted Bedroom])	{
		//Do something to get more moxie.
		print("Need to Level up a bit to get "+sMox+" Mainstat", "fuschia");
		levelMe(sMox);
	}
	cli_execute("mood execute");
	
	//Goals must be set after trying to levelme()
	cli_execute("goal clear");
	string[int] split_goals = split_string(goals, ",");
	boolean have_goal = false;
	if (length(goals) > 0) {
		cli_execute("goal set "+goals);
		print("BCC: Setting goals of '"+goals+"'...", "lime");
		foreach i in split_goals {
			if(is_goal(to_item(split_goals[i])) || (length(split_goals[i]) > 0 && to_item(split_goals[i]) == $item[none]))
				have_goal = true;
		}
		if(!have_goal) {
			print("BCC: All goals have already been met, moving on.", "lime");
			return true;
		}
	}
	
	//Finally, check for and use the MCD if we can. No need to do this in 
	if (my_buffedstat(my_primestat()) > sMox) {
		print("BCC: We should set the MCD if we can.", "purple");
		//Check if we have access to the MCD
		setMCD(my_buffedstat(my_primestat()), sMox);
	}
	//Force to 0 in Junkyard
	if (loc == $location[Next to that Barrel with Something Burning in it] || loc == $location[Near an Abandoned Refrigerator] || loc == $location[Over Where the Old Tires Are] || loc == $location[Out By that Rusted-Out Car]) {
		print("BCC: We're adventuring in the Junkyard. Let's turn the MCD down...", "purple");
		if (canMCD()) cli_execute("mcd 0");
	}
	//Force to correct MCD levels in Boss Bat, Knob King
	int b, k;
	switch (my_primestat()) {
		case $stat[muscle]: b = 8; k = 0; break;
		case $stat[mysticality]: b = 4; k = 3; break;
		case $stat[moxie]: b = 4; k = 7; break;
	}
	if (canMCD() && loc == $location[Boss Bat's Lair]) { cli_execute("mcd "+b); }
	if (canMCD() && loc == $location[Throne Room]) { cli_execute("mcd "+k); }
	
	if (can_interact()) {
		if (adventure(my_adventures(), loc, "consultCasual")) {}
	} else if (consultScript != "") {
		if (adventure(my_adventures(), loc, consultScript)) {}
	} else if (my_primestat() == $stat[Mysticality] && in_hardcore()) {
		if (adventure(my_adventures(), loc, "consultMyst")) {}
	} else {
		if (adventure(my_adventures(), loc)) {}
	}
	
	if(my_adventures() == 0)
		return false;
	else
		return true;
}
boolean bumAdv(location loc, string maxme, string famtype, string goals, string printme, string combat) { return bumAdv(loc, maxme, famtype, goals, printme, combat, ""); }
boolean bumAdv(location loc, string maxme, string famtype, string goals, string printme) { return bumAdv(loc, maxme, famtype, goals, printme, ""); }
boolean bumAdv(location loc, string maxme, string famtype, string goals) { return bumAdv(loc, maxme, famtype, goals, ""); }
boolean bumAdv(location loc, string maxme, string famtype) { return bumAdv(loc, maxme, famtype, "", ""); }
boolean bumAdv(location loc, string maxme) { return bumAdv(loc, maxme, "", "", ""); }
boolean bumAdv(location loc) { return bumAdv(loc, "", "", "", ""); }

boolean bumUse(int n, item i) {
	if (n > item_amount(i)) n = item_amount(i);
	if (n > 0) return use(n, i);
	return false;
}

/**********************************
* START THE ADVENTURING FUNCTIONS *
**********************************/

boolean bcasc8Bit() {
	if (checkStage("8bit")) return true;
	if (!in_hardcore() || can_interact()) return checkStage("8bit", true);
	if (i_a("digital key") > 0) { 	
		checkStage("8bit", true);
		return true;
	}
	
	//Guarantee that we have an equippable 1-handed ranged weapon.
	if (my_primestat() == $stat[Moxie]) {
		while (i_a("disco ball") == 0) use(1, $item[chewing gum on a string]); 
	}
	
	while (i_a("digital key") == 0) {
		//First, we have to make sure we have at least one-handed moxie weapon to do this with. 	
		if (i_a("continuum transfunctioner") == 0) visit_url("mystic.php?action=crackyes3");
		bumAdv($location[8-Bit Realm], "+equip continuum transfunctioner +item drop", "items", "1 digital key", "Getting the Digital Key", "i");
	}
	checkStage("8bit", true);
	return true;
}

boolean bcascAirship() {
	if (checkStage("airship")) return true;
	
	if (can_interact() && item_amount($item[enchanted bean]) == 0) buy(1, $item[enchanted bean]);
	
	while (i_a("enchanted bean") == 0 && !contains_text(visit_url("plains.php"), "beanstalk.gif"))
		bumAdv($location[Beanbat Chamber], "", "items", "1 enchanted bean", "Getting an Enchanted Bean");
	
	cli_execute("set choiceAdventure182 = 2");
	
	string airshipGoals = "1 metallic A, 1 S.O.C.K.";
	if (!in_hardcore() || my_path() == "Bees Hate You" || my_path() == "Avatar of Boris") airshipGoals = "1 S.O.C.K.";
	while (index_of(visit_url("beanstalk.php"), "castle.gif") == -1) {
		bumAdv($location[Fantasy Airship], "", "itemsnc", airshipGoals, "Opening up the Castle by adventuring in the Airship", "-i");
	}
	
	cli_execute("use * fantasy chest");
	if (index_of(visit_url("beanstalk.php"), "castle.gif") > -1) {
		checkStage("airship", true);
		return true;
	}
	return false;
}

boolean bcascBats1() {
	string[int] clover_result;
	boolean stenchOK(){
		if (my_primestat() == $stat[mysticality]) {
			return elemental_resistance($element[stench]) > 5;
		}
		return elemental_resistance($element[stench]) > 0;
	}

	if (checkStage("bats1")) return true;
	if (use(3, $item[sonar-in-a-biscuit])) {}
	if (contains_text(visit_url("bathole.php"), "bathole_4.gif")) {
		return checkStage("bats1", true);
	}
	//Guano
	if (!contains_text(visit_url("questlog.php?which=2"), "slain the Boss Bat")) {
		//There's no need to get the air freshener if you have the Stench Resist Skill
		if (!stenchOK()) {
			buMax("+1000 stench res");
			//Check it NOW (i.e. see if we have stench resistance at all, and get an air freshener if you don't.
			if (!stenchOK()) {
				while (!have_skill($skill[Diminished Gag Reflex]) && (i_a("Pine-Fresh air freshener") == 0))
					bumAdv($location[Entryway], "", "items", "1 Pine-Fresh air freshener", "Getting a pine-fresh air freshener.");
			}
			buMax("+1000 stench res");
			if (!stenchOK()) {
				print("There is some error getting stench resist - perhaps you don't have enough Myst to equip the air freshener? Please manually sort this out.", "red");
				return false;
			}
		}
		
		buMax("+10 stench res");
		if (my_path() != "Bees Hate You") {
			while (item_amount($item[sonar-in-a-biscuit]) < 1 && contains_text(visit_url("bathole.php"), "action=rubble")) {
				//Let's use a clover if we can.
				if (i_a("sonar-in-a-biscuit") == 0 && cloversAvailable(true) > 0) {
					clover_result[0] = visit_url("adventure.php?snarfblat=31&confirm=on");
					if(!contains_text(clover_result[0], "but you see a few biscuits left over from whatever bizarre tea party")) {
						map_to_file(clover_result, "BCCDebug.txt");
						abort("BCC: There was a problem using your clover. Please try it manually.");
					}
				} else {
					bumAdv($location[Guano Junction], "+10stench res", "items", "1 sonar-in-a-biscuit", "Getting a Sonars");
				}
				if (cli_execute("use * sonar-in-a-biscuit")) {}
			}
			if (cli_execute("use * sonar-in-a-biscuit")) {}
		} else {
			//The screambat should show up every 8 turns, but make it 9 to account for potential bees
			if(count(split_string(visit_url("bathole.php"), "action=rubble")) == 4) {
				print("BCC: Hunting for the first screambat.");
				repeat {
					bumminiAdv(1, $location[Guano Junction], "");
				} until(last_monster() == $monster[screambat]);
			}
			if(count(split_string(visit_url("bathole.php"), "action=rubble")) == 3) {
				print("BCC: Hunting for a second screambat.");
				repeat {
					bumminiAdv(1, $location[Batrat and Ratbat Burrow], "");
				} until(last_monster() == $monster[screambat]);
			}
			if(count(split_string(visit_url("bathole.php"), "action=rubble")) == 2) {
				print("BCC: Hunting for a third screambat.");
				repeat {
					bumminiAdv(1, $location[Beanbat Chamber], "");
				} until(last_monster() == $monster[screambat]);
			}
		}
	}
		
	if (!contains_text(visit_url("bathole.php"), "action=rubble")) {
		checkStage("bats1", true);
		return true;
	}
	return false;
}

boolean bcascBats2() {
	if (checkStage("bats2")) return true;
	if (!checkStage("bats1")) return false;
	while (index_of(visit_url("questlog.php?which=1"), "I Think I Smell a Bat") > 0) {
		if (cli_execute("use 3 sonar")) {}
		
		if (contains_text(visit_url("bathole.php"), "action=rubble")) {
			cli_execute("set bcasc_stage_bats1 = 0");
			bcascBats1();
		}
		
		if (canMCD()) cli_execute("mcd 4");
		bumAdv($location[Boss Bat's Lair], "", "meatbossbat", "1 Boss Bat bandana", "WTFPWNing the Boss Bat", "m");
		visit_url("council.php");
	}
	checkStage("bats1", true);
	checkStage("bats2", true);
	return true;
}

boolean bcascCastle() {
	if (checkStage("castle")) return true;
	if (cli_execute("make 1 intragalactic rowboat")) {}
	if (checkStage("castle")) return true;
	
	if (in_hardcore()) {
		while (index_of(visit_url("beanstalk.php"), "hole.gif") == -1) {
			string goalsForCastle = "";
			switch (get_property("currentWheelPosition")) {
				case "muscle" : goalsForCastle = "2 choiceadv, "; break;
				case "mysticality" :
				case "moxie" :
					goalsForCastle = "1 choiceadv, ";
				break;
			}
			cli_execute("set choiceAdventure9 = 2");
			cli_execute("set choiceAdventure10 = 1");
			cli_execute("set choiceAdventure11 = 3");
			cli_execute("set choiceAdventure12 = 2");
			bumAdv($location[Giant's Castle], "", "itemsnc", goalsForCastle+"castle map items", "Opening up the HitS by adventuring in the Castle", "-i");
			if (cli_execute("use giant castle map")) {}
			if (cli_execute("make 1 intragalactic rowboat")) {}
		}
	} else {
		visit_url("council.php");
		while (!contains_text(visit_url("questlog.php?which=2"), "stopped the rain of giant garbage")) {
			cli_execute("set choiceAdventure9 = 2");
			cli_execute("set choiceAdventure10 = 1");
			cli_execute("set choiceAdventure11 = 3");
			cli_execute("set choiceAdventure12 = 2");
			bumAdv($location[Giant's Castle], "", "itemsnc", "1 choiceadv", "Getting one choiceadv adventuring in the Castle", "-i");
			visit_url("council.php");
		}
	}
	
	checkStage("castle", true);
	return true;
}

boolean bcascChasm() {
	boolean needLowercaseN() {
		if (i_a("lowercase N") >= 1) return false;
		if (!in_hardcore()) return false;
		if (my_path() == "Bees Hate You") return false;
		if (my_path() == "Avatar of Boris") return false;
		return true;
	}

	if (checkStage("chasm")) return true;
	if (index_of(visit_url("mountains.php"), "chasm.gif") > 0) {
		cli_execute("outfit swashbuckling getup");
		if (i_a("bridge") + i_a("abridged dictionary") == 0) {
			cli_execute("buy 1 abridged dictionary");
		}
		print("BCC: Using the dictionary.", "purple");
		//The below seems to exit the script on successful completion. I'm going to try capturing the output.
		visit_url("forestvillage.php?action=screwquest&submit=&quot;Sure Thing.&quot;");
		visit_url("forestvillage.php?place=untinker&action=screwquest");
		visit_url("forestvillage.php?action=screwquest&submit=&quot;Sure Thing.&quot;");
		safe_visit_url("knoll.php?place=smith");
		if (visit_url("mountains.php?orcs=1&pwd="+my_hash()).to_string() != "") {}
	}
	
	while (contains_text(visit_url("questlog.php?which=1"), "A Quest, LOL")) {
		if (index_of(visit_url("questlog.php?which=1"), "to the Valley beyond the Orc Chasm") > 0) {
			if (can_interact()) {
				buy(1, $item[668 scroll]);
				buy(1, $item[64067 scroll]);
			}
		
			cli_execute("set addingScrolls = 1");
			if (i_a("64735 scroll") == 0 || needLowercaseN()) {
				bumAdv($location[Orc Chasm], "", "items", "1 64735 scroll, 1 lowercase N", "Get me the 64735 Scroll", "i");
			} else if (i_a("64735 scroll") == 0) {
				bumAdv($location[Orc Chasm], "", "items", "1 64735 scroll", "Get me the 64735 Scroll", "i");
			}
			if (cli_execute("use 64735 scroll")) {}
		} else {
			abort("For some reason we haven't bridged the chasm.");
		}
	}
	checkStage("chasm", true);
	return true;
}

boolean bcascCyrpt() {
	boolean stageDone(string name) {
		if (get_revision() < 9260 && get_revision() > 0) abort("You need to update your Mafia to handle the cyrpt. A revision of at least 9260 is required. This script is only ever supported for a latest daily build.");
		print("The "+name+" is at "+get_property("cyrpt"+name+"Evilness")+"/50 Evilness...", "purple");
		return (get_property("cyrpt"+name+"Evilness") == 0);
	}
	
	if (checkStage("cyrpt")) return true;
	
	if (!contains_text(visit_url("questlog.php?which=2"), "defeated the Bonerdagon")) {
		set_property("choiceAdventure523", "4");
		use(1, $item[evilometer]);
		
		while (!stageDone("Nook")) {
			if (item_amount($item[evil eye]) > 0) use(1, $item[evil eye]);
			bumAdv($location[Defiled Nook], "", "items", "1 evil eye", "Un-Defiling the Nook (1/4)", "i");
			if (item_amount($item[evil eye]) > 0) use(1, $item[evil eye]);
		}
		while (!stageDone("Alcove")) {	//Kill modern zmobies (+initiative) to decrease evil
			use(item_amount($item[Okee-Dokee soda]),$item[Okee-Dokee soda]);
			use(item_amount($item[yellow candy heart]),$item[yellow candy heart]);
			bumAdv($location[Defiled Alcove], "", "", "", "Un-Defiling the Alcove (2/4)", "n");
		}
		while (!stageDone("Cranny")) {	//Kill swarms of ghuol welps (+NC, +ML) to decrease evil
			set_property("choiceAdventure523",4);
			bumAdv($location[Defiled Cranny], "", "", "", "Un-Defiling the Cranny (3/4)", "-");
		}
		while (!stageDone("Niche")) bumAdv($location[Defiled Niche], "", "", "", "Un-Defiling the Niche (4/4)");
		
		if (my_buffedstat(my_primestat()) > 101) {
			set_property("choiceAdventure527", "1");
			bumAdv($location[Haert of the Cyrpt], "", "meatboss");
			visit_url("council.php");
			if (item_amount($item[chest of the Bonerdagon]) > 0) {
				if (cli_execute("use chest of the Bonerdagon")) {}
				checkStage("cyrpt", true);
				return true;
			}
		}
	} else {
		checkStage("cyrpt", true);
		return true;
	}
	return false;
}

void bcascDailyDungeon() {
	if (my_adventures() < 10) return;
	zapKeys();
	int targetKeys = (get_property("bcasc_3KeysNoWand").to_boolean()) ? 3 : 2;
	if (numUniqueKeys() >= targetKeys || !in_hardcore()) return;
	
	int amountKeys;
	//Make skeleton keys if we can.
	if (i_a("skeleton bone") > 1 && i_a("loose teeth") > 1) {
		if (i_a("skeleton bone") > i_a("loose teeth")) {
			amountKeys = i_a("loose teeth") - 1;
		} else {
			amountKeys = i_a("skeleton bone") - 1;
		}
		cli_execute("make "+amountKeys+" skeleton key");
	}
	while (!contains_text(visit_url("dungeon.php"), "reached the bottom")) {
		if (have_skill($skill[Astral Shell])) {
			cli_execute("cast 2 astral shell");
		} else if (have_skill($skill[Elemental Saucesphere])) {
			cli_execute("cast 2 elemental saucesphere");
		}
		cli_execute("adv " + my_adventures() + " daily dungeon");
		if (my_adventures() == 0) abort("No adventures in the Daily Dungeon");
	}
	
	zapKeys();
}


boolean bcascDinghyHippy() {
	if (checkStage("dinghy")) return true;
	//We shore first so that we can get the hippy outfit ASAP.
	if (item_amount($item[dingy dinghy]) == 0) {
		if (index_of(visit_url("beach.php"), "can't go to Desert Beach") > 0)
			visit_url("guild.php?place=paco");
		
		if (item_amount($item[dinghy plans]) == 0) {
			print("BCC: Getting plans.", "purple");
			cli_execute("goal clear");
			
			matcher shore = create_matcher("You have taken (.+?) trip(s?) so far",  visit_url("shore.php"));
			if(shore.find()) {
				string numTripsTaken = shore.group(1);
				if (numTripsTaken == "no") numTripsTaken = "0";
				if (numTripsTaken < 5 && (my_meat() > 500*(5-to_int(numTripsTaken))))
					adventure((5-numTripsTaken.to_int()), to_location(to_string(my_primestat()) + " vacation"));
			}
			if (item_amount($item[dinghy plans]) == 0) abort("Unable to check shore progress (99% of the time, this is because you lack meat). I recommend you make the Dinghy manually.");
		}
		if (item_amount($item[dingy planks]) == 0) {
			print("BCC: Getting planks.", "purple");
			hermit(1, $item[dingy planks]);
		}
		print("BCC: Making the dinghy.", "purple");
		cli_execute("use dinghy plans");
	}
	
	if (can_interact()) {
		buy(1, $item[filthy knitted dread sack]);
		buy(1, $item[filthy corduroys]);
		return checkStage("dinghy", true);
	}
	
	if (!in_hardcore()) return checkStage("dinghy", true);
	
	while ((i_a("filthy knitted dread sack") == 0 || i_a("filthy corduroys") == 0) && have_effect($effect[Everything Looks Yellow]) == 0)
		bumAdv($location[Hippy Camp], "", "hebo", "1 filthy knitted dread sack, 1 filthy corduroys", "Getting Hippy Kit", "", "consultHeBo");
	
	if (i_a("filthy knitted dread sack") > 0 && i_a("filthy corduroys") > 0) {
		checkStage("dinghy", true);
		return true;
	}
	return false;
}

boolean bcascEpicWeapons() {
	if (bcasc_cloverless) return false;
	if (!in_hardcore()) return false;
	if (my_path() == "Avatar of Boris") return false;
	
	//Returns true if you lack one of the kickass astral weapons for your Mox/Mus class as appropriate.
	boolean dontHaveAstral() {
		switch (my_primestat()) {
			case $stat[Muscle] :
				return (i_a("astral mace") == 0);
			
			case $stat[Moxie] :
				return (i_a("astral longbow") + i_a("astral pistol") == 0);
		}
		return false;
	}
	
	boolean getEpic(string className, string baseWeapon, string theOtherThingYouNeed, string theEpicWeaponYouWantToGet) {
		print("BCC: Getting the "+className+" Epic Weapon", "purple");
		
		if (can_interact()) return buy(1, to_item(theEpicWeaponYouWantToGet));
		if (i_a(theEpicWeaponYouWantToGet) > 0) return true;
		
		while (i_a(baseWeapon) == 0) use(1, $item[chewing gum on a string]);
		if (i_a(theOtherThingYouNeed) == 0) {
			if (cli_execute("hermit "+theOtherThingYouNeed)) {}
		}
		
		if (i_a("big rock") == 0 && cloversAvailable(true) > 0) {
			print("BCC: Getting the Big Rock", "purple");
			visit_url("casino.php?action=slot&whichslot=11&confirm=on");
		}
		
		visit_url("guild.php?place=scg");
		visit_url("guild.php?place=scg");
		if (my_meat() < 1000 && i_a("tenderizing hammer") == 0 && !knoll_available()) return false;
		if (cli_execute("make "+theEpicWeaponYouWantToGet)) {}
		return true;
	}
	
	boolean requireRNR() {
		float n = 0;
		if (have_skill($skill[ The Moxious Madrigal ])) n += 0.1 + (0.1 * to_float(my_primestat() == $stat[Moxie]));
		if (have_skill($skill[ The Magical Mojomuscular Melody ])) n += 0.1 + (0.3 * to_float(my_primestat() == $stat[Mysticality]));
		if (have_skill($skill[ Cletus's Canticle of Celerity ])) n += 0.1;
		if (have_skill($skill[ The Power Ballad of the Arrowsmith ])) n += (0.5 * to_float(my_primestat() == $stat[Muscle]));
		if (have_skill($skill[ The Polka of Plenty ])) n += 0.1;
		if (have_skill($skill[ Jackasses' Symphony of Destruction ])) n += 0.2;
		if (have_skill($skill[ Fat Leon's Phat Loot Lyric ])) n += 0.8;
		if (have_skill($skill[ Brawnee's Anthem of Absorption ])) n += 0.1;
		if (have_skill($skill[ The Psalm of Pointiness ])) n += 0.1;
		if (have_skill($skill[ Stevedave's Shanty of Superiority ])) n += 0.2;
		if (have_skill($skill[ Aloysius' Antiphon of Aptitude ])) n += 0.2;
		if (have_skill($skill[ The Ode to Booze ])) n += 0.6;
		if (have_skill($skill[ The Sonata of Sneakiness ])) n += 0.5;
		if (have_skill($skill[ Ur-Kel's Aria of Annoyance ])) n += 0.4;
		if (have_skill($skill[ Dirge of Dreadfulness ])) n += 0.1;
		if (have_skill($skill[ Inigo's Incantation of Inspiration ])) n+= 0.7;
		return (n >= 1.0 || my_class() == $class[Accordion Thief]);
	}
	
	if(my_path() != "way of the surprising fist") {
		if (my_class() == $class[Disco Bandit] && my_basestat(my_primestat()) > 10 && i_a("Disco Banjo") == 0 && i_a("Shagadelic Disco Banjo") == 0 && i_a("Seeger's Unstoppable Banjo") == 0) {
			if (dontHaveAstral())
				if (getEpic("DB", "disco ball", "banjo strings", "disco banjo"))
					return true;
		}
		
		if (my_class() == $class[Turtle Tamer] && my_basestat(my_primestat()) > 10 && i_a("Mace of the Tortoise") == 0 && i_a("Chelonian Morningstar") == 0 && i_a("Flail of the Seven Aspects") == 0) {
			if (dontHaveAstral())
				if (getEpic("TT", "turtle totem", "chisel", "Mace of the Tortoise"))
					return true;
		}
		
		if (my_class() == $class[Seal Clubber] && my_basestat(my_primestat()) > 10 && i_a("Bjorn's Hammer") == 0 && i_a("Hammer of Smiting") == 0 && i_a("Sledgehammer of the Vælkyr") == 0) {
			if (dontHaveAstral())
				if (getEpic("SC", "seal-clubbing club", "seal tooth", "Bjorn's Hammer"))
					return true;
		}
		
		if (my_class() == $class[Sauceror] && my_basestat(my_primestat()) > 10 && ((have_skill($skill[jaba&ntilde;ero saucesphere]) || have_skill($skill[jalape&ntilde;o saucesphere])) || bcasc_bartender || bcasc_chef) && i_a("5-alarm Saucepan") == 0 && i_a("17-alarm Saucepan") == 0 && i_a("Windsor Pan of the Source") == 0) {
			if (getEpic("S", "saucepan", "jaba&ntilde;ero pepper", "5-alarm Saucepan"))
				return true;
		}
		
		if (my_class() == $class[Pastamancer] && my_basestat(my_primestat()) > 10 && (!have_skill($skill[springy fusilli]) || bcasc_bartender || bcasc_chef) && i_a("Pasta of Peril") == 0 && i_a("Greek Pasta of Peril") == 0 && i_a("Wrath of the Capsaician Pastalords") == 0) {
			if (getEpic("P", "pasta spoon", "petrified noodles", "Pasta of Peril"))
				return true;
		}
 	}
	
	if (my_basestat(my_primestat()) > 10 && i_a("Rock and Roll Legend") == 0 && i_a("Squeezebox of the Ages") == 0 && i_a("The Trickster's Trikitixa") == 0 && requireRNR()) {
		if(getEpic("AT", "stolen accordion", "hot buttered roll", "rock and roll legend"))
			return true;
	}
	return false;
}

boolean bcascFriars() {
	boolean needRubyW() {
		if (!in_hardcore()) return false;
		if (my_path() == "Bees Hate You") return false;
		if (my_path() == "Avatar of Boris") return false;
		return true;
	}
	
	if (checkStage("friars")) return true;
	if (visit_url("friars.php?action=ritual&pwd="+my_hash()).to_string() != "") {}
	
	if (index_of(visit_url("friars.php"), "friars.gif") > 0) {
		print("BCC: Gotta get the Friars' Items", "purple");
		while (item_amount($item[eldritch butterknife]) == 0)
			bumAdv($location[Dark Elbow of the Woods], "", "", "1 eldritch butterknife", "Getting butterknife from the Elbow (1/3)", "-");
			
		while (item_amount($item[box of birthday candles]) == 0)
			bumAdv($location[Dark Heart of the Woods], "", "", "1 box of birthday candles", "Getting candles from the Heart (2/3)", "-");
			
		while (item_amount($item[dodecagram]) == 0) {
			if (needRubyW()) {
				bumAdv($location[Dark Neck of the Woods], "", "items", "1 dodecagram, 1 ruby w", "Getting dodecagram from the Neck (3/3)", "-");
			} else {
				bumAdv($location[Dark Neck of the Woods], "", "", "1 dodecagram", "Getting dodecagram from the Neck (3/3)", "-");
			}
		}
			
		print("BCC: Yay, we have all three items. I'm off to perform the ritual!", "purple");
		if (visit_url("friars.php?action=ritual&pwd="+my_hash()).to_string() != "") {}
	}
	if (contains_text(visit_url("friars.php"), "pandamonium.php")) {
		checkStage("friars", true);
		return true;
	}
	return false;
}

boolean bcascFriarsSteel() {
	if (checkStage("friarssteel")) return true;
	if (can_interact() || get_property("bcasc_skipSteel") == "true") return checkStage("friarssteel", true);
	if (have_skill($skill[Liver of Steel]) || have_skill($skill[Spleen of Steel]) || have_skill($skill[Stomach of Steel])) return checkStage("friarssteel", true);

	boolean logicPuzzleDone() {
		/*    
			* Jim the sponge cake or pillow
			* Flargwurm the cherry or sponge cake
			* Blognort the marshmallow or gin-soaked paper
			* Stinkface the teddy bear or gin-soaked paper 
		*/
		if (item_amount($item[sponge cake]) + item_amount($item[comfy pillow]) + item_amount($item[gin-soaked blotter paper]) + item_amount($item[giant marshmallow]) + item_amount($item[booze-soaked cherry]) + item_amount($item[beer-scented teddy bear]) == 0) return false;
		
		int j = 0, f = 0, b = 0, s = 0, jf, bs;
		string sven = visit_url("pandamonium.php?action=sven");
		if (contains_text(sven, "<option>Bognort")) b = 1;
		if (contains_text(sven, "<option>Flargwurm")) f = 1;
		if (contains_text(sven, "<option>Jim")) j = 1;
		if (contains_text(sven, "<option>Stinkface")) s = 1;
		jf = j+f;
		bs = b+s;
		
		boolean x, y;
		x = ((item_amount($item[sponge cake]) >= jf) || (item_amount($item[sponge cake]) + item_amount($item[comfy pillow]) >= jf) || (item_amount($item[sponge cake]) + item_amount($item[booze-soaked cherry]) >= jf) || (item_amount($item[comfy pillow]) + item_amount($item[booze-soaked cherry]) >= jf));
		y = ((item_amount($item[gin-soaked blotter paper]) >= bs) || (item_amount($item[gin-soaked blotter paper]) + item_amount($item[giant marshmallow]) >= bs) || (item_amount($item[gin-soaked blotter paper]) + item_amount($item[beer-scented teddy bear]) >= bs) || (item_amount($item[beer-scented teddy bear]) + item_amount($item[giant marshmallow]) >= bs));
		print("BCC: x is "+x+" and y is "+y+". j, f, b, s are "+j+", "+f+", "+b+", "+s+".", "purple");
		return x && y;
	}
	
	if (to_string(visit_url("pandamonium.php")) != "") {}
	if (to_string(visit_url("pandamonium.php")) != "") {}
	if (checkStage("friarssteel")) return true;
	//Let's do this check now to get it out the way. 
	if (!contains_text(visit_url("questlog.php?which=1"), "this is Azazel in Hell")) {
		print("BCC: Unable to detect organ of steel quest.", "purple");
		return false;
	} else if (contains_text(visit_url("questlog.php?which=2"), "this is Azazel in Hell")) {
		checkStage("friarssteel", true);
		return true;
	}
	
	string steelName() {
		if (!can_drink() && !can_eat()) { return "steel-scented air freshener"; }
		if (!can_drink() || my_path() == "Avatar of Boris") { return "steel lasagna"; }
		return "steel margarita";
	}
	string steelWhatToDo() {
		if (!can_drink() && !can_eat()) { return "use steel-scented air freshener"; }
		if (!can_drink() || my_path() == "Avatar of Boris") { return "eat steel lasagna"; }
		return "drink steel margarita";
	}
	int steelLimit() {
		if (!can_drink() && !can_eat()) { return spleen_limit(); }
		if (!can_drink() || my_path() == "Avatar of Boris") { return fullness_limit(); }
		return inebriety_limit();
	}
	
	if ((steelLimit() > 16 && my_path() != "Avatar of Boris") || (my_path() == "Avatar of Boris" && steelLimit() - to_int(have_skill($skill[Legendary Appetite])) * 5 > 21)) return true;
	if (i_a(steelName()) > 0) {
		cli_execute(steelWhatToDo());
		if (steelLimit() > 16) {
			checkStage("friarssteel", true);
			return true;
		} else {
			abort("There was some problem using the steel item. Perhaps use it manually?");
		}
	}
	
	while (item_amount($item[Azazel's unicorn]) == 0) {
		//I'm hitting this page a couple times quietly because I'm fairly sure that the first time you visit him,
		//there's no drop-downs and this makes the script act screwy.
		visit_url("pandamonium.php?action=sven");
		visit_url("pandamonium.php?action=sven");
	
		//Solve the logic puzzle in the Hey Deze Arena to receive Azazel's unicorn
		cli_execute("mood execute");
		buMax();
		levelMe(70, false);
		print("BCC: Getting Azazel's unicorn and the bus passes", "purple");
		setFamiliar("itemsnc");
		cli_execute("mood execute; conditions clear");
		bumAdv($location[Hey Deze Arena], "", "itemsnc", "5 bus pass", "Let's get the bus passes first", "i");
		while (!logicPuzzleDone()) {
			bumMiniAdv(1, $location[Hey Deze Arena]);
		}
		int bog = 0, sti = 0, fla = 0, jim = 0;
		if (item_amount($item[giant marshmallow]) > 0) { bog = to_int($item[giant marshmallow]); }
		if (item_amount($item[beer-scented teddy bear]) > 0) { sti = to_int($item[beer-scented teddy bear]); }
		if (item_amount($item[booze-soaked cherry]) > 0) { fla = to_int($item[booze-soaked cherry]); }
		if (item_amount($item[comfy pillow]) > 0) { jim = to_int($item[comfy pillow]); }
		if (bog == 0) bog = to_int($item[gin-soaked blotter paper]);
		if (sti == 0) sti = to_int($item[gin-soaked blotter paper]);
		if (fla == 0) fla = to_int($item[sponge cake]);
		if (jim == 0) jim = to_int($item[sponge cake]);
		if (contains_text(visit_url("pandamonium.php?action=sven"), "<option>Bognort")) visit_url("pandamonium.php?action=sven&bandmember=Bognort&togive="+bog+"&preaction=try");
		if (contains_text(visit_url("pandamonium.php?action=sven"), "<option>Stinkface")) visit_url("pandamonium.php?action=sven&bandmember=Stinkface&togive="+sti+"&preaction=try");
		if (contains_text(visit_url("pandamonium.php?action=sven"), "<option>Flargwurm")) visit_url("pandamonium.php?action=sven&bandmember=Flargwurm&togive="+fla+"&preaction=try");
		if (contains_text(visit_url("pandamonium.php?action=sven"), "<option>Jim")) visit_url("pandamonium.php?action=sven&bandmember=Jim&togive="+jim+"&preaction=try");
		if (item_amount($item[Azazel's unicorn]) == 0) abort("The script doesn't have the unicorn, but it should have. Please do this part manually.");
	}
	
	while (item_amount($item[Azazel's lollipop]) == 0) {
		levelMe(77, false);
		void tryThis(item i, string preaction) {
			if (item_amount(i) > 0) { 
				equip(i);
				visit_url("pandamonium.php?action=mourn&preaction="+preaction); 
			}
		}
	
		//Adventure in Belilafs Comedy Club until you encounter Larry of the Field of Signs. Equip the observational glasses and Talk to Mourn. 
		print("BCC: Getting Azazel's lollipop", "purple");
		while (item_amount($item[observational glasses]) == 0) bumAdv($location[Belilafs Comedy Club], "", "items", "1 observational glasses", "Getting the Observational Glasses", "i");
		if (my_path() != "Avatar of Boris") cli_execute("unequip weapon");
		if (my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") tryThis($item[Victor, the Insult Comic Hellhound Puppet], "insult");
		tryThis($item[observational glasses], "observe");
		if (my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") tryThis($item[hilarious comedy prop], "prop");
	}
	
	while (item_amount($item[Azazel's tutu]) == 0) {
		//After collecting 5 cans of imp air and 5 bus passes from the comedy blub and backstage, go the Moaning Panda Square to obtain Azazel's tutu. 
		print("BCC: Getting Azazel's tutu", "purple");
		while (item_amount($item[bus pass]) < 5) bumAdv($location[Hey Deze Arena], "", "items", "5 bus pass", "Getting the 5 Bus Passes", "i");
		while (item_amount($item[imp air]) < 5)  bumAdv($location[Belilafs Comedy Club], "", "items", "5 imp air", "Getting the 5 Imp Airs", "i");
		visit_url("pandamonium.php?action=moan");
	}
	
	visit_url("pandamonium.php?action=temp");
	cli_execute(steelWhatToDo());
	if (steelLimit() > 16) {
		checkStage("friarssteel", true);
		return true;
	} else {
		abort("There was some problem using the steel item. Perhaps use it manually?");
	}
	abort("There was some problem using the steel item. Perhaps use it manually or something?");
	return false;
}

boolean bcascGuild() {
	if (!in_hardcore() || my_path() == "Avatar of Boris") return checkStage("guild", true);
	if (checkStage("guild")) return true;
	setFamiliar("");
	location loc;
	while (!guild_store_available()) {
		switch (my_primestat()) {
			case $stat[Muscle] : loc = $location[Outskirts of The Knob]; break;
			case $stat[Mysticality]: loc = $location[Haunted Pantry]; break;
			case $stat[Moxie] : 
				loc = $location[Sleazy Back Alley];
				buMax("");
				if (item_type(equipped_item($slot[pants])) != "pants") return false;
			break;
		}
		print("BCC: The script is trying to unlock the guild quest. If this adventures forever in the starting area, type 'ash set_property(\"bcasc_stage_guild\", my_ascensions())' into the CLI to stop it.", "purple");
		bumMiniAdv(1, loc);
		visit_url("guild.php?place=challenge");		
	}
	visit_url("guild.php?place=challenge");		
	
	if (guild_store_available() && my_basestat(my_primestat()) > 12) {
		checkStage("guild", true);
		return true;
	}
	return false;
}

boolean bcascHoleInTheSky() {
	if (checkStage("hits")) return true;
	if (can_interact()) {
		//Don't need to do anything here because the lair automatically gets these. 
	}
	if (!in_hardcore()) return checkStage("hits", true);
	
	setFamiliar("items");
	setMood("i");
	buMax();
	cli_execute("conditions clear");
	levelMe((get_property("bcasc_ignoreSafeMoxInHardcore") == "true" ? 0 : safeMox($location[Hole in the Sky])));
	cli_execute("conditions clear");
	
	while (i_a("star hat") == 0 || (i_a("star crossbow") == 0 && my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") || i_a("richard's star key") == 0) {
		bumMiniAdv(1, $location[Hole in the Sky]);
		if (item_amount($item[star chart]) > 0) {
			if (equipped_item($slot[hat]) != $item[star hat]) { (!retrieve_item(1, $item[star hat])); }
			if (equipped_item($slot[weapon]) != $item[star crossbow] && my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") { (!retrieve_item(1, $item[star crossbow])); }
			(!retrieve_item(1, $item[richards star key]));
		}
	}
	checkStage("hits", true);
	return true;
}

boolean bcascInnaboxen() {
	if (bcasc_cloverless) return false;
	if (my_path() == "Bees Hate You" || my_path() == "Avatar of Boris") return false;
	if (checkStage("innaboxen")) return true;
	if (!in_hardcore()) return checkStage("innaboxen", true);
	boolean trouble = false;
	
	int[item] campground = get_campground();
	if((bcasc_bartender && campground contains to_item("bartender-in-the-box")) && (bcasc_chef && campground contains to_item("chef-in-the-box"))) {
		checkStage("innaboxen", true);
		return true;
	} else if((bcasc_bartender && !bcasc_chef) && campground contains to_item("bartender in-the-box")) {
		checkStage("innaboxen", true);
		return true;
	} else if((!bcasc_bartender && bcasc_chef) && campground contains to_item("chef-n-the-box")) {
		checkStage("innaboxen", true);
		return true;
	} else if(!bcasc_bartender && !bcasc_chef) {
		checkStage("innaboxen", true);
		return true;
	}
	
	//Thanks, gruddlefitt!
	item bcascWhichEpic() {
		item [class] epicMap;
		epicMap[$class[Seal Clubber]] = $item[Bjorn's Hammer];
		epicMap[$class[Turtle Tamer]] = $item[Mace of the Tortoise];
		epicMap[$class[Pastamancer]] = $item[Pasta of Peril];
		epicMap[$class[Sauceror]] = $item[5-Alarm Saucepan];
		epicMap[$class[Disco Bandit]] = $item[Disco Banjo];
		epicMap[$class[Accordion Thief]] = $item[Rock and Roll Legend];
		return epicMap[my_class()];
	}
	
	boolean getBox() {
		//I know, we should already have run this, but what's a visit to the hermit between friends?
		if (i_a("box") > 0) { return true; }
		item epicWeapon = bcascWhichEpic();
		if (item_amount(epicWeapon) == 0) { return false; }
		
		//Then hit the guild page until we see the clown thingy.
		while (!contains_text(visit_url("plains.php"), "funhouse.gif")) {
			print("BCC: Visiting the guild to unlock the funhouse", "purple");
			visit_url("guild.php?place=scg");
		}
		
		if (cloversAvailable(true) > 0) {
			visit_url("adventure.php?snarfblat=20&confirm=on");
			return true;
		}
		
		return false;
	}
	
	if (index_of(visit_url("questlog.php?which=2"), "defeated the Bonerdagon") > 0) {
		//At this point, we can clover the Cemetary for innaboxen. 
		cloversAvailable();
		
		//Apart from the brain/skull, we need a box and spring and the chef's hat/beer goggles.
		if (!contains_text(visit_url("campground.php?action=inspectkitchen"), "Chef-in-the-Box") && bcasc_chef) {
			//We're not even going to bother to try if we don't have a chef's hat. 
			if (i_a("chef's hat") > 0 && (i_a("spring") > 0 || knoll_available())) {
				print("BCC: Going to try to make a chef", "purple");
				if (getbox()) {
					if (creatable_amount($item[chef-in-the-box]) == 0) {
						//Then the only thing we could need would be brain/skull, as we've checked for all the others. 
						if (cloversAvailable(true) > 0) {
							visit_url("adventure.php?snarfblat=58&confirm=on");
							cli_execute("use chef-in-the-box");
						} else {
							print("BCC: Uhoh, we don't have enough clovers to get the brain/skull we need.", "purple");
							trouble = true;
						}
					} else {
						cli_execute("use chef-in-the-box");
					}
				} else {
					print("BCC: There was a problem getting the box.", "purple");
					trouble = true;
				}
			}
		}
		
		if (bcasc_bartender) {
			if (!contains_text(visit_url("campground.php?action=inspectkitchen"), "Bartender-in-the-Box")) {
				if (i_a("spring") > 0 || knoll_available()) {
					print("BCC: Going to try to get a bartender.", "purple");
					if (getBox()) {
						if (creatable_amount($item[bartender-in-the-box]) == 0) {
							if (creatable_amount($item[brainy skull]) + available_amount($item[brainy skull]) == 0) {
								if (cloversAvailable(true) > 0) {
									visit_url("adventure.php?snarfblat=58&confirm=on");
								} else {
									print("BCC: Uhoh, we don't have enough clovers to get the brain/skull we need.", "purple");
									trouble = true;
								}
							}
							
							while (creatable_amount($item[beer goggles]) + available_amount($item[beer goggles]) == 0) {
								bumAdv($location[A Barroom Brawl], "", "items", "1 beer goggles", "Getting the beer goggles");
							}
							
							if (creatable_amount($item[bartender-in-the-box]) > 0) {
								cli_execute("use bartender-in-the-box");
							}
						} else {
							cli_execute("use bartender-in-the-box");
						}
					} else {
						print("BCC: There was a problem getting the box.", "purple");
						trouble = true;
					}
				}
			}
		}
		
		if (!trouble) {
			checkStage("innaboxen", true);
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}

boolean bcascKnob() {
	if (checkStage("knob")) return true;
	while (contains_text(visit_url("plains.php"), "knob1.gif") && item_amount($item[knob goblin encryption key]) == 0) {
		bumAdv($location[Outskirts of the Knob], "", "", "1 knob goblin encryption key", "Let's get the Encryption Key");
	}
	checkStage("knob", true);
	return true;
}

boolean bcascKnobKing() {
	if (checkStage("knobking")) return true;
	if (contains_text(visit_url("questlog.php?which=2"), "slain the Goblin")) return checkStage("knobking", true);
	//Before we go into the harem, we gotta use the map. 
	if (item_amount($item[Cobb's Knob map]) > 0) {
		use(1, $item[Cobb's Knob map]);
	}
	
	if (can_interact()) {
		print("BCC: You can interact, so do this the lazy way.", "purple");
		while (!contains_text(visit_url("questlog.php?which=2"), "slain the Goblin King")) {
			cli_execute("outfit knob goblin harem girl disguise");
			cli_execute("use knob goblin perfume");
			bumAdv($location[Throne Room], "+outfit knob goblin harem girl disguise", "meatboss", "", "Killing the Knob King");
		}
		return checkStage("knobking", true);
	}
	
	if (!contains_text(visit_url("questlog.php?which=2"), "slain the Goblin King") || (!dispensary_available() && my_path() != "Bees Hate You" && my_path() != "Avatar of Boris")) {
		if (my_path() != "Bees Hate You" && my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris" && my_primestat() != $stat[Moxie]) {
			//First we need the KGE outfit. 
			while (i_a($item[Knob Goblin elite pants]) == 0 || i_a($item[Knob Goblin elite polearm]) == 0 || i_a($item[Knob Goblin elite helm]) == 0) {
				bumAdv($location[Cobb's Knob Barracks], "", "items", "1 Knob Goblin elite pants, 1 Knob Goblin elite polearm, 1 Knob Goblin elite helm", "Getting the KGE Outfit");
			}

			//Then we need the cake. 
			if (!contains_text(visit_url("campground.php?action=inspectkitchen"), "Dramatic")) {
				if (!use(1, to_item("Dramatic range")))
				if (!contains_text(visit_url("campground.php?action=inspectkitchen"), "Dramatic")) abort("You need a dramatic oven for this to work.");
			}

			while (available_amount($item[Knob cake]) + creatable_amount($item[Knob cake]) == 0) {
				while (item_amount($item[Knob frosting]) == 0) {
					bumAdv($location[Cobb's Knob Kitchens], "+outfit knob goblin elite guard uniform", "", "1 knob frosting", "Getting the Knob Frosting");
				}
				
				while (available_amount($item[unfrosted Knob cake]) + creatable_amount($item[unfrosted Knob cake]) == 0) {
					bumAdv($location[Cobb's Knob Kitchens], "+outfit knob goblin elite guard uniform", "", "1 Knob cake pan, 1 knob batter", "Getting the Knob Pan and Batter");
				}
			}
			if (item_amount($item[Knob cake]) == 0) {
				if(to_boolean(get_property("requireBoxServants"))) {
					if(user_confirm("BCC: You have requireBoxServants set to true. The script want to create a Knob Cake, do you wish to continue?")) {
						set_property("requireBoxServants", false);
						if (cli_execute("make knob cake")) {}
						set_property("requireBoxServants", true);
					}
				}
				else 
				{
					if (cli_execute("make knob cake")) {}
				}
			}
			
			//Now the Knob Goblin King has 55 Attack, and we'll be fighting him with the MCD set to 7. So that's 55+7+7=69 Moxie we need. 
			//Arbitrarily using 75 because will need the harem outfit equipped. 
			if (item_amount($item[Knob cake]) > 0) {
				buMax();
				if (my_buffedstat(my_primestat()) >= 75) {
					bumAdv($location[Throne Room], "+outfit knob goblin elite guard uniform", "meatboss", "", "Killing the Knob King");
					checkStage("knobking", true);
					return true;
				}
			}

			if (contains_text(visit_url("questlog.php?which=2"), "slain the Goblin King") && !dispensary_available() && my_path() != "Bees Hate You") {
				//Just get the password.
				cli_execute("outfit knob goblin elite guard uniform");
				while (!dispensary_available() && my_path() != "Bees Hate You" ) {
					print("BCC: Adventuring once to learn it's FARQUAR. Surely you'd remember this when you reincarnate?", "purple");
					adventure(1, $location[Cobb's Knob Barracks]);
				}
			}
		} else {
			//Bees hate harem girl outfits slightly less, and moxie classes need a ranged weapon.
			while (i_a($item[Knob Goblin harem pants]) == 0 || i_a($item[Knob Goblin harem veil]) == 0) {
				bumAdv($location[Cobb's Knob Harem], "", "items", "1 Knob Goblin harem pants, 1 Knob Goblin harem veil", "Getting the Harem Outfit", "", "i");
			}
			
			//Then we need to be perfumed up, but not before we're powerful enough to beat Mr King
			//Now the Knob Goblin King has 55 Attack, and we'll be fighting him with the MCD set to 7. So that's 55+7+7=69 Moxie we need. 
			//Arbitrarily using 75 because will need the harem outfit equipped. 
			buMax();
			if (my_buffedstat(my_primestat()) >= 75) {
				if(my_path() == "Bees Hate You" || (my_path() != "Bees Hate You" && i_a($item[Knob Goblin perfume]) == 0)) {
					print("BCC: Getting perfumed up for the King");
					cli_execute("outfit Knob Goblin Harem Girl Disguise");
					while(have_effect($effect[Knob Goblin Perfume]) == 0) bumminiAdv(1, $location[Cobb's Knob Harem]);
				}
				else
					use(1, $item[Knob Goblin perfume]);

				bumAdv($location[Throne Room], "+outfit Knob Goblin Harem Girl Disguise", "meatboss", "", "Killing the Knob King");
				checkStage("knobking", true);
				return true;
			}
		}
	} else {
		checkStage("knobking", true);
		return true;
	}
	return false;
}

boolean bcascKnobPassword() {
	if (item_amount($item[Cobb's Knob lab key]) == 0) return false;
	if (my_path() == "Bees Hate You" || my_path() == "Way of the Surprising Fist" || my_path() == "Avatar of Boris") return false;
	while (!dispensary_available() && my_path() != "Bees Hate You") {
		while (i_a($item[Knob Goblin elite pants]) == 0 || i_a($item[Knob Goblin elite polearm]) == 0 || i_a($item[Knob Goblin elite helm]) == 0) {
			bumAdv($location[Cobb's Knob Barracks], "", "items", "1 Knob Goblin elite pants, 1 Knob Goblin elite polearm, 1 Knob Goblin elite helm", "Getting the KGE Outfit");
		}
		cli_execute("outfit knob goblin elite guard uniform");
		
		if (my_adventures() == 0) abort("No adventures trying to learn FARQUAR.");
		print("BCC: Adventuring once to learn it's FARQUAR. Surely you'd remember this when you reincarnate.", "purple");
		adventure(1, $location[Cobb's Knob Barracks]);
	}
	if (dispensary_available())
		return true;
	else
		return false;
}

void bcascLairFightNS() {
	print("BCC: Fighting the NS", "purple");
	if (canMCD()) cli_execute("mcd 0");
	buMax();
	cli_execute("uneffect beaten up; restore hp; restore mp");
	
	if (item_amount($item[ng]) > 0) cli_execute("untinker ng");
	if (item_amount($item[wand of nagamar]) == 0) {
		if (!retrieve_item(1, $item[wand of nagamar])) {
			if (!take_storage(1, $item[wand of nagamar])) {
				abort("Failed to create the wand!");
			}
		}
	}
	if (item_amount($item[wand of nagamar]) == 0) abort("Failed to get the wand!");
	
	if (my_primestat() == $stat[Mysticality]) {
		buMax("DA, DR");
	}
	
	setFamiliar("");
	if (bcasc_fightNS) {
		visit_url("lair6.php?place=5");
		for i from 1 to 3 {
			if (!contains_text(bumRunCombat(), "You win the fight!")) {
				abort("Maybe you should fight Her Naughtiness yourself...");
			}
		}
		ascendLog("yes");
		if (!contains_text(visit_url("trophy.php"), "not currently entitled to")) abort("You're entitled to some trophies!");
		print("BCC: Hi-keeba!", "purple");
		visit_url("lair6.php?place=6");
		if (get_property("bcasc_getItemsFromStorage") == "true") {
			print("BCC: Getting all your items out of Storage. Not all bankers are evil, eh?", "purple");
			visit_url("storage.php?action=pullall&pwd=");
		}
		abort("Tada! Thank you for using bumcheekascend.ash.");
	} else {
		abort("Bring it on.");
	}
}

boolean bcascLairFirstGate() {
	boolean tryPull(string i, boolean abortOnFailure) {
		item it = to_item(i);
		
		if(pulls_remaining() > 0)
			if (take_storage(1, it))
				return true;
		if (abortOnFailure) abort("We need a '"+i+"', but the script cannot get this item (if you are in softcore, you can't pull it either).");
		return false;
	}
	boolean tryPull(string i) { return tryPull(i, false); }

	if (checkStage("lair1")) return true;
	load_current_map("bumrats_lairitems", lairitems);
	html = visit_url("lair1.php?action=gates");
	int numGatesWeHaveItemFor = 0;
	
	foreach x in lairitems {
		if (contains_text(html, lairitems[x].gatename)) {
			print("BCC: We see "+lairitems[x].gatename, "purple");
			
			if (i_a(lairitems[x].a) > 0 || have_effect(to_effect(lairitems[x].effectname)) > 0) {
				print("BCC: We have the effect/item, for that gate.", "purple");
				numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
			} else {
				print("BCC: We do not have the item for that gate. (We need a "+lairitems[x].a+" for that.)", "purple");
				
				//So get the item, using a clover for the gum.  
				if (contains_text(lairitems[x].a, "chewing gum") && i_a(to_string(lairitems[x].a)) == 0) {
					print("BCC: I'm going to get the chewing gum using a clover.", "purple");
					if (i_a("pack of chewing gum") == 0) {
						if (cloversavailable(true) > 0) {
							visit_url("adventure.php?snarfblat=45&confirm=on");
							cli_execute("use pack of chewing gum");
							numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						} else {
							print("BCC: I dont have a clover, so am going to adventure to get the gum. .", "purple");
							if(bumAdv($location[South of the Border], "", "", "1 " + to_string(lairitems[x].a), "Hunting for Chewing Gums", "-"))
								numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						}
					} else {
						cli_execute("use pack of chewing gum");
						numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
					}
				} else if (lairitems[x].a == "dod") {
					if (item_amount(bangPotionWeNeed().to_item()) == 0) {
						cli_execute("use * dead mimic; use * large box; use * small box");
						
						setFamiliar("items");
						setMood("i+");
						while (!identifyBangPotions() && (bangPotionWeNeed() == "")) {
							bumMiniAdv(1, $location[Dungeons of Doom]);
							cli_execute("use * dead mimic; use * large box; use * small box");
						}
							
						//So at this point, we at least know WHICH bang potion we need, though we don't know whether we have it or not.
						while (item_amount(bangPotionWeNeed().to_item()) == 0) {
							bumMiniAdv(1, $location[Dungeons of Doom]);
							cli_execute("use * dead mimic; use * large box; use * small box");
						}
					}
					
					if (item_amount(bangPotionWeNeed().to_item()) > 0) { numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1; }
				} else {
					//Now check for any other item(s).
					switch (lairitems[x].a) {
						case "marzipan skull" :
							if (gnomads_available()) {
								cli_execute("buy marzipan skull");
								numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
							} else {
								if(tryPull(lairitems[x].a, true)) {numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;}
							}
						break;
						
						case "Meleegra pills" :
							if (!tryPull(lairitems[x].a))
								if(bumAdv($location[South of the Border], "", "items", "1 Meleegra pills", "Getting some Meelegra pills", "-i"))
									numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						break;
						
						case " gremlin juice" :
							if (!tryPull(lairitems[x].a))
								if(bumAdv($location[post-war junkyard], "", "hebo", "1 gremlin juice", "Getting gremlin juice", "", "consultHeBo"))
									numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						break;
						
						case "handsomeness potion" :
							if (!tryPull(lairitems[x].a))
								if(bumAdv($location[South of the Border], "", "hebo", "1 handsomeness potion", "Getting some Meelegra pills", "+i"))
									numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						break;
						
						case "thin black candle" :
							if (!tryPull(lairitems[x].a))
								if(bumAdv($location[Giant's Castle], "", "items", "1 thin black candle", "Getting some Meelegra pills", "-i"))
									numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						break;
						
						case "Mick's IcyVapoHotness Rub" :
							if (!tryPull(lairitems[x].a))
								if(bumAdv($location[Giant's Castle], "", "items", "1 Mick's IcyVapoHotness Rub", "Getting some Meelegra pills", "+i"))
									numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;
						break;
						
						default :
							if (lairitems[x].a != "") {
								if(tryPull(lairitems[x].a, true)) {numGatesWeHaveItemFor = numGatesWeHaveItemFor + 1;}
							} else {
								//abort("Due to the way the gates are handled, the script aborts here. Please re-run it.");
							}
						break;
					}
				}
			}
		}
	}
	
	print("BCC: The number of gates for which we have items is "+numGatesWeHaveItemFor, "purple");
	//When we get to this point, check if we have all the items. 
	if (numGatesWeHaveItemFor == 3 || (my_path() == "Bees Hate You" && numGatesWeHaveItemFor == 1)) {
		if (get_property("bcasc_useCloverInEntryway") == "true") {
			if (cloversAvailable() > 0) use(1, $item[disassembled clover]);
		}
		if (entryway()) {
			print("BCC: We got through the whole entryway. That's fairly unlikely at this point....", "purple");
		} else {
			//Check that lair2.php appears, because we should have got through the gates and at least be in the Mariachi bit.
			if (!contains_text(visit_url("lair1.php"), "lair2.php")) {
				print("We successfully got through lair1.php and probably a section of lair2.php as well.", "purple");
			} else {
				abort("We did not successfully get to lair2.php. This is a major error. You should probably do the rest of this manually.");
			}
		}
	} else {
		abort("We do not have all the items for the gates. This script cannot yet get them. ");
	}
	
	checkStage("lair1", true);
	return true;
}

boolean bcascLairMariachis() {
	if (checkStage("lair2")) return true;
	print("BCC: We are doing the Mariachi part.", "purple");
	cli_execute("maximize hp -equip tambourine -equip big bass drum -equip black kettle drum");
	
	//Before we do anything, we must ensure we have the instruments. 
	
	
	//We should have two keys. Two DISTINCT keys.
	if (numUniqueKeys() >= 2) {
		if (i_a("makeshift SCUBA gear") == 0) {
			if (i_a("boris's key") > 0 && i_a("fishbowl") == 0 && i_a("hosed fishbowl") == 0) {
				print("BCC: We have boris's key, but no fishbowl. Do the entryway.", "purple");
				if (entryway()) {}
			}
			if (i_a("jarlsberg's key") > 0 && i_a("fishtank") == 0 && i_a("hosed tank") == 0) {
				print("BCC: We have jarlsberg's key, but no fisktank. Do the entryway.", "purple");
				if (entryway()) {}
			}
			if (i_a("sneaky pete's key") > 0 && i_a("fish hose") == 0 && i_a("hosed tank") == 0 && i_a("hosed fishbowl") == 0) {
				print("BCC: We have sneaky pete's key, but no fish hose. Do the entryway.", "purple");
				if (entryway()) {}
			}
		
			if (numOfWand() > 0) {
				if (canZap()) {
					//At this point, we haven't used our wand and have two distinct keys. 
					if (numUniqueKeys() >= 3) {
						print("BCC: You had all three keys. You don't need to zap them.", "purple");
					} else {
						//abort("za");
						if (i_a("boris's key") > 0) {
							cli_execute("zap boris's key");
						} else {
							cli_execute("zap jarlsberg's key");
						}
					}
				} else {
					print("BCC: Your wand is not perfectly safe to zap, and as such we will not attempt to do so.", "purple");
				}
			} else {
				abort("You don't have a wand. No Zapping for you.");
			}
		}
		
		boolean armed() {
			return contains_text(visit_url("lair2.php"), "lair3.php");
		}

		if (entryway()) {}
		if (!armed()) {
			print("BCC: Maybe we're missing an instrument.", "purple");
			boolean haveAny(boolean[item] array) {
				foreach thing in array {
					if (i_a(thing) > 0) return true;
				}
				//So we don't have any of the things. Pull one. Or buy one. 
				if (!in_hardcore()) {
					foreach thing in array {
						if (can_interact()) {
							return buy(1, thing);
						} else {
							return take_storage(1, thing);
						}
					}
				}
				return false;
			}

			boolean[item] strings = $items[
				acoustic guitarrr,
				heavy metal thunderrr guitarrr,
				stone banjo,
				Disco Banjo,
				Shagadelic Disco Banjo,
				Seeger's Unstoppable Banjo,
				Crimbo ukelele,
				Massive sitar,
				4-dimensional guitar,
				plastic guitar,
				half-sized guitar,
				out-of-tune biwa,
				Zim Merman's guitar,
			];
			boolean[item] squeezings = $items[stolen accordion,calavera concertina,Rock and Roll Legend,Squeezebox of the Ages,The Trickster's Trikitixa,];
			boolean[item] drums = $items[tambourine,big bass drum,black kettle drum,bone rattle,hippy bongo,jungle drum,];

			if (!haveAny(strings))
				bumAdv($location[Belowdecks], "+equip pirate fledges", "items", "1 acoustic guitarrr", "Getting a guitar", "i");
				
			if (!haveAny(squeezings))
				while (i_a("stolen accordion") == 0) use(1, $item[chewing gum on a string]);
				
			if (!haveAny(drums))
				abort("You need a drum, but this script can't get any"); 
			
			if (entryway()) {}
		}
		
		if (entryway()) {}
		if (armed()) {
			checkStage("lair2", true);
			return true;
		} else {
			abort("Failed to arm the mariachis"); 
		}
	} else {
		abort("You don't have two distinct legend keys. This script will not attempt to zap anything.");
	}
	abort("There has been a problem in the mariachi section. Please report this issue and complete the mariachi bit manually.");
	return false;
}

void bcascLairTower() {
	//Firstly, maximize HP and make sure we have a sugar shield to get through the shadow/familiars. 
	cli_execute("maximize "+max_bees+" beeosity, hp; restore hp");
	if (i_a("sugar shield") == 0) { if (cli_execute("cast summon sugar; make sugar shield")) {} }
	
	//Then get through the place.
	cli_execute("use * canopic jar");
	cli_execute("use * black picnic basket");
	item missing = $item[steaming evil];
	
	if (in_hardcore()) {
		missing = guardians();
		if (missing == $item[none]) {
			if (cli_execute("pool 1")) {}
			if (cli_execute("concert dilated pu")) {}
			
			if (contains_text(visit_url("lair6.php"), "?place=5")) {
				bcascLairFightNS();
			} else {
				abort("You are stuck at the top of the tower.");
			}
		} else {
			abort("You need a "+ missing +" to continue.");
		}
	} else {
		//If softcore/casual then we have the option to pull or buy items.
		while (missing != $item[none]) {
			missing = guardians();
			if (missing != $item[none] && can_interact()) {
				buy(1, missing);
			}
			if (missing != $item[none] && pulls_remaining() > 0) {
				take_storage(1, missing);
			}
		}
		if (cli_execute("pool 1")) {}
		if (cli_execute("concert Optimist Primal")) {}
		
		if (contains_text(visit_url("lair6.php"), "?place=5")) {
			bcascLairFightNS();
		} else {
			abort("You are stuck at the top of the tower.");
		}
	}
}

boolean bcascMacguffinFinal() {
	if (checkStage("macguffinfinal")) return true;

	if (contains_text(visit_url("questlog.php?which=1"),"A Pyramid Scheme")) {
		if (!contains_text(visit_url("beach.php"),"pyramid.php")) visit_url("beach.php?action=woodencity");
		if (can_interact()) {
			retrieve_item(11, $item[tomb ratchet]);
		}
		
		//Set to turn the wheel. 134 is the initial and 135 subsequent visits. 
		set_property("choiceAdventure134","1");
		set_property("choiceAdventure135","1");
		if (!contains_text(visit_url("pyramid.php"),"pyramid3b.gif")) {
			if (item_amount($item[tomb ratchet]) > 0) {
				use(1, $item[tomb ratchet]);
			} else {
				if (i_a("carved wooden wheel") == 0) bumAdv($location[Upper Chamber], "", "", "carved wooden wheel", "Getting the Carved Wooden Wheel");
				bumAdv($location[Middle Chamber], "", "", "choiceadv", "Getting the initial choice adventure", "-");
			}
		}
		
		if (get_property("pyramidBombUsed") != "true") {
			boolean pyrstep(string stepname,string posnum) {
				print("BCC: "+stepname+" (image "+posnum+")", "purple");
				while (get_property("pyramidPosition") != posnum) {
					if (can_interact() || item_amount($item[tomb ratchet]) > 0 && my_path() != "Bees Hate You") {
						use(1, $item[tomb ratchet]);
					} else {
						bumAdv($location[Middle Chamber], "", "", "choiceadv", "Getting another choice adventure", "-");
					}
				}
				//No need to use bumMiniAdv here. Doing so causes a problem for casual runs.
				return adventure(1, $location[lower chambers]);
			}
			
			if (item_amount($item[ancient bronze token]) == 0 && item_amount($item[ancient bomb]) == 0 && !pyrstep("Step 1 / 3: get a token.","4"))
				abort("Unable to get a token.");
			
			if (item_amount($item[ancient bronze token]) > 0 && item_amount($item[ancient bomb]) == 0 && !pyrstep("Step 2 / 3: exchange token for a bomb.","3"))
				abort("Unable to exchange token for bomb.");
			
			if (item_amount($item[ancient bomb]) > 0)
				if (!pyrstep("Step 3 / 3: reveal Ed's chamber.","1")) abort("Unable to use bomb");
		}
		
		//Fight Ed
		if (my_adventures() < 7) { abort("You don't have enough adventures to fight Ed."); }
		print("BCC: Fighting Ed", "purple");
		visit_url("pyramid.php?action=lower");
		bumRunCombat();
		while (item_amount($item[Holy MacGuffin]) == 0) {
			if (my_hp() == 0) abort("Oops, you died. Probably better fight this one yourself.");
			visit_url("fight.php");
			bumRunCombat();
		}
	}
	checkStage("macguffinfinal", true);
	return true;
}

boolean bcascMacguffinHiddenCity() {
	if (checkStage("macguffinhiddencity")) return true;
	
	while (contains_text(visit_url("questlog.php?which=1"), "Gotta Worship Them All")) {
		string[int] citymap;
		string urldata;
		int altarcount = 0, squareNum;
		boolean sphereID = false;
		
		//Hippy outfit is +8 stench damage. I don't use bumAdv() in this function, so it won't unequip this. 
		if (my_primestat() != $stat[Mysticality]) buMax("+outfit Filthy Hippy Disguise");
		
		//Return true if we know where all the altars are and temple is.
		boolean altar_check() {
			return (altarcount == 4 && contains_text(urldata, "map_temple"));
		}
		
		//Returns the stone you need for a given temple. 
		item give_appropriate_stone(string page) {
			item this_stone(string desc) {
				for i from 2174 to 2177
				if (get_property("lastStoneSphere"+i) == desc) return to_item(i);
				abort("Unable to deduce correct stone.  You may have to identify them yourself.");
				return $item[none];
			}
			if (contains_text(page, "altar1.gif")) return this_stone("lightning");
			if (contains_text(page, "altar2.gif")) return this_stone("water");
			if (contains_text(page, "altar3.gif")) return this_stone("fire");
			if (contains_text(page, "altar4.gif")) return this_stone("nature");
			return $item[none];
		}
		
		//Searches for a given string and updates the citymap for a given image.
		void find_generic(string type, string imgname) {
			if (type == "altar") altarcount = 0;
			
			for i from 0 upto 24 {
				if (contains_text(urldata,"hiddencity.php?which="+i+"'><img src=\"IMAGES/hiddencity/"+imgname)) {
					if (type == "altar") { altarcount = altarcount + 1; }
					citymap[i] = type;
				}
			}
		}
		
		//Updates the citymap.
		void find_all() {
		   if (my_adventures() == 0) abort("Out of adventures.");
		   urldata = visit_url("hiddencity.php");
		   if (contains_text(urldata, "Combat!")) abort("You're still in the middle of a combat!");
		   if (!contains_text(urldata, "ruin")) abort("No ruins found!");
		   urldata = replace_string(urldata,"http://images.kingdomofloathing.com/otherimages", "IMAGES");
		   find_generic("altar","map_altar");
		   find_generic("explored ruin","map_ruins");
		   find_generic("unexplored ruin","map_unruins");
		   find_generic("unexplored spirit","map_spirit");
		   find_generic("smallish temple","map_temple");
		}
		
		//Unlike Zarqon, I'm going to do this in order. Saves code.
		int get_next_unexplored() {
			for i from 0 to 24 if (contains_text(citymap[i],"unexplored")) return i;
			return -1;
		}
		
		//Simple shortcut function. 
		int sphere_count() {
			return item_amount($item[mossy stone sphere]) + item_amount($item[rough stone sphere]) + item_amount($item[smooth stone sphere]) + item_amount($item[cracked stone sphere]);
		}
		
		//Finish function and start the actual adventuring code bit.
		find_all();
		setFamiliar("");
		while (!(item_amount($item[triangular stone]) + sphere_count() == 4 && altar_check())) {
			print("BCC: Continuing to adventure in the Hidden City.", "purple");
			if (my_adventures() == 0) abort("You're out of adventures.");
			squareNum = get_next_unexplored();
			
			if (squareNum != -1) {
				//Then there's something to find. If squareNum==-1 then we've explored all the squares. 
				betweenBattle();
				
				//Explore the square in question
				print("Exploring square : "+(squareNum + 1)+" / 25");
				string url = visit_url("hiddencity.php?which="+squareNum);
				bumRunCombat();
				print("BCC: Finished the combat. Let's carry on.", "purple");
				find_all();
				
				//After every adventure, print some debugging information. 
				print("spheres : "+ sphere_count() + " / 4","maroon");
				print("altars : " + altarcount + " / 4","maroon");
				if (altar_check()) print("Altars and temple all found!");
				if (get_property("betweenBattleScript") != "") cli_execute("call "+get_property("betweenBattleScript"));
			} else {
				print("BCC: We've explored all the squares.", "purple");
				//I THINK this means we're done. I hope this is right. 
				checkStage("macguffinhiddencity", true);
				return true;
			}
		}
		
		//Now we've found it, we have to finish off the city. First get the triangular stones. 
		print("BCC: We have to get the triangular stones.", "purple");
		if (item_amount(to_item("triangular stone")) < 4) {
			for i from 0 upto 24 {
				if (citymap[i] == "altar") {
					string url = visit_url("hiddencity.php?which="+i);
					if (!contains_text(url, "the altar doesn't really do anything but look neat")) {
						item stone = give_appropriate_stone(url);
						url = visit_url("hiddencity.php?action=roundthing&whichitem="+to_int(stone));
						if (contains_text(url, "tristone.gif")) print("Successfully inserted "+stone+".");
						else abort("Error inserting '"+stone+"' into altar.");
					}
				}
			}
		}
		
		//Now find the smallish temple
		int i = 0;
		while (citymap[i] != "smallish temple" && i < 30) i = i + 1;
		if (i == 30) abort("Major problem locating the smallish temple!");
		print("BCC: The smallish temple is located at square " + i + ".  Going there...", "purple");
		
		//Visit the smallish temple and kill the protector spirit. 
		switch (my_primestat()) {
			case $stat[Muscle] :
				//This used to set the bandersnatch, but there's no real point. 
			break;
			
			case $stat[Moxie] :
				print("BCC: Off to fight the final protector spirit!", "purple");
				if (in_hardcore() && my_primestat() == $stat[Moxie] && my_path() != "Way of the Surprising Fist" && get_property("bcasc_fightProtectorSpectre") != "true") {
					abort("Due to the Noodles attack, it is hard to automate this fight. You must do this manually, or set bcasc_fightProtectorSpectre to true in the relay script.");
				}
			break;
		}
		visit_url("hiddencity.php?which="+i);
		visit_url("hiddencity.php?action=trisocket");
		string url = visit_url("hiddencity.php?which="+i);
		if (index_of(bumRunCombat(), "WINWINWIN") == -1) abort("Failed to kill the last spectre!\n");
		
		print("BCC: Finished exploring the Hidden City.", "purple");
	}
	
	checkStage("macguffinhiddencity", true);
	return true;
}

boolean bcascMacguffinPalindome() {
	if (checkStage("macguffinpalin")) return true;
	
	while (contains_text(visit_url("questlog.php?which=1"), "Never Odd")) {
		while (contains_text(visit_url("questlog.php?which=1"), "Palindome") && item_amount(to_item("i love me")) == 0) {
			if (can_interact()) {
				retrieve_item(1, $item[stunt nuts]);
				retrieve_item(1, $item[ketchup hound]);
			}
			if (my_meat() < 1500) abort("You're going to need more meat for this.");
			bumAdv($location[Palindome], "+equip talisman o' nam", (in_hardcore()) ? "hebo" : "", "1 stunt nuts, 1 I Love Me Vol I", "Getting the 'I Love Me' from the Palindome", "", (in_hardcore()) ? "consultHeBo" : ""); 
		}
		
		if (item_amount($item[Cobb's Knob lab key]) == 0) abort("For some reason you don't have the lab key. Beat the goblin king manually and then restart the script. Sorry about that. ");
		while (my_adventures() > 0 && contains_text(visit_url("questlog.php?which=1"), "Fats, but then you lost it"))
			bumAdv($location[Cobb's Knob Laboratory], "", "", "1 choiceadv", "Meeting Mr. Alarm", "-");
		
		while(contains_text(visit_url("questlog.php?which=1"), "lion oil, a bird rib, and some stunt nuts")) {
			if (can_interact()) {
				retrieve_item(1, $item[wet stunt nut stew]);
			}
			while (item_amount($item[wet stunt nut stew]) < 1) {
				while (item_amount($item[wet stew]) == 0 && (item_amount($item[bird rib]) == 0 || item_amount($item[lion oil]) == 0)) {
					visit_url("guild.php?place=paco");
					bumAdv($location[whitey's grove], "", "items", "1 lion oil, 1 bird rib", "Getting the wet stew items from Whitey's Grove", "+i"); 
				}
				
				//Note that we probably already have the stunt nuts
				while (i_a("stunt nuts") == 0)
					bumAdv($location[Palindome], "", "items", "1 stunt nuts", "Getting the stunt nuts from the Palindome, which you should probably already have");
				create(1, $item[wet stunt nut stew]);
			}
			if (item_amount($item[wet stunt nut stew]) == 0) abort("Unable to cook up some tasty wet stunt nut stew.");
			
			//Get the Mega Gem
			while (i_a("mega gem") == 0 && my_adventures() > 0)
				bumMiniAdv(1, $location[laboratory]);
		}
		
		if (i_a("mega gem") == 0) abort("That's weird. You don't have the Mega Gem.");
		
		//Fight Dr. Awkward
		cli_execute("restore hp; condition clear;");
		buMax("+equip Talisman o' Nam +equip Mega Gem");
		if (!in_hardcore()) {
			//Then we have to manually equip the talisman and mega gem because of buMax() limitations
			equip($slot[acc1], $item[Talisman o' Nam]);
			equip($slot[acc2], $item[Mega Gem]);
		}
		setFamiliar("meatboss");
		bumMiniAdv(1, $location[palindome]);
		if (item_amount($item[Staff of Fats]) == 0) abort("Looks like Dr. Awkward opened a can of whoop-ass on you. Try fighting him manually.");
	}
	
	checkStage("macguffinpalin", true);
	return true;
}

boolean bcascMacguffinPrelim() {
	if (checkStage("macguffinprelim")) return true;
	
	while (!contains_text(visit_url("woods.php"), "blackmarket.gif")) {
		if (i_a("sunken eyes") > 0 && i_a("broken wings") > 0) cli_execute("use reassembled blackbird");
		if (i_a("bird brain") > 0 && i_a("busted wings") > 0) cli_execute("use reconstituted crow");
		
		if (have_path_familiar($familiar[reassembled blackbird]) || have_path_familiar($familiar[reconstituted crow])) {
			bumAdv($location[Black Forest], "", "items", "1 black market map", "Finding the black market");
		} else if(my_path() != "Bees Hate You") {
			bumAdv($location[Black Forest], "", "items", "1 black market map, 1 sunken eyes, 1 broken wings", "Finding the black market");
		} else {
			bumAdv($location[Black Forest], "", "items", "1 black market map, 1 bird brain, 1 busted wings", "Finding the black market");
		}
		use(1,$item[black market map]);
	}
	
	if (item_amount($item[your fathers macguffin diary]) == 0) {
		if (my_path() == "Way of the Surprising Fist" && item_amount($item[forged identification documents]) == 0) {
			abort("You need to fight Wu Tang the Betrayer to get the documents. He's really strong, so the script won't do this.");
		}
		
		print("BCC: Obtaining and Reading the Diary", "purple");
		retrieve_item(1,$item[forged identification documents]);
		adventure(1, to_location(to_string(my_primestat()) + " vacation"));
		use(1, $item[your fathers macguffin diary]);
	}
	
	while (!contains_text(visit_url("beach.php"),"oasis.gif")) {
		print("BCC: Revealing the Oasis", "purple");
		bumAdv($location[desert (unhydrated)], "", "hipster", "1 choiceadv", "Revealing the Oasis");
	}
	
	while (!contains_text(visit_url("woods.php"),"hiddencity.gif")) {
		abort("The new hidden temple is currently unsupported.");
		
		if (item_amount($item[The Nostril of the Serpent]) == 0) {
			set_property("choiceAdventure579", 2); //Such Great Hights: Nostril
			set_property("choiceAdventure582", 1); //Fitting In: Hights
		} else {
			set_property("choiceAdventure579", 3); //Such Great Hights: Adventures
			set_property("choiceAdventure582", 2); //Fitting In: Heart
		}
	}
	
	//At this point, Zarqon opens up the bedroom. But I'd like to do this earlier. 
	//Setting an abort() here to make sure we can get in. 
	if (item_amount($item[ballroom key]) == 0) abort("You'll need to open the Ballroom");
	while (!contains_text(visit_url("manor.php"),"sm8b.gif")) {
		print("BCC: Opening the Spookyraven Cellar", "purple");
		bumMiniAdv(1, $location[haunted ballroom]);
		betweenBattle();
	}
	
	if (cli_execute("use 2 gaudy key")) {}
	if (cli_execute("make talisman o nam")) {}
	while (i_a("Talisman o' Nam") == 0) {
		//We will almost certainly have the fledges equipped due to maximizing our Moxie. We re-equip them if we don't have them. 
		string maxstring = "+equip pirate fledges";
		if (my_basestat($stat[mysticality]) < 60) maxstring = "+outfit swashbuckling getup";
		
		if (!contains_text(visit_url("cove.php"), "cove3_5x2b.gif")) bumAdv($location[Poop Deck], maxstring, "", "", "Opening Belowdecks", "-");
		bumAdv($location[Belowdecks], maxstring, "", "2 gaudy key", "Getting the Talisman");
		if (cli_execute("use 2 gaudy key")) {}
		if (cli_execute("make talisman o nam")) {}
	}
	
	checkStage("macguffinprelim", true);
	return true;
}

boolean bcascMacguffinSpooky() {
	if (checkStage("macguffinspooky")) return true;
	
	if (contains_text(visit_url("questlog.php?which=1"),"Spooking")) {
		if (!contains_text(visit_url("questlog.php?which=1"),"secret black magic laboratory")) {
			//Get the Spectacles if you don't have them already. 
			if (i_a("Lord Spookyraven's spectacles") == 0) {
				//Correctly set Ornate Nightstand
				set_property("choiceAdventure84", 3);
				if (my_primestat() == $stat[mysticality])
					bumAdv($location[Haunted Bedroom], "", "", "Lord Spookyraven's spectacles", "Getting the Spectacles");
				else
					bumAdv($location[Haunted Bedroom], "", "", "Lord Spookyraven's spectacles", "Getting the Spectacles", "", "consultRunaway");
			}
			
			//Refresh dusty bottle information.
			cli_execute("dusty");
			
			cli_execute("equip lord spookyraven's spec");
			string[int] blar = split_string(visit_url("manor3.php?place=goblet"),"/otherimages/manor/glyph");
			if (count(blar) != 4) abort("Error parsing wine puzzle.");
			
			//Straight from Zarqon. I have really no idea how this works. 
			item get_this_wine(int wine_no) {
				for i from 2271 to 2276
					if (get_property("lastDustyBottle"+i) == wine_no) {
						return to_item(i);
					}
				return $item[none];
			}
			
			//Actually get the wines.
			item[int] wines;
			for i from 1 to 3 {
				wines[i] = get_this_wine(to_int(substring(blar[i],0,1)));
			}
			if (cli_execute("friars booze")) {}
			if (can_interact()) {
				foreach i in $ints[2271,2272,2273,2274,2275,2276] {
						retrieve_item(1, to_item(i));
				}
			} else {
				if (item_amount(wines[1]) == 0 || item_amount(wines[2]) == 0 || item_amount(wines[3]) == 0)
					bumAdv($location[Haunted Wine Cellar (Automatic)], "", "items", "1 "+wines[1]+", 1 "+wines[2]+", 1 "+wines[3], "Getting the three wines ("+wines[1]+", "+wines[2]+", "+wines[3]+")");
			}
			
			if (equipped_amount($item[Lord Spookyraven's spectacles]) > 0 || equip($slot[acc3], $item[Lord Spookyraven's spectacles])) {}
			//Pour the wines
			for i from 1 to 3 {
				blar[1] = visit_url("manor3.php?action=pourwine&whichwine="+to_int(wines[i]));
				print("BCC: Pouring Wine "+wines[i], "purple");
				if (!contains_text(blar[1],"glow more brightly") && !contains_text(blar[1],"reveal a hidden passage")) abort("There has been a problem with pouring the wines - probably lag or a minor error. Please pour them manually. ");
			}
		}
		
		if (contains_text(visit_url("manor3.php"), "chambera.gif")) {
			buMax();
			print("BCC: Fighting Spookyraven", "purple");
			restore_hp(my_maxhp());
			if (have_skill($skill[Elemental Saucesphere])) {
				cli_execute("cast Elemental Saucesphere");
			} else {
				cli_execute("use can of black paint");
			}
			//The below is "just in case" we haven't done the trapper's cold bit yet. It doesn't harm anyone to hit trapper.php here.
			visit_url("trapper.php");
			setFamiliar("meatboss");
			visit_url("manor3.php?place=chamber");
			bumRunCombat();
			if (item_amount($item[eye of ed]) == 0) abort("The Spooky man pwned you with his evil. Fight him yourself.");
		}
	}
	
	checkStage("macguffinspooky", true);
	return true;
}

boolean bcascMacguffinPyramid() {
	if (checkStage("macguffinpyramid")) return true;
	
	if (!contains_text(visit_url("questlog.php?which=1"),"A Pyramid Scheme") || contains_text(visit_url("questlog.php?which=1"),"found the little pyramid") || contains_text(visit_url("questlog.php?which=1"),"found the hidden buried pyramid")) {
		//We've done the pyramid
	} else {
		while (contains_text(visit_url("questlog.php?which=1"),"your desert explorations")) {
			bumAdv($location[desert (ultrahydrated)], "", "", "", "Meeting Gnasir for the First Time");
		}
		
		if (can_interact()) buy(1, $item[drum machine]);
		while ((contains_text(visit_url("questlog.php?which=1"), "stone rose") && i_a("stone rose") == 0) || i_a("drum machine") == 0)
			bumAdv($location[Oasis], "", "items", "1 drum machine, 1 stone rose", "Getting the stone rose and/or drum machine");
		
		print("BCC: Turning in the stone rose", "purple");
		while (item_amount($item[stone rose]) > 0) {
			if (i_a("can of black paint") == 0) {
				if (my_path() == "Way of the Surprising Fist") cli_execute("refresh inventory");
				if (my_meat() < 1000) abort("You need 1000 meat for a can of black paint");
				cli_execute("buy can of black paint");
			}
			bumMiniAdv(1, $location[desert (ultrahydrated)]);
		}
		
		//This part deals with meeting Gnasir for the second time and/or using the black paint if you didn't do it the first time. 
		while ((contains_text(visit_url("questlog.php?which=1"), "prove your honor and dedication")) || contains_text(visit_url("questlog.php?which=1"), "Gnasir seemed satisfied")) {
			if (i_a("can of black paint") == 0 && contains_text(visit_url("questlog.php?which=1"), "prove your honor and dedication")) {
				cli_execute("buy can of black paint");
			}
			print("BCC: Painting Gnasir's Door or just spending some turns waiting for him to want us to get his pages.", "purple");
			bumMiniAdv(1, $location[desert (ultrahydrated)]);
		}
		
		//Now we need the worm riding manual. So get it.
		if (i_a("worm-riding manual pages 3-15") == 0) {
			if (contains_text(visit_url("questlog.php?which=1"), "worm-riding manual") || contains_text(visit_url("questlog.php?which=1"), "missing manual pages"))
				bumAdv($location[Oasis], "", "", "worm-riding manual pages 3-15", "Getting the pages of the worm-riding manual");
		}
		
		while (contains_text(visit_url("questlog.php?which=1"), "found all of Gnasir's missing manual pages"))
			bumAdv($location[desert (ultrahydrated)], "", "", "worm-riding hooks", "Giving Gnasir his pages back");
		
		if (item_amount($item[worm-riding hooks]) == 0) abort("Unable to get worm-riding hooks.");
		if (my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") {
			cli_execute("checkpoint; equip worm-riding hooks; use drum machine; outfit checkpoint");
		} else {
			cli_execute("use drum machine");
		}
	}
	
	checkStage("macguffinpyramid", true);
	return true;
}

boolean bcascManorBedroom() {
	if (checkStage("manorbedroom")) return true;
	if (my_path() == "Way of the Suprising Fist") {
		set_property("choiceAdventure82", "2"); //White=Muscle
		set_property("choiceAdventure83", "1"); //Mahog=Coin Purse (We don't want to fight or get nothing from under the nightstand)
		set_property("choiceAdventure84", "3"); //Ornate=Spectacles
		set_property("choiceAdventure85", "5"); //Wooden=Key
	} else {
		set_property("choiceAdventure82", "1"); //White=Wallet
		set_property("choiceAdventure83", "1"); //Mahog=Coin Purse
		set_property("choiceAdventure84", "3"); //Ornate=Spectacles
		set_property("choiceAdventure85", "5"); //Wooden=Key
	}
	if (contains_text(visit_url("manor2.php"), "?place=ballroom")) {
		while (i_a("Spookyraven ballroom key") == 0 && my_buffedstat(my_primestat()) >= 85) {
			bumAdv($location[Haunted Bedroom], "", "", "Spookyraven ballroom key", "Getting the Ballroom Key", "-", "consultRunaway");
		}
		while (i_a("Lord Spookyraven's spectacles") == 0 && my_buffedstat(my_primestat()) >= 85) {
			bumAdv($location[Haunted Bedroom], "", "", "Lord Spookyraven's spectacles", "Getting Lord Spookyraven's spectacles", "-", "consultRunaway");
		}
	}
	if (i_a("Spookyraven ballroom key") + i_a("Lord Spookyraven's spectacles") >= 2) {
		checkStage("manorbedroom", true);
		return true;
	}
	return false;
}

boolean bcascManorBilliards() {
	if (checkStage("manorbilliards")) return true;
	//Billiards Room
	while (item_amount($item[Spookyraven library key]) == 0) {
		while (i_a("pool cue") == 0) {
			bumAdv($location[Haunted Billiards Room], (my_primestat() == $stat[mysticality]) ? "" : "+100000 elemental dmg", "", "1 pool cue", "Getting the Pool Cue", "-i");
		}
		
		print("BCC: Getting the Key", "purple");
		while (item_amount($item[Spookyraven library key]) == 0) {
			if (i_a("handful of hand chalk") > 0 || have_effect($effect[Chalky Hand]) > 0) {
				if (my_adventures() == 0) abort("No adventures."); 
				print("BCC: We have either a hand chalk or Chalky Hands already, so we'll use the hand chalk (if necessary) and play some pool!", "purple");
				if (i_a("handful of hand chalk") > 0 && have_effect($effect[Chalky Hand]) == 0) {
					use(1, $item[handful of hand chalk]);
				}
				cli_execute("goal clear");
				cli_execute("goal set 1 Spookyraven library key");
				buMax();
				if (bumMiniAdvNoAbort(have_effect($effect[Chalky Hand]), $location[Haunted Billiards Room])) {}
			} else {
				bumMiniAdv(1, $location[Haunted Billiards Room]);
			}
		}
	}
	checkStage("manorbilliards", true);
	return true;
}

boolean bcascManorLibrary() {
	if (checkStage("manorlibrary")) return true;
	set_property("choiceAdventure80", "99"); //(Rise) - this always needs to be set. It's Fall that has the conservatory adventure.
	set_property("choiceAdventure87", "2");  //(Read Fall) - May as well always set this to read Chapter 2.
	
	if (my_primestat() == $stat[Muscle]) {
		//If you're a muscle class, then you'll need to open the conservatory. It's an auto-stop.
		while (get_property("lastGalleryUnlock") != my_ascensions()) {
			set_property("choiceAdventure81", "1"); //(Fall) Get the Gallery adventure.
			bumAdv($location[Haunted Library], "", "", "1 choiceadv", "Unlocking the Gallery Adventure thingymajig", "-");
		}
		while (contains_text(visit_url("manor.php"), "place=gallery")) {
			bumAdv($location[Haunted Conservatory], "", "", "1 Spookyraven Gallery Key", "Getting the Gallery Key", "-");
		}
	}
	
	//Open up the second floor of the manor. 
	set_property("choiceAdventure81", "99"); //(Fall)
	while (index_of(visit_url("manor.php"), "place=stairs") + index_of(visit_url("manor.php"), "sm2b.gif") > 0) {
		bumAdv($location[Haunted Library], "", "", "1 choiceadv", "Opening Second floor of the Manor", "-");
	}
	checkStage("manorlibrary", true);
	return true;
}

boolean bcascMeatcar() {
	if (checkStage("meatcar")) return true;
	
	if (contains_text(visit_url("beach.php"), "shore.php")) return checkStage("meatcar", true);
	
	if (my_path() != "Bees Hate You" || knoll_available()) {
		if (item_amount($item[bitchin' meatcar]) + item_amount($item[pumpkin carriage]) + item_amount($item[desert bus pass]) == 0) {
			print("BCC: Getting the Meatcar", "purple");
			//Gotta hit up paco.
			visit_url("guild.php?place=paco");
			if (item_amount($item[sweet rims]) + item_amount($item[dope wheels]) == 0)
				cli_execute("hermit sweet rims");
			
			if (!knoll_available()) {
				print("BCC: Making the meatcar, getting the stuff from the Gnolls. Damned Gnolls...", "purple");
				visit_url("forestvillage.php?action=screwquest&submit=&quot;Sure Thing.&quot;");
				buMax();
				use(item_amount($item[gnollish toolbox]), $item[gnollish toolbox]);
				while (creatable_amount($item[bitchin' meatcar]) == 0) {
					use(item_amount($item[gnollish toolbox]), $item[gnollish toolbox]);
					if (my_adventures() == 0) abort("No Adventures");
					bumMiniAdv(1, $location[Degrassi Knoll]);
				}
			}
			cli_execute("make bitchin' meatcar");
			visit_url("guild.php?place=paco");
		}
	} else if(i_a("pumpkin") > 0) {
		if (item_amount($item[pumpkin carriage]) + item_amount($item[desert bus pass]) == 0) {
			print("BCC: Bees hate You: Getting a Pumpkin Carriage", "purple");
			//Gotta hit up paco.
			visit_url("guild.php?place=paco");
			if (item_amount($item[sweet rims]) + item_amount($item[dope wheels]) == 0)
				cli_execute("hermit sweet rims");
				
			print("BCC: Making the dope wheels, getting the stuff from the Gnolls. Damned Gnolls...", "purple");
			visit_url("forestvillage.php?action=screwquest&submit=&quot;Sure Thing.&quot;");			
			buMax();
			while (creatable_amount($item[dope wheels]) == 0) {
				if (my_adventures() == 0) abort("No Adventures");
				bumMiniAdv(1, $location[Degrassi Knoll]);
			}
			cli_execute("make pumpkin carriage");
			visit_url("guild.php?place=paco");
		}
	} else {
		if(my_meat() > 5000)
			cli_execute("buy 1 desert bus pas");
		else
			abort("BCC: Bees Hate You. You have no pumpkins. You have no meat. Go fix!");
	}
	checkStage("meatcar", true);
	return true;
}

//Thanks, picklish!
boolean bcascMining() {
	if (checkStage("mining")) return true;

	string trapper = visit_url("trapper.php");
	if (my_level() >= 8 && !contains_text(trapper, "I reckon 3 chunks")) {
		print("Looks like we're done.", "purple");
		checkStage("mining", true);
		return true;
	}

	string goalString = get_property("trapperOre");
	item goal = to_item(goalString);

	if (goal != $item[asbestos ore] && goal != $item[chrome ore] && goal != $item[linoleum ore])
		abort("Can't figure out which ore to look for.");

	// Seed ore locations with what mafia knows about.
	int[int] oreLocations;
	string mineLayout = get_property("mineLayout1");
	int start = 0;
	while (true) {
		int num_start = index_of(mineLayout, '#', start);
		if (num_start == -1) break;
		int num_end = index_of(mineLayout, '<', num_start);
		if (num_end == -1) break;
		int end = index_of(mineLayout, '>', num_end);
		if (end == -1) break;

		if (contains_text(substring(mineLayout, num_end, end), goalString)) {
			int spot = to_int(substring(mineLayout, num_start + 1, num_end));
			oreLocations[count(oreLocations)] = spot;
		}
		start = end;
	}

	boolean rowContainsEmpty(string mine, int y) {
		for x from 1 to 6 {
			if (contains_text(mine, "Open Cavern (" + x + "," + y + ")"))
				return true;
		}

		return false;
	}

	boolean canMine(string mine, int x, int y, boolean onlySparkly) {
		if (x < 0 || x > 7 || y < 0 || y > 7) return false;
		int index = x + y * 8; 
		boolean clickable = (index_of(mine, "mining.php?mine=1&which=" + index + "&") != -1);

		if (!clickable || !onlySparkly) return clickable;

		return contains_text(mine, "Promising Chunk of Wall (" + x + "," + y + ")");
	}

	int adjacentSparkly(string mine, int index) {
		int x = index % 8;
		int y = index / 8;

		if (canMine(mine, x, y - 1, true)) return index - 8;
		if (canMine(mine, x - 1, y, true)) return index - 1;
		if (canMine(mine, x + 1, y, true)) return index + 1;
		if (canMine(mine, x, y + 1, true)) return index + 8;
		return - 1;
	}

	int findSpot(string mine, boolean[int] rows, boolean[int] cols) {
		foreach sparkly in $booleans[true, false] {
			foreach y in cols {
				foreach x in rows {
					if (canMine(mine, x, y, sparkly))
						return x + y * 8;
				}
			}
		}
		return -1;
	}
	if(my_path() != "Avatar of Boris") {
		if (my_path() != "Way of the Surprising Fist") {
			cli_execute("outfit mining gear");
		} else {
			if (!have_skill($skill[Worldpunch])) abort("You need the skill Worldpunch, grasshopper.");
		}
	}

	while (item_amount(goal) < 3) {
		if(my_path() != "Avatar of Boris") {
			if (my_hp() == 0) cli_execute("restore hp");
			if ((my_path() == "Way of the Surprising Fist") && (have_effect($effect[Earthen Fist]) == 0)) {
				if (my_mp() < mp_cost($skill[Worldpunch])) restore_mp(mp_cost($skill[Worldpunch]));
				cli_execute("cast Worldpunch");
			}
				
			string mine = visit_url("mining.php?intro=1&mine=1");
			if (contains_text(mine, "You can't mine without the proper equipment.")) abort("Couldn't equip mining gear.");

			boolean willCostAdventure = contains_text(mine, "takes one Adventure.");
			if (have_skill($skill[Unaccompanied Miner]) && willCostAdventure && have_effect($effect[Teleportitis]) == 0 && my_level() < 12) {
				if (bcasc_MineUnaccOnly) {
					print("BCC: No more mining today. I'll come back later.", "purple");
					return false;
				}
			}
			if (my_adventures() == 0 && willCostAdventure) abort("No Adventures");
			int choice = -1;
			string why = "Mining around found ore";
			// Ore is always coincident, so look nearby if we've aleady found some.
			if (count(oreLocations) > 0) {
				foreach key in oreLocations {
					choice = adjacentSparkly(mine, oreLocations[key]);
					if (choice != -1)
						break;
				}
			}


			// Prefer mining the middle first.  It leaves more options.
			boolean[int] rows = $ints[3, 4, 2, 5, 1, 6];
			// First, try to mine up to the top four rows if we haven't yet.
			if (choice == -1 && !rowContainsEmpty(mine, 6)) {
				choice = findSpot(mine, rows, $ints[6]);
				why = "Mining upwards";
			} 
			if (choice == -1 && !rowContainsEmpty(mine, 5)) {
				choice = findSpot(mine, rows, $ints[5]);
				why = "Mining upwards";
			}
					
			// Top three rows contain most ore.  Fourth row may contain ore.
			// Prefer second row and digging towards the middle because it
			// opens up the most potential options.  This could be more
			// optimal, but it's not a bad heuristic.
			if (choice == -1) {
				choice = findSpot(mine, rows, $ints[2, 3, 1, 4]);
				why = "Mining top four rows";
			}
			// There's only four pieces of the same ore in each mine.
			// Maybe you accidentally auto-sold them or something?
			if (choice == -1 || count(oreLocations) == 4) {
				print("BCC: Resetting mine!", "purple");
				visit_url("mining.php?mine=1&reset=1&pwd");
				oreLocations.clear();
				continue;
			}
			print(why + ": " + (choice % 8) + ", " + (choice / 8) + ".", "purple");
			string result = visit_url("mining.php?mine=1&which=" + choice + "&pwd");
			if (index_of(result, goalString) != -1) {
				oreLocations[count(oreLocations)] = choice;
			}
		}
		else {
			bumAdv($location[Itznotyerzitz Mine], "", "items", "3 " + goal, "Adventuring for the ore of the mountain man.", "i");
		}
	}

	if (have_effect($effect[Beaten Up]) > 0) cli_execute("unaffect beaten up");
	visit_url("trapper.php");

	checkStage("mining", true);
	return true;
}

boolean bcascMirror() {
	if(checkStage("mirror")) return true;

	set_property("choiceAdventure85", 3);
	while(i_a("antique hand mirror") == 0) {
		bumAdv($location[Haunted Bedroom], "", "itemsnc", "antique hand mirror", "Getting an anqique hand mirror to tackle the end boss.", "-i");
	}
	
	checkStage("mirror", true);
	return true;
}

void bcascNaughtySorceress() {
	if (contains_text(visit_url("main.php"), "lair.php")) {
		//Get through the initial three doors. 
		while (!contains_text(visit_url("lair1.php"), "lair2.php")) {
			bcascLairFirstGate();
		}
		
		//Now try to get through the rest of the entryway.
		while (!contains_text(visit_url("lair2.php"), "lair3.php")) {
			bcascLairMariachis();
		}
		
		//Get through the hedge maze. Though we'll only ever spend one adventure at a time here, we use bumAdv for moxie maximiazation. 
		while (!contains_text(visit_url("lair3.php"), "lair4.php")) {
			if (item_amount($item[hedge maze puzzle]) == 0) bumAdv($location[Hedge Maze], "", "items", "1 hedge maze puzzle", "Getting another Hedge Maze");
			if (hedgemaze()) {}
		}
		
		while (!contains_text(visit_url("lair4.php"), "lair5.php")) {
			bcascLairTower();
		}
		
		while (!contains_text(visit_url("lair5.php"), "lair6.php")) {
			bcascLairTower();
		}
		
		while (!contains_text(visit_url("lair6.php"), "?place=5")) {
			bcascLairTower();
		}
		
		
		bcascLairFightNS();
	} else {
		abort("There is some error and you don't appear to be able to access the lair...");
	}
}

boolean bcascPantry() {
	if (checkStage("pantry")) return true;
	while (contains_text(visit_url("town_right.php"), "pantry.gif")) {
		bumAdv($location[Haunted Pantry], "", "", "", "Let's open the Pantry");
	}
	checkStage("pantry", true);
	return true;
}

boolean bcascPirateFledges() {
	boolean hitTheBarrr = false;
	if (checkStage("piratefledges")) return true;
	
	while (i_a("pirate fledges") == 0) {
		buMax("+outfit swashbuckling getup");
		
		//The Embarassed problem is only an issue if you're a moxie class. Otherwise, ignore it.
		if (my_primestat() == $stat[Moxie]) {
			cli_execute("speculate up Embarrassed; quiet");
			int safeBarrMoxie = 93;
			int specMoxie = 0;
			while (!hitTheBarrr && in_hardcore()) {
				specMoxie = numeric_modifier("_spec", "Buffed Moxie");
				if (specMoxie > safeBarrMoxie) { hitTheBarrr = true; }
				if (!hitTheBarrr) { levelMe(my_basestat($stat[Moxie])+3, true); }
			}
			
			setMCD(specMoxie, safeBarrMoxie);
		} else {
			cli_execute("mcd 0");
			levelMe(93, false);
		}
		
		buMax("+outfit swashbuckling getup");

		//Check if we've unlocked the f'c'le at all.
		if (index_of(visit_url("cove.php"), "cove3_3x1b.gif") == -1) {
			if(my_path() != "Avatar of Boris")
				buMax("+outfit swashbuckling getup");
			else {
				outfit("swashbuckling getup");
				equip($item[Trusty]);
			}
			setFamiliar("");
			setMood("i");
			
			if (my_path() != "Bees Hate You") {
				if (i_a("the big book of pirate insults") == 0) {
					buy(1, $item[the big book of pirate insults]);
				}
			} else {
				if (i_a("Massive Manual of Marauder Mockery") == 0) {
					buy(1, $item[Massive Manual of Marauder Mockery]);
				}
			}
			
			cli_execute("condition clear");
			//Have we been given the quest at all?
			while (!contains_text(visit_url("questlog.php?which=1"), "I Rate, You Rate")) {
				print("BCC: Adventuring once at a time to meet the Cap'm for the first time.", "purple");
				if (can_interact()) {
					bumMiniAdv(1, $location[Barrrney's Barrr], "consultCasual");
				} else {
					bumMiniAdv(1, $location[Barrrney's Barrr], "consultBarrr");
				}
			}
			
			//Check whether we've completed the beer pong quest.
			if (index_of(visit_url("questlog.php?which=1"), "Caronch has offered to let you join his crew") > 0) {
				print("BCC: Getting and dealing with the Cap'm's Map.", "purple");
				
				if (i_a("Cap'm Caronch's Map") == 0)
					bumAdv($location[Barrrney's Barrr], "+outfit swashbuckling getup", "", "1 Cap'm Caronch's Map", "", "Getting the Cap'm's Map", "consultBarrr");
				
				//Use the map and fight the giant crab.
				if (i_a("Cap'm Caronch's Map") > 0) {
					print("BCC: Using the Cap'm's Map and fighting the Giant Crab", "purple");
					use(1, $item[Cap'm Caronch's Map]);
					bumRunCombat();
					if (have_effect($effect[Beaten Up]) > 0 || i_a("Cap'm Caronch's nasty booty")== 0) abort("Uhoh. Please use the map and fight the crab manually.");
				} else {
					abort("For some reason we don't have the map even though we should have.");
				}
			}
			
			//If we have the booty, we'll need to get the map.
			if (i_a("Cap'm Caronch's nasty booty") > 0)
				bumAdv($location[Barrrney's Barrr], "+outfit swashbuckling getup", "", "1 Orcish Frat House blueprints", "Getting the Blueprints", "", "consultBarrr");
			
			//Now, we'll have the blueprints, so we'll need to make sure we have 8 insults before using them. 
			while (numPirateInsults() < 7) {
				print("BCC: Adventuring one turn at a time to get 7 insults. Currently, we have "+numPirateInsults()+" insults.", "purple");
				if (my_adventures() == 0) { abort("You're out of adventures."); }
				if (can_interact()) {
					bumMiniAdv(1, $location[Barrrney's Barrr], "consultCasual");
				} else {
					bumMiniAdv(1, $location[Barrrney's Barrr], "consultBarrr");
				}
			}
			
			print("BCC: Currently, we have "+numPirateInsults()+" insults. This is enough to continue with beer pong.", "purple");
			
			//Need to use the blueprints.
			if (index_of(visit_url("questlog.php?which=1"), "Caronch has given you a set of blueprints") > 0) {
				if ((knoll_available() || i_a("frilly skirt") > 0) && i_a("hot wing") >= 3) {
					print("BCC: Using the skirt and hot wings to burgle the Frat House...", "purple");
					cli_execute("checkpoint");
					cli_execute("equip frilly skirt");
					visit_url("inv_use.php?which=3&whichitem=2951&pwd");
					visit_url("choice.php?whichchoice=188&option=3&choiceform3=Catburgle&pwd");
					cli_execute("outfit checkpoint");
				} else if(i_a("Orcish baseball cap") > 0 && i_a("homoerotic frat-paddle") > 0 && i_a("Orcish cargo shorts") > 0) {
					print("BCC: Using the Frat Outfit to burgle the Frat House...", "purple");
					cli_execute("checkpoint");
					cli_execute("outfit frat boy ensemble");
					visit_url("inv_use.php?which=3&whichitem=2951&pwd");
					visit_url("choice.php?whichchoice=188&option=1&choiceform1=Catburgle&pwd");
					cli_execute("outfit checkpoint");
				} else if(i_a("mullet wig") > 0 && i_a("briefcase") > 0) {
					print("BCC: Using the mullet wig and briefcase to burgle the Frat House...", "purple");
					cli_execute("checkpoint");
					cli_execute("equip mullet wig");
					visit_url("inv_use.php?which=3&whichitem=2951&pwd");
					visit_url("choice.php?whichchoice=188&option=2&choiceform2=Catburgle&pwd");
					cli_execute("outfit checkpoint");
				} else {
					abort("Please use the blueprints. I was not able to use them automatically, unfortunately :(");
				}
			}
			
			if (i_a("Cap'm Caronch's dentures") > 0) {
				buMax("+outfit swashbuckling getup");
				print("BCC: Giving the dentures back to the Cap'm.", "purple");
				while (available_amount($item[Cap'm Caronch's dentures]) > 0) bumMiniAdv(1, $location[Barrrney's Barrr]);
			}
			
			print("BCC: Now going to do the beer pong adventure.", "purple");
			
			while (my_adventures() > 0) {
				if (tryBeerPong().contains_text("victory laps")) {
					break;					
				}
			}
		}
		
		
		//When we get to here, we've unlocked the f'c'le. We must assume the user hasn't used the mop, polish or shampoo.
		bumAdv($location[F'c'le], "+outfit swashbuckling getup", "items", "1 pirate fledges", "Getting the Pirate Fledges, finally!", "+i");
	}
	checkStage("piratefledges", true);
	return true;
}

boolean bcascSpookyForest() {
	if (checkStage("spookyforest")) return true;
	while (contains_text(visit_url("questlog.php?which=1"), "bring them a mosquito larva")) {
		set_property("choiceAdventure502", "2");
		set_property("choiceAdventure505", "1");
		bumAdv($location[Spooky Forest], "", "", "1 choiceadv", "Let's get the mosquito");
		visit_url("council.php");
	}
	
	if (my_level() >= 11 && get_property("bcasc_dontLevelInTemple") == "true") {
		checkStage("spookyforest", true);
		return true;
	}
	
	if (!contains_text(visit_url("woods.php"), "temple.gif")) {
		while (item_amount($item[spooky temple map]) + item_amount($item[tree-holed coin]) == 0) {
			set_property("choiceAdventure502", "2");
			set_property("choiceAdventure505", "2");
			bumAdv($location[Spooky Forest], "", "", "1 choiceadv", "Let's get a Tree-Holed Coin");
		}
		
		while (item_amount($item[spooky temple map]) == 0) {
			set_property("choiceAdventure502", "3");
			set_property("choiceAdventure506", "3");
			set_property("choiceAdventure507", "1");
			bumAdv($location[Spooky Forest], "", "", "1 choiceadv", "Let's get the map");
		}
		
		while (item_amount($item[spooky-gro fertilizer]) == 0) {
			set_property("choiceAdventure502", "3");
			set_property("choiceAdventure506", "2");
			bumAdv($location[Spooky Forest], "", "", "1 choiceadv", "Let's get the fertilizer");
		}
		
		while (item_amount($item[spooky sapling]) == 0) {
			cli_execute("mood execute");
			if (contains_text(visit_url("adventure.php?snarfblat=15"), "Combat")) {
				bumRunCombat();
			} else {
				visit_url("choice.php?whichchoice=502&option=1&pwd="+my_hash());
				visit_url("choice.php?whichchoice=503&option=3&pwd="+my_hash());
				if (item_amount($item[bar skin]) > 0) visit_url("choice.php?whichchoice=504&option=2&pwd="+my_hash());
				visit_url("choice.php?whichchoice=504&option=3&pwd="+my_hash());
				visit_url("choice.php?whichchoice=504&option=4&pwd="+my_hash());
			}
		}
		
		print("Using Spooky Temple Map", "blue");
		use(1, $item[spooky temple map]);
	}
	checkStage("spookyforest", true);
	return true;
}

//Thanks, picklish!
boolean bcascTavern() {
    if (checkStage("tavern")) return true;
	//if (!checkStage("spookyforest")) return false;
	
	boolean checkComplete() {
		if (contains_text(visit_url("questlog.php?which=2"), "solved the rat problem")) {
			checkStage("tavern", true);
			return true;
		} else {
			return false;
		}
	}

	if (checkComplete()) return true;

	setFamiliar("");
	cli_execute("mood execute");
	levelMe(19, false);
	if (canMCD()) cli_execute("mcd 0");
	visit_url("council.php");
	visit_url("tavern.php?place=barkeep");
	setMood("");
	buMax();
	
	//Re-get the current tavern layout.
	visit_url("cellar.php");

	
	while (!get_property("tavernLayout").contains_text("3")) {
		if (my_adventures() == 0) abort("No adventures.");
		print("BCC: We are adventuring at the tavern", "purple");
		tavern();
	}
	visit_url("rats.php?action=faucetoff");
	visit_url("tavern.php?place=barkeep");
	visit_url("tavern.php?place=barkeep");

	return checkComplete(); 
}

boolean bcascTeleportitisBurn() {
	if (have_effect($effect[Teleportitis]) == 0) return true;
	print("BCC: Burning off teleportitis", "purple");
	// Burn it off on shore adventures.
	if (!in_bad_moon() && get_property("telescopeUpgrades") >= 7) {
		if (cli_execute("telescope look low")) {}
		string shore = get_property("telescope7");
		location vacation;
		item goal;
		if (contains_text(shore, "horns")) {
			vacation = $location[moxie vacation];
			goal = $item[barbed-wire fence];
		} else if (contains_text(shore, "beam")) {
			vacation = $location[muscle vacation];
			goal = $item[stick of dynamite];
		} else if (contains_text(shore, "stinger")) {
			vacation = $location[mysticality vacation];
			goal = $item[tropical orchid];
		} else {
			abort("Internal error.  Couldn't sort out telescope text.");
		}
		if (item_amount(goal) == 0) {
			adventure(1, vacation);
		}
	} else if (my_path() == "Bees Hate You") {
		location vacation = $location[mysticality vacation];
		adventure(1, vacation);
		use(1, $item[packet of orchid seeds]);
	}
	
	if (have_effect($effect[Teleportitis]) == 0) return true;
	bcascMining();
	if (have_effect($effect[Teleportitis]) == 0) return true;
	bcascDailyDungeon();
	if (have_effect($effect[Teleportitis]) == 0) return true;
	bumMiniAdv(have_effect($effect[Teleportitis]), $location[Haunted Kitchen]);
	return true;
}

boolean bcascTelescope() {
	if (checkStage("lair0")) return false;
	if (!in_hardcore()) return false;
	if (my_level() >= 13) {
		if (contains_text(visit_url("lair1.php"), "lair2.php")) return false;
	}

	record lair { 
		string loc;
		string a;
		string thing;
		string section;
		boolean autoadventure;
	};
	
	lair [string] telescope;
	lair level;
	string telescopetext;
	telescope["catch a glimpse of a flaming katana"] 			= new lair("Ninja Snowmen", "a ", "frigid ninja stars", "trapper", true);
	telescope["catch a glimpse of a translucent wing"] 			= new lair("Sleazy Back Alley", "a ", "spider web", "guild", true);
	telescope["see a fancy-looking tophat"] 				= new lair("Guano Junction", "a ", "sonar-in-a-biscuit", "bats1", true);
	telescope["see a flash of albumen"] 					= new lair("Black Forest", "", "black pepper", "macguffinprelim", false);
	telescope["see a giant white ear"] 					= new lair("Hidden City (encounter)", "a ", "pygmy blowgun", "macguffinhiddencity", true);
	telescope["see a huge face made of Meat"] 				= new lair("Orc Chasm", "a ", "meat vortex", "chasm", true);
	telescope["see a large cowboy hat"] 					= new lair("Giant's Castle", "a ", "chaos butterfly", "castle", true);
	telescope["see a periscope"] 						= new lair("Fantasy Airship", "a ", "photoprotoneutron torpedo", "airship", true);
	telescope["see a slimy eyestalk"] 					= new lair("Haunted Bathroom", "", "fancy bath salts", "manorbedroom", true);
	telescope["see a strange shadow"] 					= new lair("Haunted Library", "an ", "inkwell", "manorbilliards", true);
	telescope["see moonlight reflecting off of what appears to be ice"] 	= new lair("The Market", "an", "hair spray", "buyfromthemarket", false);
	telescope["see part of a tall wooden frame"] 				= new lair("Harem", "a ", "disease", "knobking", true);
	telescope["see some amber waves of grain"]				= new lair("Desert (Ultrahydrated)", "a ", "bronzed locus", "macguffinpyramid", true);
	telescope["see some long coattails"] 					= new lair("Outskirts of the Knob", "a ", "Knob Goblin firecracker", "guild", true);
	telescope["see some pipes with steam shooting out of them"] 		= new lair("Middle Chamber", "", "powdered organs", "macguffinfinal", false);
	telescope["see some sort of bronze figure holding a spatula"]		= new lair("Haunted Kitchen", "", "leftovers of indeterminate origin", "pantry", true);
	telescope["see the neck of a huge bass guitar"] 			= new lair("South of the Border", "a ", "mariachi G-string", "dinghy", true);
	telescope["see what appears to be the North Pole"] 			= new lair("Orc Chasm", "an ", "NG", "chasm", false);
	telescope["see what looks like a writing desk"] 			= new lair("Giant's Castle", "a ", "plot hole", "castle", true);
	telescope["see the tip of a baseball bat"] 				= new lair("Guano Junction", "a ", "baseball", "bats1", true);
	telescope["see what seems to be a giant cuticle"] 			= new lair("Haunted Pantry", "a ", "razor-sharp can lid", "guild", true);
	telescope["see a pair of horns"] 					= new lair("Moxie Vacation", "", "barbed-wire fence", "dinghy", false);
	telescope["see a formidable stinger"] 					= new lair("Mysticality Vacation", "a ", "tropical orchid", "dinghy", false);
	telescope["see a wooden beam"] 						= new lair("Muscle Vacation", "a ", "stick of dynamite", "dinghy", false);
	telescope["an armchair"] 						= new lair("Hidden City (encounter)", "", "pygmy pygment", "macguffinhiddencity", true);
	telescope["a cowardly-looking man"] 					= new lair("Pandamonium Slums", "a ", "wussiness potion", "Pandamonium Slums", false);
	telescope["a banana peel"] 						= new lair("Next to that Barrel with Something Burning in it", "", "gremlin juice", "post-war junkyard", false);
	telescope["a coiled viper"] 						= new lair("Black Forest", "an ", "adder bladder", "macguffinprelim", true);
	telescope["a rose"] 							= new lair("Giant's Castle", "", "Angry Farmer candy", "castle", true);
	telescope["a glum teenager"] 						= new lair("Giant's Castle", "a ", "thin black candle", "castle", true);
	telescope["a hedgehog"] 						= new lair("Fantasy Airship", "", "super-spiky hair gel", "airship", true);
	telescope["a raven"] 							= new lair("Black Forest", "", "Black No. 2", "macguffinprelim", true);
	telescope["a smiling man smoking a pipe"] 				= new lair("Giant's Castle", "", "Mick's IcyVapoHotness Rub", "castle", true);
	
	if (my_path() == "Bees Hate You") {
		if (i_a("packet of orchid seeds") > 0 && i_a("tropical orchid") == 0) use(1, $item[packet of orchid seeds]) ;
		if (i_a("honeypot") == 0 && i_a("handful of honey") >= 3) create(1, $item[honeypot]);
	} else {
		if (get_property("telescopeUpgrades") >= 1) {
			if (get_property("lastTelescopeReset") != get_property("knownAscensions")) cli_execute("telescope");
			
			for i from get_property("telescopeUpgrades").to_int() downto 1 {
				telescopetext = get_property("telescope"+i);
				level = telescope[telescopetext];

				if (i_a(level.thing) == 0) {
					if ((get_property("bcasc_stage_"+level.section) == my_ascensions() || level.section == "") && (level.loc != "")) {
						if (level.autoadventure) {
							bumAdv(to_location(level.loc), "", "items", "1 "+level.thing, "Getting "+level.a+level.thing+" for the NS tower because we have finished the stage '"+level.section+" in this script.");
						} else {
							print("BCC: Please get "+level.thing+" for telescope part "+i+" from '"+level.loc+"' yourself", "purple");
							return false;
						}
					} else {
						print("BCC: You haven't completed the stage '"+level.section+"' for the "+level.thing+" for telescope part "+i, "purple");
					}
				} else {
					print("BCC: You have at least one "+level.thing+" for telescope part "+i, "purple");
				}
			}
		}
	}
			
	return true;
}

boolean bcascTrapper() {
	if (checkStage("trapper")) return true;

	visit_url("trapper.php");
	
	while (index_of(visit_url("trapper.php"), "reckon 3 chunks of") > 0) {
		if ((my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") && ((i_a("miner's helmet") == 0 || i_a("7-Foot Dwarven mattock") == 0 || i_a("miner's pants") == 0))) {
			bumAdv($location[Itznotyerzitz Mine], "", "hebo", "1 miner's helmet, 1 7-Foot Dwarven mattock, 1 miner's pants", "Getting the Mining Outfit", "", "consultHeBo");
			visit_url("trapper.php");
		}
		if (my_path() != "Way of the Surprising Fist" && my_path() != "Avatar of Boris") cli_execute("outfit mining gear");
		if (!bcascMining()) {
			print("BCC: The script has stopped mining for ore, probably because you ran out of unaccomapnied miner adventures. We'll try again tomorrow.", "purple");
			return false;
		}
	}
	while (contains_text(visit_url("trapper.php"), "6 chunks of goat cheese")) {
		if (can_interact()) {
			cli_execute("acquire 6 goat cheese");
		} else {
			cli_execute("friars food");
			string old = get_property("choiceAdventure162");
			set_property("choiceAdventure162", 3); //Boris hates rocks
			bumAdv($location[Goatlet], "", "items", "6 goat cheese", "Getting Goat Cheese", "i");
			set_property("choiceAdventure162", old); //Reset in order to not screw anyone up in a future ascencion
		}
		visit_url("trapper.php");
		visit_url("trapper.php");
	}
	if (index_of(visit_url("trapper.php"), "you'll need some kind of protection from the cold") > 0) {
		if (have_skill($skill[Northern Exposure])) {
			print("BCC: Visiting the trapper with your passive skill Northern Exposure to get the quest done.", "purple");
			visit_url("trapper.php");
		} else if (have_path_familiar($familiar[Exotic Parrot]) && have_skill($skill[Amphibian Sympathy])) {
			print("BCC: Visiting the trapper with a parrot to get the quest done.", "purple");
			cli_execute("familiar parrot");
			visit_url("trapper.php");
			//We do this just in case there's a 100% familiar here, so we set it back immediately. 
			setFamiliar("items");
		} else if(my_path() == "Avatar of Boris") {
			if(have_skill($skill[Legendary Girth])) {
				print("BCC: Visiting the trapper with your passive skill Legendary Girth to get the quest done.", "purple");
				visit_url("trapper.php");
			}
			else {
				//Try to use the maximizer on this. We need to have Trusty on.
				cli_execute("maximize cold res, +equip Trusty");
				if (contains_text(visit_url("trapper.php"), "you'll need some kind of protection from the cold")) {
					print("BCC: You need some cold resistance for the trapper but you don't have it yet. Try acquiring Legendary Girth or farm some cold-resistance gear.", "purple");
				}
			}
		} else {
			//Try to use the maximizer on this. Don't care about bees here because we won't adventure. 
			cli_execute("maximize cold res");
			if (contains_text(visit_url("trapper.php"), "you'll need some kind of protection from the cold")) {
				print("BCC: You need some cold resistance for the trapper but you don't have it yet.", "purple");
			}
		}
	}
	if (index_of(visit_url("questlog.php?which=2"), "learned how to hunt Yetis") > 0) {
		checkStage("trapper", true);
		return true;
	}
	return false;
}

boolean bcascToot() {
    if (checkStage("toot")) return true;
    visit_url("tutorial.php?action=toot");
    if (item_amount($item["letter from King Ralph XI"]) > 0) use(1, $item[letter from King Ralph XI]);
	
	if (get_property("bcasc_sellgems") == "true") {
		if (item_amount($item["pork elf goodies sack"]) > 0 && my_path() != "Way of the Surprising Fist") use(1, $item[pork elf goodies sack]);
		if (my_path() != "Way of the Surprising Fist") foreach stone in $items[hamethyst, baconstone, porquoise] autosell(item_amount(stone), stone);
	}
	if (my_path() != "Avatar of Boris" && i_a("stolen accordion") == 0 && i_a("Rock and Roll Legend") == 0 && i_a("Squeezebox of the Ages") == 0 && i_a("The Trickster's Trikitixa") == 0) {
		print("BCC: Getting an Accordion before we start.", "purple");
		while (i_a("stolen accordion") == 0) use(1, $item[chewing gum on a string]);
	}
	
	//KoLMafia doesn't clear these on ascension.
	set_property("mineLayout1", "");
	set_property("trapperOre", "");
	set_property("bcasc_lastFax", "");
	set_property("bcasc_lastHermitCloverGet", "");
	set_property("bcasc_lastShieldCheck", "");

	checkStage("toot", true);
    return true;
}

boolean bcascWand() {
	if (checkStage("wand")) return true;
	if (!in_hardcore()) return false;
	
	//Before we do the next thing, let's just check for and use the dead mimic.
	if (i_a("dead mimic") > 0) {
		cli_execute("use dead mimic");
		if (my_path() != "Bees Hate You") cli_execute("use * small box; use * large box");
	}
	
	
	//Check for a wand. Any wand will do. 
	if (i_a("aluminum wand") + i_a("ebony wand") + i_a("hexagonal wand") + i_a("marble wand") + i_a("pine wand") == 0) {
		//Use the plus sign if we have it. Just in case someone's found the oracle but forgotten to use the plus sign.
		if (i_a("plus sign") > 0) { if (cli_execute("use plus sign")) {} }

		//Need at least 1000 meat for the oracle adventure.  Let's be safe and say 2000.
		if (my_meat() < 2000) {
			print("BCC: Waiting on the oracle until you have more meat.", "purple");
			return false;
		}
		
		//Check for the DoD image. 
		while (index_of(visit_url("dungeons.php"), "greater.gif") > 0) {
			//Then we need to check for the plus sign. 
			if (i_a("plus sign") == 0) {
				cli_execute("set choiceAdventure451 = 3");
				bumAdv($location[Greater-Than Sign], "", "itemsnc", "1 plus sign", "Getting the Plus Sign", "-");
			}
			while (have_effect($effect[Teleportitis]) == 0) {
				cli_execute("set choiceAdventure451 = 5");
				bumAdv($location[Greater-Than Sign], "", "itemsnc", "1 choiceadv", "Getting Teleportitis", "-");
			}
			cli_execute("set choiceAdventure3 = 3");
			bumMiniAdv(1, $location[Greater-Than Sign]);
			if (i_a("plus sign") > 0) { if (cli_execute("use plus sign")) {} }
		}
		
		if (have_effect($effect[Teleportitis]) > 0) bcascTeleportitisBurn();

		//Then we have to get the wand itself. Must have at least 5000 meat for this, so use 6000 for safety. 
		if (!get_property("bcasc_3KeysNoWand").to_boolean() && my_meat() > 6000) {
			cli_execute("set choiceAdventure25 = 2");
			bumAdv($location[Dungeons of Doom], "", "itemsnc", "1 dead mimic", "Getting a Dead Mimic", "-");
		} else {
			return false;
		}
	}
	if (i_a("dead mimic") > 0) cli_execute("use dead mimic");
	if (numOfWand() > 0) {
		checkStage("wand", true);
		return true;
	}
	return false;
}

/********************************************************
* START THE FUNCTIONS CALLING THE ADVENTURING FUNCTIONS *
********************************************************/

//This is all the stuff to do in level 1.
void bcs1() {
    bcascToot();
	bcascGuild();
	bcascKnob();
	bcascPantry();
	levelMe(5, true);
}

void bcs2() {
	bcCouncil();
	bcascSpookyForest();
	levelMe(8, true);
}

void bcs3() {
	bcCouncil();
	
	//If we're an AT, we should make our Epic Weapon now. It'll be the best weapon for a long time. 
	bcascEpicWeapons();
	bcascTavern();
	
	levelMe(13, true);
}

void bcs4() {
	bcCouncil();
	bcascBats1();
	bcascMeatcar();
	bcascBats2();
	if (my_buffedstat($stat[Moxie]) > 35) bcasc8Bit();
	levelMe(20, true);
}

void bcs5() {
	bcCouncil();
	
	bcascKnobKing();
	bcascDinghyHippy();
	bcascManorBilliards();
	
	levelMe(29, true);
}

void bcs6() {
	bcCouncil();
	
	bcascFriars();
	//Setting a second call to this as we want the equipment before the steel definitely. 
	bcascKnobKing();
	bcascKnobPassword();
	bcascFriarsSteel();
	
	//Get the Swashbuckling Kit. The extra moxie boost will be incredibly helpful for the Cyrpt
	while ((i_a("eyepatch") == 0 || i_a("swashbuckling pants") == 0 || i_a("stuffed shoulder parrot") == 0) && i_a("pirate fledges") == 0) {
		bumAdv($location[Pirate Cove], "", "equipmentnc", "1 eyepatch, 1 swashbuckling pants, 1 stuffed shoulder parrot", "Getting the Swashbuckling Kit", "-i");
	}
	
	bcascManorLibrary();
	levelMe(40, true);
}

void bcs7() {
	bcCouncil();
	
	bcascCyrpt();
	bcascInnaboxen();
	bcascManorBedroom();
	
	levelMe(53, true);
}

void bcs8() {
	bcCouncil();
	bcascTrapper();
	bcascWand();
	bcascPirateFledges();
	if(my_path() == "Bees Hate You") bcascMirror();
	
	levelMe(68, true);
}

void bcs9() {
	bcCouncil();
	bcascDailyDungeon();
	
	//Yes, this check isn't perfect, but if we have the giant pinky ring, we've definitely completed the quest.
	if (i_a("giant pinky ring") == 0) { 
		cli_execute("leaflet");
		if (my_path() != "Bees Hate You") { if (cli_execute("use 1 instant house")) {} }
	}
	
	bcascChasm();
	
	levelMe(85, true);
}

void bcs10() {
	bcCouncil();
	
	bcascAirship();
	bcascCastle();
	
	levelMe(104, true);
}

void bcs11() {
	bcCouncil();
	
	bcascMacguffinPrelim();
	bcascMacguffinPalindome();
	bcascHoleInTheSky();
	bcascMacguffinSpooky();
	bcascMacguffinPyramid();
	bcascMacguffinHiddenCity();
	bcascMacguffinFinal();
	
	levelMe(125, true);
}

void bcs12() {
	boolean doSideQuest(string name) {
		if (checkStage("warstage_"+name)) return true;
		print("BCC: Starting SideQuest '"+name+"'", "purple");
		
		//We have to have these functions outside the switch. 
		int estimated_advs() { return ceil((100000 - to_float(get_property("currentNunneryMeat"))) / (1000 + (10*meat_drop_modifier()))); }
		
		int numMolyItems() { return item_amount($item[molybdenum hammer]) + item_amount($item[molybdenum crescent wrench]) + item_amount($item[molybdenum pliers]) + item_amount($item[molybdenum screwdriver]); }
		
		string visit_yossarian() {
			print("BCC: Visiting Yossarian...", "purple");
			if (cli_execute("outfit "+bcasc_warOutfit)) {}
			return visit_url("bigisland.php?action=junkman&pwd=");
		}
		
		switch (name) {
			case "arena" :
				if (get_property("sidequestArenaCompleted") != "none") return true;
				print("BCC: doSideQuest(Arena)", "purple");
				
				//First, either get the flyers or turn in the 10000ML if needed, then check if it's complete. 
				cli_execute("outfit "+bcasc_warOutfit);
				if (get_property("flyeredML").to_int() > 9999 || item_amount($item[jam band flyers]) + item_amount($item[rock band flyers]) == 0) visit_url("bigisland.php?place=concert&pwd=");
				cli_execute("outfit "+bcasc_warOutfit);
				if (get_property("sidequestArenaCompleted") != "none") return true;
				if (item_amount($item[jam band flyers]) + item_amount($item[rock band flyers]) == 0) abort("There was a problem acquiring the flyers for the Arena quest.");
				
				if (can_interact()) {
					//The consultCasual script will automatically handle noodling and flyering, so all we have to do is do the side-quests.
					if (bcasc_doSideQuestOrchard) doSideQuest("orchard");
					if (bcasc_doSideQuestNuns) doSideQuest("nuns");
					if (bcasc_doSideQuestJunkyard) doSideQuest("junkyard");
				} else {
					print("BCC: Finding the GMoB to flyer him...", "purple");
					set_property("choiceAdventure105","3");     // say "guy made of bees"
					switch (my_primestat()) {
						case $stat[Muscle] :		set_property("choiceAdventure402", "1");	break;
						case $stat[Mysticality] :	set_property("choiceAdventure402", "2");	break;
						case $stat[Moxie] :			set_property("choiceAdventure402", "3");	break;
					}
					while (to_int(get_property("guyMadeOfBeesCount")) < 5 && get_property("flyeredML").to_int() < 10000) {
						bumAdv($location[Haunted Bathroom], "", "", "1 choiceadv", "You need to say 'Guy made of bees' "+(5-to_int(get_property("guyMadeOfBeesCount")))+" more times.", "-", "consultGMOB");
					}
				}
				
				cli_execute("outfit "+bcasc_warOutfit);
				visit_url("bigisland.php?place=concert&pwd=");
				visit_url("bigisland.php?place=concert&pwd=");
				return checkStage("warstage_"+name, true);
			
			case "beach" :
				if (get_property("sidequestLighthouseCompleted") != "none") return true;
				print("BCC: doSideQuest(Beach)", "purple");
				bumUse(4, $item[reodorant]);
				while (i_a("barrel of gunpowder") < 5) {
					if (i_a("Rain-Doh black box") + i_a("spooky putty mitre") + i_a("spooky putty leotard") + i_a("spooky putty ball") + i_a("spooky putty sheet") + i_a("spooky putty snake") > 0) {
						abort("BCC: You have some putty method, but the script doesn't support puttying at the beach, so we aborted to save you a bunch of turns. Do the beach manually.");
					}
					bumAdv($location[Wartime Sonofa Beach], "", "items", "5 barrel of gunpowder", "Getting the Barrels of Gunpowder", "+");
				}
				cli_execute("outfit "+bcasc_warOutfit);
				visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
				visit_url("bigisland.php?place=lighthouse&action=pyro&pwd=");
				if (get_property("sidequestLighthouseCompleted") != "none")
					return checkStage("warstage_"+name, true);
				else
					return false;
			
			case "dooks" :
				visit_url("bigisland.php?place=farm&action=farmer&pwd=");
				visit_url("bigisland.php?place=farm&action=farmer&pwd=");
				if (get_property("sidequestFarmCompleted") != "none") return true;
				print("BCC: doSideQuest(Dooks)", "purple");
				cli_execute("outfit "+bcasc_warOutfit);
				set_property("choiceAdventure147","3");
				set_property("choiceAdventure148","1");
				set_property("choiceAdventure149","2");
				
				visit_url("bigisland.php?place=farm&action=farmer&pwd=");
				
				//Use a chaos butterfly against a generic duck
				while (!contains_text(visit_url("bigisland.php?place=farm"), "snarfblat=143")) {
					if (i_a("chaos butterfly") > 0 && my_path() != "Bees hate You") {
						string url;
						boolean altered = false;
						repeat {
							url = visit_url("adventure.php?snarfblat=137");
							if (contains_text(url, "Combat")) {
								throw_item($item[chaos butterfly]);
								altered = true;
								bumRunCombat();
							} else  {
								bumMiniAdv(1,$location[barn]);
							}
						} until (altered || contains_text(url,"no more ducks here."));
						
						if (altered) bumAdv($location[barn]);
					} else {
						bumAdv($location[barn]);
					}
				}
				bumAdv($location[pond]);
				bumAdv($location[back 40]);
				bumAdv($location[other back 40]);
				
				cli_execute("outfit "+bcasc_warOutfit);
				visit_url("bigisland.php?place=farm&action=farmer&pwd=");
				visit_url("bigisland.php?place=farm&action=farmer&pwd=");
				
				if (get_property("sidequestFarmCompleted") != "none")
					return checkStage("warstage_"+name, true);
				else
					return false;
			
			case "junkyard" :
				if (get_property("sidequestJunkyardCompleted") != "none") return true;
				print("BCC: doSideQuest(Junkyard)", "purple");
				
				visit_yossarian();
				visit_yossarian();
				while (get_property("currentJunkyardTool") != "") {
					bumAdv(to_location(get_property("currentJunkyardLocation")), "mox +DA +10DR -melee", "nothing", "1 "+get_property("currentJunkyardTool"), "Getting "+get_property("currentJunkyardTool")+"...", "", "consultJunkyard");
					visit_yossarian();
				}
				if (get_property("sidequestJunkyardCompleted") != "none")
					return checkStage("warstage_"+name, true);
				else
					return false;
			
			case "nuns" :
				if (get_property("sidequestNunsCompleted") != "none") return true;
				print("BCC: doSideQuest(Nuns)", "purple");
				setFamiliar("meat");
				
				//Set up buffs and use items as necessary.
				if (have_effect($effect[sinuses for miles]) == 0) bumUse(3, $item[mick's icyvapohotness inhaler]);
				if (have_effect($effect[red tongue]) == 0) bumUse(3, $item[red snowcone]);
				if (get_property("sidequestArenaCompleted") == "fratboy" && cli_execute("concert 2")) {}
				if (get_property("demonName2") != "" && cli_execute("summon 2")) {}
				if (i_a("filthy knitted dread sack") > 0 && i_a("\"DRINK ME\" potion") > 0) cli_execute("hatter filthy knitted dread sack");
				if (my_path() != "Bees Hate You") bumUse(ceil((estimated_advs()-have_effect($effect[wasabi sinuses]))/10), $item[Knob Goblin nasal spray]);
				bumUse(ceil((estimated_advs()-have_effect($effect[your cupcake senses are tingling]))/20), $item[pink-frosted astral cupcake]);
				bumUse(ceil((estimated_advs()-have_effect($effect[heart of pink]))/10), $item[pink candy heart]);
				bumUse(ceil((estimated_advs()-have_effect($effect[heart of green]))/10), $item[green candy heart]);
				bumUse(ceil((estimated_advs()-have_effect($effect[Greedy Resolve]))/20), $item[resolution: be wealthier]);
				if (have_skill($skill[Polka of Plenty])) cli_execute("trigger lose_effect, Polka of Plenty, cast 1 Polka of Plenty");
				if (have_skill($skill[Empathy of the Newt])) cli_execute("trigger lose_effect, Empathy, cast 1 Empathy of the Newt");
				if (have_skill($skill[Leash of Linguini])) cli_execute("trigger lose_effect, Leash of Linguini, cast 1 Leash of Linguini");
				if (dispensary_available()) cli_execute("trigger lose_effect, Wasabi Sinuses, use 1 Knob Goblin nasal spray");
				if (dispensary_available()) cli_execute("trigger lose_effect, Heavy Petting, use 1 Knob Goblin pet-buffing spray");
				
				//Put on the outfit and adventure, printing debug information each time. 
				buMax("nuns");
				cli_execute("condition clear");
				while (my_adventures() > 0 && prepSNS() != "whatever" && bumMiniAdv(1, $location[themthar hills]) && get_property("currentNunneryMeat").to_int() < 100000) {
					print("BCC: Nunmeat retrieved: "+get_property("currentNunneryMeat")+" Estimated adventures remaining: "+estimated_advs(), "green");
				}
				
				if(get_property("sidequestNunsCompleted") != "none") return checkStage("warstage_"+name, true);
				visit_url("bigisland.php?place=nunnery");
			
			case "orchard" :
				cli_execute("outfit "+bcasc_warOutfit);
				visit_url("bigisland.php?place=orchard&action=stand&pwd=");
				visit_url("bigisland.php?place=orchard&action=stand&pwd=");
				if (get_property("sidequestOrchardCompleted") != "none") return true;
				print("BCC: doSideQuest(Orchard)", "purple");
				
				if(my_path() != "Bees Hate You" && have_effect($effect[red tongue]) == 0) bumUse(3, $item[blue snowcone]);
				bumUse(3, $item[lavender candy heart]);
				
				while (item_amount($item[heart of the filthworm queen]) == 0) {
					while (have_effect($effect[Filthworm Guard Stench]) == 0) {
						while (have_effect($effect[Filthworm Drone Stench]) == 0) {
								while (have_effect($effect[Filthworm Larva Stench]) == 0) {
									bumAdv($location[hatching chamber], "", "items", "1 filthworm hatchling scent gland", "Getting the Hatchling Gland (1/3)", "i");
									use(1, $item[filthworm hatchling scent gland]);
								}
								bumAdv($location[feeding chamber], "", "items", "1 filthworm drone scent gland", "Getting the Drone Gland (2/3)", "i");
								use(1, $item[filthworm drone scent gland]);
							}
						bumAdv($location[guards' chamber], "", "items", "1 filthworm royal guard scent gland", "Getting the Royal Guard Gland (3/3)", "i");
						use(1, $item[filthworm royal guard scent gland]);
					}
					bumAdv($location[Queen's Chamber], "", "", "1 heart of the filthworm queen", "Fighting the Queen");
				}
				
				cli_execute("outfit "+bcasc_warOutfit);
				visit_url("bigisland.php?place=orchard&action=stand&pwd=");
				visit_url("bigisland.php?place=orchard&action=stand&pwd=");
				return checkStage("warstage_"+name, true);
		}
		return false;
	}
	
	void item_turnin(item i) {
		sell(i.buyer, item_amount(i), i);
	}
	
	boolean killSide(int numDeadNeeded) {
		if (my_path() == "Avatar of Boris") setFamiliar("items");
		else setFamiliar("");
		setMood("i");

		if (my_adventures() == 0) abort("You don't have any adventures :(");
		cli_execute("condition clear");
		
		int numKilled;
		if (bcasc_doWarAs == "frat") {
			numKilled = to_int(get_property("hippiesDefeated"));
			buMax("+outfit frat warrior fatigues");
		} else if (bcasc_doWarAs == "hippy") {
			numKilled = to_int(get_property("fratboysDefeated"));
			buMax("+outfit war hippy fatigues");
		} else {
			abort("There has been an error trying to defeat the enemies on the battlefield. Please report this. ");
		}
		print("BCC: Attempting to kill up to "+numDeadNeeded+" enemies in the war. You have "+numKilled+" dead already, attempting to do the war as a "+bcasc_doWarAs+".", "purple");
		
		while (numKilled < numDeadNeeded) {
			if (my_adventures() == 0) abort("No adventures in the Battlefield.");
			
			if (bcasc_doWarAs == "frat") {
				bumMiniAdv(1, $location[Battlefield (Frat Uniform)]);
				numKilled = to_int(get_property("hippiesDefeated"));
			} else if (bcasc_doWarAs == "hippy") {
				bumMiniAdv(1, $location[Battlefield (Hippy Uniform)]);
				numKilled = to_int(get_property("fratboysDefeated"));
			} else {
				abort("You have specified a wrong type of side to do the war as. Please change that (the setting is called bcasc_doWarAs");
			}
		}
		
		return (numKilled >= numDeadNeeded);
	}

	visit_url("council.php");
	if (index_of(visit_url("questlog.php?which=1"), "Make War, Not... Oh, Wait") > 0) {
		//First, get the outfit as necessary. 
		if (bcasc_doWarAs == "hippy") {
			while (i_a("reinforced beaded headband") == 0 || i_a("bullet-proof corduroys") == 0 || i_a("round purple sunglasses") == 0) 
				bumAdv($location[Wartime Hippy Camp], "+outfit filthy hippy disguise", "", "1 reinforced beaded headband, 1 bullet-proof corduroys, 1 round purple sunglasses", "Getting the War Hippy Outfit");
		} else if (bcasc_doWarAs == "frat") {
			while (i_a("beer helmet") == 0 || i_a("distressed denim pants") == 0 || i_a("bejeweled pledge pin") == 0) 
				bumAdv($location[Wartime Frat House], "+outfit filthy hippy disguise", "hebo", "1 beer helmet, 1 distressed denim pants, 1 bejeweled pledge pin", "Getting the Frat Warrior Outfit", "", "consultHeBo");
		} else {
			abort("Please specify if you want the war done as a Hippy or a Fratboy.");
		}
		
		while (my_basestat($stat[mysticality]) < 70) {
			set_property("choiceAdventure105","1");
			set_property("choiceAdventure402","2");
			bumAdv($location[Haunted Bathroom], "", "", "70 mysticality", "Getting 70 myst to equip the " + bcasc_warOutfit + " outfit", "-");
		} 
		
		//So now we have the outfit. Let's check if the war has kicked off yet. 
		if (!contains_text(visit_url("questlog.php?which=1"), "war between the hippies and frat boys started")) {
			if (bcasc_doWarAs == "hippy") {
				bumAdv($location[Wartime Frat House (Hippy Disguise)], "+outfit war hippy fatigues", "", "", "Starting the war by irritating the Frat Boys", "-");
			} else if (bcasc_doWarAs == "frat") {
				//I can't quite work out which choiceAdv number I need. Check it later. Plus, it should be "start the war" anyway. 
				//cli_execute("set choiceAdventure142");
				bumAdv($location[Wartime Hippy Camp (Frat Disguise)], "+outfit frat warrior fatigues", "", "", "Starting the war by irritating the Hippies", "-");
			}
		}
		
		//At this point the war should be started. 
		if (bcasc_doWarAs == "hippy") {
			if (i_a("reinforced beaded headband") == 0 || i_a("bullet-proof corduroys") == 0 || i_a("round purple sunglasses") == 0) {
				abort("What the heck did you do - where's your War Hippy outfit gone!?");
			}
			if (bcasc_doSideQuestOrchard) doSideQuest("orchard");
			if (bcasc_doSideQuestDooks) doSideQuest("dooks");
			if (bcasc_doSideQuestNuns) doSideQuest("nuns");
			killSide(64);
			if (bcasc_doSideQuestBeach || i_a("barrel of gunpowder") >= 5) doSideQuest("beach");
			killSide(192);
			if (bcasc_doSideQuestJunkyard) doSideQuest("junkyard");
			killSide(458);
			if (bcasc_doSideQuestArena) doSideQuest("arena");
			killSide(1000);
		} else if (bcasc_doWarAs == "frat") {
			if (i_a("beer helmet") == 0 || i_a("distressed denim pants") == 0 || i_a("bejeweled pledge pin") == 0) {
				abort("What the heck did you do - where's your Frat Warrior outfit gone!?");
			}
			if (bcasc_doSideQuestArena) doSideQuest("arena");
			if (bcasc_doSideQuestJunkyard) doSideQuest("junkyard");
			if (bcasc_doSideQuestBeach || i_a("barrel of gunpowder") >= 5) doSideQuest("beach");
			killSide(64);
			if (bcasc_doSideQuestOrchard) doSideQuest("orchard");
			killSide(192);
			if (bcasc_doSideQuestNuns) doSideQuest("nuns");
			killSide(458);
			if (bcasc_doSideQuestDooks) doSideQuest("dooks");
			killSide(1000);
		}
		
		if (get_property("bcasc_sellWarItems") == "true") {
			//Sell all stuff.
			if (bcasc_doWarAs == "hippy") {
				item_turnin($item[red class ring]);
				item_turnin($item[blue class ring]);
				item_turnin($item[white class ring]);
				item_turnin($item[beer helmet]);
				item_turnin($item[distressed denim pants]);
				item_turnin($item[bejeweled pledge pin]);
				item_turnin($item[PADL Phone]);
				item_turnin($item[kick-ass kicks]);
				item_turnin($item[perforated battle paddle]);
				item_turnin($item[bottle opener belt buckle]);
				item_turnin($item[keg shield]);
				item_turnin($item[giant foam finger]);
				item_turnin($item[war tongs]);
				item_turnin($item[energy drink IV]);
				item_turnin($item[Elmley shades]);
				item_turnin($item[beer bong]);
				buy($coinmaster[Dimemaster], $coinmaster[dimemaster].available_tokens/2, $item[filthy poultice]);
			} else if (bcasc_doWarAs == "frat") {
				item_turnin($item[pink clay bead]);
				item_turnin($item[purple clay bead]);
				item_turnin($item[green clay bead]);
				item_turnin($item[bullet-proof corduroys]);
				item_turnin($item[round purple sunglasses]);
				item_turnin($item[reinforced beaded headband]);
				item_turnin($item[hippy protest button]);
				item_turnin(to_item("Lockenstock"));
				item_turnin($item[didgeridooka]);
				item_turnin($item[wicker shield]);
				item_turnin($item[lead pipe]);
				item_turnin($item[fire poi]);
				item_turnin($item[communications windchimes]);
				item_turnin($item[Gaia beads]);
				item_turnin($item[hippy medical kit]);
				item_turnin($item[flowing hippy skirt]);
				item_turnin($item[round green sunglasses]);
				buy($coinmaster[Quartersmaster], $coinmaster[Quartersmaster].available_tokens/2, $item[gauze garter]);
			}
		} else {
			if (!checkStage("prewarboss")) {
				checkStage("prewarboss", true);
				abort("Stopping to let you sell war items.  Run script again to continue. Note that the script will not fight the boss as Muscle or Myst, so do that manually to if appropriate.");
			}
		}
		
		// Kill the boss.
		int bossMoxie = 250;
		buMax("+outfit "+bcasc_warOutfit);
		setMood("");
		cli_execute("mood execute");
		
		//Now deal with getting the moxie we need.
		switch (my_primestat()) {
			case $stat[Moxie] :
				if (get_property("telescopeUpgrades") > 0 && !in_bad_moon()) if (cli_execute("telescope look high")) {}
				if (my_buffedstat($stat[Moxie]) < bossMoxie && have_skill($skill[Advanced Saucecrafting])) cli_execute("cast * advanced saucecraft");
				if (my_buffedstat($stat[Moxie]) < bossMoxie && item_amount($item[scrumptious reagent]) > 0) cli_execute("use 1 serum of sarcasm");
				if (my_buffedstat($stat[Moxie]) < bossMoxie && item_amount($item[scrumptious reagent]) > 0) cli_execute("use 1 tomato juice of power");
				if (my_buffedstat($stat[Moxie]) < bossMoxie&& my_primestat() == $stat[moxie]) abort("Can't get to " + bossMoxie + " moxie for the boss fight.  You're on your own.");
			break;
			
			default :
				abort("Not yet doing the boss as Muscle or Mysticality.");
			break;
		}
		
		cli_execute("restore hp;restore mp");
		visit_url("bigisland.php?place=camp&whichcamp=1");
		visit_url("bigisland.php?place=camp&whichcamp=2");
		visit_url("bigisland.php?action=bossfight&pwd");
		if (index_of(bumRunCombat(), "WINWINWIN") == -1) abort("Failed to kill the boss!\n");
		visit_url("council.php");
	}
	
	levelMe(148, true);
}

void bcs13() {
	boolean tower_items;
	bcCouncil();
	
	if (!checkStage("lair0")) {
		tower_items = bcascTelescope();
		checkStage("lair0", true);
		if(!tower_items)
			abort("BCC: You need tower items that the script won't automatically get. Go get them yourself.");
	}
	load_current_map("bumrats_lairitems", lairitems);
	bcascNaughtySorceress();
}


void bumcheekcend() {
	ascendLog("");
	if ((get_property("bcasc_telescope") == "true") && (get_property("bcasc_telescopeAsYouGo") == "true") && (!checkStage("lair0"))) {
		print("Doing a check for Telescope Items", "green");
		bcascTelescope();
	}
	
	print("Level 1 Starting", "green");
	bcs1();
	print("Level 2 Starting", "green");
	bcs2();
	print("Level 3 Starting", "green");
	bcs3();
	print("Level 4 Starting", "green");
	bcs4();
	print("Level 5 Starting", "green");
	bcs5();
	print("Level 6 Starting", "green");
	bcs6();
	print("Level 7 Starting", "green");
	bcs7();
	print("Level 8 Starting", "green");
	bcs8();
	print("Level 9 Starting", "green");
	bcs9();
	print("Level 10 Starting", "green");
	bcs10();
	print("Level 11 Starting", "green");
	bcs11();
	print("Level 12 Starting", "green");
	bcs12();
	print("Level 13 Starting", "green");
	bcs13();
}

void mainWrapper() {
	if (index_of(visit_url("http://kolmafia.us/showthread.php?t=4963"), bcasc_version+"</b>") == -1) {
		print("There is a new version available - go download the next version of bumcheekascend.ash at the sourceforge page, linked from http://kolmafia.us/showthread.php?t=4963!", "red");
		print("");
		print("");
		print("");
	}
	
	print("******************************************************************************************", "purple");
	print("******************************************************************************************", "purple");
	print("******************************************************************************************", "purple");
	print("Thankyou for using bumcheekcity's ascension script. Please report all bugs on the sourceforge page available in my profile with a copy+paste from the CLI of the problematic points, and your username. Ask on the thread on the kolmafia.us forum for help and assistance with the script, particularly first time problems, and issues setting it up. ", "purple");
	print("******************************************************************************************", "purple");
	print("******************************************************************************************", "purple");
	print("******************************************************************************************", "purple");
	print("");
	print("");
	print("");
	
	alias [int] aliaslist;
	if (load_current_map("bcs_aliases", aliaslist) || get_property("bcasc_lastAliasVersion") != bcasc_version) {
		print("BCC: Registering aliases for script use. Check the forum thread - http://kolmafia.us/showthread.php?t=4963 - for more information", "purple");


		cli_execute("alias bcasc => ash import <" + __FILE__ + ">; mainWrapper();");
		foreach x in aliaslist {
			print("Setting alias '"+aliaslist[x].cliref+"' for function '"+aliaslist[x].functionname+"'.", "purple");
			cli_execute("alias bcasc_"+aliaslist[x].cliref+" => ash import <" + __FILE__ + ">; bcasc"+aliaslist[x].functionname+"();");
		}
		set_property("bcasc_lastAliasVersion", bcasc_version);
	}
	
	if (my_inebriety() > inebriety_limit()) abort("You're drunk. Don't run this script when drunk, fool.");
	
	if (get_property("autoSatisfyWithNPCs") != "true") {
		set_property("autoSatisfyWithNPCs", "true");
	}
	
	if (get_property("autoSatisfyWithCoinmasters") != "true") {
		set_property("autoSatisfyWithCoinmasters", "true");
	}
	
	if (get_property("bcasc_shutUpAboutOtherScripts") != "true") {
		if (get_property("recoveryScript") == "") {
			print("You do not have a recoveryScript set. I highly recommend Bale's 'Universal Recovery' - http://kolmafia.us/showthread.php?t=1780 - You may find this script runs into problems with meat without it.", "red");
			print("To not be reminded about supplementry scripts, please set the appropriate option in the relay script (which you can find on the kolmafia.us forum thread for this script).", "red");
			wait(1);
		}
		
		if (get_property("counterScript") == "") {
			print("You do not have a counterScript set. I highly recommend Bale's 'CounterChecker' http://kolmafia.us/showthread.php?t=2519 - This script, in combination with bumcheekascend, will allow you to get semi rares if you eat fortune cookies.", "red");
			print("To not be reminded about supplementry scripts, please set the appropriate option in the relay script (which you can find on the kolmafia.us forum thread for this script).", "red");
			wait(1);
		}
	}
	
	if (!in_hardcore() && get_property("bcasc_doNotRemindAboutSoftcore") != "true") {
		print("You are in softcore. The script behaves differently for softcore and requires you to follow the small number of instructions in the following page - http://kolmafia.us/showthread.php?t=4963", "red");
		//abort("To remove this notice and be able to use the script, please set the appropriate option in the relay script (which you can find on the kolmafia.us forum thread for this script).");
	}
	
	if (have_effect($effect[Teleportitis]) > 0 && my_level() < 13) {
		if (!contains_text("dungeons.php", "greater.gif") && my_level() >= 8)
			bcascWand();
		} else {
			bcascTeleportitisBurn();
	}

	print("******************", "green");
	print("Ascending Starting", "green");
	print("******************", "green");
	
	//Before we start, we'll need an accordion. Let's get one. 
	if (my_path() != "Avatar of Boris" && i_a("stolen accordion") == 0 && i_a("Rock and Roll Legend") == 0 && i_a("Squeezebox of the Ages") == 0 && i_a("The Trickster's Trikitixa") == 0 && (checkStage("toot"))) {
		print("BCC: Getting an Accordion before we start. By the way, you might want to tell the script to sell your pork gems using the relay script if this fails due to lack of meat.", "purple");
		while (i_a("stolen accordion") == 0) use(1, $item[chewing gum on a string]);
	}
	sellJunk();
	
	bumcheekcend();
	
	print("******************", "green");
	print("Ascending Finished", "green");
	print("******************", "green");
}

void main() {
	mainWrapper();
}
