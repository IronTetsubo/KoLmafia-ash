// MAKE, UNTN, PULV, USE, MALL, AUTO, GIFT, KBAY

script "meatgrinder.ash";
import "zlib.ash";

int total_value = 0;
item key;
foreach key in get_inventory() {
	// if ( is_displayable( key ) ) ...;

	// Gather data
	int autosell_price = autosell_price( key );
	int mall_price = mall_price( key );

	// If usable, what value can we get out of it?
	//if ( doodad.usable || doodad.multi )

	if ( mall_price > autosell_price && mall_price > 0 ) {
		int value = item_amount( key ) * mall_price;
		vprint( "MALL - " + key + " - " + mall_price + " - " + item_amount( key ) + " - " + value, "blue", 1 ); 
		total_value = total_value + value;
	} else if ( autosell_price > 0 ) {
		int value = item_amount( key ) * autosell_price;
		vprint( "AUTO - " + key + " - " + autosell_price + " - " + item_amount( key ) + " - " + value, "green", 1 ); 
		total_value = total_value + value;
	} else {
		vprint( "UNKN - " + key + " - " + autosell_price + " - " + item_amount( key ), "red", 1 ); 
	}
}

vprint( "TOTAL: " + total_value, "black", 1 );
