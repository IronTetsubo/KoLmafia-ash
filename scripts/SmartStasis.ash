/******************************************************************************
                               SmartStasis
         First Things First + Restore + DB Combos + Intelligent Stasis
*******************************************************************************

   This script does way too many things to explain here.  Visit
   http://kolmafia.us/showthread.php?t=1715
   for documentation or to post a suggestion/bug report.

   Want to say thanks?  Send me a bat! (Or bat-related item)

******************************************************************************/
import <BatBrain.ash>

boolean should_summon_ghost() {
   if ($monsters[guy made of bees, cyrus the virus, hulking construct, trophyfish] contains m)
      return vprint("Ghost ain't gonna work against this boss, boss.",-6);
   if (my_adventures() < 2*((10 + (5*to_int(have_item($item[bandolier of the spaghetti elemental]) > 0))) - to_int(get_property("pastamancerGhostSummons"))))
      return vprint("Running out of adventures to use your summons.  Summoning...",4);  // don't waste daily summonses
   int glevel = minmax(floor(square_root(to_float(get_property("pastamancerGhostExperience")))),1,10);
   switch (get_property("pastamancerGhostType")) {
      case "Angel Hair Wisp": return m_dpr(0,0) < glevel + 10;
      case "Boba Fettucini": if (glevel == 10)
          return (!should_olfact && !should_putty &&
            monster_attack($monster[giant sandworm]) < my_defstat() - 6 + to_int(vars["threshold"]));
          return (!intheclear());
      case "Bow Tie Bat": if (glevel == 10)
          return (count(item_drops(m)) > 0);
          return (!intheclear());
      case "Lasagmbie": return (meat_drop() > 100 && monster_element(m) != $element[spooky]);
      case "Penne Dreadful": if (glevel == 10)
          return (count(item_drops(m)) > 0);
          if (glevel > 4)
             foreach thingy,num in item_drops(m) if (item_type(thingy) == "food" && num < 90) return vprint("This monster drops food! Summoning...",4);
          foreach thingy,num in item_drops(m) if (item_type(thingy) == "booze" && num < 90) return vprint("This monster drops booze! Summoning...",4);
          return false;
      case "Spaghetti Elemental": return (glevel < 3 || !intheclear() ||
         (m == $monster[evil spaghetti cultist] && have_item($item[spaghetti cult robe]) == 0));
      case "Spice Ghost": return (!intheclear() || get_property("pastamancerGhostSummons") == "0");
      case "Undead Elbow Macaroni": return (!intheclear() && monster_element(m) != $element[spooky]);
      case "Vampieroghi": if (my_stat("hp") <= round(to_float(get_property("hpAutoRecovery"))*to_float(my_maxhp()))) return true;
          int suckyamount = 4*(glevel + 1);
          if (glevel == 10) suckyamount = 50;
          if (glevel > 4)
             return (my_maxhp() - my_stat("hp") > suckyamount || my_maxmp() - my_stat("mp") > suckyamount);
          return (my_maxhp() - my_stat("hp") > suckyamount);
      case "Vermincelli": if (glevel > 4 && (have_effect($effect[beaten up]) > 0 || have_effect($effect[cunctatitis]) > 0))
            return vprint("You can remove a negative effect! Summoning...",4);
          return (!intheclear());
      default: return false;
   }
}
boolean should_mayfly() {                // TODO: expand this, switch on m
   if (!have_equipped($item[mayfly bait necklace]) || to_int(get_property("_mayflySummons")) == 30) return false;
   switch (my_location()) {
      case $location[treasury]:
      case $location[slime tube]:
      case $location[haunted sorority house]:
      case $location[town square]: return true;
      case $location[degrassi knoll]: foreach i in $items[spring, cog, sprocket, empty meat tank] if (has_goal(i) > 0) return true; break;
      case $location[south of the border]: for i from 297 to 300 if (is_goal(to_item(i))) return true; break;
      case $location[fantasy airship]: if (my_level() < 13) return true; break;
      case $location[hole in the sky]: for i from 657 to 665 if (is_goal(to_item(i))) return true; break;
      case $location[haunted pantry]: 
      case $location[haunted kitchen]: 
      case $location[cobb knob kitchen]: foreach i in item_drops(m) if (item_type(i) == "food" && has_goal(i) > 0) return true; break;
   }
   return (my_adventures()/2 - 2 < 30 - to_int(get_property("_mayflySummons")));
}
item to_paste(monster whatsit) {
   switch (whatsit.phylum) {
      case $phylum[constellation]: return $item[cosmic paste];
      case $phylum[demihuman]: return $item[greasy paste];
      case $phylum[humanoid]: return $item[gooey paste];
      case $phylum[horror]: return $item[indescribably horrible paste];
      case $phylum[object]: return $item[oily paste];
      case $phylum[plant]: return $item[chlorophyll paste];
      case $phylum[slime]: return $item[slimy paste];
      case $phylum[undead]: return $item[ectoplasmic paste];
      case $phylum[none]: return $item[none];
      default: return to_item(whatsit.phylum+" paste");
   }
   return $item[none];
}

