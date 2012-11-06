script "networth.ash"
notify "dj_d";

import <zlib.ash>;

string readablenum(int source) {
   buffer cr;
   cr.append(to_string(source));
   if (cr.length() > 4) for i from 1 to floor((cr.length()-1) / 3.0)
      cr.insert(cr.length()-(i*3)-(i-1),",");
   return to_string(cr);
}

record entry {
  item thing;
  int price;
  int amount;
};
entry[int] all;

int[item] ivals;                // set specific values for items
ivals[$item[meat paste]] = 10;
ivals[$item[meat stack]] = 100;
ivals[$item[dense meat stack]] = 1000;
ivals[$item[casino pass]] = 100;
ivals[$item[vinyl boots]] = 44000;

int get_price(item it) {
   if (ivals[it] > 0) return ivals[it];
   if (!is_tradeable(it)) return max(0,autosell_price(it));
   if (historical_age(it) > 6 || historical_price(it) < 1 || historical_price(it) > 5000000)
      return max(0,mall_price(it));
    else return max(0,historical_price(it));
   return 0;
}

//thanks to Bale for noticing that nontradeable autosellables were being ignored...
int price;
int inventory;
int shop;
int hagnk;
int disp;
int total;
print("Appraising inventory...","blue");
foreach it in $items[] {
   int amount = available_amount(it) + shop_amount(it) + display_amount(it);
   if( !can_interact() ) amount += storage_amount(it);
   if (amount == 0) continue;
   price = get_price(it);
   if (price == 0) continue;
   inventory += ( ( available_amount(it) - can_interact().to_int() * storage_amount(it) ) * price );
   shop += (shop_amount(it)*price);
   hagnk += (storage_amount(it)*price);
   disp += (display_amount(it)*price);
   total += (amount *price);
   all[to_int(it)].thing = it;
   all[to_int(it)].price = price;
   all[to_int(it)].amount = amount;
}

print("Sorting....","blue");
sort all by (value.price * value.amount);
//sort all by -value.amount;
int storage_meat;
int liquid_meat;
storage_meat = excise(visit_url("storage.php"),"have "," meat").to_int();
liquid_meat = my_meat() + my_closet_meat() + storage_meat ;

total += liquid_meat ;

foreach num,rec in all {
   if (rec.amount == 1) print("1 "+rec.thing+" = "+readablenum(rec.price));
   else print(readablenum(rec.amount)+" "+to_plural(rec.thing)+" @ "+readablenum(rec.price)+
          " = "+readablenum(rec.price * rec.amount));
}
print("Liquid meat (eww): "+readablenum(liquid_meat));
print("Inventory: "+readablenum(inventory));
if (have_shop()) print("Store: "+readablenum(shop));
print("Hagnk's: "+readablenum(hagnk));
if (have_display()) print("DC: "+readablenum(disp));
print_html("<b>Total: "+readablenum(total)+"</b>");