/*
  bumcheekcity's Hardcore Checklist Script. v1.0
  
  This script will also be of (limited) use to Softcore players who are not planning on breaking Ronin. 
  
  VERSION:
  0.1 - Began Script. Beginning outline. 
  0.2 - Script goes up to about Level 10.
  0.3 - Got up to the end. There are some bugs, but it's mostly working. 
  0.4 - Small bugs in Level 11 Quest Fixed.
  0.5 - Changed outfit checking to being a function, added level override. Added all NS items. Will change hasItem() to having 2 arguments only.
  0.6 - Misc Fixes.
  0.7 - Familiars in BM checked. Boss Bat checking now works the right way round. Checking for wet stunt nut stew items now works if the Mega Gem is equipped. Fixed Outfit Checks where you have items equipped.
  0.8 - Tells you if you haven't killed the Knob Goblin King or got the perfume. Correctly checks for Talisman o'Nam if you have it equipped.
  0.9 - Fixed Boss Bat check again. Cached results of questlog for speed and win.
  1.0 - Moved main() into a different function so that this can be included into breakfast scripts. Lowercase N checked correctly. Definitely spelt right. Fixed HitS and F'c'le checks.
  
  WANT TO INCLUDE THIS IN YOUR BREAKFAST SCRIPTS?
  Just type:
  -----------------------------------
  import <hccheck.ash>
  bumcheekcitys_hardcore_checklist();
  -----------------------------------
  That's it!
*/

notify bumcheekcity;
import <zlib.ash>
check_version("bumcheekcity's Hardcore Checklist", "bumcheekcityhc", "1.0", 2117);