void set_autoputtifaction() {
   if (m == $monster[none] || (!have_skill($skill[olfaction]) && item_amount($item[putty sheet]) == 0)) return;
  // first, transparency with mafia settings
   if (to_monster(excise(get_property("autoOlfact"),"monster ","")) == m) should_olfact = true;
   if (to_monster(excise(get_property("autoPutty"),"monster ","")) == m || m == $monster[fudgewasps]) should_putty = true;
   if (item_drops(m) contains to_item(excise(get_property("autoOlfact"),"item ",""))) should_olfact = true;
   if (item_drops(m) contains to_item(excise(get_property("autoPutty"),"item ",""))) should_putty = true;
   if (should_putty && should_olfact) return;
  // second, set puttifaction for bounty monsters
   item ihunt = to_item(to_int(get_property("currentBountyItem")));
   if (ihunt != $item[none]) {
      if (item_drops(m) contains ihunt && (
          !($locations[fun house,goatlet,ninja snowmen,laboratory] contains my_location()) ||
          (contains_text(vars["ftf_olfact"],m.to_string())))) {
         if (ihunt.bounty_count <= to_int(vars["puttybountiesupto"]) && item_amount(ihunt) < ihunt.bounty_count-1) should_putty = true;
         should_olfact = true;
      } else if (contains_text(vars["ftf_olfact"],m.to_string()) && ihunt.bounty != my_location())
         should_olfact = true;
   } else if (contains_text(vars["ftf_olfact"],m.to_string())) should_olfact = true;
  // next, handle effective goal-getting (this only olfacts if you set "goals" for autoOlfact)
   monster bestm;
   float bestr, temp;
   int sources;
   foreach i,mon in get_monsters(my_location()) {
      temp = has_goal(mon);
      if (temp <= 0) continue;
      sources += 1;
      if (temp > bestr || (temp == bestr && mon == m)) { bestm = mon; bestr = temp; }
   }
   if (bestr == 0) return;
   print(sources+"/"+count(get_monsters(my_location()))+" monsters drop goals here.");
   if (bestm == m) {
      vprint("This monster is the best source of goals ("+rnum(bestr)+")!","green",3);
      if (get_property("autoOlfact").contains_text("goals")) should_olfact = true;
      if (get_property("autoPutty").contains_text("goals")) should_putty = true;
   }
}

// TODO: ask the hobo to dance (takes 3 rounds, significant +item and some food/drink)

