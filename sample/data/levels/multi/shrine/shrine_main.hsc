(script startup shrine_main
	; Set up the turrets
	(vehicle_auto_turret turret_north0 tv_turret_north0 185.0 195.0 10.0)
	(vehicle_auto_turret turret_north1 tv_turret_north1 195.0 205.0 10.0)
	(vehicle_auto_turret turret_side0 tv_turret_side0 185.0 190.0 10.0)
	(vehicle_auto_turret turret_side1 tv_turret_side1 182.5 190.0 10.0)
	(vehicle_auto_turret turret_south0 tv_turret_south0 189.0 195.0 10.0)
	(vehicle_auto_turret turret_south1 tv_turret_south1 190.0 200.0 10.0)
	
		(object_set_permutation albatross doorway_rear clear)
		(object_set_permutation albatross doorway_left clear)
		(object_set_permutation albatross doorway_right clear)
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