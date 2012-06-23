/*
CONTAINS:
DONUT BOX
EGG BOX
MONKEY CUBE BOX

*/


/mob/living/carbon/var/last_eating = 0

/obj/item/kitchen/donut_box
	var/amount = 6
	icon = 'food.dmi'
	icon_state = "donutbox"
	name = "donut box"
/obj/item/kitchen/egg_box
	var/amount = 12
	icon = 'food.dmi'
	icon_state = "eggbox"
	name = "egg box"

/obj/item/kitchen/donut_box/proc/update()
	src.icon_state = text("donutbox[]", src.amount)
	return

/*
/obj/item/kitchen/donut_box/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/reagent_containers/food/snacks/donut) && (amount < 6))
		user.drop_item()
		W.loc = src
		usr << "You place a donut back into the box."
	src.update()
	return
*/

/obj/item/kitchen/donut_box/MouseDrop(mob/user as mob)
	if ((user == usr && (!( usr.restrained() ) && (!( usr.stat ) && (usr.contents.Find(src) || in_range(src, usr))))))
		if(!istype(user, /mob/living/carbon/metroid))
			if( !usr.get_active_hand() )
				src.attack_hand(usr, usr.hand, 1)
	return

/obj/item/kitchen/donut_box/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/kitchen/donut_box/attack_hand(mob/user as mob, unused, flag)
	if (flag)
		return ..()
	src.add_fingerprint(user)

	var/obj/item/weapon/reagent_containers/food/snacks/donut/P = locate() in src
	if(!P && (amount >= 1))
		P = new /obj/item/weapon/reagent_containers/food/snacks/donut( src )
	if(P)
		usr.put_in_hands(P)
		usr << "You take a donut out of the box."
		src.amount--
		src.update()
	return

/obj/item/kitchen/donut_box/examine()
	set src in oview(1)

	src.amount = round(src.amount)
	var/n = src.amount
	for(var/obj/item/weapon/reagent_containers/food/snacks/donut/P in src)
		n++
	if (n <= 0)
		n = 0
		usr << "There are no donuts left in the box."
	else
		if (n == 1)
			usr << "There is one donut left in the box."
		else
			usr << text("There are [] donuts in the box.", n)
	return

/obj/item/kitchen/egg_box/proc/update()
	src.icon_state = text("eggbox[]", src.amount)
	return


/obj/item/kitchen/egg_box/MouseDrop(mob/user as mob)
	if ((user == usr && (!( usr.restrained() ) && (!( usr.stat ) && (usr.contents.Find(src) || in_range(src, usr))))))
		if( !usr.get_active_hand() )
			attack_hand(usr, usr.hand, 1)
			return
	return

/obj/item/kitchen/egg_box/attack_paw(mob/user as mob)
	return src.attack_hand(user)

/obj/item/kitchen/egg_box/attack_hand(mob/user as mob, unused, flag)
	if (flag)
		return ..()
	src.add_fingerprint(user)
	var/obj/item/weapon/reagent_containers/food/snacks/egg/P = locate() in src
	if(!P && (amount >= 1))
		P = new /obj/item/weapon/reagent_containers/food/snacks/egg( src )
	if(P)
		usr.put_in_hands(P)
		usr << "You take an egg out of the box."
		src.amount--
		src.update()
	return


/obj/item/kitchen/egg_box/examine()
	set src in oview(1)

	src.amount = round(src.amount)
	var/n = src.amount
	for(var/obj/item/weapon/reagent_containers/food/snacks/egg/P in src)
		n++
	if (n <= 0)
		n = 0
		usr << "There are no eggs left in the box."
	else
		if (n == 1)
			usr << "There is one egg left in the box."
		else
			usr << text("There are [] eggs in the box.", n)
	return

/obj/item/weapon/monkeycube_box
	name = "monkey cube box"
	desc = "Drymate brand monkey cubes. Just add water!"
	icon = 'food.dmi'
	icon_state = "monkeycubebox"
	var/amount = 2

	attack_hand(mob/user as mob, unused, flag)
		add_fingerprint(user)

		if(user.r_hand == src || user.l_hand == src)
			if(amount)
				user.put_in_hands(new /obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped(user))
				user << "You take a monkey cube out of the box."
				amount--
			else
				user << "There are no monkey cubes left in the box."
		else
			..()

		return

	attack_paw(mob/user as mob)
		return attack_hand(user)