// Category II: must-do-sometime actions
void build_custom() {
   vprint("Building custom actions...",9);
  // stealing! add directly to queue[] rather than custom actions
   if (should_pp && (intheclear() || has_goal(m) > 0) && contains_text(page,"form name=steal"))
      enqueue(to_event("pickpocket","",1));
  // Smash & Graaagh
  if (have_skill($skill[graaagh]))
      foreach i in item_drops(m) if (has_goal(i) > 0) {
	      custom[count(custom)] = get_action($skill[graaagh]);
		  break;
	  }
  // safe salve
   if (have_skill($skill[saucy salve]) && !happened($skill[saucy salve]) && (my_stat("hp") < m_dpr(0,0) ||
       min(round(to_float(get_property("hpAutoRecoveryTarget"))*to_float(my_maxhp())) - my_stat("hp"),12)*meatperhp > mp_cost($skill[saucy salve])*meatpermp))
      custom[count(custom)] = get_action($skill[saucy salve]);
  // summon pasta guardian                              TODO: rework to modify base event
   if (my_class() == $class[pastamancer] && contains_text(page,"form name=summon") && should_summon_ghost())
      custom[count(custom)] = to_event("summonspirit","",1);
  // flyers
   foreach flyer in $items[jam band flyers, rock band flyers] if (item_amount(flyer) > 0 && get_property("flyeredML").to_int() < 10000 &&
      (to_boolean(vars["flyereverything"]) || m.base_attack.to_int() >= 10000 - get_property("flyeredML").to_int()) && !happened(flyer) &&
      !($locations[battlefield (hippy uniform), battlefield (frat uniform)] contains my_location()))
     custom[count(custom)] = to_event("use "+to_int(flyer),to_spread(0),to_spread(to_string(m_regular()*(1-m_hit_chance()))),"!! flyeredML +"+monster_attack(m),1);
  // olfaction
   set_autoputtifaction();
   if (have_skill($skill[olfaction]) && have_effect($effect[form of bird]) == 0 && have_effect($effect[on the trail]) == 0 &&
       should_olfact && !happened($skill[olfaction]))
      custom[count(custom)] = to_event("skill 19","mp -"+mp_cost($skill[olfaction]),1);
  // putty                                                                                          TODO: black box!
   if (item_amount($item[spooky putty sheet]) > 0 && to_int(get_property("spookyPuttyCopiesMade")) < 5 &&
       (should_putty ||
//           (my_location() == $location[guards' chamber] && have_effect($effect[fithworm drone stench]) == 1) ||
        (m == $monster[lobsterfrogman] && get_property("sidequestLighthouseCompleted") == "none" &&
       item_amount($item[barrel of gunpowder]) < 4))) {
      if (to_item(to_int(get_property("currentBountyItem"))).bounty_count > 0)
         should_olfact = (to_item(to_int(get_property("currentBountyItem"))).bounty_count >= 5 - to_int(get_property("spookyPuttyCopiesMade")));
      custom[count(custom)] = to_event("use 3665",to_spread(0),to_spread(to_string(m_regular()*(1-m_hit_chance()))),"",1);
   }
  // insults
   if (my_location().zone == "Island" && have_item($item[pirate fledges]) == 0 &&
       m.phylum == $phylum[pirate] && monster_attack(m) - monster_level_adjustment() < 100)
     foreach i in $items[massive manual of marauder mockery, big book of pirate insults]
       if (item_amount(i) > 0 && !happened(i)) {
          int insultsknown;
          for n from 1 to 8 if (get_property("lastPirateInsult"+n) == "true") insultsknown += 1;
          if (insultsknown < 8) custom[count(custom)] = to_event("use "+to_int(i),"att 0.3*buffedmox",1);
       }
  // identify potions
   float dier,bangcount;
   for i from 819 to 827
      if (get_property("lastBangPotion"+i) == "" && be_good(to_item(i)) && item_amount(to_item(i)) > to_int(get_property("autoPotionID") == "false")) {
         custom[count(custom)] = to_event("use "+i,get_bang(""),1);
         bangcount += 1;
         if (dier == 0) dier = die_rounds();
         if (bangcount >= ceil(dier/10.0)) break;
      }
  // identify spheres		 
   for i from 2174 to 2177
      if (item_amount(to_item(i)) > 0 && get_property("lastStoneSphere"+i) == "" && get_property("autoSphereID") == "true")
         custom[count(custom)] = to_event("use "+i,get_sphere(""),1);
  // release the boots!
   if (my_familiar() == $familiar[stomping boots] && my_location() != $location[none] && get_property("bootsCharged") == "true" && 
       count(get_monsters(my_location())) > 1 && !($items[none,gooey paste] contains to_paste(m)) && !m.boss) {
	  boolean belongs() { foreach i,mon in get_monsters(my_location()) if (mon == m) return true; return false; }
      boolean[item] pastegoals;
      for i from 5198 to 5219 if (is_goal(to_item(i))) pastegoals[to_item(i)] = true;
     // TODO: if there are other monsters in the zone that have paste goals, wait to stomp them
      if (belongs() && (is_goal(to_paste(m)) || has_goal(m) == 0))
         custom[count(custom)] = to_event("skill 7115",to_spread(monster_stat("hp")*6),to_spread(0),"stun 1",1);
   }
  // grin/stinkeye
   if (contains_text(vars["ftf_grin"],m.to_string())) {
      foreach sk in $skills[creepy grin, give your opponent the stinkeye]
         if (contains_text(page,sk+" (")) custom[count(custom)] = to_event("skill "+to_int(sk),"stun 1, !! banish for 10 turns",1);
   }
   item basepair() {
      string prop = get_property("usedAgainstCyrus");
      for i from 4011 to 4016
         if (item_amount(to_item(i)) > 0 && !contains_text(prop,to_item(i))) {
            if (prop == "" || index_of(prop,"memory") == last_index_of(prop,"memory"))
               set_property("usedAgainstCyrus",prop+to_item(i));
              else set_property("usedAgainstCyrus","");
            return to_item(i);
         }
      return $item[none];
   }
  // summon mayflies   (toward the end since it can result in free runaways)
   if (should_mayfly()) custom[count(custom)] = get_action($skill[summon mayfly swarm]);
  // vibrato punchcards
   boolean try_cards(int com, int obj) {
      if (item_amount(to_item(com)) == 0 || item_amount(to_item(obj)) == 0) return false;
      custom[count(custom)] = to_event("use "+com+"; use "+obj,"",2);
      return true;
   }
   switch (m) {
      case $monster[hulking construct]:
         if (try_cards(3146,3155)) break;  // ATTACK WALL
         if (try_cards(3146,3153)) break;  // ATTACK FLOOR
         if (try_cards(3146,3152)) break;  // ATTACK SELF
         break;
      case $monster[bizarre construct]:
         if (item_amount($item[repaired El Vibrato drone]) > 0 && !is_goal($item[repaired El Vibrato drone]) && try_cards(3148,3154)) break;  // BUFF DRONE
         if (my_stat("hp") < 0.7*my_maxhp() && try_cards(3147,3151)) break;  // REPAIR TARGET
         if (have_effect($effect[fitter, happier]) < 5 && try_cards(3148,3151)) break;  // BUFF TARGET
         break;
      case $monster[lonely construct]:
         if (item_amount($item[broken El Vibrato drone]) > 0 && !is_goal($item[broken El Vibrato drone]) && try_cards(3147,3154)) break;  // REPAIR DRONE
         if (have_outfit("El Vibrato") && item_amount($item[El Vibrato power sphere]) > 0 && try_cards(3149,3156)) break;  // MODIFY SPHERE
         break;
      case $monster[towering construct]:
         int evdgoals = 1 - to_int(have_familiar($familiar[El Vibrato megadrone]));
         foreach it in $items[broken El Vibrato drone, repaired El Vibrato drone, augmented El Vibrato drone, El Vibrato megadrone]
            evdgoals += to_int(has_goal(it) > 0) - to_int(item_amount(it) > 0);
         if (item_amount($item[El Vibrato drone]) > 0 && evdgoals > 0 && try_cards(3149,3154)) break; // MODIFY DRONE
         if (item_amount($item[El Vibrato power sphere]) > 0 && !have_outfit("El Vibrato") && try_cards(3149,3156)) break;  // MODIFY SPHERE
         if (try_cards(3150,3154)) break;  // BUILD DRONE
         if (item_amount(to_item(3149)) > 4+evdgoals && item_amount(to_item(3146)) > 0 && item_amount(to_item(3155)) > 0 && try_cards(3149,3152)) break;  // MODIFY SELF (if you can ATTACK WALL)
         break;
     // meat vortices vs. brigands
      case $monster[dirty thieving brigand]: if (item_amount($item[meat vortex]) > 1)
         custom[count(custom)] = to_event("use 546","meat 600",1); break;
     // cocktail napkin
      case $monster[clingy pirate]: if (item_amount($item[cocktail napkin]) > 0) {
         boolean clinggoal;
         for i from 2988 to 2992 if (is_goal(to_item(i))) { clinggoal = true; break; } // only throw cocktail napkin if clingfilm items are not goals
         if (!clinggoal) custom[count(custom)] = to_event("use 2956","",1);
      } break;
     // skate decoys for goals
      case $monster[grouper groupie]: if (is_goal($item[grouper fangirl]) && item_amount($item[ice skate decoy]) > 0 && !happened($item[ice skate decoy]))
         custom[count(custom)] = to_event("use 4231","item grouper fangirl",1); break;
      case $monster[urchin urchin]: if (is_goal($item[urchin roe]) && item_amount($item[roller skate decoy]) > 0 && !happened($item[roller skate decoy]))
         custom[count(custom)] = to_event("use 4210","item urchin roe",1); break;
     // boss killers
      case $monster[gargantulihc]: if (item_amount($item[plus-size phylactery]) > 0)
         custom[count(custom)] = to_event("use 2564",to_spread(monster_stat("hp")*6),to_spread(0),"",1); break;
      case $monster[sexy sorority ghost]: if (item_amount($item[ghost trap]) > 0)
         custom[count(custom)] = to_event("use 5308",to_spread((monster_stat("hp")*6)+" spooky"),to_spread(0),"",1); break;
      case $monster[guy made of bees]: if (get_action($item[antique hand mirror]).id != "")
         custom[count(custom)] = get_action($item[antique hand mirror]);
         custom[count(custom)] = to_event("runaway","",1); break;
      case $monster[cyrus the virus]: for i from 4011 to 4016
          if (item_amount(to_item(i)) > 0 && !contains_text(get_property("usedAgainstCyrus"),to_item(i))) {
             custom[count(custom)] = to_event("use "+i,"",1); break;
          }
         custom[count(custom)] = to_event("runaway","",1); break;
   }
  // learn rave combos
   advevent unknown_rave() {
      if (available_amount($item[seegers unstoppable banjo]) == 0 && my_location().zone != "Volcano") return new advevent;
      for i from 50 to 52 if (!have_skill(to_skill(i))) return new advevent;
      for i from 50 to 52 for j from 50 to 52 {
         if (j == i) continue;
         for k from 50 to 52 {
            if (k == j || k == i) continue;
            boolean found = false;
            for l from 1 to 6 if (get_property("raveCombo"+l) == to_skill(i)+","+to_skill(j)+","+to_skill(k)) found = true;
            if (!found) return merge(to_event("skill "+i,factors["skill",i],1), to_event("skill "+j,factors["skill",j],1), to_event("skill "+k,factors["skill",k],1));
         }
      }
      return new advevent;
   }
   if (unknown_rave().id != "") custom[count(custom)] = unknown_rave();
   vprint("Custom actions built! ("+count(custom)+" actions)",9);
}

