SELECT p.planet_name,
	   v.orbital_period_days,
	   v.mass_wrt,
	   v.mass_multiplier,
	   s.host_star_name,
	   s.spectral_type
FROM values AS v
		 JOIN
	 stars AS s
	 ON
		 v.star_id = s.star_id
		 JOIN planets AS p on s.star_id = p.star_id
WHERE v.orbital_period_days IS NOT NULL
  AND s.spectral_type IS NOT NULL
  AND p.planet_type = 'Terrestrial'
  AND v.mass_wrt = 'Earth'
ORDER BY v.spectral_type;


