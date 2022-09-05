(script continuous armory_main
	(add_recycling_volume garbage 0 5)
	(sleep 300)
)

(script continuous update_albatross_physics
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_rear blocked)
		(object_set_permutation albatross doorway_rear clear)
	)
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_left blocked)
		(object_set_permutation albatross doorway_left clear)
	)
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_right blocked)
		(object_set_permutation albatross doorway_right clear)
	)
)