void enqueue_custom() {
   foreach n,ev in custom {
      if (my_stat("mp") + ev.mp < 0) continue;   // can't cast this skill (yet)
      boolean stunfirst = (adj.stun < 1 && to_profit(merge(stun_action(contains_text(ev.id,"use ")),ev)) > to_profit(ev));  // should we stun?
      if (!stunfirst && my_stat("hp") - ev.pdmg[$element[none]] < 0) continue;   // you will die
      vprint("Custom action: "+ev.id+((stunfirst) ? " (stun first with "+stun_action(contains_text(ev.id,"use ")).id+")" : " (no stun)"),"purple",5);
      if (stunfirst) enqueue(stun_action(contains_text(ev.id,"use ")));
      if (enqueue(ev)) remove custom[n];
   }
}
string try_custom() {
   enqueue_custom();
   return macro();
}


//                           ---===== DISCO COMBOS =====---

advevent[int] combos;
advevent to_combo(effect which) {
   if (have_effect(which) > 0) return new advevent;
   string ravepref(int i) {
      return (available_amount($item[seegers unstoppable banjo]) > 0 || my_location().zone == "Volcano") ? get_property("raveCombo"+i) : "";
   }
   string seq(effect c) {
      switch (c) {
         case $effect[disco nirvana]: return "disco dance of doom,disco dance ii: electric boogaloo";
         case $effect[disco concentration]: return "disco eye-poke,disco dance of doom,disco dance ii: electric boogaloo";
         case $effect[none]: return ravepref(5);                // rave steal is $effect[none]
         case $effect[rave nirvana]: return ravepref(2);
         case $effect[rave concentration]: return ravepref(1);
        // combat combos
         case $effect[disco inferno]: return "disco eye-poke,disco dance ii: electric boogaloo";
//         case $effect[disco blindness]: return "disco dance ii: electric boogaloo,disco eye-poke";
//         case $effect[rave stats]: ravepref(6);
      } return "";
   }
   string[int] ord = split_string(seq(which),",");
   if (count(ord) < 2) return new advevent;
   advevent res;
   foreach i,s in ord {
      if (get_action(to_skill(s)).id == "") return new advevent;
      res = (res.id == "" ? get_action(to_skill(s)) : merge(res,get_action(to_skill(s))));
      if (to_int(to_skill(s)) < 53) res.dmg[$element[none]] += 5;    // rave combos are merge(1,2,3) + 15 dmg
   }
   if (-res.mp > my_maxmp()) return new advevent;
   float bonus = 0.3;
   switch (which) {                                                  // add meat/items profit gained
      case $effect[disco concentration]: bonus = 0.2;
      case $effect[none]:
      case $effect[rave concentration]: float dcprofit,prev,icount; boolean skipped;
         foreach num,rec in item_drops_array(m) {
            if (!skipped && stolen contains rec.drop) { skipped = true; continue; }
            switch (rec.type) {
               case "p": continue;
               case "c": if (item_type(rec.drop) == "shirt" && !have_skill($skill[torso awaregness])) continue;
                         if (!is_displayable(rec.drop)) continue;
                         if (item_type(rec.drop) == "pasta guardian" && my_class() != $class[pastamancer]) break;  // skip pasta guardians for non-PMs
                         if (rec.drop == $item[bunch of square grapes] && my_level() < 11) break;  // grapes drop at 11
            }
            prev = item_val(rec.drop,rec.rate);
            if (which != $effect[none]) {
               if (prev == item_val(rec.drop)) continue;
               dcprofit += item_val(rec.drop,(1.0 + bonus)*rec.rate) - prev;
            } else { icount += 1; dcprofit += prev; }
            if (has_goal(rec.drop) > 0) { dcprofit = 9999999; break; }
         }
         res.meat += which == $effect[none] ? dcprofit/max(1,icount)+to_int($locations[outside the club, haunted house, lollipop forest] contains my_location())*9999999 : dcprofit; break;
      case $effect[rave nirvana]: bonus = 0.5;
      case $effect[disco nirvana]: if (m == $monster[dirty thieving brigand] && vars["ocw_nunspeed"] == "false") break;
         res.meat += bonus*to_float(meat_drop(m)); break;
      case $effect[disco inferno]: res.att -= 5; break;
//      case $effect[disco blindness]: res.stun = 3; break;
   }
   return res;
}