/*
  START DECLARING GLOBAL VARIABLES
*/
string [int] bufferedoutput;
int buffernumber = 1;
int[item] Telescope;
string[item] Telescope1;
string[item] Telescope2;
string[item] Telescope3;
string[int] upgrade;
int telescopeupgrade;
//Gate 1
Telescope1[$item[pygmy pygment]]="an armchair";
Telescope1[$item[wussiness potion]]="a cowardly-looking man";
Telescope1[$item[gremlin juice]]="a banana peel";
Telescope1[$item[adder bladder]]="a coiled viper";
Telescope1[$item[Angry Farmer candy]]="a rose";
Telescope1[$item[thin black candle]]="a glum teenager";
Telescope1[$item[super-spiky hair gel]]="a hedgehog";
Telescope1[$item[Black No. 2]]="a raven";
Telescope1[$item[Mick's IcyVapoHotness Rub]]="a smiling man";

//Tower 1-5
Telescope2[$item[frigid ninja stars]]="catch a glimpse of a flaming katana";
Telescope2[$item[spider web]]="catch a glimpse of a translucent wing";
Telescope2[$item[sonar-in-a-biscuit]]="see a fancy-looking tophat";
Telescope2[$item[black pepper]]="see a flash of albumen";
Telescope2[$item[pygmy blowgun]]="see a giant white ear";
Telescope2[$item[meat vortex]]="see a huge face made of Meat";
Telescope2[$item[chaos butterfly]]="see a large cowboy hat";
Telescope2[$item[photoprotoneutron torpedo]]="see a periscope";
Telescope2[$item[fancy bath salts]]="see a slimy eyestalk";
Telescope2[$item[inkwell]]="see a strange shadow";
Telescope2[$item[hair spray]]="see moonlight reflecting off of what appears to be ice";
Telescope2[$item[disease]]="see part of a tall wooden frame";
Telescope2[$item[bronzed locust]]="see some amber waves of grain";
Telescope2[$item[Knob Goblin firecracker]]="see some long coattails";
Telescope2[$item[powdered organs]]="see some pipes with steam shooting out of them";
Telescope2[$item[leftovers of indeterminate origin]]="see some sort of bronze figure holding a spatula";
Telescope2[$item[mariachi G-string]]="see the neck of a huge bass guitar";
Telescope2[$item[NG]]="see what appears to be the North Pole";
Telescope2[$item[plot hole]]="see what looks like a writing desk";
Telescope2[$item[baseball]]="see the tip of a baseball bat";
Telescope2[$item[razor-sharp can lid]]="see what seems to be a giant cuticle ";

//Tower 6
Telescope3[$item[tropical orchid]]="formidable stinger";
Telescope3[$item[stick of dynamite]]="wooden beam";
Telescope3[$item[barbed-wire fence]]="pair of horns";

/*
  FINISH DECLARING GLOBAL VARIABLES
*/

//Prints a string if I want it to. Just comment out the line for debugging.
boolean debug(string write)
{
  //print("DEBUG: " + write, "blue");
  return true;
}

//Prints a string always. Just if I want to debug ONE thing, not the entire script. 
boolean debugalways(string write)
{
  print("DEBUG: " + write, "blue");
  return true;
}

//Stores the output for a given level.
boolean bufferoutput(string stuff)
{
  //Add text to buffer
  if (length(stuff) > 0)
  {
    bufferedoutput[buffernumber] = stuff;
    buffernumber = buffernumber + 1;
  }
}

//Prints the output for a given level. 
boolean bufferoutput(int level)
{
  //Is there anything to say, i.e. is the array empty?
  if (length(bufferedoutput[1]) > 0)
  {
    //Print level number.
    print("");
    print("Commencing Level " + to_string(level) + " checks...");
    //Print all output.
    foreach i in bufferedoutput
    {
      print(bufferedoutput[i]);
    }
    //Clear buffer.
    clear(bufferedoutput);
    buffernumber = 1;
  } else {
    //print("There is nothing to say for level " + to_string(level));
  }
}

//Used for Bad Moon to check for the NS Familiars.
boolean checkFamiliar(string famname, string itemname)
{
  if (!have_familiar(to_familiar(famname)))
  {
    if (item_amount(to_item(itemname)) == 0)
    {
      print("You do not have the " + itemname + ".");
    } else {
      if (in_bad_moon())
      {
        use(1, to_item(itemname));
      } else {
        print("You have the " + itemname + ", but no " + famname + " in your terranium.");
      }
    }
  } else {
    debug("You have the " + famname + ".");
  }
}

string hasItem(string itemname, int amount)
{
  int numgot = item_amount(to_item(itemname)) + closet_amount(to_item(itemname));
  
  //First, let's just double-check if it's a scope item.
  if (Telescope[to_item(itemname)] > 0)
  {
    //Then it is.
    if (numgot >= amount)
    {
      //Then we have the required quantites of items. YAY!
      return "";
    } else {
      if (Telescope[to_item(itemname)] == 1)
      {
        //Then it's possibly needed.
        if (amount == 1)
        {
          return "You (might) need " + amount + " " + itemname + ".";
        } else {
          return "You (might) need " + amount + " " + itemname + ". You have " + numgot + ", needing " + (amount - numgot);
        }
      } else if (Telescope[to_item(itemname)] == 2) {
        //Then it's definitely needed.
        if (amount == 1)
        {
          return "YOU DEFINITELY NEED " + amount + " " + itemname + ".";
        } else {
          return "YOU DEFINITELY NEED " + amount + " " + itemname + ". You have " + numgot + ", needing " + (amount - numgot);
        }
      } else {
        //Then it's definitely NOT needed. Only here for debugging, really.
        //return "YOU DONT NEED THE ITEM - " + itemname;
        return "";
      }
    } 
  } else {
    //It's not a tower item.
    if (numgot >= amount)
    {
      //Then we have the required quantites of items. YAY!
      return "";
    } else {
      if (amount == 1)
      {
        return "You need " + amount + " " + itemname + ".";
      } else {
        return "You need " + amount + " " + itemname + ". You have " + numgot + ", needing " + (amount - numgot);
      }
    } 
  }
  return "";
}

//Prints the total quantity of the items. Useful for stuff in the same Zap group. 
int hasHowManyOf(string [string] itemlist)
{
  int amount;
  foreach var in itemlist
  {
    amount = amount + item_amount(to_item(var)) + closet_amount(to_item(var));
  }
  return amount;
}

//Checks if you have an outfit.
string outfitCheck(string item1, string item2, string item3, string outfitname)
{
  int n1 = item_amount(to_item(item1));
  int n2 = item_amount(to_item(item2));
  int n3;
  if (length(item3) > 0) 
  { 
    n3 = item_amount(to_item(item3)); 
  } else {
    n3 = 1; 
  }
  
  if (have_equipped(to_item(item1))) { n1 = n1 + 1; }
  if (have_equipped(to_item(item2))) { n2 = n2 + 1; }
  if (have_equipped(to_item(item3))) { n3 = n3 + 1; }
  
  debug(outfitname + " " + n1 + " - " + n2 + " - " + n3);
  
  if (n1 >= 1 && n2 >= 1 && n3 >= 1)
  {
    debug("You have the " + outfitname + ".");
    return "";
  } else {
    if (n1 + n2 + n3 >= 3)
    {
      return "You don't have the " + outfitname + ", but you could Zap it.";
    } else if (n1 + n2 + n3 == 0) {
      return "You don't have any items for the " + outfitname + ".";
    } else {
      hasItem(item1, 1);
      hasItem(item2, 1);
      if (length(item3) > 0) { hasItem(item3, 1); }
      return "You don't have some of the items for the " + outfitname + ".";
    }
    return "";
  }
  return "";
}

void telescope()
{
  /*
    First, let's set up the main array Telescope
    This array will store:
    Telescope[$item[itemname]] = "1" (possibly needed)
    Telescope[$item[itemname]] = "2" (definitely needed)
    Telescope[$item[itemname]] = "3" (definitely not needed)
  */
  foreach Item in Telescope1 {
    Telescope[Item] = 1;
  }
  foreach Item in Telescope2 {
    Telescope[Item] = 1;
  }
  foreach Item in Telescope3 {
    Telescope[Item] = 1;
  }
  
	//Mafia does not refresh telescope values upon entering BM. Else get the scope number.
	if (in_bad_moon())
	{
		telescopeupgrade = 0;
	} else {
	  telescopeupgrade = to_int(get_property("telescopeUpgrades"));
	}
	
	if (telescopeupgrade > 0)
	{
	  upgrade[1] = get_property("telescope1");
	  upgrade[2] = get_property("telescope2");
	  upgrade[3] = get_property("telescope3");
	  upgrade[4] = get_property("telescope4");
	  upgrade[5] = get_property("telescope5");
	  upgrade[6] = get_property("telescope6");
	  upgrade[7] = get_property("telescope7");
	  
	  //If we have a telescope, we can ALWAYS see the first gate.
		foreach Item in Telescope1
		{
			if(Telescope1[Item] == upgrade[1])
			{
				Telescope[Item] = 2;
			} else {
			  Telescope[Item] = 3;
			}
		}
		
		//Now, if the power of the scope is >=6, we know the items for Tower 1-5 are definite.
		//Else if the power is 2-5 inclusive, we can conclude less.
		if (telescopeupgrade >= 6)
		{
		  foreach Item in Telescope2
		  {
		    if ((Telescope2[Item] == upgrade[2]) || (Telescope2[Item] == upgrade[3]) || (Telescope2[Item] == upgrade[4]) || (Telescope2[Item] == upgrade[5]) || (Telescope2[Item] == upgrade[6]))
		    {
		      Telescope[Item] = 2;
		    } else {
		      Telescope[Item] = 3;
		    }
		  }
		} else if (telescopeupgrade >= 2) {
		  foreach Item in Telescope2
		  {
		    //This time, we won't set Telescope[item] = 3, because we don't know what we DONT need if we have < 6 telescope upgrades.
		    if ((Telescope2[Item] == upgrade[2]) || (Telescope2[Item] == upgrade[3]) || (Telescope2[Item] == upgrade[4]) || (Telescope2[Item] == upgrade[5]))
		    {
		      Telescope[Item] = 2;
		    }
		  }
		}
		
		//Finally if the power is 7, we can find out about the last Shore item for Tower 6.
		if (telescopeupgrade == 7)
		{
		  foreach Item in Telescope3
  		{
  			if(Telescope3[Item] == upgrade[7])
  			{
  				Telescope[Item] = 2;
  			} else {
  			  Telescope[Item] = 3;
  			}
  		}
		}
	}
	
	/*
    This is obviously just for testing.
  	foreach number in upgrade
  	{
  	  print(to_string(number) + " === " + to_string(upgrade[number]), "blue");
  	}
  	
  	foreach Item in Telescope
  	{
  	  print(to_string(Item) + " --- " + to_string(Telescope[Item]));
  	}
  	abort();
  */
}

string [string] urltext;
//Check if a URL contains a particular string. 
boolean urlContains(string url, string needle)
{
  string html;
  if (length(urltext[url]) > 0)
  {
    //print("You have already visited " + url + ".", "green");
    html = urltext[url];
  } else {
    //print("You have not already visited " + url + " so I am storing it for you.", "red");
    html = visit_url(url);
    urltext[url] = html;
  }
  if (index_of(html, needle) > 0)
  {
    return true;
  } else {
    return false;
  }
}

//Let's get checkin'
void bumcheekcitys_hardcore_checklist()
{
  //Before ANYTHING, throw a hit to council.php. This is because some of the quests (for example, the boss bat)
  //don't update the quest log, even though they're done, unless one visits the council.
  //Doing it via urlContains caches it, rather than using visit_url directly. 
  urlContains("council.php", "");
  
  //Then, check the telescope.
  telescope();

  //Just before we start, check the Wand of Nagamar Situation. We'll use this a bit later on. 
  boolean hasWandOfNagamar = false;
  boolean hasWA = false;
  boolean hasND = false;
  boolean hasNG = false;
  if (item_amount($item[Wand of Nagamar]) >= 1)
  {
    debug("You have the Wand of Nagamar");
    hasWandOfNagamar = true;
  } else {
    if (item_amount($item[WA]) >= 1 && item_amount($item[ND]) >= 1)
    {
      hasWandOfNagamar = true;
    }
    if (item_amount($item[WA]) >= 1)
    {
      hasWA = true;
    }
    if (item_amount($item[ND]) >= 1)
    {
      hasND = true;
    }
    if (item_amount($item[NG]) >= 1)
    {
      hasNG = true;
    }
  }
  
  //CHECK FOR FAMILIARS IN BAD MOON
  if (in_bad_moon())
  {
  	print("Commencing Bad Moon Checks");
  	
  	checkFamiliar("Angry Goat", "goat");
  	checkFamiliar("Barrrnacle", "barrrnacle");
  	checkFamiliar("Levitating Potato", "potato sprout");
  	checkFamiliar("Mosquito", "mosquito larva");
  	checkFamiliar("Sabre-Toothed Lime", "sabre-toothed lime cub");
  	checkFamiliar("Star Starfish", "star starfish");
  }
  
  //Some variables appear to need to be declared here. (Infiltration, you see.)
  boolean hasOrcOutfit = false;
  boolean couldZapOrcOutfit = false;
  
  //I've done this so I can override it for testing. 
  int my_level;
  my_level = my_level();
  //my_level = 13;
  
  //Level 1 Checks:
  if (my_level >= 1)
  {
    //Keys
    string [string] itemlist;
    itemlist["Boris's key"] = "You don't have Boris's Key.";
    itemlist["Jarlsberg's key"] = "You don't have Jarlsberg's Key";
    itemlist["Sneaky Pete's key"] = "You don't have Sneaky Pete's Key";
    if (hasHowManyOf(itemlist) < 2)
    {
      bufferoutput("You don't have at least 2 of Boris's Key, Jarlsberg's Key and/or Sneaky Pete's Key");
    } else {
      //Should probably test for the zap group here.
      debug("You have at least two of the Boris/Jarl/Pete's Keys");
    }
    
    //Discover Spookyraven Manor
    if (urlContains("town_right.php", "manor.gif"))
    {
      debug("Spookyraven Manor has been discovered.");
    } else {
      bufferoutput("You have not yet discovered Spookyraven Manor");
    }
    
    //Knob Goblin Encryption Key
    
    if (urlContains("plains.php", "knob2.gif"))
    {
      debug("You can go inside Cobb's Knob.");
    } else {
      if (item_amount($item[Knob Goblin encryption key]) > 0)
      {
        debug("You have the Knob Goblin Encryption Key.");
      } else {
        bufferoutput("You do not have the Knob Goblin Encryption Key.");
      }
    }
    
    bufferoutput(hasItem("razor-sharp can lid", 1));
    bufferoutput(hasItem("leftovers of indeterminate origin", 1));
    bufferoutput(hasItem("spider web", 1));
    
    bufferoutput(1);
  }
  
  if (my_level >= 2)
  {
    //Mosquito Larva
    if (!have_familiar($familiar[Mosquito]))
    {
      if (item_amount($item[mosquito larva]) == 0)
      {
        bufferoutput("You do not have the Mosquito Larva");
      } else {
        bufferoutput("You have the Mosquito Larva, but no Mosquito in your terranium.");
      }
    } else {
      debug("You have the Mosquito");
    }
    
    //Unlocked Hidden Temple
    if (urlContains("questlog.php?which=3", "You have discovered the Hidden Temple."))
    {
      debug("The Hidden Temple has been discovered.");
    } else {
      bufferoutput("You have not yet discovered The hidden Temple.");
    }
    
    //Loaded Dice
    if (in_bad_moon())
    {
      bufferoutput(hasItem("loaded dice", 1));
    }
    bufferoutput(2);
  }
  
  if (my_level >= 3)
  {
    //Dinghy Plans
    if (item_amount($item["dingy dinghy"]) > 0)
    {
      debug("You have discovered the Island");
    } else {
      bufferoutput("You need to get and use the Dinghy Planks.");
    }
    
    //Gate 6 Items
    
    //Pool Cue, Hand Chalk, Library Key
    if (item_amount($item[Spookyraven library key]) > 0)
    {
      debug("You have unlocked the Spookyraven Library");
    } else {
      bufferoutput("You need to unlock the Spookyraven Library");
    }
    
    //NS Items from South of the Border
    bufferoutput(hasItem("lime-and-chile-flavored chewing gum", 1));
    bufferoutput(hasItem("jabañero-flavored chewing gum", 1));
    bufferoutput(hasItem("pickle-flavored chewing gum", 1));
    bufferoutput(hasItem("tamarind-flavored chewing gum", 1));
    bufferoutput(hasItem("handsomeness potion", 1));
    bufferoutput(hasItem("Meleegra pills", 1));
    bufferoutput(hasItem("marzipan skull", 1));
    bufferoutput(hasItem("mariachi G-string", 1));
    bufferoutput(3);
  }
  
  if(my_level >= 4)
  {
    //Boss Bat's Cave
    if (urlContains("questlog.php?which=2", "You have slain the Boss Bat."))
    {
      debug("You have Defeated the Boss Bat.");
    } else {
      bufferoutput("You need to Defeat the Boss Bat.");
    }
    
    //Enchanted Bean for Level 10 Quest
    if (urlContains("questlog.php?which=3", "You have planted a Beanstalk in the Nearby Plains."))
    {
      debug("You have already planted the Enchanted Bean.");
    } else {
      bufferoutput(hasItem("enchanted bean", 1));
    }
    
    //Digital key
    if (item_amount($item[digital key]) > 0)
    {
      debug("You have the Digital Key");
    } else {
      //Check if they have 30 white. Also need to check for making them out of RGB.
      bufferoutput(hasitem("white pixel", 30));
    }
    
    //Various NS Items
    bufferoutput(hasItem("sonar-in-a-biscuit", 1));
    bufferoutput(hasItem("baseball", 1));
    bufferoutput(hasItem("disease", 1));
    bufferoutput(4);
  }
  
  if(my_level >= 5)
  {
    //Cobb's Knob Outfit
    if (urlContains("questlog.php?which=2", "You have slain the Goblin King."))
    {
      debug("You have killed the Knob Goblin King.");
    } else {
      bufferoutput(outfitCheck("Knob Goblin harem pants", "Knob Goblin harem veil", "", "Harem Outfit"));
      bufferoutput(hasItem("Knob Goblin perfume", 1));
      bufferoutput("You have not defeated the Goblin King");
    }
    bufferoutput(5);
  }
  
  if(my_level >= 6)
  {
    //Whitey's Grove. Infiltration Equip is handled in the Lv7 Code.
    if ((item_amount($item[wet stew]) + item_amount($item[wet stunt nut stew]) + item_amount($item[Mega Gem]) == 0) || have_equipped($item[Mega Gem]))
    {
      //Then the ingredients for the wet stew are needed.
      bufferoutput(hasItem("lion oil", 1));
      bufferoutput(hasItem("bird rib", 1));
    }
    
    //Orc & Hippy Outfits. 
    bufferoutput(outfitCheck("filthy knitted dread sack", "filthy corduroys", "", "Hippy Disguise"));
    if (length(outfitCheck("Orcish baseball cap", "homoerotic frat-paddle", "Orcish cargo shorts", "Orcish Frat Boy Outfit")) == 0)
    {
      hasOrcOutfit = true;
    } else {
      //bufferoutput(outfitCheck("Orcish baseball cap", "homoerotic frat-paddle", "Orcish cargo shorts", "Orcish Frat Boy Outfit"));
    }
    
    //Friars
    if (urlContains("questlog.php?which=2", "You have cleansed the taint of the Deep Fat Friars."))
    {
      debug("You've already helped the Friars.");
    } else {
      if(item_amount($item[eldritch butterknife]) + item_amount($item[dodecagram]) + item_amount($item[box of birthday candles]) == 3)
      {
        debug("You have all the Friars Items - go perform the ritual!");
      } else {
        bufferoutput(hasItem("eldritch butterknife", 1));
        bufferoutput(hasItem("dodecagram", 1));
        bufferoutput(hasItem("box of birthday candles", 1));        
      }
    }
    if (!hasWandOfNagamar && !hasWA)
    {
      bufferoutput(hasItem("ruby W", 1));
    }
    bufferoutput(hasItem("wussiness potion", 1));
    bufferoutput(6);
  }
  
  if(my_level >= 7)
  {
    //Pirates Outfit. Infiltration gear checked below. 
    if ((item_amount($item[pirate fledges]) == 0) && (!have_equipped($item[pirate fledges])))
    {
      //First, check if the F'c'le is unlocked. If it is, they only need the three cleaning items. 
      //THIS DOESNT WORK IF YOU DONT HAVE SWASHBUCKLING KIT ON!!!
      if (urlContains("cove.php", "cove3_3x1b.gif"))
      {
        //F'c'le is unlocked. 
        bufferoutput(hasItem("ball polish", 1));
        bufferoutput(hasItem("mizzenmast mop", 1));
        bufferoutput(hasItem("rigging shampoo", 1));
      } else {
        //Do they have the Blueprints, or the dentures they would give?
        if (item_amount($item[Cap'm Caronch's Dentures]) == 1)
        {
          bufferoutput("You have the Dentures. Give them to the Captain in the Barr to unlock the F'c'le.");
        } else if (item_amount($item[Orcish Frat House Blueprints]) == 1) {
          bufferoutput("You have the Blueprints. Get your infiltration gear on and go get the dentures.");
        } else if (item_amount($item[Cap'm Caronch's nasty booty]) == 1) {
          bufferoutput("You have the Nasty Booty. Give it to the Cap'm in the Barr.");
        } else if (item_amount($item[Cap'm Caronch's map]) == 1) {
          bufferoutput("You have the Map. Go fight the massive crab for the Nasty Booty.");
        } else {
          //Check they have Swashbuckling stuff. There is just no way anybody's got here with 25 Myst/Mox.
          if (have_outfit("Swashbuckling Getup"))
          {
            debug("You don't have the Cap'm's map yet. Put your swashbuckling kit on and go get it.");
          } else {
            bufferoutput("You don't have the Swashbuckling Getup.");
          }
        }
      }
    } else {
      debug("You already have your Pirate Fledges.");
    }
    
    //Check infiltration gear. 
    if ((item_amount($item[pirate fledges]) == 0) && (!have_equipped($item[pirate fledges])))
    {
      //Then they're going to need the infiltration gear. IF they haven't unlocked the F'c'le
      if (!urlContains("questlog.php?which=1", "joined Cap'm Caronch's crew"))
      {
        if (hasOrcOutfit || 
          (item_amount($item[mullet wig]) >= 1 && item_amount($item[briefcase]) >= 1) || 
          (((item_amount($item[frilly skirt]) >= 1) || in_muscle_sign()) && item_amount($item[hot wing]) >= 3))
        {
          debug("You have an Infiltration Outfit");
        } else {
          if (couldZapOrcOutfit)
          {
            bufferoutput("You don't have any Infiltration Kit, but could Zap the Orc Outfit.");
          } else {
            bufferoutput("You don't have any Infiltration Kit at all.");
          }
        }
      }
    }
    
    //Dungeons of Doom. Need to check for potions.
    if (urlContains("questlog.php?which=3", "You have discovered the secret of the Dungeons of Doom."))
    {
      debug("The Dungeons of Doom have been unlocked.");
    } else {
      bufferoutput("You should unlock the Dungeons of Doom");
    }
    
    //Check for Zap Wand. Technically not necessary, but I don't care. 
    if (item_amount($item[aluminum wand]) + item_amount($item[ebony wand]) + item_amount($item[hexagonal wand]) + item_amount($item[marble wand]) + item_amount($item[pine wand]) >= 1)
    {
      debug("You have a Zap Wand");
    } else {
      bufferoutput("You don't have a Zap Wand. You'll almost certainly want to get one.");
    }
    
    //Skeleton Bone. 
    if (item_amount($item[skeleton key]) >= 1)
    {
      debug("You have a Skeleton Key.");
    } else {
      bufferoutput(hasItem("Skeleton Bone", 1));
      bufferoutput(hasItem("Loose Teeth", 1));
    }
    
    //Rest of the Crypt.
    if (urlContains("questlog.php?which=2", "You've undefiled the Cyrpt, and defeated the Bonerdagon.")) 
    {
      debug("You have undefiled the crypt.");
    } else {
      bufferoutput("You need to undefile the crypt."); 
    }
    
    //Haunted Library
    if (urlContains("town_right.php", "manor.php"))
    { 
      if (urlContains("manor.php", "manor2.php"))
      {
        debug("You've unlocked the Second Floor of the Manor.");
      } else {
        bufferoutput("You need to unlock the Second Floor of the Manor.");
      }
    }
    
    bufferoutput(hasItem("inkwell", 1));
    bufferoutput(7);
  }
  
  if(my_level >= 8)
  {
    if (urlContains("questlog.php?which=2", "You have learned how to hunt Yetis from the L337 Tr4pz0r. Shazam!"))
    {
      debug("The Mt. McLargeHuge Quest is done.");
    } else if (urlContains("questlog.php?which=2", "The Tr4pz0r wants you to find some way to protect yourself from the cold.")) {
      bufferoutput("You need some Cold Resist for the 1337 Tr4pz0r.");
    } else if (urlContains("questlog.php?which=2", "The Tr4pz0r wants you to bring him 6 chunks of goat cheese from the Goatlet.")) {
      bufferoutput(hasItem("goat cheese", 6));
    } else {
      if (length(outfitCheck("miner's helmet", "miner's pants", "7-foot dwarven mattock", "Mining Outfit")) > 0)
      {
        bufferoutput("You now need 3 of the ore the 1337 Tr4pz0r wanted from you.");
      }
    }
    bufferoutput(hasItem("frigid ninja stars", 1));
    bufferoutput(8);
  }
  
  if(my_level >= 9)
  {
    //Orc Chasm
    if (urlContains("questlog.php?which=2", "A Quest, LOL"))
    {
      debug("You've done the Orc Chasm Quest");
    } else {
      if (item_amount($item["64735 scroll"]) > 0)
      {
        bufferoutput("You have the 64735 scroll. Use it.");
      } else {
        bufferoutput("Get the 64735 scroll from the Orc Chasm.");
      }
    }
    int numNneeded = 0;
    boolean northPoleDef   = false;
    boolean northPoleMaybe = true;
    if ((!hasWandOfNagamar && !hasND) || !hasNG)
    {
      if (!hasNG) { numNneeded = numNneeded + 1; }
      if (!hasWandOfNagamar && !hasND) { numNneeded = numNneeded + 1; }
      
      //The telescope check is applied manually for this one item, as it is required 
      //for the wand AND the NG, which is a tower item. 
      if (telescopeupgrade >= 6)
      {
        //We can see all of the tower items. 
        foreach num in upgrade
        {
          if (upgrade[num] == "see what appears to be the North Pole")
          {
            northPoleDef = true;
            northPoleMaybe = false;
          }
        }
        //So, if we've gone through all 5 of towers 1-5 and NOT seen the Giant Desktop Globe, we know we DON'T need the 
        //NG, and hence the extra N. 
        if (!northPoleDef)
        {
          northPoleMaybe = false;
        }
      } else if (telescopeupgrade >= 2) {
        //We can see some of the tower items.
        foreach num in upgrade
        {
          if (upgrade[num] == "see what appears to be the North Pole")
          {
            northPoleDef = true;
            northPoleMaybe = false;
          }
        }
        //Here, note that we don't set northPoleMaybe to be false if northPoleDef is false too.
      }
      
      int totalNs = item_amount($item[lowercase N]) + item_amount($item[NG]) + item_amount($item[ND]) + item_amount($item[Wand of Nagamar]);
      if (northPoleDef)
      {
        //Definitely need two.
        if (totalNs < 2)
        {
          bufferoutput("You DEFINITELY need a total of 2 lowercase N's. You have " + totalNs + " at the moment.");
        }
      } else if (northPoleMaybe) {
        //Might need two N's, as a result of not seeing the Giant Globe and having < 6 telescope upgrades.
        if (totalNs < 2)
        {
          bufferoutput("You (might) need a total of 2 lowercase N's. You have " + totalNs + " at the moment.");
        }
      } else {
        //We only need one, as we have >= 6 scope upgrades, and didn't see the Giant Globe.
        if (totalNs < 1)
        {
          bufferoutput("You only need a 1 lowercase N', but you don't have any.");
        }
      }
    }
    bufferoutput(hasItem("fancy bath salts", 1));  
    bufferoutput(9);  
  }
  
  if(my_level >= 10)
  {
    if (urlContains("questlog.php?which=3", "You have planted a Beanstalk"))
    {
      debug("The beanstalk is planted");
      if (urlContains("questlog.php?which=3", "You have found the Hole in the Sky."))
      {
        debug("You've unlocked the Hole in the Sky");
        bufferoutput(hasItem("Richard's Star Key", 1));
        bufferoutput(hasItem("star hat", 1));
        bufferoutput(hasItem("star crossbow", 1));
      } else if (urlContains("beanstalk.php", "castle.gif")) {
        bufferoutput("You need to unlock the Hole in the Sky.");
      } else {
        bufferoutput("You need to unlock the castle.");
      }
    } else {
      if (item_amount($item["enchanted bean"]) > 0)
      {
        bufferoutput("You have the Enchanted Bean. Use it.");
      }
    }
    
    bufferoutput(hasItem("super-spiky hair gel", 1));
    bufferoutput(hasItem("photoprotoneutron torpedo", 1));
    bufferoutput(hasItem("thin black candle", 1));
    bufferoutput(hasItem("Mick's IcyVapoHotness Rub", 1));
    if (!hasWandOfNagamar && !hasND)
    {
      //Must either have one or the other. Hence only need one more original G.
      bufferoutput(hasItem("original G", 1));
    }
    if (!hasWandOfNagamar && !hasWA)
    {
      //The WA is not a Tower item, so we only need one metallic A in total. 
      bufferoutput(hasItem("metallic A", 1));
    }
    bufferoutput(hasItem("chaos butterfly", 1));
    bufferoutput(hasItem("plot hole", 1));
    bufferoutput(10);
  }
  
  if(my_level >= 11)
  {
    //Have we finished the Level 11 Quest?
    if (urlContains("questlog.php?which=2", "You've handed the Holy MacGuffin over to the Council"))
    {
      debug("You've completed the Level 11 Quest");
    } else {
      if (item_amount($item[Holy MacGuffin]) == 1)
      {
        bufferoutput("You've got the Holy MacGuffin - go give it to the Council!");
      } else {
        //Is the Pyramid Opened?
        if (item_amount($item["Staff of Ed"]) == 1)
        {
          //Then yes, it's opened. 
          if (urlContains("pyramid.php", "pyramid4_1b.gif"))
          {
            bufferoutput("You need to go beat the crap out of Ed the Undying.");
          } else {
            bufferoutput("You need to go Unlock the Lower Chamber to go beat Ed.");
          }
        } else {
          //Have we even got the diary?
          if (item_amount($item[your father's MacGuffin diary]) == 0)
          {
            bufferoutput("You need to go get your Father's Diary");
          } else {
            //Oasis & Desert
            if (urlContains("beach.php", "smallpyramid.gif"))
            {
              debug("You've done the Oasis/Desert Quest to unlock the Pyramid.");
            } else {
              if (item_amount($item[worm-riding hooks]) >= 1) {
                bufferoutput("You have the worm-riding hooks, now use a drum machine.");
              } else if (urlContains("questlog.php?which=1", "stumble upon a hidden oasis out in the desert")) {
                bufferoutput("You've unlocked the Oasis. You need to meet Gnasir for the first time.");
              } else if (urlContains("questlog.php?which=1", "The fremegn leader Gnasir has tasked you with finding a stone rose")) {  
                if (item_amount($item[stone rose]) > 0)
                {
                  bufferoutput("You have the stone rose. Give it to Gnasir.");
                } else {
                  bufferoutput("You need to give the Stone Rose to Gnasir (and find it first)");
                  bufferoutput(hasItem("stone rose", 1));
                }
                bufferoutput(hasItem("can of black paint", 1));
                bufferoutput(hasItem("drum machine", 1));
              } else if (urlContains("questlog.php?which=1", "Gnasir seemed satisfied with the tasks you performed for his tribe, and has asked you to come back later.")) {
                bufferoutput("You gave the stone rose to Gnasir. Keep adventuring in the Ultrahydrated Desert until you find him again.");
                bufferoutput(hasItem("drum machine", 1));
              } else if (urlContains("questlog.php?which=1", "For your worm-riding training, you need to find a 'thumper'")) {
                if (item_amount($item[drum machine]) > 0)
                {
                  bufferoutput("You have a drum machine, you need to adventure in the Ultrahydrated Desert to give it to Gnasir");
                } else {
                  bufferoutput("You need to get a drum machine from the Oasis, then give it to Gnasir.");
                }
              } else if (urlContains("questlog.php?which=1", "You need to find fifteen missing pages from Gnasir's worm-riding manual. Have fun!")) {
                bufferoutput("You need to find the fifteen pages from the worm-riding manual. You haven't found any.");
              } else if (urlContains("questlog.php?which=1", "One worm-riding manual page down, fourteen to go.")) {
                bufferoutput("You need to find the fifteen pages from the worm-riding manual. You've found page one.");
              } else if (urlContains("questlog.php?which=1", "Two worm-riding manual pages down, thirteen to go. Sigh.")) {
                bufferoutput("You need to find the fifteen pages from the worm-riding manual. You've found two pages.");
              } else if (item_amount($item[worm-riding manual pages 3-15]) >= 1) {
                bufferoutput("You need to give the worm-riding manual back to Gnasir in the Desert.");
              } else {
                bufferoutput("The Oasis/Desert part is not done, but this script can't work out where you are.");
              }
            }
            //Palindrome
            if (item_amount($item[Staff of Fats]) + item_amount($item[Staff of Ed, almost]) + item_amount($item[Staff of Ed]) >= 1)
            {
              debug("You've completed the Palindeome Section");
            } else {
              if ((item_amount($item[Mega Gem]) >= 1) || have_equipped($item[Mega Gem]))
              {
                bufferoutput("You have the Mega Gem, now you just need to kill Dr. Awkward.");
              } else if (item_amount($item[I Love Me, Vol. I]) == 1) {
                //Note that the bird rib and lion oil are handled in the Lv4 section. 
                if (item_amount($item[wet stew]) + item_amount($item[wet stunt nut stew]) == 0)
                {
                  bufferoutput(hasItem("stunt nuts", 1));
                }
                bufferoutput("You need to get the Mega Gem from the Laboratory.");
              } else if ((item_amount($item[Talisman o' Nam]) > 0) || (have_equipped($item[Talisman o' Nam]))) {
                bufferoutput("You have to put all the stuff on the shelves.");
                bufferoutput(hasItem("hard rock candy", 1));
                bufferoutput(hasItem("photograph of God", 1));
                bufferoutput(hasItem("hard-boiled ostrich egg", 1));
                bufferoutput(hasItem("ketchup hound", 1));
              } else {
                bufferoutput("Go unlock Belowdecks and get the Talisman o' Nam");
              }
            }
            //Ruins
            if (item_amount($item[ancient amulet]) + item_amount($item[Staff of Ed, almost]) + item_amount($item[headpiece of the Staff of Ed]) + item_amount($item[Staff of Ed]) >= 1)
            {
              debug("You've completed the Hidden Ruins section.");
            } else if(urlContains("plains.php", "hiddencity.gif")) {
              bufferoutput("You need to unlock the Hidden Temple");
            } else {
              if (item_amount($item["triangular stone"]) < 4)
              {
                bufferoutput("You need to go fight the Ancient Protector Spirit.");
              }
            }
            //Spookyraven Wine Celler
            //Remember, we have already checked that the Manor and Second Floor are unlocked.
            if (item_amount($item[Eye of Ed]) + item_amount($item[headpiece of the Staff of Ed]) + item_amount($item[Staff of Ed]) >= 1)
            {
              debug("You've done the Spookyraven section.");
            } else if (urlContains("manor.php", "sm8b.gif")) {
              bufferoutput("You've unlocked the second floor. Go collect the wine and defeat Lord Spookyraven.");
            } else {
              bufferoutput("Go unlock the basement of Spookyraven Manor.");
            }
          }
        }
      }
    }
    
    bufferoutput(hasItem("pygmy pygment", 1));
    bufferoutput(hasItem("pygmy blowgun", 1));
    bufferoutput(hasItem("powdered organs", 1));
    bufferoutput(hasItem("adder bladder", 1));
    bufferoutput(hasItem("Black No. 2", 1));
    bufferoutput(hasItem("bronzed locust", 1));
    bufferoutput(hasItem("black pepper", 1));
    bufferoutput(11);
  }
  
  if(my_level >= 12)
  {
    if (urlContains("questlog.php?which=2", "Make War, Not... Oh, Wait"))
    {
      debug("You've done the Level 12 Quest.");
    } else {
      bufferoutput("You haven't done the Level 12 Quest.");
    }
    bufferoutput(hasItem("gremlin juice", 1));
    bufferoutput(12);
  }
  
  if (my_level >= 10)
  {
    //I want this here to be the last thing that's printed. 
    if (item_amount($item[wand of nagamar]) == 0)
    {
      print("You do not have the Wand of Nagamar!", "red");
    }
  }
  
  print("Finished NS Checking", "green");
}

void main()
{
  bumcheekcitys_hardcore_checklist();
}