void build_combos() {
   if (my_class() != $class[disco bandit]) return;
   void encombo(effect c) { advevent thec = to_combo(c); if (thec.id != "") combos[count(combos)] = thec; }
   if (meat_drop(m) > 0) {
      encombo($effect[disco nirvana]);
      encombo($effect[rave nirvana]);
   }
   if (should_pp || my_location() == $location[outside the club])
      encombo($effect[none]);
   if (count(item_drops(m)) > 1) {
      encombo($effect[disco concentration]);
      encombo($effect[rave concentration]);
   }
   sort combos by -to_profit(value);
}

void enqueue_combos() {
   foreach n,com in combos if (monster_stat("hp") > dmg_dealt(com.dmg) && to_profit(com) > 0 &&
      die_rounds() - kill_rounds(attack_action()) > com.rounds) {
      if (!enqueue(com)) continue;
      remove combos[n];
   }
}
string try_combos() {
   enqueue_combos();
   return macro();
}

// special cases for stasis
boolean is_our_huckleberry() {
   if (my_stat("hp") < round(m_dpr(0,0))) return vprint("Your huckleberry will kill you.",-9);
   if (item_amount($item[molybdenum magnet]) > 0 && !happened("lackstool") &&
       $monsters[batwinged gremlin, erudite gremlin, spider gremlin, vegetable gremlin] contains m) {
      if (my_location() == to_location(get_property("currentJunkyardLocation")))
         return (item_drops() contains to_item(get_property("currentJunkyardTool")));
      return (!(item_drops() contains to_item(get_property("currentJunkyardTool"))));
   }
   if (have_equipped($item[ruby rod]) && my_location() == $location[seaside megalopolis]) {
      foreach thingy in item_drops()
         if (contains_text(to_string(thingy),"essence of ") && available_amount(thingy) == 0) 
            return vprint("This "+m+" has a "+thingy+", making it your huckleberry.",9);
   }
   if (my_location() == $location[outside the club] && have_skill($skill[gothy handwave]) && !happened($skill[gothy handwave])) {
      switch (m) {
         case $monster[breakdancing raver]: if (!have_skill($skill[break it on down])) return true; break;
         case $monster[pop-and-lock raver]: if (!have_skill($skill[pop and lock it])) return true; break;
         case $monster[running man]: if (!have_skill($skill[run like the wind])) return true;
      }
   }
   if (my_fam() == $familiar[he-boulder] && have_effect($effect[everything looks yellow]) == 0 &&
       contains_text(vars["ftf_yellow"],m.to_string())) return true;
   return vprint("This monster is not your huckleberry.","black",-9);
}

string stasis_repeat() {       // the string of repeat conditions for stasising
   int expskill() { int res; foreach s in $skills[] if (s.combat && have_skill(s)) res = max(res,mp_cost(s)); return res; }
   return "!hpbelow "+my_stat("hp")+                                                        // hp
      (my_stat("hp") < my_maxhp() ? " && hpbelow "+my_maxhp() : "")+
      " && !mpbelow "+my_stat("mp")+                                                        // mp
      (my_stat("mp") < min(expskill(),my_maxmp()) ? " && mpbelow "+min(expskill(),my_maxmp()) : "")+
      " && !pastround "+floor(maxround - 3 - kill_rounds(smack))+                           // time to kill
      ((have_equipped($item[crown of thrones])) ? " && !match \"acquire an item\"" : "")+   // CoT
      ((my_fam() == $familiar[hobo monkey]) ? " && !match \"hands you some Meat\"" : "")+   // famspent
      ((my_fam() == $familiar[gluttonous green ghost]) ? " && match ggg.gif" : "")+
      ((my_fam() == $familiar[slimeling]) ? " && match slimeling.gif" : "");
}

string stasis() {
   if ($monsters[naughty sorority nurse, the naughty sorceress, the naughty sorceress (2),
       pufferfish, bonerdagon] contains m) return page;    // never stasis these monsters
   if (m == $monster[quantum mechanic] && m_hit_chance() > 0.1) return page;  // avoid teleportitis
   stasis_action();
   attack_action();
   while ((to_profit(plink) > to_float(vars["BatMan_profitforstasis"]) || is_our_huckleberry()) &&
         (round < maxround - 3 - kill_rounds(smack) && die_rounds() > kill_rounds(smack))) {
      vprint("Top of the stasis loop.",9);
     // special actions
      enqueue_custom();
      enqueue_combos();
     // stasis action as picked by BatBrain -- macro it until anything changes
      if (plink.id == "" && vprint("You don't have any stasis actions.","olive",4)) break;
      macro(plink, stasis_repeat());
      if (finished()) break;
      stasis_action();       // recalculate stasis/attack actions
      attack_action();
   }
   vprint("Stasis loop complete"+(count(queue) > 0 ? " (queue still contains "+count(queue)+" actions)." : "."),9);
   return page;
}

// NOTE: after running this script, changing these variables here in the script will have no
// effect.  You can view ("zlib vars") or edit ("zlib <settingname> = <value>") values in the CLI.
setvar("flyereverything",true);
setvar("puttybountiesupto",19);
setvar("ftf_olfact","blooper, dairy goat, shaky clown, zombie waltzers, goth giant, knott yeti, hellion, violent fungus","list of monster");
setvar("ftf_grin","procrastination giant","list of monster");
setvar("ftf_yellow","knob goblin harem girl","list of monster");
string SSver = check_version("SmartStasis","SS","3.15",1715);

void main(int initround, monster foe, string pg) {
   act(pg);
   vprint_html("Profit per round: "+to_html(baseround()),5);
  // custom actions
   build_custom();
   switch (m) {    // add boss monster items here since BatMan is not being consulted
      case $monster[conjoined zmombie]: for i from 1 upto item_amount($item[half-rotten brain])
         custom[count(custom)] = get_action("use 2562"); break;
      case $monster[giant skeelton]: for i from 1 upto item_amount($item[rusty bonesaw])
         custom[count(custom)] = get_action("use 2563"); break;
      case $monster[huge ghuol]: for i from 1 upto item_amount($item[can of ghuol-b-gone])
         custom[count(custom)] = get_action("use 2565"); break;
      case $monster[protector spectre]:
      case $monster[ancient protector spirit]: if (item_amount($item[Shard of double-ice]) > 0)
         custom[count(custom)] = get_action("use 5048"); break;
   }
   if (count(queue) > 0 && queue[0].id == "pickpocket" && my_class() == $class[disco bandit]) try_custom();
    else enqueue_custom();
  // combos
   build_combos();
   if (($familiars[hobo monkey, gluttonous green ghost, slimeling] contains my_fam() && !happened("famspent")) || have_equipped($item[crown of thrones])) try_combos();
    else enqueue_combos();
  // stasis loop
   stasis();
   if (round < maxround && !is_our_huckleberry() && get_action($skill[entangling noodles]).stun > 0 &&
        m_dpr(0,0)*2*meatperhp > mp_cost($skill[entangling noodles])*meatpermp)
      enqueue($skill[entangling noodles]);
   macro();
   vprint("SmartStasis complete.",9);
}
